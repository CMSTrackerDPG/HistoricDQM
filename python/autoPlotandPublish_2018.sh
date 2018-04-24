#!/bin/bash


LOGDIR="/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/Logs"

#DCS JSON file production for collisions and cosmics
python dcsonlyjson_all.py --min 294600 --cosmics
python Get_Run_RunDuration_LHCFill_info.py --cosmics
cp Run_LHCFill_RunDuration_Cosmics.json /data/users/event_display/HDQM/v4/alljsons/2018/
python dcsonlyjson_all.py --min 314400
python Get_Run_RunDuration_LHCFill_info.py
cp Run_LHCFill_RunDuration.json /data/users/event_display/HDQM/v4/alljsons/2018/



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
python MakeIncremental.py -h /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/Tracking/ -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
touch .doneCosmicsTracking

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptRecoErrors.ini -C cfg/trendPlotsRECOErrorsCosmics.ini --dataset Cosmics --epoch Commissioning2018 -r "run >= 308320" --reco Prompt -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/promptCosmicsRECOerrors.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/CosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/CosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/RecoErrors/
touch .doneCosmics

#Cosmics Pixel Commissioning
rm -rf ./JSON/*
python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersCosmics.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset Cosmics --epoch Commissioning2018 -r "run>=292505" --reco Prompt -J json_DCSONLY_cosmics.txt &> "${LOGDIR}/promptCosmicsPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/CosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/CosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/CosmicsCommissioning/PixelPhase1/
touch .doneCosmics

#Cosmics STRIPS
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset Cosmics --epoch Run2018 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_DECO.txt &> "${LOGDIR}/promptCosmicsStripsDECO.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/Cosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/Cosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/Cosmics/Strips/DECO/
touch .doneCosmics

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini  --dataset Cosmics --epoch Run2018 -r "run >= 290129" --reco Prompt -J json_DCSONLY_cosmics_PEAK.txt &> "${LOGDIR}/promptCosmicsStripsPEAK.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/Cosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/Cosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/Cosmics/Strips/PEAK/
touch .doneCosmics

#Cosmics PIXEL
rm -rf ./JSON/*
python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset Cosmics --epoch Run2018 -r "run>=292505" --reco Prompt -J json_DCSONLY_cosmics.txt &> "${LOGDIR}/promptCosmicsPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/Cosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/Cosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/Cosmics/PixelPhase1/
touch .doneCosmics

#Cosmics Tracking
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCPromptTracking.ini  -C cfg/trendPlotsTrackingCosmics.ini --dataset Cosmics --epoch Run2018 -r "run >= 292505" --reco Prompt -J json_DCSONLY_cosmics.txt &> "${LOGDIR}/promptCosmicsTracking.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/Cosmics/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/Cosmics/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/Cosmics/Tracking
touch .doneCosmicsTracking



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
python MakeIncremental.py -h /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/Tracking/ -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
touch .doneStreamExpressCosmicsTracking      

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressRecoErrors.ini -C cfg/trendPlotsRECOErrorsCosmics.ini --dataset StreamExpressCosmics --epoch Commissioning2018 -r "run > 308320" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsRECOerrors.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmicsCommissioning/RecoErrors/
touch .doneStreamExpressCosmics


#StreamExpressCosmics Pixel Commissioning
rm -rf ./JSON/*
python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersCosmics.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset StreamExpressCosmics --epoch Commissioning2018 -r "run>=308320" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmicsCommissioning/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmicsCommissioning/PixelPhase1/
touch .doneStreamExpressCosmics


#StreamExpressCosmics STRIPS
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Run2018 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_DECO.txt &> "${LOGDIR}/expressCosmicsStripDECO.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmics/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmics/Strips/DECO/
touch .doneStreamExpressCosmics

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini --dataset StreamExpressCosmics --epoch Run2018 -r "run >= 290129" --reco Express -J json_DCSONLY_cosmics_PEAK.txt &> "${LOGDIR}/expressCosmicsStripPEAK.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmics/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmics/Strips/PEAK/
touch .doneStreamExpressCosmics

#StreamExpressCosmics PIXEL
rm -rf ./JSON/*
python trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clusters.ini --dataset StreamExpressCosmics --epoch Run2018 -r "run>=292505" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmics/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmics/PixelPhase1/
touch .doneStreamExpressCosmics

#StreamExpressCosmics Tracking
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronCExpressTracking.ini -C cfg/trendPlotsTrackingCosmics.ini --dataset StreamExpressCosmics --epoch Run2018 -r "run > 292505" --reco Express -J json_DCSONLY_cosmics.txt  &> "${LOGDIR}/expressCosmicsTracking.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpressCosmics/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpressCosmics/Tracking
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpressCosmics/Tracking
touch .doneStreamExpressCosmicsTracking




# ++++++++++++++++++++++++++++++++   ZeroBias +++++++++++++++++++++++++++++++++++++++                                                       

#ZeroBias STRIPS
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini --dataset ZeroBias --epoch Commissioning2018 -r "run >= 290129" --reco Prompt -J json_DCSONLY_DECO.txt &> "${LOGDIR}/promptStripDECO.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/ZeroBias/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/ZeroBias/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/ZeroBias/Strips/DECO/
touch .doneZeroBias

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset ZeroBias --epoch Commissioning2018 -r "run >= 290129" --reco Prompt -J json_DCSONLY_PEAK.txt  &> "${LOGDIR}/promptStripPEAK.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/ZeroBias/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/ZeroBias/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/ZeroBias/Strips/PEAK/
touch .doneZeroBias

#ZeroBias PIXEL
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini -C cfg/trendPlotsPixelPhase1_DigiCluster.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_test.ini -C cfg/trendPlotsPixelPhase1_clustersFPixByRing.ini -C cfg/trendPlotsPixelPhase1_clustersBPixByModule.ini -C cfg/trendPlotsPixelPhase1_deadROC.ini --dataset ZeroBias --epoch Commissioning2018 -r "run >= 292505" --reco Prompt -J json_DCSONLY.txt  &> "${LOGDIR}/promptPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/ZeroBias/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/ZeroBias/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/ZeroBias/PixelPhase1/
touch .doneZeroBiasPixel


#ZeroBias TRACKING
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPPromptTracking.ini -C cfg/trendPlotsTracking.ini --dataset ZeroBias --epoch Commissioning2018 -r "run >= 290129" --reco Prompt -J json_DCSONLY.txt &> "${LOGDIR}/promptTracking.log"
python ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/ZeroBias/Tracking/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/ZeroBias/Tracking/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/ZeroBias/Tracking/
touch .doneZeroBiasTracking

#ZeroBias RecoError
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPPromptRecoErrors.ini -C cfg/trendPlotsRECOErrors2018.ini --dataset ZeroBias --epoch Commissioning2018 -J json_DCSONLY.txt --reco Prompt &> "${LOGDIR}/promptRECOerrors.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/Prompt/ZeroBias/RecoErrors/ 
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/Prompt/ZeroBias/RecoErrors/ 
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/Prompt/ZeroBias/RecoErrors/ 
touch .donePromptRecoErrors




# ++++++++++++++++++++++++++++++++   StreamExpress +++++++++++++++++++++++++++++++++++++++                                                       

#StreamExpress STRIPS
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini --dataset StreamExpress --epoch Commissioning2018 -r "run >= 290129" --reco Express -J json_DCSONLY_DECO.txt &> "${LOGDIR}/expressStripDECO.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpress/Strips/DECO/
touch .doneStreamExpress

rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini --dataset StreamExpress --epoch Commissioning2018 -r "run >= 290129" --reco Express -J json_DCSONLY_PEAK.txt &> "${LOGDIR}/expressStripPEAK.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpress/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpress/Strips/PEAK/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpress/Strips/PEAK/
touch .doneStreamExpress

#StreamExpress Strips Gains
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_GainsAAG.ini --dataset StreamExpress --epoch Commissioning2018 -r "run >= 290129" --reco PromptCalibProdSiStripGainsAAG-Express --datatier ALCAPROMPT -J json_DCSONLY_DECO.txt  &> "${LOGDIR}/expressStripGAIN.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpress/Strips/DECO/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpress/Strips/DECO/
touch .doneStreamExpress


#StreamExpress PIXEL
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini -C cfg/trendPlotsPixelPhase1_DigiCluster.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_test.ini -C cfg/trendPlotsPixelPhase1_clustersFPixByRing.ini -C cfg/trendPlotsPixelPhase1_clustersBPixByModule.ini -C cfg/trendPlotsPixelPhase1_deadROC.ini --dataset StreamExpress --epoch Commissioning2018 -r "run >= 292505" --reco Express -J json_DCSONLY.txt  &> "${LOGDIR}/expressPixel.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpress/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpress/PixelPhase1/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpress/PixelPhase1/
touch .doneStreamExpressPixel

#StreamExpress TRACKING
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPExpressTracking.ini -C cfg/trendPlotsTracking.ini --dataset StreamExpress --epoch Commissioning2018 -r "run >= 290129" --reco Express -J json_DCSONLY.txt &> "${LOGDIR}/expressTracking.log"
python ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpress/Tracking/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpress/Tracking/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpress/Tracking/
touch .doneStreamExpressTracking

#StreamExpress RecoError
rm -rf ./JSON/*
python ./trendPlots_2018.py -C cfg/trendPlotsDQM_cronPPExpressRecoErrors.ini -C cfg/trendPlotsRECOErrors2018.ini --dataset StreamExpress --epoch Commissioning2018 -J json_DCSONLY.txt --reco Express &> "${LOGDIR}/expressRECOerrors.log"
cp ./JSON/* /data/users/event_display/HDQM/v3.1/alljsons/2018/StreamExpress/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v4/alljsons/2018/StreamExpress/RecoErrors/
cp ./JSON/* /data/users/event_display/HDQM/v3/alljsons/2018/StreamExpress/RecoErrors/
touch .doneExpressRecoErrors