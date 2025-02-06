#!/bin/bash

vocms_path="/data/users/event_display/dpgtkdqm/cronjobs/HDQM/" #2025

CMSSW_version="CMSSW_14_0_14"

WORKDIR=$vocms_path$CMSSW_version"/HistoricDQM/python"
LOGDIR=$vocms_path$CMSSW_version"/HistoricDQM/Logs"
DCSONLY=$vocms_path$CMSSW_version"/HistoricDQM/python/DCSonly"
OUTDIR="/eos/cms/store/group/tracker-cctrack/www/HDQM/v4"

YEAR="2025"
FIRST_COSMICS="389000"
FIRST_COLLISIONS="390000"


# ++++++++++++++++++++++++++++++++      RunList    +++++++++++++++++++++++++++++++++++++++                                                       

export SSO_CLIENT_ID=tkhdqm
export SSO_CLIENT_SECRET=hidden

#export PYTHONPATH="${PYTHONPATH}:${DCSONLY}/.python_packages/"
cd $DCSONLY
subT=`date`
echo "      --->>> Start Cosmics Run List generation at ${subT}"
python3 ./dcsonly_2022.py -c Cosmics25 -m "${FIRST_COSMICS}" -f
subT=`date`
echo "      --->>> Cosmics Run List generation ended at ${subT}"
cp Run_LHCFill_RunDuration_Cosmics.json "${OUTDIR}/alljsons/${YEAR}/"
subT=`date`
echo "      --->>> Start Collisions Run List generation at ${subT}"
python3 ./dcsonly_2022.py -c Collisions25 -m "${FIRST_COLLISIONS}" -f
subT=`date`
echo "      --->>> Collisions Run List generation ended at ${subT}"
cp Run_LHCFill_RunDuration.json "${OUTDIR}/alljsons/${YEAR}/"

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
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Express -J "${DCSONLY}/json_DCSONLY_DECO.txt" &> "${LOGDIR}/expressStripDECO.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpress/Strips/DECO/"
touch .doneStreamExpress
subT=`date`
echo "      --->>> Strip DECO Ended at ${subT}"

#StreamExpress Strips Gains
subT=`date`
echo "      --->>> Strip GAIN Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_GainsAAG.ini -C cfg/trendPlotsStrip_GainsAAG_Langau.ini --dataset StreamExpress --dataset StreamHIExpress --dataset StreamHIExpressRawPrime --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco PromptCalibProdSiStripGainsAAG-Express --datatier ALCAPROMPT -J "${DCSONLY}/json_DCSONLY_DECO.txt"  &> "${LOGDIR}/expressStripGAIN.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpress/Strips/DECO/"
touch .doneStreamExpress
subT=`date`
echo "      --->>> Strip Gain Ended at ${subT}"

#StreamExpress PIXEL part_1
subT=`date`
echo "      --->>> Pixel part_1 Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressPixel_1.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini -C cfg/trendPlotsPixelPhase1_DigiCluster.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_test.ini -C cfg/trendPlotsPixelPhase1_clustersFPixByRing.ini -C cfg/trendPlotsPixelPhase1_clustersBPixByModule.ini -C cfg/trendPlotsPixelPhase1_deadROC.ini -C cfg/trendPlotsPixelPhase1_ROCocc.ini -C cfg/trendPlotsPixelPhase1_templateCorrBPIX.ini  -C cfg/trendPlotsPixelPhase1_templateCorrFPIX.ini -C cfg/trendPlotsPixelPhase1_DRM_BPix.ini -C cfg/trendPlotsPixelPhase1_DRM_FPix.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Express -J "${DCSONLY}/json_DCSONLY.txt"  &> "${LOGDIR}/expressPixel_1.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpress/PixelPhase1/"
touch .doneStreamExpressPixel_1
subT=`date`
echo "      --->>> Pixel part_1 Ended at ${subT}"

#StreamExpress PIXEL part_2
#subT=`date`
#echo "      --->>> Pixel part_2 Started at ${subT}"
#rm -rf ./JSON/*
#python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressPixel_2.ini -C cfg/trendPlotsPixelPhase1_DamagedL2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL4Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL3Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing1Module.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Express -J "${DCSONLY}/json_DCSONLY.txt"  &> "${LOGDIR}/expressPixel_2.log"
#cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpress/PixelPhase1/"
#touch .doneStreamExpressPixel_2
#subT=`date`
#echo "      --->>> Pixel part_2 Ended at ${subT}"

#StreamExpress TRACKING
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressTracking.ini -C cfg/trendPlotsTracking.ini -C cfg/trendPlotsAlignment.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Express -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/expressTracking.log"
python3 ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
python3 MakeIncremental.py -h ./JSON/ -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpress/Tracking/"
touch .doneStreamExpressTracking
subT=`date`
echo "      --->>> Tracking Ended at ${subT}"

#StreamHLTMonitor TRACKING
subT=`date`
echo "      --->>> HLT Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPHLTTracking.ini -C cfg/trendPlotsHLTTracking.ini -C cfg/trendPlotsHLT_Alignment.ini --dataset StreamHLTMonitor --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" --epoch Commissioning"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Express -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/expressHLTTracking.log"
python3 ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPixelVertices_mean -f TrkOverPVertices_ratio -t TrkOverPixelVertices_ratio
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamHLTMonitor/Tracking/"
touch .doneStreamHLTMonitorTracking
subT=`date`
echo "      --->>> HLT Tracking Ended at ${subT}"

#StreamExpress RecoError
subT=`date`
echo "      --->>> RecoErrors Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPExpressRecoErrors.ini -C cfg/trendPlotsRECOErrors2017.ini --dataset StreamExpress --dataset StreamHIExpressRawPrime --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -J "${DCSONLY}/json_DCSONLY.txt" --reco Express &> "${LOGDIR}/expressRECOerrors.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpress/RecoErrors/"
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
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_Number_APVShots.ini -C cfg/trendPlotsStrip_TIB_Residuals.ini -C cfg/trendPlotsStrip_TOB_Residuals.ini -C cfg/trendPlotsStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  -C cfg/trendPlotsStrip_StoN_TOB.ini  -C cfg/trendPlotsStrip_StoN_TIB.ini -C cfg/trendPlotsStrip_StoN_TEC_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TEC_MINUS.ini -C cfg/trendPlotsStrip_StoN_TID_PLUS.ini  -C cfg/trendPlotsStrip_StoN_TID_MINUS.ini -C cfg/trendPlotsStrip_BadComponents.ini -C cfg/trendPlotsStrip_FEerror.ini -C cfg/trendPlotsStrip_ClustersNoise_TOB.ini -C cfg/trendPlotsStrip_ClustersNoise_TIB.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TID_MINUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_PLUS.ini -C cfg/trendPlotsStrip_ClustersNoise_TEC_MINUS.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" --epoch Commissioning"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Prompt -J "${DCSONLY}/json_DCSONLY_DECO.txt" &> "${LOGDIR}/promptStripDECO.log"
#python3 ./HDQMInefficientModules.py
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/ZeroBias/Strips/DECO/"
touch .doneZeroBias
subT=`date`
echo "      --->>> Strip DECO Ended at ${subT}"

#ZeroBias PIXEL part_1
subT=`date`
echo "      --->>> Pixel part_1 Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptPixel_1.ini -C cfg/trendPlotsPixelPhase1_clustersV3.ini -C cfg/trendPlotsPixelPhase1_FED.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_BPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_FPIX_Residuals.ini -C cfg/trendPlotsPixelPhase1_clustersBPIX_v2.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_v2.ini -C cfg/trendPlotsPixelPhase1_HitsEfficiency.ini -C cfg/trendPlotsPixelPhase1_DigiCluster.ini -C cfg/trendPlotsPixelPhase1_clustersFPIX_test.ini -C cfg/trendPlotsPixelPhase1_clustersFPixByRing.ini -C cfg/trendPlotsPixelPhase1_clustersBPixByModule.ini -C cfg/trendPlotsPixelPhase1_deadROC.ini -C cfg/trendPlotsPixelPhase1_templateCorrBPIX.ini  -C cfg/trendPlotsPixelPhase1_templateCorrFPIX.ini -C cfg/trendPlotsPixelPhase1_DRM_BPix.ini -C cfg/trendPlotsPixelPhase1_DRM_FPix.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" --epoch Commissioning"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Prompt -J "${DCSONLY}/json_DCSONLY.txt"  &> "${LOGDIR}/promptPixel_1.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/ZeroBias/PixelPhase1/"
touch .doneZeroBiasPixel_1
subT=`date`
echo "      --->>> Pixel part_1 Ended at ${subT}"

#ZeroBias PIXEL part_2
#subT=`date`
#echo "      --->>> Pixel part_2 Started at ${subT}"
#rm -rf ./JSON/*
#python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptPixel_2.ini -C cfg/trendPlotsPixelPhase1_DamagedL2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL4Module.ini -C cfg/trendPlotsPixelPhase1_DamagedL3Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing2Module.ini -C cfg/trendPlotsPixelPhase1_DamagedRing1Module.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" --epoch Commissioning"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Prompt -J "${DCSONLY}/json_DCSONLY.txt"  &> "${LOGDIR}/promptPixel_2.log"
#cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/ZeroBias/PixelPhase1/"
#touch .doneZeroBiasPixel_2
#subT=`date`
#echo "      --->>> Pixel part_2 Ended at ${subT}"

#ZeroBias TRACKING
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptTracking.ini -C cfg/trendPlotsTracking.ini -C cfg/trendPlotsAlignment.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" --epoch Commissioning"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Prompt -J "${DCSONLY}/json_DCSONLY.txt" &> "${LOGDIR}/promptTracking.log"
python3 ./MakeRatioJSON.py -n NumberOfTrack_mean -d NumberofPVertices_mean -f TrkOverPVertices_ratio -t TrkOverPVertices_ratio
python3 MakeIncremental.py -h ./JSON/ -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/ZeroBias/Tracking/"
touch .doneZeroBiasTracking
subT=`date`
echo "      --->>> Tracking Ended at ${subT}"

#ZeroBias RecoError
subT=`date`
echo "      --->>> RecoErrors Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronPPPromptRecoErrors.ini -C cfg/trendPlotsRECOErrors2017.ini --dataset ZeroBias --dataset HIPhysicsRawPrime0 --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" --epoch Commissioning"${YEAR}" -J "${DCSONLY}/json_DCSONLY.txt" --reco Prompt &> "${LOGDIR}/promptRECOerrors.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/ZeroBias/RecoErrors/"
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
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpress.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset StreamExpressCosmics --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COLLISIONS}" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics_DECO.txt" &> "${LOGDIR}/expressCosmicsStripDECO.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpressCosmics/Strips/DECO/"
touch .doneStreamExpressCosmics
subT=`date`
echo "      --->>> Strips DECO Ended at ${subT}"

#StreamExpressCosmics PIXEL
subT=`date`
echo "      --->>> Pixel Started at ${subT}"
rm -rf ./JSON/*
python3 trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpressPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersCosmics.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset StreamExpressCosmics --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run>=292505" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics.txt"  &> "${LOGDIR}/expressCosmicsPixel.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpressCosmics/PixelPhase1/"
touch .doneStreamExpressCosmics
subT=`date`
echo "      --->>> Pixel Ended at ${subT}"

#StreamExpressCosmics Tracking
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCExpressTracking.ini -C cfg/trendPlotsTrackingCosmics.ini --dataset StreamExpressCosmics --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run > ${FIRST_COLLISIONS}" --reco Express -J "${DCSONLY}/json_DCSONLY_cosmics.txt"  &> "${LOGDIR}/expressCosmicsTracking.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/StreamExpressCosmics/Tracking"
python3 MakeIncremental.py -h "${OUTDIR}/alljsons/${YEAR}/StreamExpressCosmics/Tracking/" -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
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
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPrompt.ini -C cfg/trendPlotsStrip_TotalClusterMultiplicity.ini -C cfg/trendPlotsStrip_StoN.ini -C cfg/trendPlotsStrip_StoN_mean.ini -C cfg/trendPlotsCStrip_TIB_Residuals.ini -C cfg/trendPlotsCStrip_TOB_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Minus_Residuals.ini -C cfg/trendPlotsCStrip_TEC_Plus_Residuals.ini -C cfg/trendPlotsStrip_TID_Minus_Residuals.ini -C cfg/trendPlotsStrip_TID_Plus_Residuals.ini  --dataset Cosmics --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COSMICS}" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics_DECO.txt" &> "${LOGDIR}/promptCosmicsStripsDECO.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/Cosmics/Strips/DECO/"
touch .doneCosmics
subT=`date`
echo "      --->>> Strips DECO Ended at ${subT}"

#Cosmics PIXEL
subT=`date`
echo "      --->>> Pixel Started at ${subT}"
rm -rf ./JSON/*
python3 trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPromptPixel.ini -C cfg/trendPlotsPixelPhase1_ADCDIGI.ini -C cfg/trendPlotsPixelPhase1_clustersCosmics.ini -C cfg/trendPlotsPixelPhase1_tracks.ini --dataset Cosmics --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COSMICS}" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics.txt" &> "${LOGDIR}/promptCosmicsPixel.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/Cosmics/PixelPhase1/"
touch .doneCosmics
subT=`date`
echo "      --->>> Pixel Ended at ${subT}"

#Cosmics Tracking
subT=`date`
echo "      --->>> Tracking Started at ${subT}"
rm -rf ./JSON/*
python3 ./trendPlots_2022.py -C cfg/trendPlotsDQM_cronCPromptTracking.ini  -C cfg/trendPlotsTrackingCosmics.ini --dataset Cosmics --epoch Commissioning"${YEAR}" --epoch Run"${YEAR}" --epoch HIRun"${YEAR}" -r "run >= ${FIRST_COSMICS}" --reco Prompt -J "${DCSONLY}/json_DCSONLY_cosmics.txt" &> "${LOGDIR}/promptCosmicsTracking.log"
cp ./JSON/* "${OUTDIR}/alljsons/${YEAR}/Prompt/Cosmics/Tracking"
python3 MakeIncremental.py -h "${OUTDIR}/alljsons/${YEAR}/Prompt/Cosmics/Tracking/" -i NumberOfALCARecoTracks -o IncrementalNumberOfALCARecoTracks -t "Incremental Number of ALCA Reco Tracks"
touch .doneCosmicsTracking
subT=`date`
echo "      --->>> Tracking Ended at ${subT}"
