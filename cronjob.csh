#!/bin/tcsh

set WORKINGDIR="/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python"

cd $WORKINGDIR
cmsenv
./autoPlotandPublish_2018.sh >& "$WORKINGDIR/../log.cron"

