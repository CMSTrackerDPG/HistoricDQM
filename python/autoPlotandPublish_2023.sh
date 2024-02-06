#!/bin/bash

WORKDIR="/home/dpgtkdqm/HDQM/CMSSW_12_6_4/HistoricDQM/python"
LOGDIR="/home/dpgtkdqm/HDQM/CMSSW_12_6_4/HistoricDQM/Logs"
DCSONLY="/home/dpgtkdqm/HDQM/CMSSW_12_6_4/HistoricDQM/python/DCSonly"
OUTDIR="/eos/cms/store/group/tracker-cctrack/www/HDQM/v4"

# ++++++++++++++++++++++++++++++++      RunList    +++++++++++++++++++++++++++++++++++++++                                                       

export SSO_CLIENT_ID=tkhdqm
export SSO_CLIENT_SECRET=ushe20s3EXe3yjmH8rerBD8LNRRfFKUL
#export ENVIRONMENT=qa

#export PYTHONPATH="${PYTHONPATH}:${DCSONLY}/.python_packages/"
cd $DCSONLY
subT=`date`
echo "      --->>> Start Cosmics Run List generation at ${subT}"
python3 ./dcsonly_2022.py -c Cosmics23 -m 363380 -f
subT=`date`
echo "      --->>> Cosmics Run List generation ended at ${subT}"
cp Run_LHCFill_RunDuration_Cosmics.json "${OUTDIR}/alljsons/2023/"
subT=`date`
echo "      --->>> Start Collisions Run List generation at ${subT}"
python3 ./dcsonly_2022.py -c Collisions23 -m 363380 -f
subT=`date`
echo "      --->>> Collisions Run List generation ended at ${subT}"
cp Run_LHCFill_RunDuration.json "${OUTDIR}/alljsons/2023/"

# ++++++++++++++++++++++++++++++++   StreamExpress +++++++++++++++++++++++++++++++++++++++                                                       
cd $WORKDIR
echo " "
echo " "
echo " "
echo "      --->>> STREAMEXPRESS <<<---"

#StreamExpress STRIPS
subT=`date`
echo "      --->>> Strip DECO Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY_DECO.txt" &> "${LOGDIR}/expressStripDECO.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpress/Strips/DECO/"
touch .doneStreamExpress
subT=`date`
echo "      --->>> Strip DECO Ended at ${subT}"

subT=`date`
echo "      --->>> Strip PEAK Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY_PEAK.txt" &> "${LOGDIR}/expressStripPEAK.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpress/Strips/PEAK/"
touch .doneStreamExpress
subT=`date`
echo "      --->>> Strip PEAK Ended at ${subT}"

subT=`date`
echo "      --->>> Strip ALL Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/expressStripALL.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpress/Strips/ALL/"
touch .doneStreamExpress
subT=`date`
echo "      --->>> Strip ALL Ended at ${subT}"


#StreamExpress Strips Gains
subT=`date`
echo "      --->>> Strip GAIN Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_GainsAAG.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco PromptCalibProdSiStripGainsAAG-Express --datatier ALCAPROMPT -J "${DCSONLY}/json_DCSONLY_DECO.txt"  &> "${LOGDIR}/expressStripGAIN.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpress/Strips/DECO/"
touch .doneStreamExpress
subT=`date`
echo "      --->>> Strip Gain Ended at ${subT}"

#StreamExpress PIXEL
subT=`date`
echo "      --->>> Pixel Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressPixel.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini -C cfg/trendPlotsPixelPhase1_DigiCluster.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_test.ini -C cfg/trendPlotsPixelPhase1_clustersFPixByRing.ini -C cfg/trendPlotsPixelPhase1_clustersBPixByModule.ini -C cfg/trendPlotsPixelPhase1_deadROC.ini -C cfg/trendPlotsPixelPhase1_DamagedL2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL4Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL3Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing1Module.ini -C cfg/trendPlotsPixelPhase1_ROCocc.ini -C cfg/trendPlotsPixelPhase1_templateCorrBPIX.ini  -C cfg/trendPlotsPixelPhase1_templateCorrFPIX.ini -C cfg/trendPlotsPixelPhase1_DRM_BPix.ini -C cfg/trendPlotsPixelPhase1_DRM_FPix.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 292505" --reco Express -J "${DCSONLY}/json_DCSONLY.txt"  &> "${LOGDIR}/expressPixel.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpress/PixelPhase1/"
touch .doneStreamExpressPixel
subT=`date`
echo "      --->>> Pixel Ended at ${subT}"


#StreamExpress TRACKING
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressTracking.ini -C cfg/trendPlotsTracking.ini -C cfg/trendPlotsAlignment.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/expressTracking.log"
python3 ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
python3 MakeIncremental.py -h ./JSON/ -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpress/Tracking/"
touch .doneStreamExpressTracking
subT=`date`
echo "      --->>> Tracking Ended at ${subT}"

#StreamHLTMonitor TRACKING
subT=`date`
echo "      --->>> HLT Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPHLTTracking.ini -C cfg/trendPlotsHLTTracking.ini -C cfg/trendPlotsHLT_Alignment.ini --dataset StreamHLTMonitor --epoch Run2023 --epoch HIRun2023 --epoch Commissioning2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/expressHLTTracking.log"
python3 ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPixelVertices_mean -f TrkOverPVertices_ratio -t TrkOverPixelVertices_ratio
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamHLTMonitor/Tracking/"
touch .doneStreamHLTMonitorTracking
subT=`date`
echo "      --->>> HLT Tracking Ended at ${subT}"

#StreamExpress RecoError
subT=`date`
echo "      --->>> RecoErrors Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressRecoErrors.ini -C cfg/trendPlotsRECOErrors2017.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -J "${DCSONLY}/json_DCSONLY.txt" --reco Express &> "${LOGDIR}/expressRECOerrors.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpress/RecoErrors/"
touch .doneExpressRecoErrors
subT=`date`
echo "      --->>> RecoErrors Ended at ${subT}"


# ++++++++++++++++++++++++++++++++   ZeroBias +++++++++++++++++++++++++++++++++++++++                                                       
echo " "
echo " "
echo " "
echo "      --->>> ZEROBIAS <<<---"


#ZeroBias STRIPS
subT=`date`
echo "      --->>> Strip DECO Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run2023 --epoch HIRun2023 --epoch Commissioning2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY_DECO.txt" &> "${LOGDIR}/promptStripDECO.log"
#python3 ./HDQMInefficientModules.py
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/ZeroBias/Strips/DECO/"
touch .doneZeroBias
subT=`date`
echo "      --->>> Strip DECO Ended at ${subT}"

subT=`date`
echo "      --->>> Strip PEAK Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run2023 --epoch HIRun2023 --epoch Commissioning2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY_PEAK.txt"  &> "${LOGDIR}/promptStripPEAK.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/ZeroBias/Strips/PEAK/"
touch .doneZeroBias
subT=`date`
echo "      --->>> Strip PEAK Ended at ${subT}"

subT=`date`
echo "      --->>> Strip ALL Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run2023 --epoch HIRun2023 --epoch Commissioning2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/promptStripALL.log"
#python3 ./HDQMInefficientModules.py
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/ZeroBias/Strips/ALL/"
touch .doneZeroBias
subT=`date`
echo "      --->>> Strip ALL Ended at ${subT}"

#ZeroBias PIXEL
subT=`date`
echo "      --->>> Pixel Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptPixel.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini -C cfg/trendPlotsPixelPhase1_DigiCluster.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_test.ini -C cfg/trendPlotsPixelPhase1_clustersFPixByRing.ini -C cfg/trendPlotsPixelPhase1_clustersBPixByModule.ini -C cfg/trendPlotsPixelPhase1_deadROC.ini -C cfg/trendPlotsPixelPhase1_DamagedL2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL4Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL3Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing1Module.ini -C cfg/trendPlotsPixelPhase1_templateCorrBPIX.ini  -C cfg/trendPlotsPixelPhase1_templateCorrFPIX.ini -C cfg/trendPlotsPixelPhase1_DRM_BPix.ini -C cfg/trendPlotsPixelPhase1_DRM_FPix.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run2023 --epoch HIRun2023 --epoch Commissioning2023 --epoch HIRun2023 -r "run >= 292505" --reco Prompt -J "${DCSONLY}/json_DCSONLY.txt"  &> "${LOGDIR}/promptPixel.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/ZeroBias/PixelPhase1/"
touch .doneZeroBiasPixel
subT=`date`
echo "      --->>> Pixel Ended at ${subT}"


#ZeroBias TRACKING
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptTracking.ini -C cfg/trendPlotsTracking.ini -C cfg/trendPlotsAlignment.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run2023 --epoch HIRun2023 --epoch Commissioning2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/promptTracking.log"
python3 ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
python3 MakeIncremental.py -h ./JSON/ -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/ZeroBias/Tracking/"
touch .doneZeroBiasTracking
subT=`date`
echo "      --->>> Tracking Ended at ${subT}"

#ZeroBias RecoError
subT=`date`
echo "      --->>> RecoErrors Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptRecoErrors.ini -C cfg/trendPlotsRECOErrors2017.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run2023 --epoch HIRun2023 --epoch Commissioning2023 --epoch HIRun2023 -J "${DCSONLY}/json_DCSONLY.txt" --reco Prompt &> "${LOGDIR}/promptRECOerrors.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/ZeroBias/RecoErrors/"
touch .donePromptRecoErrors
subT=`date`
echo "      --->>> RecoErrors Ended at ${subT}"




# ++++++++++++++++++++++++++++++++   StreamExpressCosmics  +++++++++++++++++++++++++++++++++++++++
echo " "
echo " "
echo " "
echo "      --->>> STREAMEXPRESS COSMICS <<<---"


#StreamExpressCosmics STRIPS
subT=`date`
echo "      --->>> Strips DECO Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset StreamExpressCosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics_DECO.txt" &> "${LOGDIR}/expressCosmicsStripDECO.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpressCosmics/Strips/DECO/"
touch .doneStreamExpressCosmics
subT=`date`
echo "      --->>> Strips DECO Ended at ${subT}"

subT=`date`
echo "      --->>> Strips PEAK Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset StreamExpressCosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics_PEAK.txt" &> "${LOGDIR}/expressCosmicsStripPEAK.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpressCosmics/Strips/PEAK/"
touch .doneStreamExpressCosmics
subT=`date`
echo "      --->>> Strips PEAK Ended at ${subT}"

subT=`date`
echo "      --->>> Strips ALL Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset StreamExpressCosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics.txt" &> "${LOGDIR}/expressCosmicsStripALL.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpressCosmics/Strips/ALL/"
touch .doneStreamExpressCosmics
subT=`date`
echo "      --->>> Strips ALL Ended at ${subT}"

#StreamExpressCosmics PIXEL
subT=`date`
echo "      --->>> Pixel Started at ${subT}"
rm -rf ./JSON/*
python3 trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersCosmics.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset StreamExpressCosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run>=292505" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics.txt"  &> "${LOGDIR}/expressCosmicsPixel.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpressCosmics/PixelPhase1/"
touch .doneStreamExpressCosmics
subT=`date`
echo "      --->>> Pixel Ended at ${subT}"

#StreamExpressCosmics Tracking
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpressTracking.ini -C cfg/trendPlotsTrackingCosmics.ini --dataset StreamExpressCosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run > 292505" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics.txt"  &> "${LOGDIR}/expressCosmicsTracking.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/StreamExpressCosmics/Tracking"
python3 MakeIncremental.py -h "${OUTDIR}/alljsons/2023/StreamExpressCosmics/Tracking/" -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
touch .doneStreamExpressCosmicsTracking
subT=`date`
echo "      --->>> Tracking Ended at ${subT}"




# ++++++++++++++++++++++++++++++++   Cosmics  +++++++++++++++++++++++++++++++++++++++
echo " "
echo " "
echo " "
echo "      --->>> COSMICS <<<---"

#Cosmics STRIPS
subT=`date`
echo "      --->>> Strips DECO Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset Cosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics_DECO.txt" &> "${LOGDIR}/promptCosmicsStripsDECO.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/Cosmics/Strips/DECO/"
touch .doneCosmics
subT=`date`
echo "      --->>> Strips DECO Ended at ${subT}"

subT=`date`
echo "      --->>> Strips PEAK Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset Cosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics_PEAK.txt" &> "${LOGDIR}/promptCosmicsStripsPEAK.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/Cosmics/Strips/PEAK/"
touch .doneCosmics
subT=`date`
echo "      --->>> Strips PEAK Ended at ${subT}"

subT=`date`
echo "      --->>> Strips ALL Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset Cosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics.txt" &> "${LOGDIR}/promptCosmicsStripsALL.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/Cosmics/Strips/ALL/"
touch .doneCosmics
subT=`date`
echo "      --->>> Strips ALL Ended at ${subT}"

#Cosmics PIXEL
subT=`date`
echo "      --->>> Pixel Started at ${subT}"
rm -rf ./JSON/*
python3 trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersCosmics.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset Cosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics.txt" &> "${LOGDIR}/promptCosmicsPixel.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/Cosmics/PixelPhase1/"
touch .doneCosmics
subT=`date`
echo "      --->>> Pixel Ended at ${subT}"

#Cosmics Tracking
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPromptTracking.ini  -C cfg/trendPlotsTrackingCosmics.ini --dataset Cosmics --epoch Commissioning2023 --epoch Run2023 --epoch HIRun2023 -r "run >= 363380" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics.txt" &> "${LOGDIR}/promptCosmicsTracking.log"
cp ./JSON/* "${OUTDIR}/alljsons/2023/Prompt/Cosmics/Tracking"
python3 MakeIncremental.py -h "${OUTDIR}/alljsons/2023/Prompt/Cosmics/Tracking/" -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
touch .doneCosmicsTracking
subT=`date`
echo "      --->>> Tracking Ended at ${subT}"


