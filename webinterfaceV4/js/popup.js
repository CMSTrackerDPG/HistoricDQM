var current_chart = null;
var popup_chart = null;
// var last_popup_name = null;

function popup(el) {
    var name = $(el).attr("name");
    console.log("popup: " + name);

    // if (name === last_popup_name)
    //     return;

    // last_popup_name = name;

    if (popup_chart != null)
        Chart.prototype.destroy.call(popup_chart);

    current_chart = chart_list.find(name);

    $("#start").val(current_chart.runs_range[0]);
    $("#end").val(current_chart.runs_range[1]);

    popup_chart = $.extend(true, new current_chart.constructor({}, ""), current_chart); //copy chart

    popup_chart.el_id = "popup-chart";
    popup_chart.filters = $.extend(true, {}, global_filters);
    popup_chart.last_filters = undefined;
    popup_chart.chart_obj = null;
    
    console.log(popup_chart);
    Chart.prototype.update.call(popup_chart);
}

function updatePopup() {
    console.log("updatePopup()");
    var range = [0,Infinity];
    var start = $("#start").val();
    var end = $("#end").val();
    
    popup_chart.filters.runs = new Filter(true, "run-filter-range", new NumRange(parseInt(start), parseInt(end)));
    
    Chart.prototype.update.call(popup_chart);
}