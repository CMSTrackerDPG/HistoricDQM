#!/usr/bin/env python26
import urllib,os,string,sys,commands,time,json
from rrapi import RRApi, RRApiError
from optparse import OptionParser
from os.path import exists as pathExisits

parser = OptionParser()
parser.add_option("-c", "--cosmics", dest="cosmics", action="store_true", default=False, help="cosmic runs")
parser.add_option("-m", "--min", dest="min", type="int", default=0, help="Minimum run")
parser.add_option("-y", "--year", dest="year", type="choice", choices=["16","17", "18"], default="18", help="year")
parser.add_option("-o", "--outdir", dest="outdir", type="string", default="/data/users/HDQM/CMSSW_10_1_0_pre3/HistoricDQM/python/", help="directory for output")
parser.add_option("-d", "--detector", dest="detector", default="tracker", help="detector",
                type='choice', choices=["tracker", "dt", "csc", "ecal", "hcal"])
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
    year = options.year
    print " Running for year : ", year
    if year == "16":
        runclass = "Collisions"+year
    if year == "17" or year == "18":
        runclass = "Collisions"+year
        if options.detector == "tracker" :
            runclass = runclass + " || Collisions"+year+"SpecialRun"

    if options.cosmics:
        if year == "16":
            runclass = "Cosmics" + year
        if year == "17" or year == "18":
            runclass = "Cosmics"+ year +" || Cosmics"+ year +"CRUZET"

    print " RunClass : ", runclass

    print "detector: " + options.detector
#    runclass = "Collisions18 "|| "Collisions18SpecialRun"
    filter = {"runNumber": ">= %d" % options.min, "dataset": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunDatasetRowGlobal", "filter": {"online": "= true", "datasetName": "like %Online%ALL", "runClassName" : "%s" % runclass, "run": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunSummaryRowGlobal", "filter": {"pixelPresent": "= true", "trackerPresent": "= true"}}}}}
    if options.cosmics:
#        runclass = "Cosmics18CRUZET || Cosmics18"
        filter = {"runNumber": ">= %d" % options.min, "dataset": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunDatasetRowGlobal", "filter": {"online": "= true", "datasetName": "like %Online%ALL", "runClassName" : "%s" % runclass, "run": {"rowClass": "org.cern.cms.dqm.runregistry.user.model.RunSummaryRowGlobal", "filter": {"trackerPresent": "= true"}}}}}

    if options.detector == "tracker":
#        filter.setdefault("fpixReady", "isNull OR = true")
#        filter.setdefault("bpixReady", "isNull OR = true")
        filter.setdefault("tecmReady", "isNull OR = true")
        filter.setdefault("tecpReady", "isNull OR = true")
        filter.setdefault("tobReady",  "isNull OR = true")
        filter.setdefault("tibtidReady", "isNull OR = true")

    if options.detector == "dt":
        filter.setdefault("dtpReady", "isNull OR = true")
        filter.setdefault("dtmReady", "isNull OR = true")
        filter.setdefault("dt0Ready", "isNull OR = true")
    if options.detector == "csc":
        filter.setdefault("cscmReady", "isNull OR = true")
        filter.setdefault("cscpReady", "isNull OR = true")
    if options.detector == "ecal":
        filter.setdefault("ebmReady", "isNull OR = true")
        filter.setdefault("ebpReady", "isNull OR = true")
        filter.setdefault("eemReady", "isNull OR = true")
        filter.setdefault("eepReady", "isNull OR = true")
        filter.setdefault("esmReady", "isNull OR = true")
        filter.setdefault("espReady", "isNull OR = true")
    if options.detector == "hcal":
        filter.setdefault("hbheaReady", "isNull OR = true")
        filter.setdefault("hbhebReady", "isNull OR = true")
        filter.setdefault("hbhecReady", "isNull OR = true")
        filter.setdefault("hfReady", "isNull OR = true")
        filter.setdefault("hoReady",  "isNull OR = true")

    if options.cosmics == False:
        filter.setdefault("fpixReady", "isNull OR = true")
        filter.setdefault("bpixReady", "isNull OR = true")
        filter.setdefault("cmsActive",   "isNull OR = true")
        filter.setdefault("beam1Present","isNull OR = true")
        filter.setdefault("beam2Present","isNull OR = true")
        filter.setdefault("beam1Stable", "isNull OR = true")
        filter.setdefault("beam2Stable", "isNull OR = true")

   # filter.setdefault("fpixReady", "isNull OR = true")
   # filter.setdefault("bpixReady", "isNull OR = true")
#    filter.setdefault("tecmReady", "isNull OR = true")
#    filter.setdefault("tecpReady", "isNull OR = true")
#    filter.setdefault("tobReady",  "isNull OR = true")
#    filter.setdefault("tibtidReady", "isNull OR = true")
#    if options.cosmics == False:
#        filter.setdefault("cmsActive",   "isNull OR = true")
#        filter.setdefault("beam1Present","isNull OR = true")
#        filter.setdefault("beam2Present","isNull OR = true")
#        filter.setdefault("beam1Stable", "isNull OR = true")
#        filter.setdefault("beam2Stable", "isNull OR = true")

    template = 'json'
    table = 'datasetlumis'
    
    print json.dumps(filter)
    dcs_only = api.data(workspace = 'GLOBAL', table = table, template = template, columns = ['runNumber', 'sectionFrom', 'sectionTo'], filter = filter)
   
    print json.dumps(dcs_only, indent=2)


    runlist=list(set([ar.values()[0] for ar in dcs_only]))
    runlist.sort()
#    print json.dumps(toOrdinaryJSON(dcs_only, verbose=False), indent=2)
    print "------------------> {0} RUNs selected from {1} to {2}".format(len(runlist),runlist[0],runlist[len(runlist)-1])

    if len(dcs_only)!=0:
        if save:
	    outdir = options.outdir
	    if len(outdir) > 0 and not outdir.endswith("/"):
		outdir = outdir + "/"

	    print "Output directory is: " + outdir
	    fileroot = "json_DCSONLY"
	    if options.detector != "tracker" :
		fileroot = fileroot + "_" + options.detector.upper();

#            lumiSummary = open('/data/users/HDQM/CMSSW_9_1_0_pre1/HistoricDQM/python/'+filename, 'w')
            print "------------------> Retrieving APV info from DB"
            link = " http://ebutz.web.cern.ch/ebutz/cgi-bin/getReadOutmodeMulti.pl?FIRSTRUN=" + str(options.min) + "&LASTRUN=999999"
            f = urllib.urlopen(link)
            json_data = f.read()
            dblist = json.loads(json_data)

            filename = fileroot + ".txt"
            if options.cosmics:
                filename = fileroot + "_cosmics.txt"
            print "Writing PEAK+DECO file : "+outdir+filename
            lumiSummary = open(outdir+filename, 'w')
            json.dump(toOrdinaryJSON(dcs_only, dblist, "", verbose=False), lumiSummary, indent=2, sort_keys=True)
            lumiSummary.close()

            filename = fileroot+"_DECO.txt"
            if options.cosmics:
                filename = fileroot+"_cosmics_DECO.txt"
            print "Writing DECO file : "+outdir+filename
            lumiSummary = open(outdir+filename, 'w')
            json.dump(toOrdinaryJSON(dcs_only, dblist, "DECO", verbose=False), lumiSummary, indent=2, sort_keys=True)
            lumiSummary.close()

            filename = fileroot+"_PEAK.txt"
            if options.cosmics:
                filename = fileroot+"_cosmics_PEAK.txt"
            print "Writing PEAK file : "+outdir+filename
            lumiSummary = open(outdir+filename, 'w')
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
