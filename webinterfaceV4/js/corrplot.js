class CorrPlot extends Chart {
    on_data_ready() {
        var corr_data = this.get_corr_data(
            [this.series[0].xValues, this.series[1].xValues],
            [this.series[0].yValues, this.series[1].yValues]
        );
        this.regression_all = LinearRegression(corr_data);
        this.update();
    }

    draw(xValues, yValues, yErr) {
        var self = this;
        if (this.chart_obj !== null) {
            this.chart_obj.destroy();
        }
        var pos = common_positions(xValues[0], xValues[1]);
        var corr_data = this.get_corr_data(xValues, yValues);
        var min_run = corr_data[0].Run;
        var run_dist = corr_data[corr_data.length - 1].Run - min_run;
        for (var i = 0; i < corr_data.length; i++) {
            corr_data[i].color = color_scale((corr_data[i].Run - min_run) / run_dist);
        }
        
        if (this.filters.regression) var line = LinearRegression(corr_data);
        
        var rangeX = [Math.min(...corr_data.map(a => a.x)), Math.max(...corr_data.map(a => a.x))];
        var rangeY = [Math.min(...corr_data.map(a => a.y)), Math.max(...corr_data.map(a => a.y))];
        rangeX = rangeX.map((x, i) => x + (i % 2 ? 1 : -1) * 0.005 * Math.abs(x));
        rangeY = rangeY.map((x, i) => x + (i % 2 ? 1 : -1) * 0.005 * Math.abs(x));
        var range = [Math.min(rangeX[0], rangeY[0]), Math.max(rangeX[1], rangeY[1])];
        console.log(rangeY[0]);
        console.log(rangeY[1]);
        var tickInterval = Math.pow(2, Math.round( Math.log((range[1] - range[0])/6) / Math.log(2))); 

        var options = {
            credits: {
                enabled: false
            },
            chart: {
                renderTo: (this.el_id), //the id of the dom element where the chart will be rendered ("chart0", "chart1", ...)
                zoomType: 'xy',
                height: "500",
                alignTicks: false
            },
            title: {
                text: this.name
            },
            xAxis: {
                title: {
		    //                    text: this.series[1].name + ' [' + this.series[1].yTitle + ']',
                    text: this.series[0].yTitle,
                },
                gridLineWidth: 1
                //,tickInterval: tickInterval
                // ,min: range[0], max: range[1]
                ,min: rangeX[0], max: rangeX[1]
            },
            yAxis: {
                title: {
		    //                    text: this.series[0].name + ' [' + this.series[0].yTitle + ']',
		    text: this.series[1].yTitle,
                }
                //,tickInterval: tickInterval
                // ,min: range[0], max: range[1]
                ,min: rangeY[0], max: rangeY[1]
            },
            scatter: {
                marker: {
                    radius: 1
                }
            },
            tooltip: {
                headerFormat: '',
                pointFormat: '<b>Run No: {point.Run}</b><br>X={point.x}<br>Y={point.y} '
            },
            colorAxis: {
                min: min_run,
                max: min_run + run_dist,
                minColor: color_scale(0),
                maxColor: color_scale(1),
                stops: (function () {
                    var result = [];
                    for (var i = 0; i < 21; i++) result.push([i * 1.0 / 20, color_scale(i * 1.0 / 20)]);
                    return result;
                })(),
                labels: {
                    // formatter: function () {
                    //     return Math.floor(this.value);
                    // },
                    enabled: true
                },
                tickInterval: null,
                tickPixelInterval: 120,
                startOnTick: true,
                endOnTick: true
            },
            legend: {
                useHTML: true,
                align: 'center',
                floating: false,
                reversed: true,
                labelFormatter: function formatter() {
                    const dist = 20;
                    if (formatter.vertical_offset === undefined)
                        formatter.vertical_offset = 0;
                    else
                        formatter.vertical_offset = (formatter.vertical_offset + dist) % (2 * dist);
                    if (this.name){
                        var index = self.series.findIndex(x => x.name === this.name);
                        return '<span style="position: absolute; margin-left: -320px; top: ' + (400 + formatter.vertical_offset) + 'px"><span style="color: ' + this.color + '">&#9644</span> ' + this.name + '</span>';
                    }
                    return '';
                },
                itemStyle: {
                    textOverflow: "visible"
                },
                // itemMarginTop: 0,
                symbolWidth: 410
            },
            series: [{
                name: this.files[0] + ' vs. ' + this.files[1],
                type: 'scatter',
                showInLegend: false,
                marker: {
                    radius: 3
                },
                data: corr_data,
                color: 'rgba(123, 223, 183, .8)'//Chart.colors[i]
            }]
        };
        if (this.filters.regression) {
            Array.prototype.push.apply(options.series,
                [{
                    type: 'line',
                    name: 'Regression Line (current data)',
                    marker: {
                        enabled: false
                    },
                    data: crop_line(line, rangeX, rangeY),
                    enableMouseTracking: false,
                    showInLegend: true,
                    color: '#3FBFBF'
                },
                {
                    type: 'line',
                    data: crop_line(this.regression_all, rangeX, rangeY),
                    name: 'Regression Line (all data)',
                    marker: {
                        enabled: false
                    },
                    enableMouseTracking: false,
                    showInLegend: true,
                    color: '#728C8C'
                }]
            );
        }
        this.chart_obj = new Highcharts.Chart(options);
        // this.chart_obj.xAxis[0].setExtremes(...rangeX);
        // this.chart_obj.yAxis[0].setExtremes(...rangeY);
    }

    get_corr_data(xValues, yValues) {
        var pos = common_positions(xValues[0], xValues[1]);
        return pos[0].map((x, i) => {
            return {
                x: yValues[0][x],
                y: yValues[1][pos[1][i]],
                Run: xValues[0][x]
            }
        });
    }
}

//Returns a color based on val which must be between 0.0 and 1.0
function color_scale(val) {
    var r, g, b = 0;
    var perc = 100 - val * 100;
	if(perc < 50) {
		r = 255;
		g = Math.round(5.1 * perc);
	}
	else {
		g = 255;
		r = Math.round(510 - 5.10 * perc);
	}
	var h = r * 0x10000 + g * 0x100 + b * 0x1;
	return '#' + ('000000' + h.toString(16)).slice(-6);
}

function LinearRegression(data) {
    var avg_y = 0, avg_x = 0;
    var start_x = Infinity, end_x = 0;
    var start_y = Infinity, end_y = 0;
    for (var i = 0; i < data.length; i++) {
        avg_y += data[i].y;
        avg_x += data[i].x;
        if (start_x > data[i].x)
            start_x = data[i].x;
        if (end_x < data[i].x) 
            end_x = data[i].x;
        if (start_y > data[i].y)
            start_y = data[i].y;
        if (end_y < data[i].y) 
            end_y = data[i].y;
    }
    start_x -= Math.abs(start_x);
    end_x += Math.abs(end_x);
    start_y -= Math.abs(start_y);
    end_y += Math.abs(end_y);
    avg_x /= data.length;
    avg_y /= data.length;
    var cov_xy = 0;
    var var_x = 0;
    var var_y = 0;
    for (var i = 0; i < data.length; i++) {
        cov_xy += (data[i].x - avg_x) * (data[i].y - avg_y);
        var_x += Math.pow(data[i].x - avg_x, 2);
        var_y += Math.pow(data[i].y - avg_y, 2);
    }
    var a_x = cov_xy / var_x;
    var b_x = avg_y - a_x * avg_x;
    var a_y = cov_xy / var_y;
    var b_y = avg_x - a_y * avg_y;
    var ref_line = [start_x < start_y ? start_y : start_x, end_x > end_y ? end_y : end_x];
    var offset = avg_y - avg_x;
    var res = [[start_x, a_x * start_x + b_x], [end_x, a_x * end_x + b_x]];
    return res;
}

var eps = 0.0000001;
function between(a, b, c) {
    return a-eps <= b && b <= c+eps;
}

function segment_intersection(l1, l2) {
    var x1 = l1[0][0], y1 = l1[0][1], x2 = l1[1][0], y2 = l1[1][1];
    var x3 = l2[0][0], y3 = l2[0][1], x4 = l2[1][0], y4 = l2[1][1];
    var x=((x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4)) /
            ((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
    var y=((x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4)) /
            ((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
    if (isNaN(x)||isNaN(y)) {
        return false;
    } else {
        if (x1>=x2) {
            if (!between(x2, x, x1)) {return false;}
        } else {
            if (!between(x1, x, x2)) {return false;}
        }
        if (y1>=y2) {
            if (!between(y2, y, y1)) {return false;}
        } else {
            if (!between(y1, y, y2)) {return false;}
        }
        if (x3>=x4) {
            if (!between(x4, x, x3)) {return false;}
        } else {
            if (!between(x3, x, x4)) {return false;}
        }
        if (y3>=y4) {
            if (!between(y4, y, y3)) {return false;}
        } else {
            if (!between(y3, y, y4)) {return false;}
        }
    }
    return [x, y];
}

function crop_line(line, x_range, y_range) {
    const gray = [[0, 0], [0, 1], [1, 1], [1, 0]];
    var result = []
    for (var i = 0; i < 4; i++) {
        var intersection = segment_intersection(line,
            [
                [ x_range[gray[i][0]], y_range[gray[i][1]] ], 
                [ x_range[gray[(i + 1) % 4][0]], y_range[gray[(i + 1) % 4][1]] ]
            ]
        );
        if (intersection !== false) {
            result.push(intersection);
        }
    }
    return result;
}