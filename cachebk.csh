#!/bin/tcsh

set WORKINGDIR="/data/users/HDQM/CMSSW_9_1_0_pre1/HistoricDQM/python"

cd $WORKINGDIR
set subfix=`date +_%Y_%m_%d-%H_%M`
cp "$WORKINGDIR/.DQMCacheCronCExpress" "$WORKINGDIR/CacheBackup/DQMCacheCronCExpress$subfix"
cp "$WORKINGDIR/.DQMCacheCronCExpressPixel" "$WORKINGDIR/CacheBackup/DQMCacheCronCExpressPixel$subfix"
cp "$WORKINGDIR/.DQMCacheCronCExpressTracking" "$WORKINGDIR/CacheBackup/DQMCacheCronCExpressTracking$subfix"
cp "$WORKINGDIR/.DQMCacheCronCPrompt" "$WORKINGDIR/CacheBackup/DQMCacheCronCPrompt$subfix"
cp "$WORKINGDIR/.DQMCacheCronCPromptPixel" "$WORKINGDIR/CacheBackup/DQMCacheCronCPromptPixel$subfix"
cp "$WORKINGDIR/.DQMCacheCronCPromptTracking" "$WORKINGDIR/CacheBackup/DQMCacheCronCPromptTracking$subfix"

cp "$WORKINGDIR/.DQMCacheCronPPExpressStrips" "$WORKINGDIR/CacheBackup/DQMCacheCronPPExpressStrips$subfix"
cp "$WORKINGDIR/.DQMCacheCronPPExpressPixel" "$WORKINGDIR/CacheBackup/DQMCacheCronPPExpressPixel$subfix"
cp "$WORKINGDIR/.DQMCacheCronPPExpressTracking" "$WORKINGDIR/CacheBackup/DQMCacheCronPPExpressTracking$subfix"
cp "$WORKINGDIR/.DQMCacheCronPPExpressRecoErrors" "$WORKINGDIR/CacheBackup/DQMCacheCronPPExpressRecoErrors$subfix"

cp "$WORKINGDIR/.DQMCacheCronPPPromptStrips" "$WORKINGDIR/CacheBackup/DQMCacheCronPPPromptStrips$subfix"
cp "$WORKINGDIR/.DQMCacheCronPPPromptPixel" "$WORKINGDIR/CacheBackup/DQMCacheCronPPPromptPixel$subfix"
cp "$WORKINGDIR/.DQMCacheCronPPPromptTracking" "$WORKINGDIR/CacheBackup/DQMCacheCronPPPromptTracking$subfix"
cp "$WORKINGDIR/.DQMCacheCronPPPromptRecoErrors" "$WORKINGDIR/CacheBackup/DQMCacheCronPPPromptRecoErrors$subfix"
