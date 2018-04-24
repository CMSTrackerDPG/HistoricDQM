#!/usr/bin/env python26
import urllib,os,string,sys,commands,time,json
from rrapi import RRApi, RRApiError
from optparse import OptionParser
from os.path import exists as pathExisits

parser = OptionParser()
parser.add_option("-c", "--cosmics", dest="cosmics", action="store_true", default=False, help="cosmic runs")
parser.add_option("-m", "--min", dest="min", type="int", default=0, help="Minimum run")
#parser.add_option("-P", "--PEAK", dest="Peak", action="store_true", default=False, help="Peak Mode")
(options, args) = parser.parse_args()

def toOrdinaryJSON(fromRR3, dbmodelist, OPT, verbose=False):
    result = {}
    for block in fromRR3:
        if len(block) == 3:
            runNum = block['runNumber']
            lumiStart = block['sectionFrom']
            lumiEnd = block['sectionTo']
            if verbose:
                print " debug: Run ", runNum, " Lumi ", lumiStart, ", ", lumiEnd               
#            print "DB APV Mode for Run : ",runNum, " is : ", dbmode
            dbmode = ""
            if OPT == "PEAK":
                for idx in range(len(dbmodelist)) :
                    if( dbmodelist[idx][0] == str(runNum) ) :
#                        print "Run ",runNum," found"
                        dbmode = dbmodelist[idx][1]
                        break
                if  dbmode == "PEAK":
#                    print "Write Run : ",runNum, " with APV mode : ", dbmode
                    result.setdefault(str(runNum), []).append([lumiStart, lumiEnd])
            elif OPT == "DECO":
                for idx in range(len(dbmodelist)) :
                    if( dbmodelist[idx][0] == str(runNum) ) :
#                        print "Run ",runNum," found"
                        dbmode = dbmodelist[idx][1]
                        break
                if  dbmode == "DECO": 
#                    print "Write Run : ",runNum, " with APV mode : ", dbmode
                    result.setdefault(str(runNum), []).append([lumiStart, lumiEnd])
            else :
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
    runclass = "Collisions18 || Collisions18SpecialRun"
    filter = {"runNumber": ">= %d" % options.min, "dataset": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunDatasetRowGlobal", "filter": {"online": "= true", "datasetName": "like %Online%ALL", "runClassName" : "%s" % runclass, "run": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunSummaryRowGlobal", "filter": {"pixelPresent": "= true", "trackerPresent": "= true"}}}}}
    if options.cosmics:
        runclass = "Cosmics18CRUZET || Cosmics18"
        filter = {"runNumber": ">= %d" % options.min, "dataset": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunDatasetRowGlobal", "filter": {"online": "= true", "datasetName": "like %Online%ALL", "runClassName" : "%s" % runclass, "run": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunSummaryRowGlobal", "filter": {"trackerPresent": "= true"}}}}}

   # filter.setdefault("fpixReady", "isNull OR = true")
   # filter.setdefault("bpixReady", "isNull OR = true")
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
    print "Total Number of RUNs selected = ",len(list(set([ar.values()[0] for ar in dcs_only])))

    if len(dcs_only)!=0:
        if save:
#            lumiSummary = open('/data/users/HDQM/CMSSW_9_1_0_pre1/HistoricDQM/python/'+filename, 'w')
            print "------------------> Retrieving APV info from DB"
            link = " http://ebutz.web.cern.ch/ebutz/cgi-bin/getReadOutmodeMulti.pl?FIRSTRUN=" + str(options.min) + "&LASTRUN=999999"
            f = urllib.urlopen(link)
            json_data = f.read()
            dblist = json.loads(json_data)

            filename = "json_DCSONLY.txt"
            if options.cosmics:
                filename = "json_DCSONLY_cosmics.txt"
            print "Writing PEAK+DECO file : "+filename
            lumiSummary = open('/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python/'+filename, 'w')
            json.dump(toOrdinaryJSON(dcs_only, dblist, "", verbose=False), lumiSummary, indent=2, sort_keys=True)
            lumiSummary.close()

            filename = "json_DCSONLY_DECO.txt"
            if options.cosmics:
                filename = "json_DCSONLY_cosmics_DECO.txt"
            print "Writing DECO file : "+filename
            lumiSummary = open('/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python/'+filename, 'w')
            json.dump(toOrdinaryJSON(dcs_only, dblist, "DECO", verbose=False), lumiSummary, indent=2, sort_keys=True)
            lumiSummary.close()

            filename = "json_DCSONLY_PEAK.txt"
            if options.cosmics:
                filename = "json_DCSONLY_cosmics_PEAK.txt"
            print "Writing PEAK file : "+filename
            lumiSummary = open('/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python/'+filename, 'w')
            json.dump(toOrdinaryJSON(dcs_only, dblist, "PEAK", verbose=False), lumiSummary, indent=2, sort_keys=True)
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
