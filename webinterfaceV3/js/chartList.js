class ChartList {
    constructor(dataset, charts) {
        var self = this;
        this.charts = [];
        this.map = {};
        let i = 0;
        charts.forEach(function (c) {
            self.map[c[0]] = self.charts.length;
            self.charts.push(new Chart(c[0], c, i++));
        });
        this.page = 1;
        this.dataset = dataset;
        var per_page_el = $("#per-page");
        this.per_page = per_page_el.val();
        per_page_el.off("change");
        per_page_el.change(function() {
            var val = $(this).val();
            if (val > 0 && val <= chart_list.charts.length) {
                chart_list.per_page = val;
                chart_list.update();
            }
        });
        $("#nav-buttons").show().find("button").off("click");
        $("#next-button").click(function() {
            chart_list.page++;
            chart_list.update();
        });
        $("#prev-button").click(function() {
            chart_list.page--;
            chart_list.update();
        });
        this.num_selected = this.charts.length;
        this.list_items = {};
        this.init_list();
        this.update();
    }

    init_list() {
        var self = this;
        var cnt = 1;
        var list_el = $("#list").html("");
        var list_page = '<li class="list-page""></li>';
        var list_page_el = $(list_page).appendTo(list_el);
        for (var i = 0; i < this.charts.length; i++) {
            var chart = this.charts[i];
            var chart_name = chart.name;
            var list_item = '<div><input type="checkbox"><a></a></div>';
            var item_el = $(list_item).appendTo(list_page_el);
            chart.list_item = item_el
            var checkbox_el = item_el.find("input").prop("checked", true);
            //checkbox click handler
            checkbox_el.change(
                (function (chart_name) {
                    return function () {
                        var el = this;
                        console.log("checkbox clicked");
                        setTimeout(function() {
                            if ($(el).prop("checked")) {
                                self.add(chart_name);
                            }
                            else {
                                self.remove(chart_name);
                            }
                            self.update();
                        }, 200);
                    };
                })(chart_name)
            );
            checkbox_el.dblclick(function () {
                if ($(this).prop("checked")) {
                    $(".list-page input").prop("checked", false).each(function () {
                        self.remove($(this).siblings("a").text());
                    });
                }
                else {
                    $(".list-page input").prop("checked", true).trigger("change");
                }
                self.update();
            });
            //link click handler
            item_el.find("a").text(chart_name).click((function (chart_name) {
                return function () {
                    self.goto_chart(chart_name);
                };
            })(chart_name)
            );
            if (cnt++ % 5 == 0) {
                list_page_el = $(list_page).appendTo(list_el); //add new page to list
            }
        }
        list_el.show();
    }

    update() {
        var t = new Date();
        var pages = this.num_pages;
        if (this.page > pages || this.page === 0) {
            this.page = pages;
        }
        var self = this;
        var displayed = this.displayed_charts; // Aris get the already displayed charts
//        console.log("pages = ",pages);
//	console.log("this.page = ",this.page);
//	console.log("this.displayed_charts = ",displayed); 
//        console.log("this.charts.length = ",this.charts.length);
        var cnt = 0;
        for (var i = 0; i < this.charts.length; i++) {
            var chart = this.charts[i];
            if (displayed.has(chart.name))
                chart.list_item.addClass("highlight");
            else {
                chart.list_item.removeClass("highlight");
                chart.list_item.removeClass("drawn");
            }
            if (!chart.removed) {
                if (Math.floor(cnt++ / this.per_page) % 2 === 0)
                    chart.list_item.addClass("colored");
                else
                    chart.list_item.removeClass("colored");
            }
            else
                chart.list_item.removeClass("colored");
        }
        this.charts.forEach(function (chart) {
            chart.update();
            if (displayed.has(chart.name)) {
//	        console.log("Show chart name = " + chart.name);
                chart.show();
            }
            else {
	        //console.log("Hide chart name = " + chart.name);
                chart.hide();
            }
        });
        var disable_next = false;
        var disable_prev = false;
        if (this.page >= pages)
            disable_next = true;
        else if (this.page <= 1)
            disable_prev = true;
        $("#next-button").prop("disabled", disable_next);
        $("#prev-button").prop("disabled", disable_prev);
        console.log("Update took " + ((new Date()) - t) + " ms.");
    }

    find(chart_name) {
        if (!this.map.hasOwnProperty(chart_name))
            return null;
        return this.charts[this.map[chart_name]];
    }

    add(chart_name) {
        var chart = this.find(chart_name);
        if (chart == null)
            return;
        if (!chart.removed)
            return;
        chart.removed = false;
        chart.list_item.removeClass("removed");
        this.num_selected++;
    }

    remove(chart_name) {
        var chart = this.find(chart_name);
        if (chart == null)
            return;
        if (chart.removed)
            return;
        chart.removed = true;
        chart.hidden = true;
        chart.list_item.addClass("removed");
        this.num_selected--;
    }

    goto_page(new_page) {
        //console.log("goto_page: " + new_page);
        if (new_page == this.page)
            return;
        if (new_page > this.num_pages)
            return;
        this.page = new_page;
        this.update();
    }

    goto_chart(chart_name) {
        // console.log("Inside chartList.goto_chart.............. ");
        if (!this.map.hasOwnProperty(chart_name))
            return;
        var index = this.map[chart_name];
        var chart = this.charts[index];
        //console.log("chartList.goto_chart chart index = " + index);
        //console.log("chartList.goto_chart chart name = " + chart.name);
        if (chart.removed) {
          //  console.log("chartList.goto_chart chart name = " + chart.name + " removed - return");
            return;
	}    
        var displayed_index = index + 1;
        //console.log("chartList.goto_chart chart displayed_index = " + displayed_index);
 	for (var i = 0; i < index; i++) {
	   // console.log("chartList.goto_chart chart name in this page = " + this.charts[i].name);
            if (this.charts[i].removed) {
               console.log("chartList.goto_chart chart name = " + chart.name + " removed");
               displayed_index--;}
        }
        console.log("chartList.goto_chart chart displayed_index = " + displayed_index);
        this.goto_page(Math.ceil(displayed_index / this.per_page));
        chart.scroll();
	
//	for (var i = 0; i < index; i++) {
//	    console.log("chartList.goto_chart chart name in this page = " + this.charts[i].name);
//            
//	    console.log("chartList.goto_chart before -> chart.initialized = " + this.charts[i].initialized);
//            this.charts[i].initialized = false; // Aris
//	    this.charts[i].removed = false; // Aris
//	    console.log("chartList.goto_chart after ->chart.initialized = " + this.charts[i].initialized);
 //       }
     }

    get num_pages() {
        return Math.ceil(this.num_selected / this.per_page);
    }

    get displayed_charts() {
        var result = new Set();
        var cnt = 0;
        for (var i = 0; i < this.charts.length; i++) {
            if (!this.charts[i].removed) {
                if ((cnt >= (this.page - 1) * this.per_page) && (cnt < this.page * this.per_page)) {
//                if ((cnt >= (this.page ) * this.per_page) && (cnt < this.page * this.per_page)) {
                    result.add(this.charts[i].name);
                }
                cnt++;
            }
        }
        return result;
    }
}

