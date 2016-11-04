var start;
var end;
var yArray = [];
var yMinArray = [];
var yMaxArray = [];
var yErrArray = [];
var xAxisValues = [];
var myYValues = [];
var myYValue_max = 0;
var myYValue_min = 0;
var myYErrValues = [];
var urlLink = "";
var colors = [];
var type = "";
var yTitle = "";
var runFrom = 0;
var runTo = 0;
jQuery(document).ready(
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

			$('.popUp[rel*=facebox]').facebox();
			var year = sessionStorage.getItem("year");
			var dataSet = sessionStorage.getItem("dataSet");
			var apvMode = sessionStorage.getItem("apvMode");
			var subsystem = sessionStorage.getItem("subsystem");
			runFrom = sessionStorage.getItem("runFrom");
			runTo = sessionStorage.getItem("runTo");
			runFrom = sessionStorage.getItem("runFrom");
			var urlFromSession = sessionStorage.getItem("url");
			console.log("urlFromSession : " + urlFromSession);
			console.log("apvMode : " + apvMode);
 
			console.log("runFrom: " + runFrom);
			console.log("runTo: " + runTo);
			
				if (apvMode == "" || apvMode == "null" || apvMode == "PEAK + DECO") { 
					urlLink = "/" + year + "/Prompt/" + dataSet + "/"
							+ subsystem;
				     if (dataSet == "StreamExpress" || dataSet == "StreamExpressCosmics") {
				          urlLink = "/" + year + "/" + dataSet + "/"
							+ subsystem;
				     }							     			
				} else {
				  if (dataSet == "StreamExpress") {
					urlLink = "/" + year + "/" + dataSet + "/"
							+ subsystem + "/" + apvMode;
				  } else if (dataSet == "StreamExpressCosmics") {
					urlLink = "/" + year + "/" + dataSet + "/"
							+ subsystem + "/" + apvMode;
				  } else if (dataSet == "Cosmics") {
					urlLink = "/" + year + "/Prompt/" + dataSet + "/"
							+ subsystem + "/" + apvMode;
				  } else {
					urlLink = "/" + year + "/Prompt/" + dataSet + "/"
							+ subsystem + "/" + apvMode;
				  }
				}
				console.log("urlLink : " + urlLink);
                                
			
			if (runFrom == -1 && runTo == -1) {
				type = 0;
				console.log("type : " + type);
			} else if (runFrom >= 0 || runTo >= 0) {
				type = 1;
				console.log("type : " + type);
			}
                       
			$("input:checkbox").each(function() {
				$(this).prop('checked', true);
				upgradeGraph(this);

			});
		});
$(function() {
	for (var i = 1; i <= 10; i++) {
		$('.button-checkbox' + i)
				.each(
						function() {

							// Settings
							var $widget = $(this), $button = $widget
									.find('button'), $checkbox = $widget
									.find('input:checkbox'), color = $button
									.data('color'), settings = {
								on : {
									icon : 'glyphicon glyphicon-check'
								},
								off : {
									icon : 'glyphicon glyphicon-unchecked'
								}
							};

							// Event Handlers
							$button.on('click', function() {
								$checkbox.prop('checked', !$checkbox
										.is(':checked'));
								$checkbox.triggerHandler('change');
								updateDisplay();
							});
							$checkbox.on('change', function() {
								updateDisplay();
							});

							// Actions
							function updateDisplay() {
								var isChecked = $checkbox.is(':checked');

								// Set the button's state
								$button.data('state', (isChecked) ? "on"
										: "off");

								// Set the button's icon
								$button
										.find('.state-icon')
										.removeClass()
										.addClass(
												'state-icon '
														+ settings[$button
																.data('state')].icon);

								// Update the button's color
								if (isChecked) {
									$button.removeClass('btn-default')
											.addClass(
													'btn-' + color + ' active');
								} else {
									$button.removeClass(
											'btn-' + color + ' active')
											.addClass('btn-default');
								}
							}

							// Initialization
							function init() {

								updateDisplay();

								// Inject the icon if applicable
								if ($button.find('.state-icon').length == 0) {
									$button
											.prepend('<i class="state-icon '
													+ settings[$button
															.data('state')].icon
													+ '"></i> ');
								}
							}
							init();
						});
	}
});

function upgradeGraph(sel) {

	start = 0;
	end = 0;
	yArray = [];
	yErrArray = [];
	var name = sel.name;
	myYValues = [];
	myYErrValues = [];
	var jsons = [];

	$("input:checkbox").each(function() {
		if ($(this).is(":checked")) {
			if (name === $(this).attr('name')) {
				jsons.push($(this).attr('value'));
			}
		}

	});

	if (type === 1) {
		console.log(jsons);
		scatterData(jsons, 1);
	} else {

		scatterData(jsons, 0);
	}

	console.log("Y List : " + yArray.length);
	console.log("Y Err List : " + yErrArray.length);
	chart = new Highcharts.Chart({
		chart : {
			renderTo : (name),
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
			},
			min: myYValue_min,
			max: myYValue_max

		},
		scatter : {
			marker : {
				radius : 2
			}
		}
	});

	for (var i = 0; i < yArray.length; i++) {
		console.log("Adding: " + i);
		chart
				.addSeries({
					name : jsons[i].split(".")[0],
					type : 'scatter',
					data : yArray[i],
					color : colors[i],
					tooltip : {
						headerFormat : "",
						pointFormat : '<span style="color:{series.color}"></span><b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>'
								+ yTitle + ': </b>{point.y}'
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
	console.log("Check: " + check);
	console.log("jsons: " + jsons);
	var data = [];
	var maxYValue = 0;
	var minYValue = 0;
	var jsonYminValue = 0;
	var jsonYmaxValue = 0;
	var lowRun = 0;
	var upRun = 0;
	var upRunId = 0;	
	for (var i = 0; i < jsons.length; i++) {
		myYValues = [];
		myYErrValues = [];
		xAxisValues = [];
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
                                var j = 0;

				if (check == "1") {
					console.log("In 1: " + value.length);
					console.log("runFrom: " + runFrom);
					console.log("runTo: " + runTo);
				        
					upRunId = value.length -1;
				        lowRun = runFrom;
					upRun = runTo;
					if(lowRun == 0) lowRun = value[0].run;
					if(upRun == 0 ) upRun = value[upRunId].run;
					
					console.log("lowRun: " + lowRun);
					console.log("upRun: " + upRun);
					for (j; j < value.length; j++) {
                                                
						if (value[j].run >= lowRun && value[j].run <= upRun) {
							yTitle = value[j].yTitle;
							xAxisValues.push(value[j].run);
							myYValues.push(value[j].y);
                                                        
							if( value[j].y > maxYValue ){ maxYValue  = value[j].y;} 
                                                        if( value[j].y < minYValue ){ minYValue  = value[j].y;} 

                                                        jsonYminValue = value[j].yMin;
				                        jsonYmaxValue = value[j].yMax;

							var yErrUp = value[j].y + value[j].yErr;
							var yErrDown = value[j].y - value[j].yErr;

							// myYErrValues.push([ value[i].x, yErr ]);
							myYErrValues.push([ yErrDown, yErrUp ]);
					               
//						        console.log("J value  : " + j );
//	                                                console.log("Run 1 : " +  value[j].run);
//	                                                console.log("Run 2 : " +  xAxisValues);
//					                console.log("Y  : " + value[j].y );
						}

					}
				}
				if (check == "0") {
					console.log("In 0");
					for (i; i < value.length; i++) {

						yTitle = value[i].yTitle;
						xAxisValues.push(value[i].run);
						myYValues.push(value[i].y);

                                                if( value[i].y > maxYValue ){ maxYValue  = value[i].y;} 
                                                if( value[i].y < minYValue ){ minYValue  = value[i].y;} 

                                                jsonYminValue = value[i].yMin;
				                jsonYmaxValue = value[i].yMax;
								      

						var yErrUp = value[i].y + value[i].yErr;
						var yErrDown = value[i].y - value[i].yErr;
						// myYErrValues.push([ value[i].x, yErr ]);
						myYErrValues.push([ yErrDown, yErrUp ]);
                                             
					       console.log("i value  : " + i );
	                                       console.log("Run  : " + value[i].run );
					       console.log("Y  : " + value[i].y );

					}
				}
				yArray.push(myYValues);
				yErrArray.push(myYErrValues);
                     
		                console.log("JsonYValue Max : " + jsonYmaxValue );
	                        console.log("JsonYValue Min : " + jsonYminValue );
                    
		                myYValue_max  =   jsonYmaxValue;
		                myYValue_min  = jsonYminValue;
		       
		                if( (jsonYmaxValue == 0 ) || (jsonYmaxValue == jsonYminValue ) ) {  
                                    myYValue_max  = 1.5*maxYValue;
                                    myYValue_min  = 1.5*minYValue;
                                    if( myYValue_min == 0) { 
		                        myYValue_min = -20;
                                        if( maxYValue < 10  ) myYValue_min = -0.2;
					if( maxYValue < 0.001  ) {
					   myYValue_max = 0.0005;
					   myYValue_min = -0.0001;
					}   
                                    }
                                }
                                
				console.log("MyYValue Max : " + myYValue_max );
	                        console.log("MyYValue Min : " + myYValue_min );

	               }

		}

		xmlhttp.open("GET", url, false);
		xmlhttp.send();
	}

	return data;

}
function popup(sel) {
	var count = sessionStorage.length;
	console.log("Storage Length before: " + count);
	sessionStorage.clear();
	count = sessionStorage.length;
	console.log("Storage Length after: " + count);
	sessionStorage.setItem("url", urlLink);
	sessionStorage.setItem("year", year);
	sessionStorage.setItem("dataSet", dataSet);
	sessionStorage.setItem("apvMode", apvMode);
	sessionStorage.setItem("subsystem", subsystem);
	sessionStorage.setItem("runFrom", runFrom);
	sessionStorage.setItem("runTo", runTo);
	var num = 0;
	var name = sel.name;

	$("input:checkbox").each(function() {
		if ($(this).is(":checked")) {
			if (name === $(this).attr('name')) {

				sessionStorage.setItem("json" + num, $(this).attr('value'));
				num++;
			}
		}
	});

}
