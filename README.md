# HistoricDQM
How to run historic DQM:

First setup your grid environment (automatically done for cctrack)

Then run `trendPlots` script with params, for example:

`./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini`

`./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsPixel_General.ini -C cfg/trendPlotsStrip_General.ini`

`./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini --epoch Run2011B --dataset Jet --reco 19Nov2011`

`./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini -r "run > 190000 and run < 191000"`

`./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini --dataset Cosmics --state PEAK`

`./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini -r "run > 190000 and run < 191000" -L runlist.txt`

`./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/aaaaa.ini -C cfg/trendPlotsExample.ini -r "run > 190000 and run < 191000" -J json.json`

To run on online data:
`./trendPlots.py -C cfg/trendPlotsDQMOnline.ini -C cfg/trendPlotsExample.ini -r "run > 194000 and run < 195000" --dataset Online/ALL --reco "*" --epoch "*" --tag "*"`

Type `trendPlots.py --help` for all defaults. Any plot cfg file can be used from list in `cfg/*.ini`.

(OBSOLETE) Plot comparisons together: `python -i plotTogether.py`

