var yArray = [];
var yErrArray = [];
var xAxisValues = [];
var myYValues = [];
var myYErrValues = [];
var start;
var end;
var urlLink = "";
var yTitle="";
var colors = [];
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
			var runFrom = sessionStorage.getItem("runFrom");
			var runTo = sessionStorage.getItem("runTo");
			if (apvMode == "") {
				urlLink = "/" + year + "/Prompt/" + dataSet + "/" + subsystem;
			} else {
				urlLink = "/" + year + "/Prompt/" + dataSet + "/" + subsystem
						+ "/" + apvMode;
			}
			
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

	yArray = [];
	yErrArray = [];
	start = 0;
	end = 0;
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

	if (sel.value === "button") {

		$("input:text").each(function() {

			if (name === $(this).attr('name')) {
				if ($(this).attr('id') === "start") {
					start = $(this).val();

				}
				if ($(this).attr('id') === "end") {
					end = $(this).val();

				}

			}
		});

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
			}
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
						pointFormat : '<span style="color:{series.color}"></span><b>{point.series.name}</b><br> <b>Run No:</b> {point.category}<br/><b>'+yTitle+': </b>{point.y}'
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
		//var url = "alljsons" + urlLink + "/" + jsons[i];
		var url = "alljsons/" + jsons[i];

		var parameters = location.search;

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				var myArr = JSON.parse(xmlhttp.responseText);

				var jsonName = "clusterCharge_ONTk_TIB_L1_mpv";
				var temp = jsonName;

				var value = myArr[temp];

				var i = value.length;
				i = i - 100;
				if (i < 0)
					i = 0;

				if (check == "1") {

					for (var x = 0; x < value.length; x++) {

						if (value[x].run >= start && value[x].run <= end) {
							xAxisValues.push(value[x].run);
							myYValues.push(value[x].y);
							yTitle=value[x].yTitle;
							// var yErr = value[x].y - value[x].yErr;
							var yErrUp = value[x].y + value[x].yErr;
							var yErrDown = value[x].y - value[x].yErr;
							if (yErrDown < 0)
								yErrDown = value[x].y;
							// myYErrValues.push([ value[x].x, yErr ]);
							myYErrValues.push([ yErrDown, yErrUp ]);
						}

					}
				}
				if (check == "0") {

					for (i; i < value.length; i++) {

						xAxisValues.push(value[i].run);
						myYValues.push(value[i].y);
						yTitle=value[i].yTitle;
						var yErrUp = value[i].y + value[i].yErr;
						var yErrDown = value[i].y - value[i].yErr;
						if (yErrDown < 0)
							yErrDown = value[i].y;
						// myYErrValues.push([ value[i].x, yErr ]);
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
function popup(sel) {
	var count = sessionStorage.length;

	for (var x = 0; x <= count; x++) {

		sessionStorage.removeItem(sessionStorage.key(x));
	}
	count = sessionStorage.length;

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