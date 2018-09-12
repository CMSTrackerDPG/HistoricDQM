var year;
var dataSet;
var apvMode;
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

		urlLink="/2018/StreamExpress/PixelPhase1/"
		$.getJSON("monitoring.json", function (data) {
			collections = data;
			console.log("-->", collections);
			name="PixelPhase1";
			load_dataset(name);
		});

		$.getJSON("alljsons/2018/Run_LHCFill_RunDuration.json", function (data) {
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
		$("#search").click(
			function () {
				console.log("SUBMIT!");
				name="PixelPhase1";
				load_dataset(name);
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
