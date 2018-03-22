#!/bin/bash


LOGDIR="/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/Logs"

#DCS JSON file production for collisions and cosmics
 
#python dcsonlyjson_all.py --min 294600
#python Read_DCSONLY_JSON.py
#cp Run_LHCFill.json /data/users/event_display/HDQM/v3.1/alljsons/2018/
#python Get_Run_RunDuration_LHCFill_info.py
#cp Run_LHCFill_RunDuration.json /data/users/event_display/HDQM/v4/alljsons/2018/

python dcsonlyjson_all.py --min 294600 --cosmics

# ++++++++++++++++++++++++++++++++   Cosmics  +++++++++++++++++++++++++++++++++++++++

#Cosmics STRIPS Commissioning
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_General_Cosmics.ini --dataset Cosmics --epoch Commissioning2018 -r "run >= 308320" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt &> "${LOGDIR}/promptCosmicsStripsDECO.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/CosmicsCommissioning/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/CosmicsCommissioning/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini  --dataset Cosmics --epoch Commissioning2018 -r "run >= 308320" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt &> "${LOGDIR}/promptCosmicsStripsPEAK.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/CosmicsCommissioning/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/CosmicsCommissioning/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/Strips/PEAK/
touch .doneCosmics

#Cosmics TrackingCommissioning
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptTracking.ini  -C cfg/trendPlotsTrackingCosmics.ini --dataset Cosmics --epoch Commissioning2018 -r "run >= 308320" --reco Prompt -J json_DCSONLY_cosmics.txt &> "${LOGDIR}/promptCosmicsTracking.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/CosmicsCommissioning/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/CosmicsCommissioning/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/Tracking
touch .doneCosmicsTracking

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptRecoErrors.ini -C cfg/trendPlotsRECOErrorsCosmics.ini --dataset Cosmics --epoch Commissioning2018 -r "run >= 308320" --reco Prompt -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/promptCosmicsRECOerrors.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/CosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/CosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/RecoErrors/
touch .doneCosmics

#Cosmics Pixel Commissioning
rm -rf ./JSON/*
python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset Cosmics --epoch Commissioning2018 -r "run>=292505" --reco Prompt -J json_DCSONLY_cosmics.txt &> "${LOGDIR}/promptCosmicsPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/CosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/CosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/PixelPhase1/
touch .doneCosmics

#Cosmics PIXEL
#rm -rf ./JSON/*
#python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset Cosmics --epoch Run2018 -r "run>=292505" --reco Prompt -J json_DCSONLY_cosmics.txt &> "${LOGDIR}/promptCosmicsPixel.log"
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/Cosmics/PixelPhase1/
#cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/Cosmics/PixelPhase1/
#cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/Cosmics/PixelPhase1/
#touch .doneCosmics

#Cosmics Tracking
#rm -rf ./JSON/*
#python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptTracking.ini  -C cfg/trendPlotsTrackingCosmics.ini --dataset Cosmics --epoch Run2018 -r "run >= 292505" --reco Prompt -J json_DCSONLY_cosmics.txt &> "${LOGDIR}/promptCosmicsTracking.log"
#cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/Cosmics/Tracking
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/Cosmics/Tracking
#cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/Cosmics/Tracking
#touch .doneCosmicsTracking


# ++++++++++++++++++++++++++++++++   StreamExpressCosmics  +++++++++++++++++++++++++++++++++++++++


#StreamExpressCosmics STRIPS Commissioning
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_General_Cosmics.ini --dataset StreamExpressCosmics --epoch Commissioning2018 -r "run >= 308320" --reco Express -J json_DCSONLY_cosmics_DECO.txt &> "${LOGDIR}/expressCosmicsStripDECO.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmicsCommissioning/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmicsCommissioning/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Commissioning2018 -r "run >= 308320" --reco Express -J json_DCSONLY_cosmics_PEAK.txt &> "${LOGDIR}/expressCosmicsStripPEAK.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmicsCommissioning/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmicsCommissioning/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/Strips/PEAK/
touch .doneStreamExpressCosmics

#StreamExpressCosmics TrackingCommissioning
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressTracking.ini -C cfg/trendPlotsTrackingCosmics.ini --dataset StreamExpressCosmics --epoch Commissioning2018 -r "run > 308320" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsTracking.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmicsCommissioning/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmicsCommissioning/Tracking
touch .doneStreamExpressCosmicsTracking      

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressRecoErrors.ini -C cfg/trendPlotsRECOErrorsCosmics.ini --dataset StreamExpressCosmics --epoch Commissioning2018 -r "run > 308320" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsRECOerrors.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmicsCommissioning/RecoErrors/
touch .doneStreamExpressCosmics


#StreamExpressCosmics Pixel Commissioning
rm -rf ./JSON/*
python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset StreamExpressCosmics --epoch Commissioning2018 -r "run>=308320" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/PixelPhase1/
touch .doneStreamExpressCosmics


#StreamExpressCosmics PIXEL
#rm -rf ./JSON/*
#python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset StreamExpressCosmics --epoch Run2018 -r "run>=292505" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsPixel.log"
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmics/PixelPhase1/
#cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmics/PixelPhase1/
#cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmics/PixelPhase1/
#touch .doneStreamExpressCosmics

#StreamExpressCosmics Tracking
#rm -rf ./JSON/*
#python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressTracking.ini -C cfg/trendPlotsTrackingCosmics.ini --dataset StreamExpressCosmics --epoch Run2018 -r "run > 292505" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsTracking.log"
#cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmics/Tracking
#cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmics/Tracking
#cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmics/Tracking
#touch .doneStreamExpressCosmicsTracking



