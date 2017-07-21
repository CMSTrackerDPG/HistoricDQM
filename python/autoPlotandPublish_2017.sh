#!/bin/bash

#DCS JSON file production for collisions and cosmics
 
python dcsonlyjson_all.py --min 294600
#python dcsonlyjson_with_APVmode.py --min 290129
#python dcsonlyjson_with_APVmode.py --min 290129 --PEAK

python dcsonlyjson_all.py --min 294600 --cosmics
#python dcsonlyjson.py --min 290129 --cosmics
#python dcsonlyjson_with_APVmode.py --min 290129 --cosmics
#python dcsonlyjson_with_APVmode.py --min 290129 --cosmics --PEAK 


# ++++++++++++++++++++++++++++++++   Cosmics  +++++++++++++++++++++++++++++++++++++++


#Cosmics STRIPS Commissioning2017
#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/DECO/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/DECO/
#touch .doneCosmics

#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
#touch .doneCosmics

#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/DECO/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/DECO/
#touch .doneCosmics

#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Commissioning2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
#touch .doneCosmics

#Cosmics STRIPS
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset Cosmics --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Strips/PEAK/
touch .doneCosmics

#Cosmics PIXEL Commissioning2017
#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset Cosmics --epoch Commissioning2017 -r "run>=292505" --reco Prompt -J json_DCSONLY_cosmics.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/PixelPhase1/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/PixelPhase1/
#touch .doneCosmics

#Cosmics PIXEL
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset Cosmics --epoch Run2017 -r "run>=292505" --reco Prompt -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/PixelPhase1/
touch .doneCosmics

#Cosmics Tracking
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCPromptTracking.ini  -C cfg/trendPlotsTrackingCosmics.ini --dataset Cosmics --epoch Run2017 -r "run >= 292505" --reco Prompt -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/Cosmics/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/Cosmics/Tracking
touch .doneCosmicsTracking


# ++++++++++++++++++++++++++++++++   StreamExpressCosmics  +++++++++++++++++++++++++++++++++++++++


#StreamExpressCosmics STRIPS Commissioning2017
#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_DECO.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/DECO/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/DECO/
#touch .doneStreamExpressCosmics

#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
#touch .doneStreamExpressCosmics

#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_DECO.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/DECO/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/DECO/
#touch .doneStreamExpressCosmics

#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
#touch .doneStreamExpressCosmics

#StreamExpressCosmics STRIPS
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini --dataset StreamExpressCosmics --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Strips/PEAK/
touch .doneStreamExpressCosmics

#StreamExpressCosmics PIXEL Commissioning2017
#rm -rf ./JSON/*
#python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset StreamExpressCosmics --epoch Commissioning2017 -r "run>=292505" --reco Express -J json_DCSONLY_cosmics.txt
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/PixelPhase1/
#cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/PixelPhase1/
#touch .doneStreamExpressCosmics

#StreamExpressCosmics PIXEL
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset StreamExpressCosmics --epoch Run2017 -r "run>=292505" --reco Express -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/PixelPhase1/
touch .doneStreamExpressCosmics

#StreamExpressCosmics Tracking
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronCExpressTracking.ini -C cfg/trendPlotsTrackingCosmics.ini --dataset StreamExpressCosmics --epoch Run2017 -r "run > 292505" --reco Express -J json_DCSONLY_cosmics.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpressCosmics/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpressCosmics/Tracking
touch .doneStreamExpressCosmicsTracking


# ++++++++++++++++++++++++++++++++   ZeroBias +++++++++++++++++++++++++++++++++++++++                                                       

#ZeroBias STRIPS
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini --dataset ZeroBias --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/Strips/DECO/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini  -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset ZeroBias --epoch Run2017 -r "run >= 271036" --reco Prompt -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/Strips/DECO/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini   -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini --dataset ZeroBias --epoch Run2017 -r "run >= 271036" --reco Prompt -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/Strips/DECO/   
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/Strips/DECO/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini --dataset ZeroBias --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/Strips/PEAK/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset ZeroBias --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/Strips/PEAK/
touch .doneZeroBias

#ZeroBias PIXEL
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini --dataset ZeroBias --epoch Run2017 -r "run >= 292505" --reco Prompt -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
touch .doneZeroBiasPixel

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini --dataset ZeroBias --epoch Run2017 -r "run >= 292505" --reco Prompt -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
touch .doneZeroBiasPixel

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini --dataset ZeroBias --epoch Run2017 -r "run >= 292505" --reco Prompt -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
touch .doneZeroBiasPixel

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini --dataset ZeroBias --epoch Run2017 -r "run >= 292505" --reco Prompt -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/PixelPhase1/
touch .doneZeroBiasPixel


#ZeroBias TRACKING                                                                                                                                            
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPPromptTracking.ini -C cfg/trendPlotsTracking.ini --dataset ZeroBias --epoch Run2017 -r "run >= 290129" --reco Prompt -J json_DCSONLY.txt
python ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/Tracking/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/Tracking/
touch .doneZeroBiasTracking


# ++++++++++++++++++++++++++++++++   StreamExpress +++++++++++++++++++++++++++++++++++++++                                                       

#StreamExpress STRIPS
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini --dataset StreamExpress --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Strips/DECO/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini  -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset StreamExpress --epoch Run2017 -r "run >= 271036" --reco Express -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Strips/DECO/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini   -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini --dataset StreamExpress --epoch Run2017 -r "run >= 271036" --reco Express -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Strips/DECO/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini --dataset StreamExpress --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Strips/PEAK/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset StreamExpress --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY_PEAK.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Strips/PEAK/
touch .doneStreamExpress

#StreamExpress Strips Gains
rm -rf ./JSON/*
python ./trendPlots_ROOTfile.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_GainsAAG.ini --dataset StreamExpress --epoch Run2017 -r "run >= 290129" --reco PromptCalibProdSiStripGainsAAG-Express --datatier ALCAPROMPT -J json_DCSONLY_DECO.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Strips/DECO/
touch .doneStreamExpress


#StreamExpress PIXEL
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini --dataset StreamExpress --epoch Run2017 -r "run >= 292505" --reco Express -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/PixelPhase1/
touch .doneStreamExpressPixel

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini --dataset StreamExpress --epoch Run2017 -r "run >= 292505" --reco Express -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/PixelPhase1/
touch .doneStreamExpressPixel

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini --dataset StreamExpress --epoch Run2017 -r "run >= 292505" --reco Express -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/PixelPhase1/
touch .doneStreamExpressPixel

rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini --dataset StreamExpress --epoch Run2017 -r "run >= 292505" --reco Express -J json_DCSONLY.txt
cp ./JSON/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/PixelPhase1/
touch .doneStreamExpressPixel

#StreamExpress TRACKING
rm -rf ./JSON/*
python ./trendPlots_2017.py -C cfg/trendPlotsDQM_cronPPExpressTracking.ini -C cfg/trendPlotsTracking.ini --dataset StreamExpress --epoch Run2017 -r "run >= 290129" --reco Express -J json_DCSONLY.txt
python ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Tracking/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/Tracking/
touch .doneStreamExpressTracking


# Reco Errors
if [ -d  JSON_RECO ]
  then
      rm -r JSON_RECO
fi
python ./trendPlots_RECOErrors2017.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsRECOErrors.ini --dataset StreamExpress --epoch Run2017 -J json_DCSONLY.txt --reco Express
python ./trendPlots_RECOErrors2017.py -C cfg/trendPlotsDQM.ini -C cfg/trendPlotsRECOErrors.ini --dataset ZeroBias --epoch Run2017 -J json_DCSONLY.txt --reco Prompt
cp JSON_RecoErrors_ImpFiles/*.* JSON_RECO/
cd JSON_RECO
./doRatio.sh StreamExpress
cp ./StreamExpress/* /data/users/event_display/HDQM/v2/alljsons/2017/StreamExpress/RecoErrors/
cp ./StreamExpress/* /data/users/event_display/HDQM/v3/alljsons/2017/StreamExpress/RecoErrors/
./doRatio.sh ZeroBias
cp ./ZeroBias/* /data/users/event_display/HDQM/v2/alljsons/2017/Prompt/ZeroBias/RecoErrors/
cp ./ZeroBias/* /data/users/event_display/HDQM/v3/alljsons/2017/Prompt/ZeroBias/RecoErrors/
cd ..