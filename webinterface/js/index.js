$(document).ready(
		function() {
			$("#search").click(
					function() {
						var year = $("#year").val();
						var dataSet = $("#dataSet").val();
						var apvMode = $("#apvMode").val();
						var subsystem = $("#subsystem").val();
						var runFrom = $("#runFrom").val();
						var runTo = $("#runTo").val();
						if (year == "" || dataSet == "" || subsystem == "") {
							alert("Please Make Selection");
						} else {
							var count = sessionStorage.length;

							for (var x = 0; x <= count; x++) {

								sessionStorage
										.removeItem(sessionStorage.key(x));
							}
							count = sessionStorage.length;
							sessionStorage.setItem("year", year);
							sessionStorage.setItem("dataSet", dataSet);
							sessionStorage.setItem("apvMode", apvMode);
							sessionStorage.setItem("subsystem", subsystem);
							if (runFrom == "") {
								sessionStorage.setItem("runFrom", -1);
								sessionStorage.setItem("runTo", -1);
							} else {
								sessionStorage.setItem("runFrom", runFrom);
								sessionStorage.setItem("runTo", runTo);
							}

							if (dataSet == "ZeroBias"
									&& subsystem == "Pixel"
									&& (apvMode == "" || apvMode == null)) {
								$("#body").load("PixelCombined.html");
							} else if (dataSet == "ZeroBias"
									&& subsystem == "Tracking"
									&& (apvMode == "" || apvMode == null)) {
								$("#body").load("Tracking.html");

							} else if ((dataSet == "ZeroBias" || dataSet == "StreamExpress")
									&& subsystem == "Strips"
									&& apvMode == "DECO") {
								$("#body").load("StripDeco.html");
							} else {
								$("#body").load("404page.html");
							}

						}

					});

		});

function subsystem() {
	if ($("#subsystem").val() == "Pixel" || $("#subsystem").val() == "Tracking") {
		$("#apvMode").prop("disabled", true);
		$("#apvMode").val("No Selection");
	} else {
		$("#apvMode").prop("disabled", false);
		if ($("#apvMode").val() == null) {
			$("#apvMode").val("");
		}	
	}
}
