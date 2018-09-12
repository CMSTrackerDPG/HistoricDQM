class Chart {
    constructor(plot, id, url) {
        this.el_id = 'chart-' + id
        this.name = plot.name;
        this.id = id;
        this.files = plot.files;
        this.el = null;
        this.removed = false;
        this.hidden = true;
        this.initialized = false;
        this.list_item = null;
        this.chart_obj = null;
        this.bands = [];
        this.fills = [];
        this.runs_range = [];
        this.filters = global_filters;
	this.url= url;
    }

    //called once, the first time we need to show the chart
    init() {
        //init chart
        var self = this;
        this.el = Chart.template_el.clone().appendTo("#body");
        this.el.find("div.chart>div").attr("id", this.el_id);
        this.el.find("a.popUp").attr("name", this.name).click(function() {
            $("#popup").show();
        });//.facebox();
        this.files.forEach(function (f) {
            var button_el = Chart.button_el.clone().appendTo(self.el.find(".buttons"));
            button_el.find("button").text(f);
            button_el.find("input:checkbox").attr("value", f + ".json").attr("name", self.el_id).prop("checked", true);
        });
        this.get_data();
    }

    get_data() {
        var self = this;
        this.series = Array(this.files.length).fill({});
        var files_loaded = 0;
        var files_data = Array(this.files.length);
	var myLink="";
        for (let i = 0; i < this.files.length; i++) {
	    if(this.url != null ) myLink=this.url[i];
	    else myLink=urlLink;
	    console.log("myLink: "+myLink);
            $.ajax({
                dataType: "json",			
                url: ("alljsons" + myLink + "/" + this.files[i] + ".json"),
                async: true,
                success: function (data) {
                    var name = Object.keys(data)[0];
                    files_data[i] = data[name];
		    if (files_data.length == self.files.length) {
                        for (var j = 0; j < self.files.length; j++) {
                            self.series[j] = { name: name };
                            self.series[j].yTitle = files_data[j][0].yTitle;
                            self.series[j].hTitle = files_data[j][0].hTitle;
                            self.series[j].yValues = [];
                            self.series[j].xValues = [];
                            self.series[j].yErr = [];
                        }
                        var ids = Array(self.files.length).fill(0);
                        for (var j = 0; j < files_data[0].length; j++) {
                            var match = false;
                            var p1 = files_data[0][j];
                            for (var k = 1; k < self.files.length; k++) {
                                while (ids[k] < files_data[k].length - 1 && files_data[0][j].run > files_data[k][ids[k]].run) {
                                    ids[k]++;
                                }
                                if (p1.run === files_data[k][ids[k]].run) {
                                    match = true;
                                    var p2 = files_data[k][ids[k]];
                                    self.series[k].xValues.push(p2.run);
                                    self.series[k].yValues.push(p2.y);
                                    self.series[k].yErr.push([p2.y - p2.yErr, p2.y + p2.yErr])
                                }
                            }
                            if (match || self.files.length == 1) {
                                self.series[0].xValues.push(p1.run);
                                self.series[0].yValues.push(p1.y);
                                self.series[0].yErr.push([p1.y - p1.yErr, p1.y + p1.yErr])
                            }
                        }
                        self.initialized = true;
                        self.on_data_ready();
                    }
                }
            });
        }
    }

    on_data_ready() {
        this.update();
    }

    update() {
        if (this.hidden) {
            return;
        }
        if (!this.initialized) {
            this.init();
            return;
        }
        if (this.series.length == 0)
            return;

        if (!this.need_update()) {
            console.log("no update");
            return;
        }

        var self = this;
        var yValues = [];
        var yErr = [];
        var xValues = [];
        var runsRange = [];

        var filters = this.filters;

        if (filters.runs.mode == 'run-filter-list' || filters.runs.mode == 'run-filter-file') {
            var runSet = filters.runs.val;
            for (var i = 0; i < this.series.length; i++) {
                xValues[i] = [];
                yValues[i] = [];
                yErr[i] = [];
                for (var j = 0; j < this.series[i].xValues.length; j++) {
                    if (runSet.contains(this.series[i].xValues[j])) {
                        xValues[i].push(this.series[i].xValues[j]);
                        yValues[i].push(this.series[i].yValues[j])
                        yErr[i].push(this.series[i].yErr[j])
                    }
                }
            }
            //console.log(runSet);
        }
        else {
            var indexRange = [];
            if (filters.runs.mode == 'run-filter-latest') {
                indexRange = [-filters.runs.val];
            }
            else if (filters.runs.mode == 'run-filter-range') {
                var runsRange = filters.runs.val;
                indexRange = [binarySearch(this.series[0].xValues, runsRange.min, 0), binarySearch(this.series[0].xValues, runsRange.max, 1)];
            }
            else {
                indexRange = [0, this.series[0].xValues.length];
            }
            for (var i = 0; i < this.series.length; i++) {

                yValues[i] = Array.prototype.slice.apply(this.series[i].yValues, indexRange)
                yErr[i] = Array.prototype.slice.apply(this.series[i].yErr, indexRange)
                xValues[i] = Array.prototype.slice.apply(this.series[i].xValues, indexRange)
            }

        }
        if (filters.y_values.enabled) {
            for (var i = 0; i < this.series.length; i++) {
                var new_yValues = [];
                var new_yErr = [];
                var new_xValues = [];
                for (var j = 0; j < yValues[i].length; j++) {
                    if (filters.y_values.val.contains(yValues[i][j])) {
                        new_yValues.push(yValues[i][j]);
                        new_yErr.push(yErr[i][j]);
                        new_xValues.push(xValues[i][j]);
                    }
                }
                yValues[i] = new_yValues;
                yErr[i] = new_yErr;
                xValues[i] = new_xValues;
            }
        }

        this.runs_range = [xValues[0][0], xValues[0][xValues[0].length - 1]];

        this.draw(xValues, yValues, yErr);

        this.last_filters = jQuery.extend(true, {}, filters);
    }

    show() {
        if (this.removed)
            return;
        this.hidden = false;
        //if (!this.initialized) // Aris found last problem mentioned by Hugo
        this.update();
        this.el.show();
        this.list_item.addClass("drawn");
    }

    hide() {
        if (this.el !== null)
            this.el.hide();
        this.hidden = true;
        this.list_item.removeClass("highlight");
        this.list_item.removeClass("drawn");
    }

    scroll() {
        if (this.initialized)
            this.el.get(0).scrollIntoView();
    }

    destroy() {
        if (this.chart_obj != null)
            this.chart_obj.destroy();
    }

    need_update() {
        if (this.last_filters === undefined) return true;
        for (var key in this.filters) {
            if (this.filters.hasOwnProperty(key)) {
                var curr = this.filters[key];
                var last = this.last_filters[key];
                if (typeof(curr) === "boolean") {
                    if (curr !== last) return true;
                }
                else {
                    if (typeof(curr.equals) === "function") {
                        if (!curr.equals(last)) return true;
                    }
                    else {
                        console.log("WTF", key, curr);
                    }
                }
            }
        }
        return false;
    }
}

Chart.template_el = $(
    `<div class="chartarea">
        <div class="chart">
            <div
                style="min-width: 310px; height: 500px; max-width: 800px;  margin: 0 auto"></div>
        </div>
        <a class="popUp" href="#popup" rel="modal:open"
            onclick="popup(this);">Change Ranges</a>
    </div>`
);

Chart.button_el = $(
    `<span class="button-checkbox1">
        <button type="button" class="btn" data-color="primary"></button>
        <input type="checkbox" value=""
        name="{name}" class="subchart hidden" id="check11"
        onchange='upgradeGraph(this)' />
    </span>`
);

/**
 * Performs a binary search on the host array
 *
 * @param {*} array The array.
 * @param {*} searchElement The item to search for within the array.
 * @return {Number} The index of the first element with value equal to or 
 * greater than the value of searchElement or the last element of the array.
 */
function binarySearch(array, searchElement, id) { // Aris 5-4-2017
    //console.log("inside binarySearch : search for Element = " + searchElement);
    'use strict';

    var minIndex = 0;
    var maxIndex = array.length - 1;
    var currentIndex;
    var currentElement;

    while (minIndex <= maxIndex) {
        currentIndex = (minIndex + maxIndex) / 2 | 0;
        currentElement = array[currentIndex];

        if (currentElement < searchElement) {
            minIndex = currentIndex + 1;
        }
        else if (currentElement > searchElement) {
            maxIndex = currentIndex - 1;
        }
        else {
            if (id == 0) return currentIndex; // Aris 5-4-2017
            if (id == 1) return currentIndex + 1; // Aris 5-4-2017
        }
    }

    //console.log(minIndex);
    return minIndex < array.length ? minIndex : minIndex;
}
