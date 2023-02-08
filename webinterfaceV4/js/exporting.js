/*
 Highcharts JS v10.2.1 (2022-08-29)

 Exporting module

 (c) 2010-2021 Torstein Honsi

 License: www.highcharts.com/license
*/
(function(a) {
    "object" === typeof module && module.exports ? (a["default"] = a, module.exports = a) : "function" === typeof define && define.amd ? define("highcharts/modules/exporting", ["highcharts"], function(k) {
        a(k);
        a.Highcharts = k;
        return a
    }) : a("undefined" !== typeof Highcharts ? Highcharts : void 0)
})(function(a) {
    function k(a, b, u, D) {
        a.hasOwnProperty(b) || (a[b] = D.apply(null, u), "function" === typeof CustomEvent && window.dispatchEvent(new CustomEvent("HighchartsModuleLoaded", {
            detail: {
                path: b,
                module: a[b]
            }
        })))
    }
    a = a ? a._modules : {};
    k(a,
        "Core/Chart/ChartNavigationComposition.js", [],
        function() {
            var a;
            (function(a) {
                a.compose = function(a) {
                    a.navigation || (a.navigation = new b(a));
                    return a
                };
                var b = function() {
                    function a(a) {
                        this.updates = [];
                        this.chart = a
                    }
                    a.prototype.addUpdate = function(a) {
                        this.chart.navigation.updates.push(a)
                    };
                    a.prototype.update = function(a, z) {
                        var b = this;
                        this.updates.forEach(function(d) {
                            d.call(b.chart, a, z)
                        })
                    };
                    return a
                }();
                a.Additions = b
            })(a || (a = {}));
            return a
        });
    k(a, "Extensions/Exporting/ExportingDefaults.js", [a["Core/Globals.js"]], function(a) {
        a =
            a.isTouchDevice;
        return {
            exporting: {
                type: "image/png",
                url: "https://export.highcharts.com/",
                pdfFont: {
                    normal: void 0,
                    bold: void 0,
                    bolditalic: void 0,
                    italic: void 0
                },
                printMaxWidth: 780,
                scale: 2,
                buttons: {
                    contextButton: {
                        className: "highcharts-contextbutton",
                        menuClassName: "highcharts-contextmenu",
                        symbol: "menu",
                        titleKey: "contextButtonTitle",
                        menuItems: "viewFullscreen printChart separator downloadPNG downloadJPEG downloadPDF downloadSVG".split(" ")
                    }
                },
                menuItemDefinitions: {
                    viewFullscreen: {
                        textKey: "viewFullscreen",
                        onclick: function() {
                            this.fullscreen &&
                                this.fullscreen.toggle()
                        }
                    },
                    printChart: {
                        textKey: "printChart",
                        onclick: function() {
                            this.print()
                        }
                    },
                    separator: {
                        separator: !0
                    },
                    downloadPNG: {
                        textKey: "downloadPNG",
                        onclick: function() {
                            this.exportChart()
                        }
                    },
                    downloadJPEG: {
                        textKey: "downloadJPEG",
                        onclick: function() {
                            this.exportChart({
                                type: "image/jpeg"
                            })
                        }
                    },
                    downloadPDF: {
                        textKey: "downloadPDF",
                        onclick: function() {
                            this.exportChart({
                                type: "application/pdf"
                            })
                        }
                    },
                    downloadSVG: {
                        textKey: "downloadSVG",
                        onclick: function() {
                            this.exportChart({
                                type: "image/svg+xml"
                            })
                        }
                    }
                }
            },
            lang: {
                viewFullscreen: "View in full screen",
                exitFullscreen: "Exit from full screen",
                printChart: "Print chart",
                downloadPNG: "Download PNG image",
                downloadJPEG: "Download JPEG image",
                downloadPDF: "Download PDF document",
                downloadSVG: "Download SVG vector image",
                contextButtonTitle: "Chart context menu"
            },
            navigation: {
                buttonOptions: {
                    symbolSize: 14,
                    symbolX: 12.5,
                    symbolY: 10.5,
                    align: "right",
                    buttonSpacing: 3,
                    height: 22,
                    verticalAlign: "top",
                    width: 24,
                    symbolFill: "#666666",
                    symbolStroke: "#666666",
                    symbolStrokeWidth: 3,
                    theme: {
                        padding: 5
                    }
                },
                menuStyle: {
                    border: "1px solid ".concat("#999999"),
                    background: "#ffffff",
                    padding: "5px 0"
                },
                menuItemStyle: {
                    padding: "0.5em 1em",
                    color: "#333333",
                    background: "none",
                    fontSize: a ? "14px" : "11px",
                    transition: "background 250ms, color 250ms"
                },
                menuItemHoverStyle: {
                    background: "#335cad",
                    color: "#ffffff"
                }
            }
        }
    });
    k(a, "Extensions/Exporting/ExportingSymbols.js", [], function() {
        var a;
        (function(a) {
            function b(a, b, d, l) {
                return [
                    ["M", a, b + 2.5],
                    ["L", a + d, b + 2.5],
                    ["M", a, b + l / 2 + .5],
                    ["L", a + d, b + l / 2 + .5],
                    ["M", a, b + l - 1.5],
                    ["L", a + d, b + l - 1.5]
                ]
            }

            function t(a, b, d, l) {
                a = l / 3 - 2;
                l = [];
                return l = l.concat(this.circle(d -
                    a, b, a, a), this.circle(d - a, b + a + 4, a, a), this.circle(d - a, b + 2 * (a + 4), a, a))
            }
            var n = [];
            a.compose = function(a) {
                -1 === n.indexOf(a) && (n.push(a), a = a.prototype.symbols, a.menu = b, a.menuball = t.bind(a))
            }
        })(a || (a = {}));
        return a
    });
    k(a, "Extensions/Exporting/Fullscreen.js", [a["Core/Renderer/HTML/AST.js"], a["Core/Utilities.js"]], function(a, b) {
        function t() {
            this.fullscreen = new A(this)
        }
        var k = b.addEvent,
            n = b.fireEvent,
            z = [],
            A = function() {
                function b(a) {
                    this.chart = a;
                    this.isOpen = !1;
                    a = a.renderTo;
                    this.browserProps || ("function" === typeof a.requestFullscreen ?
                        this.browserProps = {
                            fullscreenChange: "fullscreenchange",
                            requestFullscreen: "requestFullscreen",
                            exitFullscreen: "exitFullscreen"
                        } : a.mozRequestFullScreen ? this.browserProps = {
                            fullscreenChange: "mozfullscreenchange",
                            requestFullscreen: "mozRequestFullScreen",
                            exitFullscreen: "mozCancelFullScreen"
                        } : a.webkitRequestFullScreen ? this.browserProps = {
                            fullscreenChange: "webkitfullscreenchange",
                            requestFullscreen: "webkitRequestFullScreen",
                            exitFullscreen: "webkitExitFullscreen"
                        } : a.msRequestFullscreen && (this.browserProps = {
                            fullscreenChange: "MSFullscreenChange",
                            requestFullscreen: "msRequestFullscreen",
                            exitFullscreen: "msExitFullscreen"
                        }))
                }
                b.compose = function(a) {
                    -1 === z.indexOf(a) && (z.push(a), k(a, "beforeRender", t))
                };
                b.prototype.close = function() {
                    var a = this,
                        b = a.chart,
                        f = b.options.chart;
                    n(b, "fullscreenClose", null, function() {
                        if (a.isOpen && a.browserProps && b.container.ownerDocument instanceof Document) b.container.ownerDocument[a.browserProps.exitFullscreen]();
                        a.unbindFullscreenEvent && (a.unbindFullscreenEvent = a.unbindFullscreenEvent());
                        b.setSize(a.origWidth, a.origHeight, !1);
                        a.origWidth = void 0;
                        a.origHeight = void 0;
                        f.width = a.origWidthOption;
                        f.height = a.origHeightOption;
                        a.origWidthOption = void 0;
                        a.origHeightOption = void 0;
                        a.isOpen = !1;
                        a.setButtonText()
                    })
                };
                b.prototype.open = function() {
                    var a = this,
                        b = a.chart,
                        f = b.options.chart;
                    n(b, "fullscreenOpen", null, function() {
                        f && (a.origWidthOption = f.width, a.origHeightOption = f.height);
                        a.origWidth = b.chartWidth;
                        a.origHeight = b.chartHeight;
                        if (a.browserProps) {
                            var l = k(b.container.ownerDocument, a.browserProps.fullscreenChange, function() {
                                    a.isOpen ?
                                        (a.isOpen = !1, a.close()) : (b.setSize(null, null, !1), a.isOpen = !0, a.setButtonText())
                                }),
                                h = k(b, "destroy", l);
                            a.unbindFullscreenEvent = function() {
                                l();
                                h()
                            };
                            var d = b.renderTo[a.browserProps.requestFullscreen]();
                            if (d) d["catch"](function() {
                                alert("Full screen is not supported inside a frame.")
                            })
                        }
                    })
                };
                b.prototype.setButtonText = function() {
                    var b = this.chart,
                        h = b.exportDivElements,
                        f = b.options.exporting,
                        d = f && f.buttons && f.buttons.contextButton.menuItems;
                    b = b.options.lang;
                    f && f.menuItemDefinitions && b && b.exitFullscreen && b.viewFullscreen &&
                        d && h && (h = h[d.indexOf("viewFullscreen")]) && a.setElementHTML(h, this.isOpen ? b.exitFullscreen : f.menuItemDefinitions.viewFullscreen.text || b.viewFullscreen)
                };
                b.prototype.toggle = function() {
                    this.isOpen ? this.close() : this.open()
                };
                return b
            }();
        "";
        "";
        return A
    });
    k(a, "Core/HttpUtilities.js", [a["Core/Globals.js"], a["Core/Utilities.js"]], function(a, b) {
        var k = a.doc,
            t = b.createElement,
            n = b.discardElement,
            z = b.merge,
            A = b.objectEach,
            d = {
                ajax: function(a) {
                    var b = {
                            json: "application/json",
                            xml: "application/xml",
                            text: "text/plain",
                            octet: "application/octet-stream"
                        },
                        f = new XMLHttpRequest;
                    if (!a.url) return !1;
                    f.open((a.type || "get").toUpperCase(), a.url, !0);
                    a.headers && a.headers["Content-Type"] || f.setRequestHeader("Content-Type", b[a.dataType || "json"] || b.text);
                    A(a.headers, function(a, b) {
                        f.setRequestHeader(b, a)
                    });
                    a.responseType && (f.responseType = a.responseType);
                    f.onreadystatechange = function() {
                        if (4 === f.readyState) {
                            if (200 === f.status) {
                                if ("blob" !== a.responseType) {
                                    var b = f.responseText;
                                    if ("json" === a.dataType) try {
                                        b = JSON.parse(b)
                                    } catch (x) {
                                        if (x instanceof Error) {
                                            a.error && a.error(f, x);
                                            return
                                        }
                                    }
                                }
                                return a.success && a.success(b, f)
                            }
                            a.error && a.error(f, f.responseText)
                        }
                    };
                    a.data && "string" !== typeof a.data && (a.data = JSON.stringify(a.data));
                    f.send(a.data)
                },
                getJSON: function(a, b) {
                    d.ajax({
                        url: a,
                        success: b,
                        dataType: "json",
                        headers: {
                            "Content-Type": "text/plain"
                        }
                    })
                },
                post: function(a, b, f) {
                    var d = t("form", z({
                        method: "post",
                        action: a,
                        enctype: "multipart/form-data"
                    }, f), {
                        display: "none"
                    }, k.body);
                    A(b, function(a, b) {
                        t("input", {
                            type: "hidden",
                            name: b,
                            value: a
                        }, void 0, d)
                    });
                    d.submit();
                    n(d)
                }
            };
        "";
        return d
    });
    k(a, "Extensions/Exporting/Exporting.js", [a["Core/Renderer/HTML/AST.js"], a["Core/Chart/Chart.js"], a["Core/Chart/ChartNavigationComposition.js"], a["Core/DefaultOptions.js"], a["Extensions/Exporting/ExportingDefaults.js"], a["Extensions/Exporting/ExportingSymbols.js"], a["Extensions/Exporting/Fullscreen.js"], a["Core/Globals.js"], a["Core/HttpUtilities.js"], a["Core/Utilities.js"]], function(a, b, k, D, n, z, A, d, l, h) {
        b = D.defaultOptions;
        var f = d.doc,
            t = d.SVG_NS,
            x = d.win,
            B = h.addEvent,
            v = h.css,
            u = h.createElement,
            J = h.discardElement,
            E = h.extend,
            N = h.find,
            F = h.fireEvent,
            O = h.isObject,
            p = h.merge,
            P = h.objectEach,
            q = h.pick,
            Q = h.removeEvent,
            R = h.uniqueKey,
            G;
        (function(b) {
            function n(a) {
                var c = this,
                    b = c.renderer,
                    g = p(c.options.navigation.buttonOptions, a),
                    f = g.onclick,
                    C = g.menuItems,
                    d = g.symbolSize || 12;
                c.btnCount || (c.btnCount = 0);
                c.exportDivElements || (c.exportDivElements = [], c.exportSVGElements = []);
                if (!1 !== g.enabled && g.theme) {
                    var e = g.theme,
                        I;
                    c.styledMode || (e.fill = q(e.fill, "#ffffff"), e.stroke = q(e.stroke, "none"));
                    f ? I = function(a) {
                        a && a.stopPropagation();
                        f.call(c, a)
                    } : C && (I = function(a) {
                        a && a.stopPropagation();
                        c.contextMenu(r.menuClassName, C, r.translateX, r.translateY, r.width, r.height, r);
                        r.setState(2)
                    });
                    g.text && g.symbol ? e.paddingLeft = q(e.paddingLeft, 30) : g.text || E(e, {
                        width: g.width,
                        height: g.height,
                        padding: 0
                    });
                    c.styledMode || (e["stroke-linecap"] = "round", e.fill = q(e.fill, "#ffffff"), e.stroke = q(e.stroke, "none"));
                    var r = b.button(g.text, 0, 0, I, e).addClass(a.className).attr({
                        title: q(c.options.lang[g._titleKey || g.titleKey], "")
                    });
                    r.menuClassName = a.menuClassName || "highcharts-menu-" +
                        c.btnCount++;
                    if (g.symbol) {
                        var h = b.symbol(g.symbol, g.symbolX - d / 2, g.symbolY - d / 2, d, d, {
                            width: d,
                            height: d
                        }).addClass("highcharts-button-symbol").attr({
                            zIndex: 1
                        }).add(r);
                        c.styledMode || h.attr({
                            stroke: g.symbolStroke,
                            fill: g.symbolFill,
                            "stroke-width": g.symbolStrokeWidth || 1
                        })
                    }
                    r.add(c.exportingGroup).align(E(g, {
                        width: r.width,
                        x: q(g.x, c.buttonOffset)
                    }), !0, "spacingBox");
                    c.buttonOffset += (r.width + g.buttonSpacing) * ("right" === g.align ? -1 : 1);
                    c.exportSVGElements.push(r, h)
                }
            }

            function D() {
                if (this.printReverseInfo) {
                    var a = this.printReverseInfo,
                        b = a.childNodes,
                        w = a.origDisplay;
                    a = a.resetParams;
                    this.moveContainers(this.renderTo);
                    [].forEach.call(b, function(a, c) {
                        1 === a.nodeType && (a.style.display = w[c] || "")
                    });
                    this.isPrinting = !1;
                    a && this.setSize.apply(this, a);
                    delete this.printReverseInfo;
                    H = void 0;
                    F(this, "afterPrint")
                }
            }

            function G() {
                var a = f.body,
                    b = this.options.exporting.printMaxWidth,
                    w = {
                        childNodes: a.childNodes,
                        origDisplay: [],
                        resetParams: void 0
                    };
                this.isPrinting = !0;
                this.pointer.reset(null, 0);
                F(this, "beforePrint");
                b && this.chartWidth > b && (w.resetParams = [this.options.chart.width,
                    void 0, !1
                ], this.setSize(b, void 0, !1));
                [].forEach.call(w.childNodes, function(a, c) {
                    1 === a.nodeType && (w.origDisplay[c] = a.style.display, a.style.display = "none")
                });
                this.moveContainers(a);
                this.printReverseInfo = w
            }

            function S(a) {
                a.renderExporting();
                B(a, "redraw", a.renderExporting);
                B(a, "destroy", a.destroyExport)
            }

            function T(c, b, w, g, d, C, k) {
                var e = this,
                    y = e.options.navigation,
                    r = e.chartWidth,
                    K = e.chartHeight,
                    t = "cache-" + c,
                    l = Math.max(d, C),
                    m = e[t];
                if (!m) {
                    e.exportContextMenu = e[t] = m = u("div", {
                        className: c
                    }, {
                        position: "absolute",
                        zIndex: 1E3,
                        padding: l + "px",
                        pointerEvents: "auto"
                    }, e.fixedDiv || e.container);
                    var p = u("ul", {
                        className: "highcharts-menu"
                    }, {
                        listStyle: "none",
                        margin: 0,
                        padding: 0
                    }, m);
                    e.styledMode || v(p, E({
                        MozBoxShadow: "3px 3px 10px #888",
                        WebkitBoxShadow: "3px 3px 10px #888",
                        boxShadow: "3px 3px 10px #888"
                    }, y.menuStyle));
                    m.hideMenu = function() {
                        v(m, {
                            display: "none"
                        });
                        k && k.setState(0);
                        e.openMenu = !1;
                        v(e.renderTo, {
                            overflow: "hidden"
                        });
                        v(e.container, {
                            overflow: "hidden"
                        });
                        h.clearTimeout(m.hideTimer);
                        F(e, "exportMenuHidden")
                    };
                    e.exportEvents.push(B(m,
                        "mouseleave",
                        function() {
                            m.hideTimer = x.setTimeout(m.hideMenu, 500)
                        }), B(m, "mouseenter", function() {
                        h.clearTimeout(m.hideTimer)
                    }), B(f, "mouseup", function(a) {
                        e.pointer.inClass(a.target, c) || m.hideMenu()
                    }), B(m, "click", function() {
                        e.openMenu && m.hideMenu()
                    }));
                    b.forEach(function(c) {
                        "string" === typeof c && (c = e.options.exporting.menuItemDefinitions[c]);
                        if (O(c, !0)) {
                            var b = void 0;
                            c.separator ? b = u("hr", void 0, void 0, p) : ("viewData" === c.textKey && e.isDataTableVisible && (c.textKey = "hideData"), b = u("li", {
                                className: "highcharts-menu-item",
                                onclick: function(a) {
                                    a && a.stopPropagation();
                                    m.hideMenu();
                                    c.onclick && c.onclick.apply(e, arguments)
                                }
                            }, void 0, p), a.setElementHTML(b, c.text || e.options.lang[c.textKey]), e.styledMode || (b.onmouseover = function() {
                                v(this, y.menuItemHoverStyle)
                            }, b.onmouseout = function() {
                                v(this, y.menuItemStyle)
                            }, v(b, E({
                                cursor: "pointer"
                            }, y.menuItemStyle || {}))));
                            e.exportDivElements.push(b)
                        }
                    });
                    e.exportDivElements.push(p, m);
                    e.exportMenuWidth = m.offsetWidth;
                    e.exportMenuHeight = m.offsetHeight
                }
                b = {
                    display: "block"
                };
                w + e.exportMenuWidth > r ? b.right =
                    r - w - d - l + "px" : b.left = w - l + "px";
                g + C + e.exportMenuHeight > K && "top" !== k.alignOptions.verticalAlign ? b.bottom = K - g - l + "px" : b.top = g + C - l + "px";
                v(m, b);
                v(e.renderTo, {
                    overflow: ""
                });
                v(e.container, {
                    overflow: ""
                });
                e.openMenu = !0;
                F(e, "exportMenuShown")
            }

            function U(a) {
                var c = a ? a.target : this,
                    b = c.exportSVGElements,
                    g = c.exportDivElements;
                a = c.exportEvents;
                var d;
                b && (b.forEach(function(a, y) {
                    a && (a.onclick = a.ontouchstart = null, d = "cache-" + a.menuClassName, c[d] && delete c[d], b[y] = a.destroy())
                }), b.length = 0);
                c.exportingGroup && (c.exportingGroup.destroy(),
                    delete c.exportingGroup);
                g && (g.forEach(function(a, c) {
                    a && (h.clearTimeout(a.hideTimer), Q(a, "mouseleave"), g[c] = a.onmouseout = a.onmouseover = a.ontouchstart = a.onclick = null, J(a))
                }), g.length = 0);
                a && (a.forEach(function(a) {
                    a()
                }), a.length = 0)
            }

            function V(a, b) {
                b = this.getSVGForExport(a, b);
                a = p(this.options.exporting, a);
                l.post(a.url, {
                    filename: a.filename ? a.filename.replace(/\//g, "-") : this.getFilename(),
                    type: a.type,
                    width: a.width || 0,
                    scale: a.scale,
                    svg: b
                }, a.formAttributes)
            }

            function W() {
                this.styledMode && this.inlineStyles();
                return this.container.innerHTML
            }

            function X() {
                var a = this.userOptions.title && this.userOptions.title.text,
                    b = this.options.exporting.filename;
                if (b) return b.replace(/\//g, "-");
                "string" === typeof a && (b = a.toLowerCase().replace(/<\/?[^>]+(>|$)/g, "").replace(/[\s]+/g, "-").replace(/[^a-z0-9_\-]/g, "").replace(/^[\-]+/g, "").replace(/[\-]+/g, "-").replace(/[\-]+$/g, ""));
                if (!b || 2 > b.length) b = "chart";
                return b
            }

            function Y(a) {
                var b, c = p(this.options, a);
                c.plotOptions = p(this.userOptions.plotOptions, a && a.plotOptions);
                c.time = p(this.userOptions.time, a && a.time);
                var g = u("div", null, {
                        position: "absolute",
                        top: "-9999em",
                        width: this.chartWidth + "px",
                        height: this.chartHeight + "px"
                    }, f.body),
                    d = this.renderTo.style.width;
                var h = this.renderTo.style.height;
                d = c.exporting.sourceWidth || c.chart.width || /px$/.test(d) && parseInt(d, 10) || (c.isGantt ? 800 : 600);
                h = c.exporting.sourceHeight || c.chart.height || /px$/.test(h) && parseInt(h, 10) || 400;
                E(c.chart, {
                    animation: !1,
                    renderTo: g,
                    forExport: !0,
                    renderer: "SVGRenderer",
                    width: d,
                    height: h
                });
                c.exporting.enabled = !1;
                delete c.data;
                c.series = [];
                this.series.forEach(function(a) {
                    b = p(a.userOptions, {
                        animation: !1,
                        enableMouseTracking: !1,
                        showCheckbox: !1,
                        visible: a.visible
                    });
                    b.isInternal || c.series.push(b)
                });
                var k = {};
                this.axes.forEach(function(a) {
                    a.userOptions.internalKey || (a.userOptions.internalKey = R());
                    a.options.isInternal || (k[a.coll] || (k[a.coll] = !0, c[a.coll] = []), c[a.coll].push(p(a.userOptions, {
                        visible: a.visible
                    })))
                });
                var e = new this.constructor(c, this.callback);
                a && ["xAxis", "yAxis", "series"].forEach(function(b) {
                    var c = {};
                    a[b] && (c[b] = a[b], e.update(c))
                });
                this.axes.forEach(function(a) {
                    var b = N(e.axes, function(b) {
                            return b.options.internalKey === a.userOptions.internalKey
                        }),
                        c = a.getExtremes(),
                        d = c.userMin;
                    c = c.userMax;
                    b && ("undefined" !== typeof d && d !== b.min || "undefined" !== typeof c && c !== b.max) && b.setExtremes(d, c, !0, !1)
                });
                h = e.getChartHTML();
                F(this, "getSVG", {
                    chartCopy: e
                });
                h = this.sanitizeSVG(h, c);
                c = null;
                e.destroy();
                J(g);
                return h
            }

            function Z(a, b) {
                var c = this.options.exporting;
                return this.getSVG(p({
                        chart: {
                            borderRadius: 0
                        }
                    }, c.chartOptions,
                    b, {
                        exporting: {
                            sourceWidth: a && a.sourceWidth || c.sourceWidth,
                            sourceHeight: a && a.sourceHeight || c.sourceHeight
                        }
                    }))
            }

            function aa(a) {
                return a.replace(/([A-Z])/g, function(a, b) {
                    return "-" + b.toLowerCase()
                })
            }

            function ba() {
                function a(b) {
                    var c = {},
                        e, f;
                    if (n && 1 === b.nodeType && -1 === ca.indexOf(b.nodeName)) {
                        var l = x.getComputedStyle(b, null);
                        var w = "svg" === b.nodeName ? {} : x.getComputedStyle(b.parentNode, null);
                        if (!g[b.nodeName]) {
                            k = n.getElementsByTagName("svg")[0];
                            var m = n.createElementNS(b.namespaceURI, b.nodeName);
                            k.appendChild(m);
                            g[b.nodeName] = p(x.getComputedStyle(m, null));
                            "text" === b.nodeName && delete g.text.fill;
                            k.removeChild(m)
                        }
                        for (var t in l)
                            if (d.isFirefox || d.isMS || d.isSafari || Object.hasOwnProperty.call(l, t)) {
                                var u = l[t],
                                    q = t;
                                m = e = !1;
                                if (h.length) {
                                    for (f = h.length; f-- && !e;) e = h[f].test(q);
                                    m = !e
                                }
                                "transform" === q && "none" === u && (m = !0);
                                for (f = y.length; f-- && !m;) m = y[f].test(q) || "function" === typeof u;
                                m || w[q] === u && "svg" !== b.nodeName || g[b.nodeName][q] === u || (L && -1 === L.indexOf(q) ? "parentRule" !== q && (c[q] = u) : u && b.setAttribute(aa(q), u))
                            }
                        v(b, c);
                        "svg" === b.nodeName && b.setAttribute("stroke-width", "1px");
                        "text" !== b.nodeName && [].forEach.call(b.children || b.childNodes, a)
                    }
                }
                var y = da,
                    h = b.inlineWhitelist,
                    g = {},
                    k, l = f.createElement("iframe");
                v(l, {
                    width: "1px",
                    height: "1px",
                    visibility: "hidden"
                });
                f.body.appendChild(l);
                var n = l.contentWindow && l.contentWindow.document;
                n && n.body.appendChild(n.createElementNS(t, "svg"));
                a(this.container.querySelector("svg"));
                k.parentNode.removeChild(k);
                l.parentNode.removeChild(l)
            }

            function ea(a) {
                (this.fixedDiv ? [this.fixedDiv, this.scrollingContainer] : [this.container]).forEach(function(b) {
                    a.appendChild(b)
                })
            }

            function fa() {
                var a = this;
                a.exporting = {
                    update: function(b, c) {
                        a.isDirtyExporting = !0;
                        p(!0, a.options.exporting, b);
                        q(c, !0) && a.redraw()
                    }
                };
                k.compose(a).navigation.addUpdate(function(b, c) {
                    a.isDirtyExporting = !0;
                    p(!0, a.options.navigation, b);
                    q(c, !0) && a.redraw()
                })
            }

            function ha() {
                var a = this;
                a.isPrinting || (H = a, d.isSafari || a.beforePrint(), setTimeout(function() {
                    x.focus();
                    x.print();
                    d.isSafari || setTimeout(function() {
                        a.afterPrint()
                    }, 1E3)
                }, 1))
            }

            function ia() {
                var a =
                    this,
                    b = a.options.exporting,
                    d = b.buttons,
                    g = a.isDirtyExporting || !a.exportSVGElements;
                a.buttonOffset = 0;
                a.isDirtyExporting && a.destroyExport();
                g && !1 !== b.enabled && (a.exportEvents = [], a.exportingGroup = a.exportingGroup || a.renderer.g("exporting-group").attr({
                    zIndex: 3
                }).add(), P(d, function(b) {
                    a.addButton(b)
                }), a.isDirtyExporting = !1)
            }

            function ja(a, b) {
                var c = a.indexOf("</svg>") + 6,
                    d = a.substr(c);
                a = a.substr(0, c);
                b && b.exporting && b.exporting.allowHTML && d && (d = '<foreignObject x="0" y="0" width="' + b.chart.width + '" height="' +
                    b.chart.height + '"><body xmlns="http://www.w3.org/1999/xhtml">' + d.replace(/(<(?:img|br).*?(?=>))>/g, "$1 />") + "</body></foreignObject>", a = a.replace("</svg>", d + "</svg>"));
                a = a.replace(/zIndex="[^"]+"/g, "").replace(/symbolName="[^"]+"/g, "").replace(/jQuery[0-9]+="[^"]+"/g, "").replace(/url\(("|&quot;)(.*?)("|&quot;);?\)/g, "url($2)").replace(/url\([^#]+#/g, "url(#").replace(/<svg /, '<svg xmlns:xlink="http://www.w3.org/1999/xlink" ').replace(/ (|NS[0-9]+:)href=/g, " xlink:href=").replace(/\n/, " ").replace(/(fill|stroke)="rgba\(([ 0-9]+,[ 0-9]+,[ 0-9]+),([ 0-9\.]+)\)"/g,
                    '$1="rgb($2)" $1-opacity="$3"').replace(/&nbsp;/g, "\u00a0").replace(/&shy;/g, "\u00ad");
                this.ieSanitizeSVG && (a = this.ieSanitizeSVG(a));
                return a
            }
            var M = [],
                da = [/-/, /^(clipPath|cssText|d|height|width)$/, /^font$/, /[lL]ogical(Width|Height)$/, /perspective/, /TapHighlightColor/, /^transition/, /^length$/],
                L = "fill stroke strokeLinecap strokeLinejoin strokeWidth textAnchor x y".split(" ");
            b.inlineWhitelist = [];
            var ca = ["clipPath", "defs", "desc"],
                H;
            b.compose = function(a, b) {
                z.compose(b);
                A.compose(a); - 1 === M.indexOf(a) &&
                    (M.push(a), b = a.prototype, b.afterPrint = D, b.exportChart = V, b.inlineStyles = ba, b.print = ha, b.sanitizeSVG = ja, b.getChartHTML = W, b.getSVG = Y, b.getSVGForExport = Z, b.getFilename = X, b.moveContainers = ea, b.beforePrint = G, b.contextMenu = T, b.addButton = n, b.destroyExport = U, b.renderExporting = ia, b.callbacks.push(S), B(a, "init", fa), d.isSafari && d.win.matchMedia("print").addListener(function(a) {
                        H && (a.matches ? H.beforePrint() : H.afterPrint())
                    }))
            }
        })(G || (G = {}));
        b.exporting = p(n.exporting, b.exporting);
        b.lang = p(n.lang, b.lang);
        b.navigation =
            p(n.navigation, b.navigation);
        "";
        "";
        return G
    });
    k(a, "masters/modules/exporting.src.js", [a["Core/Globals.js"], a["Extensions/Exporting/Exporting.js"], a["Core/HttpUtilities.js"]], function(a, b, k) {
        a.HttpUtilities = k;
        a.ajax = k.ajax;
        a.getJSON = k.getJSON;
        a.post = k.post;
        b.compose(a.Chart, a.Renderer)
    })
});
//# sourceMappingURL=exporting.js.map
