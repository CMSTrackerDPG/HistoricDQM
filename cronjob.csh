#!/bin/tcsh

set WORKINGDIR="/data/users/HDQM/CMSSW_10_0_0/HistoricDQM/python"

cd $WORKINGDIR
cmsenv
./autoPlotandPublish_2017.sh >& "$WORKINGDIR/../log.cron"

