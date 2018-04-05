class ScatterPlot extends Chart {
    draw(xValues, yValues, yErr) {
        var self = this;
        var yTitle = this.series[0].yTitle;
        if (this.chart_obj !== null) {
            this.chart_obj.destroy();
        }
	this.update_runs_data(xValues);
        var min_y = Math.min(...yValues.map(x => Math.min(...x)));
        var max_y = Math.max(...yValues.map(x => Math.max(...x)));
        var dist = Math.abs(max_y - min_y);
        min_y -= 0.4 * dist;
        max_y += 0.05 * dist;
        var options = {
            credits: {
                enabled: false
            },
            chart: {
                renderTo: (this.el_id),
                zoomType: 'xy',
                height: "470"
            },
            title: {
                text: this.name
            },
            xAxis: {
                title: {
                    text: 'Run No.',
                },
                categories: [...new Set([].concat(...xValues))] //xValues[0] // 10Apr2017
                , plotBands: this.filters.fills ? this.bands : []
            },
            yAxis: [
                {
                    title: {
                        text: yTitle,
                    },
                    min: min_y,
                    max: max_y,
                    tickPixelInterval: 60
                    // endOnTick: false,
                    // startOnTick: false
                },
                {
                    zoomEnabled: false,
                    title: {
                        text: "Run Duration [sec]",
                    },
                    opposite: true,
                    visible: this.filters.durations && this.durations !== undefined,
                    tickPixelInterval: 60
                }
            ],
            plotOptions: this.filters.fills ? 
                {
                    series: {
                        events: {
                            legendItemClick: function () {
                                if (this.name == "Fills") {
                                    var plotBands = this.chart.xAxis[0].plotLinesAndBands;
                                    if (!this.visible) {
                                        for (var i = 0; i < plotBands.length; i++) {
                                            this.chart.xAxis[0].plotLinesAndBands[i].hidden = false;
                                            $(this.chart.xAxis[0].plotLinesAndBands[i].svgElem.element).show();
                                        }
                                    }
                                    else {
                                        for (var i = 0; i < plotBands.length; i++) {
                                            this.chart.xAxis[0].plotLinesAndBands[i].hidden = true;
                                            $(this.chart.xAxis[0].plotLinesAndBands[i].svgElem.element).hide();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                :
                {}
            ,
            series: this.filters.fills ?
                [{ // "Fills" legend item
                    name: "Fills",
                    color: "#e6eaf2",
                    type: "area",
                    legendIndex: 100
                }]
                :
                []
        };

        this.chart_obj = new Highcharts.Chart(options);

        var show_dur = (this.filters.durations && this.durations);

        for (var i = 0; i < this.files.length; i++) {
            var tooltip = '<span style="color:{series.color}"></span><b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>'
                + yTitle + ': </b>{point.y}<br><b>Fill No:</b> {point.fill}';
            var data = [];
            if (show_dur) {
                tooltip += "<br><b>Duration:</b> {point.dur}";
                data = yValues[i].map((y, k) => ({ y: y, fill: this.fills[k], dur: this.durations[k] }));
            }
            else {
                data = yValues[i].map((y, k) => ({ y: y, fill: this.fills[k] }))
            }
            var fileName = this.get_file_label(i);
            this.chart_obj.addSeries({
                name: fileName,
                type: 'scatter',
                data: data,
                color: colors[i],
                marker: {
                    radius: 3
                },
                tooltip: {
                    headerFormat: "",
                    pointFormat: tooltip
                },
                showInLegend: true,
                animation: false
            }, false);

            if (this.filters.errors) {
                this.chart_obj.addSeries({
                    name: 'Bin Content Error',
                    type: 'errorbar',
                    data: yErr[i]
                    ,
                    marker: {
                        radius: 3
                    },
                    tooltip: {
                        headerFormat: "",
                        pointFormat: '<b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>Error Range</b> : {point.low} to {point.high}<br/>'
                    },
                    animation: false
                }, false);
            }
        }
        if (this.filters.durations && this.durations) {
            this.chart_obj.addSeries({
                type: 'column',
                name: 'Run Duration',
                yAxis: 1,
                color: "#a8a8a8",
                zIndex: -1,
                groupPadding: 0,
                pointPadding: 0,
                borderWidth: 0,
                tooltip: {
                    headerFormat: "",
                    pointFormat: '<b>Run No</b>: {point.category}<br/><b>Duration</b>: {point.y}<br/>'
                },
                data: this.durations
            });
        }
        var self = this;
        setTimeout(function () { self.chart_obj.reflow(); }, 50);
    }

    update_runs_data(xValues) {
        this.bands = [];
        this.fills = [];//Array(xValues[0].length);
        this.durations = [];
        var start_i = 0;
        var curr = 0;
        var last_fill = 0;
        var flag = false;
        for (var i = 0; i < xValues[0].length; i++) {
            while (curr < runs_data.length && runs_data[curr].run < xValues[0][i])++curr;
            if (curr == runs_data.length) {
                console.log("Could not find the following runs in the fills file:");
                console.log(xValues[0].slice(i));
                break;
            }
            if (runs_data[curr].run === xValues[0][i]) {
                this.fills[i] = runs_data[curr].lhcfill;
                this.durations[i] = runs_data[curr].dur;
                if (runs_data[curr].lhcfill !== last_fill) {
                    if (flag) {
                        this.bands.push({
                            color: "#e6eaf2",
                            from: start_i - 0.5,
                            to: i - 1 + 0.5,
                            id: "fills"
                        });
                    }
                    else start_i = i;
                    flag = !flag;
                    last_fill = runs_data[curr].lhcfill;
                }
            }
        }
    }

    get_file_label(i) {
        var fileName = this.files[i].split(".")[0]; //Hugo: basic name of the file

        console.log(" Plot FileName = " + fileName);

        // Display the Labels of the PixelPhase1 multy plots in more readable way

        if (fileName.indexOf("perInOutLayer") !== -1) { //Convention: for plus or minus trends only, the first trend must be disk -/+3 and is called "perMinusDisk" or "perPlusDisk" in the title. So the title is correct and the legend also
            fileName = 'Inner Layer 1';
        }

	for (var number = 1; number <= 4; number++) { //If we have several plots on the same plot, show the layer number instead...  
	    if ((fileName.indexOf("Module" + number) !== -1)) {
		fileName = 'Module ' + number;
		continue;
	    }
	}

	for (var number = 1; number <= 2; number++) { //If we have several plots on the same plot, show the layer number instead...  
	    if (((fileName.indexOf("Ring" + number) !== -1) || (fileName.indexOf("R" + number) !== -1)) && (fileName.indexOf("TEC") == -1) && (fileName.indexOf("TID") == -1) ){
		fileName = 'Ring ' + number;
		continue;
	    }
	}


        for (var number = 1; number <= 6; number++) { //If we have several plots on the same plot, show the layer number instead...
            if ((fileName.indexOf("InnerLayer" + number) !== -1) || (fileName.indexOf("TIB_L" + number) !== -1)) {

                fileName = 'Inner Layer ' + number;
                continue;
            }
            if ((fileName.indexOf("OuterLayer" + number) !== -1) || (fileName.indexOf("TOB_L" + number) !== -1)) {
                fileName = 'Outer Layer ' + number;
                continue;
            }
            if ((fileName.indexOf("Layer" + number) !== -1) || (fileName.indexOf("L" + number) !== -1)) {
                fileName = 'Layer ' + number;
                continue;
            }
        }
        for (var number = 1; number <= 7; number++) { //If we have several plots on the same plot, show the layer number instead...

            if ((fileName.indexOf("TEC_MINUS_R" + number) !== -1)) {
                fileName = 'TEC- R ' + number;
                continue;
            }
            if ((fileName.indexOf("TEC_PLUS_R" + number) !== -1)) {
                fileName = 'TEC+ R ' + number;
                continue;
            }
        }
        for (var number = 1; number <= 9; number++) { //If we have several plots on the same plot, show the layer number instead...

            if ((fileName.indexOf("TEC_MINUS_W" + number) !== -1)) {
                fileName = 'TEC- W ' + number;
                continue;
            }
        }
        for (var number = 1; number <= 9; number++) { //If we have several plots on the same plot, show the layer number instead...

            if ((fileName.indexOf("TEC_PLUS_W" + number) !== -1)) {
                fileName = 'TEC+ W ' + number;
                continue;
            }
        }
        for (var number = 1; number <= 3; number++) { //or the disk number

            if (fileName.indexOf("Dm" + number) !== -1) {
                fileName = 'Disk -' + number;
                continue;
            }
            if (fileName.indexOf("Dp" + number) !== -1) {
                fileName = 'Disk +' + number;
                continue;
            }
            if (fileName.indexOf("TID_PLUS_R" + number) !== -1) {
                fileName = 'TID+ R' + number;
                continue;
            }
            if (fileName.indexOf("TID_MINUS_R" + number) !== -1) {
                fileName = 'TID- R' + number;
                continue;
            }
            if (fileName.indexOf("TID_PLUS_W" + number) !== -1) {
                fileName = 'TID+ W' + number;
                continue;
            }
            if (fileName.indexOf("TID_MINUS_W" + number) !== -1) {
                fileName = 'TID- W' + number;
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
        return fileName;
    }
}