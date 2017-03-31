#!/bin/tcsh

set WORKINGDIR="/data/users/HDQM/CMSSW_9_1_0_pre1/HistoricDQM/python"

cd $WORKINGDIR
cmsenv
./autoPlotandPublish_2017.sh > "$WORKINGDIR/../log.cron"

