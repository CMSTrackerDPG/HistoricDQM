# HistoricDQM
How to run historic DQM:

Make sure you have your user certificate installed (automatically done for `cctrack` at `vocms061`) and CMSSW initialized (needed only for ROOT), then run `trendPlots` script with params, for example:

bash autoPlotandPublish_2017.sh

Inside autoPlotandPublish_2017.sh you find commands of the type:

python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini --dataset StreamExpress --epoch Run2017 -r "run >= 292129" --reco Express -J json_DCSONLY_DECO.txt

Type `trendPlots.py --help` for all defaults. Any plot cfg file can be used from list in `cfg/*.ini`.

All output trend plots (PNG/ROOT/PDF/...) are saved in a corresponding directory `fig/`.


