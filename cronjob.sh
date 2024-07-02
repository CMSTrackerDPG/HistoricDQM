#!/bin/sh
source /cvmfs/cms.cern.ch/cmsset_default.sh

#kerberos authentication
kdestroy
kinit -k -t /home/dpgtkdqm/dpgtkdqm.keytab dpgtkdqm
klist
eosfusebind
aklog CERN.CH

##Only update the CMSSW release
CMSSW_REL=CMSSW_14_0_8

WORKINGDIR="/home/dpgtkdqm/cronjobs/HDQM/"${CMSSW_REL}"/HistoricDQM/python"
echo "Work dir path:"$WORKINGDIR

cd $WORKINGDIR

cmsenv

echo "Starting json preparation"

./autoPlotandPublish_2024.sh >& "$WORKINGDIR/../log.cron"

echo "Job completed, copy log"

cat $WORKINGDIR/../log.cron >> $WORKINGDIR/../../../../../cronlogs/hdqm.log
