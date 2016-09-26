var yArray = [];
var yErrArray = [];
var myYValues = [];
var myYErrValues = [];
var jsons = [];
var xAxisValues = [];
var start;
var end;
var urlLink = "";
var runFrom = "";
var runTo = "";
var type = "";
var yTitle = "";
var colors = [];

jQuery(document)
		.ready(
				function($) {
					colors.push("#669999");
					colors.push("#FF6600");
					colors.push("#669900");
					colors.push("#002E00");
					colors.push("#CC3300");
					colors.push("#996633");
					colors.push("#000099");
					colors.push("#9900CC");
					colors.push("#FF0066");
					colors.push("#8D1919");
					var count = sessionStorage.length;
				

					urlLink = sessionStorage.getItem("url");
					runFrom = sessionStorage.getItem("runFrom");
					runTo = sessionStorage.getItem("runTo");
					if (runFrom == -1 || runTo == -1) {
						type = 0;
					} else if (runFrom > 0 && runTo > 0) {
						type = 1;
					}

					var x = 0;
					for (var i = 0; i < count; i++) {
						
						
						if (sessionStorage.key(i).indexOf("json") >= 0) {
							jsons[x] = sessionStorage.getItem(sessionStorage
									.key(i));
							
							x++;
						}
					}
					if (type == 1) {
						scatterData(jsons, 1);
					}else{
						scatterData(jsons, 0);
					}

					chart = new Highcharts.Chart({
						chart : {
							renderTo : "container",
							zoomType : 'xy',
						// defaultSeriesType : 'scatter',
						},
						title : {
							text : yTitle 
						},
						xAxis : {
							title : {
								text : 'Run No.',
							},
							categories : xAxisValues

						},
						yAxis : {
							title : {
								text : yTitle,
							}
						},
						scatter : {
							marker : {
								radius : 2
							}
						},

					});
					for (var i = 0; i < yArray.length; i++) {
						
						chart
								.addSeries({
									name : jsons[i].split(".")[0],
									type : 'scatter',
									data : yArray[i],
									color : colors[i],
									tooltip : {
										headerFormat : "",
										pointFormat : '<span style="color:{series.color}"></span><b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>S/N(mpv): </b>{point.y}'
									}
								});
						chart
								.addSeries({
									name : 'Bin Content Error',
									type : 'errorbar',
									data : yErrArray[i],
									tooltip : {
										headerFormat : "",
										pointFormat : '<b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>Error Range</b> : {point.low}-{point.high}<br/>'
									}
								});

					}

				});
function updateGraph() {
	yArray = [];
	yErrArray = [];
	myYErrValues = [];
	myYValues = [];
	xAxisValues=[];
	runFrom = $("#start").val();
	
	runTo = $("#end").val();
	
	scatterData(jsons, 1);

	console.log("X values: "+xAxisValues);
	chart = new Highcharts.Chart({
		chart : {
			renderTo : "container",
			zoomType : 'xy',
		// defaultSeriesType : 'scatter',
		},
		title : {
			text : yTitle
		},
		xAxis : {
			title : {
				text : 'Run No.',
			},
			categories : xAxisValues

		},
		yAxis : {
			title : {
				text : yTitle,
			}
		},
		scatter : {
			marker : {
				radius : 2
			}
		},

	});
	for (var i = 0; i < yArray.length; i++) {
		
		chart
				.addSeries({
					name : jsons[i].split(".")[0],
					type : 'scatter',
					color : colors[i],
					data : yArray[i],
					tooltip : {
						headerFormat : "",
						pointFormat : '<span style="color:{series.color}"></span><b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>S/N(mpv): </b>{point.y}'
					}
				});
		chart
				.addSeries({
					name : 'Bin Content Error',
					type : 'errorbar',
					data : yErrArray[i],
					tooltip : {
						headerFormat : "",
						pointFormat : '<b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>Error Range</b> : {point.low}-{point.high}<br/>'
					}
				});

	}

}
function scatterData(jsons, check) {

	var data = [];

	for (var i = 0; i < jsons.length; i++) {
		myYValues = [];
		myYErrValues = [];
		xAxisValue = [];
		var jsonURL = jsons[i];
		var xmlhttp = new XMLHttpRequest();
		var url = "alljsons" + urlLink + "/" + jsons[i];

		var parameters = location.search;

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				var myArr = JSON.parse(xmlhttp.responseText);

				var jsonName = jsonURL.split(".");
				var temp = jsonName[0];

				var value = myArr[temp];

				var i = value.length;
				i = i - 100;
				if (i < 0)
					i = 0;

				if (check == "1") {

					for (var x = 0; x < value.length; x++) {

						if (value[x].run >= runFrom && value[x].run <= runTo) {
							yTitle = value[x].yTitle;
							xAxisValues.push(value[x].run);
							myYValues.push(value[x].y);
							// var yErr = value[x].y - value[x].yErr;
							var yErrUp = value[x].y + value[x].yErr;
							var yErrDown = value[x].y - value[x].yErr;
							
							// myYErrValues.push([ value[x].x, yErr ]);
							myYErrValues.push([ yErrDown, yErrUp ]);
						}

					}
				}
				if (check == "0") {

					for (i; i < value.length; i++) {

						yTitle = value[i].yTitle;
						xAxisValues.push(value[i].run);
						myYValues.push(value[i].y);
						var yErrUp = value[i].y + value[i].yErr;
						var yErrDown = value[i].y - value[i].yErr;
						
						
						myYErrValues.push([ yErrDown, yErrUp ]);

					}
				}
				yArray.push(myYValues);
				yErrArray.push(myYErrValues);
			}

		};

		xmlhttp.open("GET", url, false);
		xmlhttp.send();
	}

	return data;

}