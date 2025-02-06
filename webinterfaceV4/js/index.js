var year;
var dataSet;
var apvMode;
var fullMode;
var subsystem;
var colors = [];

var list_file_str = "";
var global_filters = {};

var collections = {}; //contains file names for each dataset
var chart_list = null; //global ref to ChartList instance

var runs_data = [];
//var show_fills = true;

function load_dataset(name) {
	var need_refresh = false;
	update_filters();

	console.log("index.js -> dataset name = ", name);
	console.log("index.js -> chart_list = ", chart_list);
	//console.log("index.js -> need_update = ", need_update);
	//console.log("index.js -> need_refresh = ", need_refresh);   
	if (chart_list == null) {
		need_refresh = true;
		console.log("index.js -> chart_list == null -> put need_refresh = true");
	}
	else {
		console.log("index.js -> chart_list != null");
		if (name != chart_list.dataset) {
			//        if (name != chart_list.dataset || need_update) { // Aris
			console.log("index.js -> name != chart_list.dataset -> destroy all charts and create new ones");
			need_refresh = true;
			chart_list.charts.forEach(function (c) {
				c.destroy();
			});
			$("#body").html("");
		}
	}
	if (need_refresh) {
	    //if (dataSet === "StreamExpress" || dataSet === "ZeroBias")
	    //		$.ajax({
	    //			dataType: "json",
	    //			url: ("alljsons/" + year + "/Run_LHCFill.json"),
	    //			async: false,
	    //			success: function (data) {
	    //				run_fill = data["Run_LHCFill.json"].map(x => ({ run: parseInt(x['run']), lhcfill: x['lhcfill'] }));
	    //				console.log("fills loaded");
	    //			}
	    //		});
		update_collections();
		console.log("--> ",collections[name]);
		chart_list = new ChartList(name, collections[name]);
		//console.log("index.js -> need_refresh = true");
		//console.log("index.js -> new chart_list = ", chart_list);
		console.log("index.js ->  chart_list.dataset = ", chart_list.dataset);
	}
	else {
		chart_list.update();
	}
}

function is_num(x) {
	return !isNaN(parseFloat(x))
}

function update_filters() {
	var mode = document.getElementById("filter-runs").checked ? $("#runs-mode").val() : "all";
	switch (mode) {
		case "run-filter-latest":
			global_filters.runs = new Filter(true, mode, parseInt($("#run-latest").val()));
			break;
		case "run-filter-range":
			global_filters.runs = new Filter(true, mode, new NumRange(parseInt($("#runFrom").val()), parseInt($("#runTo").val())));
			break;
		case "run-filter-list":
			global_filters.runs = new Filter(true, mode, parse_runs_list($("#run-list").val()));
			break;
		case "run-filter-file":
			global_filters.runs = new Filter(true, mode, parse_runs_list(list_file_str));
			break;
		default:
			global_filters.runs = new Filter(false);
	}
	global_filters.y_values = new Filter(
		document.getElementById("filter-y").checked,
		"",
		new NumRange(
			parseFloat($("#y-from").val()),
			parseFloat($("#y-to").val())
		),
		(a, b) => (a !== undefined) && a.equals(b)
	);
	global_filters.errors = $("#show-errors")[0].checked;
	global_filters.fills = $("#show-fills")[0].checked;
	global_filters.durations = $("#show-durations")[0].checked;
	global_filters.regression = $("#show-regression")[0].checked;
}

function parse_runs_list(str) {
	var regex = /(([0-9]+)[ ]*-[ ]*([0-9]+))|([0-9]+)/g;
	var result = new NumSet();
	while (1) {
		var match = regex.exec(str);
		if (match === null)
			break;
		if (match[1] !== undefined) {
			var min = parseInt(match[2]);
			var max = parseInt(match[3]);
			result.add(new NumRange(min, max));
		}
		else {
			result.add(parseInt(match[0]));
		}
	}
	return result;
}

function update_url() {
	if (apvMode == "" || apvMode === null || apvMode == "PEAK + DECO") {
		urlLink = "/" + year + "/Prompt/" + dataSet + "/"
			+ subsystem;
		if (dataSet == "StreamExpress" || dataSet == "StreamExpressCosmics" || dataSet == "StreamExpressCosmicsCommissioning" || dataSet == "ReReco" || dataSet == "UltraLegacy" || dataSet == "StreamHLTMonitor") {
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
		} else if (dataSet == "StreamExpressCosmicsCommissioning") {
			urlLink = "/" + year + "/" + dataSet + "/"
				+ subsystem + "/" + apvMode;
		} else if (dataSet == "Cosmics") {
			urlLink = "/" + year + "/Prompt/" + dataSet + "/"
				+ subsystem + "/" + apvMode;
		} else if (dataSet == "CosmicsCommissioning") {
			urlLink = "/" + year + "/Prompt/" + dataSet + "/"
				+ subsystem + "/" + apvMode;
		} else if (dataSet == "ReReco") {
			urlLink = "/" + year + "/" + dataSet + "/"
				+ subsystem + "/" + apvMode;		    
		} else if (dataSet == "UltraLegacy") {
			urlLink = "/" + year + "/" + dataSet + "/"
				+ subsystem + "/" + apvMode;		    
		} else {
			urlLink = "/" + year + "/Prompt/" + dataSet + "/"
				+ subsystem + "/" + apvMode;

		}
	}
	console.log("urlLink : " + urlLink);
}

function update_subsystem() {
    if ($("#subsystem").val() == "Strips") {
	$("#apvMode").prop("disabled", true);
	$("#apvMode").val("DECO");
    } else {
	$("#apvMode").prop("disabled", true);
	$("#apvMode").val("No Selection");
    }
}

function update_collections() {

	collec_file = "collections_" + $("#year").val() + ".json";
	console.log("collection file  : " + collec_file);

	$.getJSON(collec_file, function (data) {
		//$.getJSON(collec_file, function (data) {
		collections = data;
	    });

}


function getCollectionName(dset,subsys,apv,extra) {
    var name="";
    if (dset == "ZeroBias" || dset == "ReReco" || dset== "UltraLegacy"){
	if(subsys == "PixelPhase1") name="PixelPhase1";
	else if(subsys == "Strips") name="Strips";
	else if(subsys == "Tracking") name="Tracking";
	else if(subsys == "RecoErrors") name="RecoErrors";
	else if(subsys == "Pixel") name="Pixel";
    }
    else if (dset == "StreamExpress"){
	if(subsys == "PixelPhase1") name="ExpressPixelPhase1";
	else if(subsys == "Strips") name="ExpressStrips";
	else if(subsys == "Tracking") name="ExpressTracking";
	else if(subsys == "RecoErrors") name="ExpressRecoErrors";
	else if(subsys == "Pixel") name="ExpressPixel";
    }

    else if (dset == "Cosmics"){
	if(subsys == "PixelPhase1") name="CosmicsPixelPhase1";
	else if(subsys == "Strips") name="CosmicsStrips";
	else if(subsys == "Tracking") name="CosmicsTracking";
	else if(subsys == "RecoErrors") name="CosmicsRecoErrors";
	else if(subsys == "Pixel") name="CosmicsPixel";
    }
    else if (dset == "StreamExpressCosmics"){
	if(subsys == "PixelPhase1") name="ExpressCosmicsPixelPhase1";
	else if(subsys == "Strips") name="ExpressCosmicsStrips";
	else if(subsys == "Tracking") name="ExpressCosmicsTracking";
	else if(subsys == "RecoErrors") name="ExpressCosmicsRecoErrors";
	else if(subsys == "Pixel") name="ExpressCosmicsPixel";
    }

    else if (dset == "StreamExpressCosmicsCommissioning"){
	if(subsys == "PixelPhase1") name="SreamExpressCosmicPixelPhase1";
	else if(subsys == "Strips"){
	    if(apv=="PEAK") name="StripPeakStreamExpressCosmicsCommissioning";
	    else name="StripDecoStreamExpressCosmicsCommissioning";
	}
	else if(subsys == "Tracking") name="StreamExprCosmicTracking";
	else if(subsys == "RecoErrors") name="StreamExprCosmicsRecoErrors";
	else if(subsys == "Pixel") name="SreamExpressCosmicPixel";
    }
    else if (dset == "CosmicsCommissioning"){
	if(subsys == "PixelPhase1") name="CosmicPixelPhase1";
	else if(subsys == "Strips"){
	    if(apv=="PEAK") name="StripPeakCosmicsCommissioning";
	    else name="StripDecoCosmicsCommissioning";
	}
	else if(subsys == "Tracking") name="CosmicTracking";
	else if(subsys == "RecoErrors") name="CosmicsRecoErrors";
	else if(subsys == "Pixel") name="CosmicPixel";
    }
    else if (dset == "StreamHLTMonitor"){
	if(subsys == "PixelPhase1") name="HLTPixelPhase1";
	else if(subsys == "Strips"){
	    name="HLTStrip"
	}
	else if(subsys == "Tracking") name="HLTTracking";
	else if(subsys == "RecoErrors") name="HLTRecoErrors";
    }

    if (extra == "Extra") name = name+"Extra";
    console.log("Collection name : "+name);

    return name;
}




function update_runDurationFile() {
    
    if($("#dataSet").val().includes("Cosmics")){
	duration_file= "alljsons/"+$("#year").val()+"/Run_LHCFill_RunDuration_Cosmics.json";
	fname="Run_LHCFill_RunDuration_Cosmics.json";
    }
    else{
	duration_file= "alljsons/"+$("#year").val()+"/Run_LHCFill_RunDuration.json";
	fname="Run_LHCFill_RunDuration.json";
    }
    $.getJSON(duration_file, function (data) {
	    runs_data = data[fname].map(x => ({ run: parseInt(x['run']), lhcfill: x['lhcfill'], dur: x['rundur'] }));
	    console.log("runs_data loaded : "+fname);
	});


}

function make_modal(id) {
	let modal = document.getElementById(id);
	$(modal).find(".close").click(function() {
		modal.style.display = "none";
	});
	$(window).click(function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	});
}

$(document).ready(
	function () {
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

		// collec_file = "collections_" + $("#year").val() + ".json";
		// console.log("collection file  : " + collec_file);

		$.getJSON("collections_2023.json", function (data) {
			//$.getJSON(collec_file, function (data) {
			collections = data;
		});

		$.getJSON("alljsons/2023/Run_LHCFill_RunDuration.json", function (data) {
			runs_data = data["Run_LHCFill_RunDuration.json"].map(x => ({ run: parseInt(x['run']), lhcfill: x['lhcfill'], dur: x['rundur'] }));
			console.log("runs_data loaded");
		});

		$('<ul id="list" style="white-space:nowrap;overflow-x:auto"></ul>').appendTo('#list-cotnainer');

		$("#" + $("#runs-mode").val()).show();
		$("#runs-mode").change(function (e) {
			$(".runs-input").hide();
			$("#" + this.value).show();
		});

		$(".runs-input input").attr("disabled", !document.getElementById("filter-runs").checked);
		$("#filter-runs").change(function (e) {
			$(".runs-input input, #runs-mode").attr("disabled", !this.checked);
		});

		$(".y-input input").attr("disabled", !document.getElementById("filter-y").checked);
		$("#filter-y").change(function (e) {
			$(".y-input input").attr("disabled", !this.checked);
		});

		// this must be a DOM input element of type "file"
		var readListFile = function () {
			if (this.files[0] !== undefined) {
				var reader = new FileReader();
				reader.onload = function () {
					list_file_str = reader.result;
				};
				reader.readAsText(this.files[0]);
			}
		};

		readListFile.apply($("#list-file").change(readListFile)[0]);

		document.getElementById("myBtn").onclick = function() {
			$("#myModal").show();
		}

		make_modal("myModal");
		make_modal("popup");
		$("#apvMode").prop("disabled", true);
		$("#apvMode").val("No Selection");
		$("#search").click(
			function () {
			    console.log("SUBMIT!");
			    year = $("#year").val();
			    dataSet = $("#dataSet").val();
			    subsystem = $("#subsystem").val();
			    apvMode = $("#apvMode").val();
			    fullMode = $("#fullMode").val();
			    
				if (year == "" || dataSet == "" || apvMode == "" || subsystem == "") {
					alert("Please Make Selection");
				} else {
					update_url(dataSet, subsystem, year);
					/*update_url(apvMode, dataSet, subsystem, year);*/
					console.log("update_url executed.............");
					name="";
				    name=getCollectionName(dataSet,subsystem,apvMode,fullMode);
					if(name!=""){
					    load_dataset(name);
					} else {
					    $("#body").load("404page.html");
					}
				}
			});
	});

class NumRange {
	constructor(min, max) {
		this.min = isNaN(min) ? -Infinity : min;
		this.max = max > this.min ? max : Infinity;
	}

	equals(other) {
		if (other && this.min === other.min && this.max === other.max)
			return true;
		return false;
	}

	contains(val) {
		if (val >= this.min && val <= this.max)
			return true;
		return false;
	}
}

// A collection of single values and ranges
class NumSet {
	constructor() {
		this.singles = new Set([]);
		this.ranges = [];
	}

	add(x) {
		if (typeof(x) === "number")
			this.singles.add(x);
		if (x.min !== undefined) {
			this.ranges.push(x);
		}
		this.compressed = false;
	}

	contains(x) {
		if (this.singles.has(x))
			return true;
		for (var range of this.ranges) {
			if (range.contains(x))
				return true;
		}
		return false;
	}

	compress() {
		if (this.compressed) return;
		this.ranges.sort((a, b) => a.min < b.min);
		var result = [this.ranges[0]];
		var top = this.ranges[0].max;
		for (var i = 1; i < this.ranges.length - 1; i++) {
			var range = this.ranges[i];
			if (range.min < top) {
				if (range.max < top) 
					continue;
				top = range.max;
				result[result.length - 1].max = top;
			}
			else {
				result.push(range);
				top = range.max;
			}
		}
		this.ranges = result;
		result = new Set([]);
		for (var single of this.singles) {
			for (var range of this.ranges) {
				if (!range.contains(single)) {
					result.add(single);
				}
			}
		}
		this.singles = result;
		this.compressed = true;
	}

	equals(other) {
		console.log("NumSet.equals: ",this, other)
		if (this.ranges.length === 0)
			return other.ranges.length === 0;
		if (other.ranges.length === 0)
			return false;
		this.compress();
		other.compress();
		if (this.ranges.length !== other.ranges.length)
			return false;
		for (var x of this.singles) {
			if (!other.singles.has(x))
				return false;
		}
		for (var y of other.singles) {
			if (!this.singles.has(y))
				return false;
		}
		for (var i = 0; i < this.ranges.length; i++) {
			if (!this.ranges[i].equals(other.ranges[i]))
				return false;
		}
		return true;
	}
}

// class NumSet {
// 	constructor(set) {
// 		this.set = set;
// 	}

// 	contains(val) {
// 		return this.set.has(val);
// 	}

// 	equals(other) {
// 		if (this !== b) {
// 			if (!b) { return false; }
// 			for (var e of a.set) {
// 				if (!b.contains(e)) { return false; }
// 			}
// 		}
// 		return true;
// 	}
// }

class Filter {
	constructor(enabled, mode, val) {
		this.enabled = enabled;
		this.mode = mode;
		this.val = val;
	}

	equals(other) {
		return this === other ||
			(!this.enabled && !other.enabled) ||
			(
				this.enabled && other.enabled &&
				this.mode === other.mode &&
				(
					this.val === other.val || 
					(typeof this.val.equals === 'function' && this.val.equals(other.val))
				)
			);
	}
}

function common_positions(a, b) {
	var j = 0;
	var pos_a = [];
	var pos_b = [];
	for (var i = 0; i < a.length; i++) {
		while (a[i] > b[j]) {
			j++;
		}
		if (a[i] === b[j]) {
			pos_a.push(i);
			pos_b.push(j);
		}
	}
	return [pos_a, pos_b];
}
