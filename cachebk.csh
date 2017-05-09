#!/bin/tcsh

set WORKINGDIR="/data/users/HDQM/CMSSW_9_1_0_pre1/HistoricDQM/python"

cd $WORKINGDIR
set subfix=`date +_%Y_%m_%d-%H_%M`
cp "$WORKINGDIR/.DQMCacheCronCExpress" "$WORKINGDIR/CacheBackup/DQMCacheCronCExpress$subfix"
cp "$WORKINGDIR/.DQMCacheCronCExpressPixel" "$WORKINGDIR/CacheBackup/DQMCacheCronCExpressPixel$subfix"
cp "$WORKINGDIR/.DQMCacheCronCPrompt" "$WORKINGDIR/CacheBackup/DQMCacheCronCPrompt$subfix"
cp "$WORKINGDIR/.DQMCacheCronCPromptPixel" "$WORKINGDIR/CacheBackup/DQMCacheCronCPromptPixel$subfix"
