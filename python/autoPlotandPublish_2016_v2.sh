#!/bin/bash

#DCS JSON file production for collisions and cosmics
 
python dcsonlyjson.py --min 271036
python dcsonlyjson_with_APVmode.py --min 271036
python dcsonlyjson_with_APVmode.py --min 271036 --PEAK

python dcsonlyjson.py --min 270985 --cosmics
python dcsonlyjson_with_APVmode.py --min 270985 --cosmics
python dcsonlyjson_with_APVmode.py --min 270985 --cosmics --PEAK 

# ++++++++++++++++++++++++++++++++   StreamExpress +++++++++++++++++++++++++++++++++++++++
#StreamExpress STRIPS
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini --dataset StreamExpress --epoch Run2016 -r "run >= 271036" --reco Express -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/Strips/DECO/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset StreamExpress --epoch Run2016 -r "run >= 271036" --reco Express -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/Strips/DECO/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini --dataset StreamExpress --epoch Run2016 -r "run >= 271036" --reco Express -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/Strips/PEAK/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset StreamExpress --epoch Run2016 -r "run >= 271036" --reco Express -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/Strips/PEAK/
touch .doneStreamExpress

#StreamExpress PIXEL
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixel_clusters.ini -C cfg/trendPlotsPixel_occupancy.ini --dataset StreamExpress --epoch Run2016 -r "run >= 271036" --reco Express -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/Pixel/
touch .doneStreamExpressPixel

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixel_SumOffADC.ini -C cfg/trendPlotsPixel_BPIX_Residuals.ini -C cfg/trendPlotsPixel_FPIX_Residuals.ini --dataset StreamExpress --epoch Run2016 -r "run >= 271036" --reco Express -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/Pixel/
touch .doneStreamExpressPixel

#StreamExpress TRACKING
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressTracking.ini -C cfg/trendPlotsTracking.ini --dataset StreamExpress --epoch Run2016 -r "run >= 271036" --reco Express -J json_DCSONLY.txt
python ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/Tracking/
touch .doneStreamExpressTracking

# ++++++++++++++++++++++++++++++++   ZeroBias +++++++++++++++++++++++++++++++++++++++

#ZeroBias STRIPS
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini\
 -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini --dataset ZeroBias --epoch Run2016 -r "run >= 271036" --reco Prompt -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/Strips/DECO/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini  -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset ZeroBias --epoch Run2016 -r "run >= 271036" --reco Prompt -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/Strips/DECO/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini\
 -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini --dataset ZeroBias --epoch Run2016 -r "run >= 271036" --reco Prompt -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/Strips/PEAK/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset ZeroBias --epoch Run2016 -r "run >= 271036" --reco Prompt -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/Strips/PEAK/
touch .doneZeroBias

#ZeroBias PIXEL
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixel_clusters.ini -C cfg/trendPlotsPixel_occupancy.ini --dataset ZeroBias --epoch Run2016 -r "run >= 271036" --reco Prompt -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/Pixel/
touch .doneZeroBiasPixel

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixel_SumOffADC.ini -C cfg/trendPlotsPixel_BPIX_Residuals.ini -C cfg/trendPlotsPixel_FPIX_Residuals.ini --dataset ZeroBias --epoch Run2016 -r "run >= 271036" --reco Prompt -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/Pixel/
touch .doneZeroBiasPixel

#ZeroBias TRACKING
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptTracking.ini -C cfg/trendPlotsTracking.ini --dataset ZeroBias --epoch Run2016 -r "run >= 271036" --reco Prompt -J json_DCSONLY.txt
python ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/Tracking/
touch .doneZeroBiasTracking

# ++++++++++++++++++++++++++++++++   Cosmics  +++++++++++++++++++++++++++++++++++++++

#Cosmics STRIPS Commissioning2016
#FIX PEAK VS DECO!!!
#rm -rf ./JSON/*
#python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini #--dataset Cosmics --epoch Commissioning2016 -r "run > 266134" --reco Prompt
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Strips/DECO/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Strips/PEAK/
#touch .doneCosmics

#Cosmics STRIPS Run2016
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Run2016 -r "run >= 270985" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Run2016 -r "run >= 270985" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Strips/PEAK/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Run2016 -r "run >= 270985" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Run2016 -r "run >= 270985" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Strips/PEAK/
touch .doneCosmics

#Cosmics Pixel Run2016
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini  -C cfg/trendPlotsPixel_clusters.ini -C cfg/trendPlotsPixel_occupancy.ini --dataset Cosmics --epoch Run2016 -r "run >= 270985" --reco Prompt -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Pixel
touch .doneCosmicsPixel

#Cosmics Tracking Run2016
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCPromptTracking.ini  -C cfg/trendPlotsTrackingCosmics.ini --dataset Cosmics --epoch Run2016 -r "run >= 270985" --reco Prompt -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/Cosmics/Tracking
touch .doneCosmicsTracking


# ++++++++++++++++++++++++++++++++   StreamExpressCosmics  +++++++++++++++++++++++++++++++++++++++

#StreamExpressCosmics STRIPS Commissioning2016
#FIXING PEAK VS DECO!!!
#rm -rf ./JSON/*
#python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C #cfg/trendPlotsStrip_StoN.ini --dataset StreamExpressCosmics --epoch Commissioning2016 -r "run > 266134" --reco Express
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Strips/DECO/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Strips/PEAK/
#touch .doneStreamExpressCosmics

#StreamExpressCosmics STRIPS Run2016
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Run2016 -r "run >= 270985" --reco Express -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Run2016 -r "run >= 270985" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Strips/PEAK/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Run2016 -r "run >= 270985" --reco Express -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Run2016 -r "run >= 270985" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Strips/PEAK/
touch .doneStreamExpressCosmics

#StreamExpressCosmics Pixel Run2016
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixel_clusters.ini -C cfg/trendPlotsPixel_occupancy.ini --dataset StreamExpressCosmics --epoch Run2016 -r "run > 270985" --reco Express -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Pixel
touch .doneStreamExpressCosmicsPixel

#StreamExpressCosmics Tracking Run2016
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronCExpressTracking.ini -C cfg/trendPlotsTrackingCosmics.ini --dataset StreamExpressCosmics --epoch Run2016 -r "run > 270985" --reco Express -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpressCosmics/Tracking
touch .doneStreamExpressCosmicsTracking

# Reco Errors
if [ -d  JSON_RECO ]
  then
      rm -r JSON_RECO
fi
python ./trendPlots_RECOErrors.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsRECOErrors.ini --dataset StreamExpress --epoch Run2016 -J json_DCSONLY.txt --reco Express
python ./trendPlots_RECOErrors.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsRECOErrors.ini --dataset ZeroBias --epoch Run2016 -J json_DCSONLY.txt --reco Prompt
cp JSON_RecoErrors_ImpFiles/*.* JSON_RECO/
cd JSON_RECO
./doRatio.sh StreamExpress
cp ./StreamExpress/* /data/users/event_display/HDQM/v2/alljsons/2016/StreamExpress/RecoErrors/
./doRatio.sh ZeroBias
cp ./ZeroBias/* /data/users/event_display/HDQM/v2/alljsons/2016/Prompt/ZeroBias/RecoErrors/
cd ..
