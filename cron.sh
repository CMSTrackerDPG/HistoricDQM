#!/bin/tcsh
#kerberos authentication
kinit -k -t /home/dpgtkdqm/dpgtkdqm.keytab dpgtkdqm@CERN.CH
klist 
eosfusebind 

set WORKINGDIR="/home/dpgtkdqm/HDQM/CMSSW_12_2_1_patch1/HistoricDQM/python"

cd $WORKINGDIR
#next 2 lines a patch
set CMSDIR="/home/dpgtkdqm/HDQM/CMSSW_12_3_6/src/"
cd $CMSDIR
cmsenv

#patch line
cd $WORKINGDIR
./autoPlotandPublish_2022.sh >& "$WORKINGDIR/../log.cron"

