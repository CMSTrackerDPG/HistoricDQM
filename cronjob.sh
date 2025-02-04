#!/bin/sh
source /cvmfs/cms.cern.ch/cmsset_default.sh

#kerberos authentication
kdestroy
kinit -k -t /data/users/event_display/dpgtkdqm/dpgtkdqm.keytab dpgtkdqm #2025
klist
eosfusebind
aklog CERN.CH

#Only update the CMSSW release
CMSSW_REL=CMSSW_14_0_14

WORKINGDIR="/data/users/event_display/dpgtkdqm/cronjobs/HDQM/"${CMSSW_REL}"/HistoricDQM/python" #2025

echo "Work dir path:"$WORKINGDIR

cd $WORKINGDIR

cmsenv

echo "Starting json preparation"

./autoPlotandPublish_2025.sh >& "$WORKINGDIR/../log.cron"

echo "Job completed, copy log"

cat $WORKINGDIR/../log.cron >> $WORKINGDIR/../../../../../cronlogs/hdqm.log

echo "Copy cache to eos"

cp $WORKINGDIR/.DQMCache* /eos/cms/store/group/tracker-cctrack/www/HDQM/v4/cache/.
