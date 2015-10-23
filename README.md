# HistoricDQM
How to run historic DQM:

Make sure you have your user certificate installed (automatically done for `cctrack` at `vocms061`) and CMSSW initialized (needed only for ROOT), then run `trendPlots` script with params, for example:

`python ./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini --epoch Run2015D --dataset ZeroBias --reco Prompt`

`python ./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini -r "run > 250000 and run < 260000" --dataset ZeroBias --reco Prompt`

`python ./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini -r "run > 250000 and run < 260000" -L runlist.txt`

`python ./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini -r "run > 250000 and run < 260000" -J json.json`

`python ./trendPlots.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsExample.ini --dataset Cosmics --state PEAK`

To run on online data:
`python ./trendPlots.py -C cfg/trendPlotsDQMOnline.ini -C cfg/trendPlotsExample.ini -r "run > 250000 and run < 260000" --dataset Online/ALL --reco "*" --epoch "*" --tag "*"`

Type `trendPlots.py --help` for all defaults. Any plot cfg file can be used from list in `cfg/*.ini`.

All output trend plots (PNG/ROOT/PDF/...) are saved in a corresponding directory `fig/`.

(OBSOLETE) Plot comparisons together: `python -i plotTogether.py`

