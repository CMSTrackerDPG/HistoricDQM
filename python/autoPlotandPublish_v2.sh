#!/bin/bash

#ZeroBias STRIPS
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPPromptStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini --dataset ZeroBias1 --epoch Run2015 -r "run > 246907" --reco Prompt
cp ./JSON/* /data/users/event_display/HDQM/v2/HDQM_NUST/alljsons/2015/Prompt/ZeroBias/Strips/DECO/

#StreamExpress STRIPS
rm -rf ./JSON/*
python ./trendPlots.py -C cfg/trendPlotsDQM_cronPPExpressStrips.ini -C cfg/trendPlotsStrip_General_2015.ini -C cfg/trendPlotsStrip_TEC_2015.ini -C cfg/trendPlotsStrip_TID_2015.ini -C cfg/trendPlotsStrip_TIB.ini -C cfg/trendPlotsStrip_TOB.ini -C cfg/trendPlotsStripG2.ini -C cfg/trendPlotsStrip_StoN.ini --dataset StreamExpress --epoch Run2015 -r "run > 246907" --reco Express
cp ./JSON/* /data/users/event_display/HDQM/v2/HDQM_NUST/alljsons/2015/StreamExpress/Strips/DECO/