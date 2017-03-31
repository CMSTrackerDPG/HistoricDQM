#!/usr/bin/env python26
import urllib,os,string,sys,commands,time,json
from rrapi import RRApi, RRApiError
from optparse import OptionParser
from os.path import exists as pathExisits

parser = OptionParser()
parser.add_option("-c", "--cosmics", dest="cosmics", action="store_true", default=False, help="cosmic runs")
parser.add_option("-m", "--min", dest="min", type="int", default=0, help="Minimum run")
parser.add_option("-P", "--PEAK", dest="Peak", action="store_true", default=False, help="Peak Mode")
(options, args) = parser.parse_args()

def toOrdinaryJSON(fromRR3, verbose=False):
    result = {}
    for block in fromRR3:
        if len(block) == 3:
            runNum = block['runNumber']
            lumiStart = block['sectionFrom']
            lumiEnd = block['sectionTo']
            runExist = 0
            if pathExisits(".APVModeCache"):
                cacheIFile = open(".APVModeCache","r")
                dataCache= []
                for line in cacheIFile :
                    dataCache=line.split()
                    if dataCache[0] == str(runNum) :
                        runExist = 1
                        modeCache = dataCache[1]
                        print "Cache APV Mode for Run : ",dataCache[0]," is : ",dataCache[1]
                        break
            if runExist == 0:
                if verbose:
                    print " debug: Run ", runNum, " Lumi ", lumiStart, ", ", lumiEnd

                link = "http://cern.ch/erik.butz/cgi-bin/getReadOutmode.pl?RUN=" + str(runNum)
                f = urllib.urlopen(link)
                json_data = f.read()
                dbmodelist = json.loads(json_data)
                dbmode = dbmodelist[0][1]
                print "DB APV Mode for Run : ",runNum, " is : ", dbmode
                cacheOFile = open(".APVModeCache","a")
                cacheOFile.write(str(runNum))
                cacheOFile.write(" ")
                cacheOFile.write(dbmode)
                cacheOFile.write("\n")
                cacheOFile.close()
            else: dbmode=modeCache                
            if options.Peak:
                if  dbmode == "PEAK":
                    print "Write Run : ",runNum, " with APV mode : ", dbmode
                    result.setdefault(str(runNum), []).append([lumiStart, lumiEnd])
            else:
                if  dbmode == "DECO": 
                    print "Write Run : ",runNum, " with APV mode : ", dbmode
                    result.setdefault(str(runNum), []).append([lumiStart, lumiEnd])


    return result

def getRunList(save=False):

    runlist = []
    FULLADDRESS  = "http://runregistry.web.cern.ch/runregistry/"

    print "RunRegistry from: ",FULLADDRESS
    try:
        api = RRApi(FULLADDRESS, debug = True)
    except RRApiError, e:
        print e

    #filter = {"runNumber": ">= %d" % minRun, "dataset": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunDatasetRowGlobal", "filter": {"online": "= true", "datasetName": "like %Online%ALL", "runClassName" : "Collisions16", "run": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunSummaryRowGlobal", "filter": {"pixelPresent": "= true", "trackerPresent": "= true"}}}}}
    runclass = "Collisions17"
    filter = {"runNumber": ">= %d" % options.min, "dataset": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunDatasetRowGlobal", "filter": {"online": "= true", "datasetName": "like %Online%ALL", "runClassName" : "%s" % runclass, "run": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunSummaryRowGlobal", "filter": {"pixelPresent": "= true", "trackerPresent": "= true"}}}}}
    if options.cosmics:
        runclass = "Cosmics17CRUZET || Cosmics17"
        filter = {"runNumber": ">= %d" % options.min, "dataset": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunDatasetRowGlobal", "filter": {"online": "= true", "datasetName": "like %Online%ALL", "runClassName" : "%s" % runclass, "run": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunSummaryRowGlobal", "filter": {"trackerPresent": "= true"}}}}}

    filter.setdefault("fpixReady", "isNull OR = true")
    filter.setdefault("bpixReady", "isNull OR = true")
    filter.setdefault("tecmReady", "isNull OR = true")
    filter.setdefault("tecpReady", "isNull OR = true")
    filter.setdefault("tobReady",  "isNull OR = true")
    filter.setdefault("tibtidReady", "isNull OR = true")
    if options.cosmics == False:
        filter.setdefault("cmsActive",   "isNull OR = true")
        filter.setdefault("beam1Present","isNull OR = true")
        filter.setdefault("beam2Present","isNull OR = true")
        filter.setdefault("beam1Stable", "isNull OR = true")
        filter.setdefault("beam2Stable", "isNull OR = true")
    template = 'json'
    table = 'datasetlumis'
    
    print json.dumps(filter)
    dcs_only = api.data(workspace = 'GLOBAL', table = table, template = template, columns = ['runNumber', 'sectionFrom', 'sectionTo'], filter = filter)
   
    print json.dumps(dcs_only, indent=2)

#    print json.dumps(toOrdinaryJSON(dcs_only, verbose=False), indent=2)
    print "Total Number of RUNs selected = ",len(dcs_only)

    if len(dcs_only)!=0:
        if save:
            filename = 'json_DCSONLY_DECO.txt'         
            if options.Peak:
                filename = 'json_DCSONLY_PEAK.txt'
                if options.cosmics:
                   filename = 'json_DCSONLY_cosmics_PEAK.txt'
            else:
               filename = 'json_DCSONLY_DECO.txt'
               if options.cosmics:
                   filename = 'json_DCSONLY_cosmics_DECO.txt'
 



	      #  if options.cosmics:
	      #      if options.Peak: 
          #         filename = 'json_DCSONLY_cosmics_PEAK.txt'
          #      else:
	      #         filename = 'json_DCSONLY_cosmic_DECO.txt'
          #  else:
          #      if options.Peak:
          #         filename = 'json_DCSONLY_PEAK.txt'
          #      else:
          #         filename = 'json_DCSONLY_DECO.txt'

            lumiSummary = open('/afs/cern.ch/user/r/rossia/workspace/CMSSW_8_1_0_pre12/HistoricDQM/python/'+filename, 'w')
            json.dump(toOrdinaryJSON(dcs_only, verbose=False), lumiSummary, indent=2, sort_keys=True)
            lumiSummary.close()

    else:
        print " Something wrong, the DCSONLY file has 0 length... skipping it"
                        
#     for line in run_data.split("\n"):
#         #print line
#         run=line.split(',')[0]
#         if "RUN_NUMBER" in run or run == "":
#             continue
#         #print "RUN: " + run
#         runlist.append(int(run))
#     return runlist

#getRunList(271036, save=True)
getRunList(save=True)
