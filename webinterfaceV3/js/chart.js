class Chart {
    constructor(name, files, id) {
        this.name = name;
        this.id = id;
        this.files = files;
        this.el = null;
        this.removed = false;
        this.hidden = true;
        this.initialized = false;
        this.list_item = null;
        this.chart_obj = null;
        this.last_range = null;
	this.cloneToolTip = null;                                                                                                        
        this.cloneToolTip2 = null;
    }

    //called once, the first time we need to show the chart
    init() {
        //init chart
        var self = this;
        this.el = Chart.template_el.clone().appendTo("#body");
        this.el.find("div.chart>div").attr("id", this.name);
        this.el.find("a.popUp").attr("name", this.name).facebox();
        this.files.forEach(function (f) {
            var button_el = Chart.button_el.clone().appendTo(self.el.find(".buttons"));
            button_el.find("button").text(f);
            button_el.find("input:checkbox").attr("value", f + ".json").attr("name", self.name).prop("checked", true);
            //init_chart_checkbox(button_el);
        });
        this.series = [];
        for (var i = 0; i < this.files.length; i++) {
            $.ajax({
                dataType: "json",
                url: ("alljsons" + urlLink + "/" + this.files[i] + ".json"),
                async: false,
                success: function(data) {
                    console.log(data)
                    var points = data[Object.keys(data)[0]];
                    self.series[i] = {};
                    self.series[i].yTitle = points[0].yTitle;
                    self.series[i].hTitle = points[0].hTitle;
                    self.series[i].yValues = [];
                    self.series[i].xValues = [];
                    self.series[i].yErr = [];
                    points.forEach(function(point) {
                        self.series[i].yValues.push(point.y);
                        self.series[i].xValues.push(point.run);
                        self.series[i].yErr.push([point.y - point.yErr, point.y + point.yErr]);
                    });
                }
            });
        }
	// 10Apr2017 Start
	self.min_array_id = 10000000;
	if(this.series.length > 0) {
          var min_array_length = 1000000;
	  for (var i = 0; i < this.series.length; i++) {
	     if(self.series[i].xValues.length < min_array_length) {
	      min_array_length = self.series[i].xValues.length;
	      self.min_array_id = i;
	     } 
	  } 	
	}
	if(this.series.length > 1) {
	   for (var i = 0; i < this.series.length; i++) {
	      if(i == self.min_array_id)  {
		 continue;
	      }
	      var xValues_tmp = [];
	      var yValues_tmp = [];
	      var yErr_tmp = [];
	         
	      for (var j = 0; j < self.series[self.min_array_id].xValues.length; j++) { 
                    
		 var ar_id = binarySearch(this.series[i].xValues, this.series[self.min_array_id].xValues[j],0);
                    
                 xValues_tmp[j] = self.series[i].xValues[ar_id];
                 yValues_tmp[j] = self.series[i].yValues[ar_id];
		 yErr_tmp[j] = self.series[i].yErr[ar_id];

	      }
	      
	      self.series[i].xValues = [];
	      self.series[i].yValues = [];
	      self.series[i].yErr = [];
	      //console.log("chart.js -> resize the yValues and yErr arrays ");
	      for (var j = 0; j < self.series[self.min_array_id].xValues.length; j++) { 
                 
                 self.series[i].xValues[j] = xValues_tmp[j];
                 self.series[i].yValues[j] = yValues_tmp[j];
		 self.series[i].yErr[j] =  yErr_tmp[j]; 
	      
	      
	      }      
	      	      
	   }	
	}
        // 10Apr2017 Stop
			
        console.log("chart.init done ")
        this.initialized = true;    
    }

    update(range = null) {
        if (this.hidden) {
            return;
        }
        if (range == null) {
            range = [runFrom, runTo];
        }

        if (!this.initialized) {
            this.init();
            //console.log("chart.update() this.last_range = " + this.last_range)
        }
        else if (this.last_range !== null)  {
            if (this.last_range[0] == range[0] && this.last_range[1] == range[1])
                return;
        }
	//console.log("chart.update() this.initialized = " + this.initialized)

        if (this.series.length == 0)
            return;
        var self = this;
        var yValues = [];
        var yErr = [];
        var xValues = [];
        this.yRange = [Infinity,0.0];
        var runsRange = [];
        
	
	//console.log("->>>>>>>>>>>>>>>>>>>>>>>    range = " + range );
	
	for (var i = 0; i < this.series.length; i++) {
            
	    var indexRange = [];
	    
            if (range[0] == -1 && range[1] == -1) {
                indexRange = [-150];
            }
            else {
                
                if (range[1] <= 0) {
                    runsRange = [range[0],Infinity];
                }
                else {
                    runsRange = [range[0],range[1]];
                }
                indexRange = [binarySearch(this.series[i].xValues, runsRange[0],0),binarySearch(this.series[i].xValues, runsRange[1],1)]
            }

	    //var firstrunid = binarySearch(this.series[i].xValues, runsRange[0],0);
	    //console.log("->>>>>>>>>>>>>>>>>>>>>>>  First Run to access = " + this.series[i].xValues[firstrunid]);
	    
	    //var lastrunid = binarySearch(this.series[i].xValues, runsRange[1],1);
	    //console.log("->>>>>>>>>>>>>>>>>>>>>>>  Last Run to access = " + this.series[i].xValues[lastrunid-1]);
	    
	    console.log("->>>>>>>>>>>>>>>>>>>>>>>  indexRange = " + indexRange);

	    // if(range[1]> 0 && this.series[i].xValues[lastrunid] == runsRange[1]) indexRange[1] += 1;
           
	    yValues[i] = Array.prototype.slice.apply(this.series[i].yValues, indexRange)
            yErr[i] = Array.prototype.slice.apply(this.series[i].yErr, indexRange)
            xValues[i] = Array.prototype.slice.apply(this.series[i].xValues, indexRange)
	    //console.log("->>>>>>>>>>>>>>>>>>>>>>>  xValues = " + xValues[i]);
            
	    for (var j = 0; j < yValues[i].length; j++) {
                if (yErr[i][j][0] < this.yRange[0]) {
                    this.yRange[0] = yErr[i][j][0]; }
                else if (yErr[i][j][1] > this.yRange[1]) {
                    this.yRange[1] = yErr[i][j][1];}
            }
        }


        var yTitle = this.series[0].yTitle;
        var hTitle = this.series[0].hTitle;
        if (this.chart_obj !== null) {
            this.chart_obj.destroy();
        }
	//	cloneToolTip = null;
	//	cloneToolTip2 = null;
        this.highcharts_options = {
            chart : {
                renderTo : (this.name),
                zoomType : 'xy',
                height : "470"
            },
            title : {
                text : hTitle
            },
            xAxis : {
                title : {
                    text : 'Run No.',
                },
		categories : xValues[0] // 10Apr2017
		 
            },
            yAxis : {
                title : {
                    text : yTitle,
                },
                min: (this.yRange[0] - 0.05 * Math.abs(this.yRange[0])),
                max: (this.yRange[1] + 0.05 * Math.abs(this.yRange[1]))
            },
            scatter : {
                marker : {
                    radius : 2
                }
            }
        };
        this.chart_obj = new Highcharts.Chart(this.highcharts_options);
	for (var i = 0; i < this.files.length; i++) {
            var fileName = this.files[i].split(".")[0]; //Hugo: basic name of the file
	    if (fileName.indexOf("perInOutLayer") !== -1) { //Convention: for plus or minus trends only, the first trend must be disk -/+3 and is called "perMinusDisk" or "perPlusDisk" in the title. So the title is correct and the legend also
                fileName = 'Inner Layer 1';
	    }

	    for (var number = 1; number <= 4; number++) { //If we have several plots on the same plot, show the layer number instead...
                if (fileName.indexOf("InnerLayer"+number) !== -1) {
		    fileName = 'Inner Layer ' +number;
            	    continue;
		}
                if (fileName.indexOf("OuterLayer"+number) !== -1) {
		    fileName = 'Outer Layer ' +number;
            	    continue;
		}
       		if ((fileName.indexOf("Layer"+number) !== -1) || (fileName.indexOf("L"+number) !== -1) ) {
		    fileName = 'Layer ' +number;
            	    continue;
		}
	    }
	    for (var number = 1; number <= 3; number++) { //or the disk number
                if (fileName.indexOf("Dm"+number) !== -1) {
		    fileName = 'Disk -' +number;
            	    continue;
		}
                if (fileName.indexOf("Dp"+number) !== -1) {
		    fileName = 'Disk +' +number;
            	    continue;
		}
	    }
	    if (fileName.indexOf("perLayer") !== -1) { //Convention: the first trend must be layer 1 and is called "perLayer" in the title. So the title is correct and the legend also
                fileName = 'Layer 1';
	    }
	    if ((fileName.indexOf("perDisk") !== -1) || (fileName.indexOf("perMinusDisk") !== -1)) { //Convention: the first trend must be disk -3 and is called "perDisk" in the title. So the title is correct and the legend also
                fileName = 'Disk -3';
	    }
	    if (fileName.indexOf("perPlusDisk") !== -1) { //Convention: for plus or minus trends only, the first trend must be disk -/+3 and is called "perMinusDisk" or "perPlusDisk" in the title. So the title is correct and the legend also
                fileName = 'Disk +3';
	    }

	    this.chart_obj.addSeries({
                name : fileName,
		type : 'scatter',
                data : yValues[i],
                color : colors[i],
                tooltip : {
                    headerFormat : "",
                    pointFormat : '<span style="color:{series.color}"></span><b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>'
                            + yTitle + ': </b>{point.y}<br><b>GUI link:</b> coming soon<br/>'
                }
            }, false);
            //console.log(yErr[i].length);
            this.chart_obj.addSeries({
                name : 'Bin Content Error',
                type : 'errorbar',
                data : yErr[i],
                tooltip : {
                    headerFormat : "",
                    pointFormat : '<b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>Error Range</b> : {point.low}-{point.high}<br/>'
                }
            }, false);
            //console.log(this.series[0].xValues.length);
        }
        this.chart_obj.redraw();
        setTimeout(function() {self.chart_obj.reflow();}, 100);
        this.last_range = range;
    }

    show() {
        if (this.removed)
            return;
        this.hidden = false;
        //if (!this.initialized) // Aris found last problem mentioned by Hugo
            this.update();
        if (this.chart_obj != null)
            this.chart_obj.reflow();
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
}

// Chart.template_el = $(
//     `<div class="chartarea">
//         <div class="buttons">
//         </div>
//         <div class="chart">
//             <div
//                 style="min-width: 310px; height: 460px; max-width: 800px; margin: 0 auto"></div>
//         </div>
//         <a class="popUp" href="#popup" rel="facebox"
//             onclick="popup(this);">Change Ranges</a>
//     </div>`
// );

Chart.highcharts_options = {

};

Chart.template_el = $(
    `<div class="chartarea">
        <div class="chart">
            <div
                style="min-width: 310px; height: 500px; max-width: 800px; margin: 0 auto"></div>
        </div>
        <a class="popUp" href="#popup" rel="facebox"
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
	    if(id==0) return currentIndex; // Aris 5-4-2017
	    if(id==1) return currentIndex + 1; // Aris 5-4-2017
        }
    }

    //console.log(minIndex);
    return minIndex < array.length ? minIndex : minIndex;
}
