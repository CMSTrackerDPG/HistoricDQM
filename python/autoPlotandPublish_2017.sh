#!/bin/bash

#DCS JSON file production for collisions and cosmics
 
python dcsonlyjson_all.py --min 290129
#python dcsonlyjson_with_APVmode.py --min 290129
#python dcsonlyjson_with_APVmode.py --min 290129 --PEAK

python dcsonlyjson_all.py --min 290129 --cosmics
#python dcsonlyjson.py --min 290129 --cosmics
#python dcsonlyjson_with_APVmode.py --min 290129 --cosmics
#python dcsonlyjson_with_APVmode.py --min 290129 --cosmics --PEAK 


# ++++++++++++++++++++++++++++++++   Cosmics  +++++++++++++++++++++++++++++++++++++++


#Cosmics STRIPS Commissioning2017
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
touch .doneCosmics

#Cosmics PIXEL Commissioning2017
rm -rf ./JSON/*
python trendPlots.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_clusters.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini --dataset Cosmics --epoch Commissioning2017 -r "run>=292505" --reco Prompt -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/PixelPhase1/
touch .doneStreamExpressCosmics

# ++++++++++++++++++++++++++++++++   StreamExpressCosmics  +++++++++++++++++++++++++++++++++++++++


#StreamExpressCosmics STRIPS Commissioning2017
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
touch .doneStreamExpressCosmics

#StreamExpressCosmics PIXEL Commissioning2017
rm -rf ./JSON/*
python trendPlots.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_clusters.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run>=292505" --reco Express -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/PixelPhase1/
touch .doneStreamExpressCosmics