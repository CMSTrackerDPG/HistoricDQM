#!/bin/tcsh
#kerberos authentication
kinit -k -t /home/dpgtkdqm/dpgtkdqm.keytab dpgtkdqm@CERN.CH
klist 
eosfusebind 

set WORKINGDIR="/home/dpgtkdqm/HDQM/CMSSW_12_6_4/HistoricDQM/python"

cd $WORKINGDIR
cmsenv

./autoPlotandPublish_2023.sh >& "$WORKINGDIR/../log.cron"

