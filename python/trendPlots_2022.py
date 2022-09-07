#!/usr/bin/env python
#import os, sys, string
#from ROOT import TStyle
#from ROOT import TFile, TCanvas, TLegend
#from ROOT import TH1, MakeNuos.makedirs(dir_path)llPointer
#from ROOT import TGraphAsymmErrors, TMultiGraph

import re
import sys
import json
import os
#import ConfigParser
import configparser
class BetterConfigParser(configparser.ConfigParser):
    def optionxform(self, optionstr):
        return optionstr

#import array
class TrendPlot:
    def __init__(self, section, config, cache = None):
        from ROOT import MakeNullPointer, TH1, TFile,TObject
        from array import array
        self.__config = config
        self.__section = section
        self.__cache = cache

        self.__threshold = int(self.__config.get("styleDefaults","histoThreshold"))
        if self.__config.has_option(self.__section,"threshold"):
            self.__threshold = int(self.__config.get(self.__section,"threshold"))
        
        metricString = "metrics."+self.__config.get(self.__section,"metric")
        metrics =__import__(".".join(metricString.split("(")[0].split(".")[:-1]))
        self.__metricName="metrics."+self.__config.get(self.__section,"metric")
        self.__metric = eval( metricString)
        self.__metric.setThreshold( self.__threshold )
        self.__metric.setCache( self.__cache )
        
        self.__title = self.__section.split("plot:")[1]
        if self.__config.has_option(self.__section,"title"):
            self.__title = self.__config.get(self.__section,"title")
        self.__xTitle ="" # this is automatically generated later
        self.__yTitle = metricString #.split("(")[0].split(".")[-1].split("(")[0]
        self.__saveHistos = metricString #.split("(")[0].split(".")[-1].split("(")[0]
        if self.__config.has_option(self.__section,"yTitle"):
            self.__yTitle = self.__config.get(self.__section,"yTitle")
        if self.__config.has_option(self.__section,"saveHistos"):
           self.__saveHistos = self.__config.get(self.__section,"saveHistos") 
        self.__x = array("d")
        self.__y = array("d")
        self.__yErrHigh = array("d")
        self.__yErrLow = array("d")
        self.__ySysErrHigh = array("d")
        self.__ySysErrLow = array("d")

        self.__count = 0
        self.__runs = []
        self.__histoSum = MakeNullPointer(TH1)
        self.__FileHisto=MakeNullPointer(TFile)
        self.__labels = []

    def addRun(self, serverUrl, runNr, dataset,tfile):
        from math import sqrt
        from ROOT import TH1,TFile,TObject,TBufferFile, TH1F, TProfile, TProfile2D, TH2F
        import ROOT
        import os, sys, string
        from os.path import split as splitPath
        from src.dqmjson import dqm_get_json_hist,dqm_get_json

        self.__count = self.__count + 1
        histoPath = self.__config.get(self.__section, "relativePath")
        
        cacheLocation = (serverUrl, runNr, dataset, histoPath, self.__config.get(self.__section,"metric"))
        if self.__config.has_option(self.__section, "saveHistos"):
          try:
              if(histoPath[0]=='/'): 
                  histoPath=histoPath.replace('/','',1)
              subdet=histoPath.split('/')[0]
              if tfile == None :
                  histo1 = dqm_get_json_hist( serverUrl, runNr, dataset, splitPath(histoPath)[0],splitPath(histoPath)[1],rootContent=True)
              else :
                  histo1=tfile.Get(('DQMData/Run %d/%s/Run summary/%s') % (runNr,subdet,histoPath.replace('%s/'%(subdet),'',1)))
              histosFile = self.__config.get(self.__section, "saveHistos")
              if not os.path.exists(histosFile): os.makedirs(histosFile)

              if self.__histoSum==None:
                  self.__histoSum=histo1
                  self.__FileHisto=TFile.Open(os.path.join("%s/SumAll_%s.root"%(histosFile,self.__title)),"RECREATE")
                  self.__histoSum.Write()
              else:
                self.__histoSum.Add(histo1)
                self.__FileHisto.cd()
                self.__histoSum.Write("",TObject.kOverwrite)
                histo1.SetName(str(runNr))
                histo1.Write()

          except :
              print("WARNING: something went wrong getting the histogram ", runNr)

        try:
            if self.__cache == None or cacheLocation not in self.__cache:
                if(histoPath[0]=='/'): 
                    histoPath=histoPath.replace('/','',1)
                subdet=histoPath.split('/')[0]
                if tfile == None :
                    histo = dqm_get_json_hist( serverUrl, runNr, dataset, splitPath(histoPath)[0],splitPath(histoPath)[1],rootContent=True)
                else :
                    histo=tfile.Get(('DQMData/Run %d/%s/Run summary/%s') % (runNr,subdet,histoPath.replace('%s/'%(subdet),'',1)))
                if self.__config.has_option(self.__section,"histo1Path"):
                    h1Path=self.__config.get(self.__section,"histo1Path")
                    if(h1Path[0]=='/'):
                        h1Path=h1Path.replace('/','',1)
                    subdet=h1Path.split('/')[0]
                    if tfile == None :
                        h1 = dqm_get_json_hist( serverUrl, runNr, dataset, splitPath(h1Path)[0],splitPath(h1Path)[1],rootContent=True)
                    else :        
                        h1=tfile.Get(('DQMData/Run %d/%s/Run summary/%s') % (runNr,subdet,h1Path.replace('%s/'%(subdet),'',1)))
                    self.__metric.setOptionalHisto1(h1)
                if self.__config.has_option(self.__section,"histo2Path"):
                    h2Path=self.__config.get(self.__section,"histo2Path")
                    if(h2Path[0]=='/'):
                        h2Path=h1Path.replace('/','',1)
                    subdet=h2Path.split('/')[0]
                    if tfile == None :
                        h2 = dqm_get_json_hist( serverUrl, runNr, dataset, splitPath(h2Path)[0],splitPath(h2Path)[1],rootContent=True)
                    else :
                        h2=tfile.Get(('DQMData/Run %d/%s/Run summary/%s') % (runNr,subdet,h2Path.replace('%s/'%(subdet),'',1)))
                    self.__metric.setOptionalHisto2(h2)
                self.__metric.setRun(runNr)
                if(histo!=None):
                    print("-> Got histogram {0} as {1}".format(splitPath(histoPath)[1],histo))
                    if self.__config.has_option(self.__section,"histo1Path"):
                        print("   -> Got auxiliary histogram {0} as {1}".format(splitPath(h1Path)[1],h1))
                    if self.__config.has_option(self.__section,"histo2Path"):
                        print("   -> Got auxiliary histogram {0} as {1}".format(splitPath(h2Path)[1],h2))
                    Entr=0
                    Entr=histo.GetEntries()
                    #print "###############    GOT HISTO #################" 
                    y=0
                    yErr    = (0.0,0.0)
                    if Entr>self.__threshold:
                        print("      -> {0} will be evaluated".format(self.__metricName))
                        (y, yErr) = self.__metric(histo, cacheLocation)
                    else:
                        print("      -> Histogram entries are {0} while threshold is {1}. Metric will not be evalueted, results set at 0".format(Entr,self.__threshold))
                        self.__cache[cacheLocation] = ((0.,0.),0.)
                else:
                    print("WARNING: something went wrong downloading histo=",splitPath(histoPath)[1])
                    return 
            elif cacheLocation in self.__cache:
                print("-> Got {0} for histogram {1} from cache".format(self.__metricName,splitPath(histoPath)[1]))
                (y, yErr) = self.__metric(None, cacheLocation)
        except :
            print("WARNING: something went wrong calculating", self.__metric)
            self.__count = self.__count - 1
            return

        ySysErr = (0.,0.)
        if self.__config.has_option(self.__section, "relSystematic"):
            fraction = self.__config.getfloat(self.__section, "relSystematic")
            ySysErr = (fraction*y, fraction*y)
        if self.__config.has_option(self.__section, "absSystematic"):
            component = self.__config.getfloat(self.__section, "absSystematic")
            ySysErr = (component, component)
            
        self.__config.get(self.__section, "relativePath")
        
        self.__y.append(y)        

        self.__yErrLow.append(yErr[0])
        self.__yErrHigh.append(yErr[1])
        self.__ySysErrLow.append(sqrt(yErr[0]**2+ySysErr[0]**2))
        self.__ySysErrHigh.append(sqrt(yErr[1]**2+ySysErr[1]**2))

        self.__runs.append(runNr)

        if self.__config.has_option(self.__section,"xMode"):
            xMode = self.__config.get(self.__section,"xMode")
        elif self.__config.has_option("styleDefaults","xMode"):
            xMode = self.__config.get("styleDefaults","xMode")
        else:
            xMode = "counted"
        if xMode == "runNumber":
            self.__x.append(run)
            print("*** appending run to x")
            self.__xTitle = "Run No."
        elif xMode == "runNumberOffset":
            runOffset = int(self.__config.get(self.__section,"runOffset"))
            self.__x.append(run - runOffset)
            self.__xTitle = "Run No. - %s"%runOffset
        elif xMode == "counted":
            self.__x.append(self.__count)
            self.__xTitle = "Nth processed run"
        elif xMode.startswith("runNumberEvery") or xMode.startswith("runNumbers"):
            self.__x.append(self.__count)
            self.__xTitle = "Run No."
        else:
            print("Unknown xMode: %s in %s"%(xMode, self__section))

    def getName(self):
        return self.__section.split("plot:")[1]

    def getPath(self):
        return self.__config.get(self.__section, "relativePath")

    def getMetric(self):
        return self.__config.get(self.__section,"metric")


    def dumpJSON(self):
        n = len(self.__x)       
        lst = []
        for inc in range (0,n):
            d={}
            d['run']=self.__runs[inc]
            d['x']=self.__x[inc]
            d['y']=self.__y[inc]
            d['yErr']=self.__yErrLow[inc]
            d['yTitle']=self.__yTitle
            if self.__config.has_option(self.__section,"hTitle") :
                d['hTitle']=self.__config.get(self.__section,"hTitle")
            else :
                d['hTitle']=self.__yTitle
            if self.__config.has_option(self.__section,"yMin") and self.__config.has_option(self.__section,"yMax") :
                d['ymin']=float(self.__config.get(self.__section,"yMin"))
                d['ymax']=float(self.__config.get(self.__section,"yMax"))
            else:
                d['ymin']=0
                d['ymax']=0
            lst.append(d)


        obj ={}
        obj[self.__title]=lst

        if not os.path.exists("./JSON"):
            os.makedirs("./JSON")
        with open("./JSON/"+self.__title+".json", 'w') as outfile:
            json.dump(obj, outfile,indent=4)
        print("Dump JSON file : {0}.json".format(self.__title))
        return

    def getGraph(self):
        from array import array
        from ROOT import TMultiGraph, TLegend, TGraphAsymmErrors
        n = len(self.__x)
        if n != len(self.__y) or n != len(self.__yErrLow) or n != len(self.__yErrHigh):
            print("The length of the x(%s), y(%s) and y error(%s,%s) lists does not match"%(len(self.__x), len(self.__y), len(self.__yErrLow), len(self.__yErrHigh)))

        result = TMultiGraph()
        legendPosition = [float(i) for i in self.__getStyleOption("legendPosition").split()]
        legend = TLegend(*legendPosition)
        legend.SetFillColor(0)
        result.SetTitle("%s;%s;%s"%(self.__title,self.__xTitle,self.__yTitle))

        xErr = array("d",[0 for i in range(n)])

        graph = TGraphAsymmErrors(n, self.__x, self.__y, xErr, xErr, self.__yErrLow,self.__yErrHigh)
        graph.SetLineWidth(2)
        graph.SetFillColor(0)
        graph.SetLineColor(int(self.__getStyleOption("lineColor")))
        graph.SetMarkerColor(int(self.__getStyleOption("markerColor")))
        graph.SetMarkerStyle(int(self.__getStyleOption("markerStyle")))
        graph.SetMarkerSize(float(self.__getStyleOption("markerSize")))

        result.Add(graph,"P")

        result.SetName("MG_%s"%(self.__title))
        legend.AddEntry(graph, self.__getStyleOption("name"))
        
        return (result, legend)


    def getHISTO(self):
        from array import array
        from ROOT import TMultiGraph, TLegend, TGraphAsymmErrors
        from ROOT import TH1,TH1F,TAxis
        from math import sqrt 
        n = len(self.__x)
        if n != len(self.__y) or n != len(self.__yErrLow):
            print("The length of the x(%s), y(%s) and y error(%s,%s) lists does not match"%(len(self.__x), len(self.__y), len(self.__yErrLow), len(self.__yErrHigh)))
        result=TH1F(self.__title,self.__title,n,0.5,float(n)+0.5)
        axis = result.GetXaxis()
        for i in range (len(self.__x)):
            result.Fill(i+1,self.__y[i])
            result.SetBinError(i+1,self.__yErrHigh[i])
            #axis.SetBinLabel(i+1, str(self.__x[i]))
            axis.SetBinLabel(i+1, str(self.__runs[i]))
#        result = MakeNullPointer(TH1)
        legendPosition = [float(i) for i in self.__getStyleOption("legendPosition").split()]
        legend = TLegend(*legendPosition)
        legend.SetFillColor(0)
        result.SetMarkerColor(int(self.__getStyleOption("markerColor")))
        result.SetMarkerStyle(int(self.__getStyleOption("markerStyle")))
        result.SetMarkerSize(float(self.__getStyleOption("markerSize")))
        result.SetTitle("%s;%s;%s"%(self.__title,self.__xTitle,self.__yTitle))
        return (result, legend)


    def formatGraphAxis(self, graph):
        if self.__config.has_option(self.__section,"xMode"):
            xMode = self.__config.get(self.__section,"xMode")
        elif self.__config.has_option("styleDefaults","xMode"):
            xMode = self.__config.get("styleDefaults","xMode")
        else:
            xMode = "counted"
        if xMode.startswith("runNumberEvery") or xMode.startswith("runNumbers"):
            nRuns = len(self.__x)
            try:
              if xMode.startswith("runNumberEvery"):
                showEvery = int(xMode[len("runNumberEvery"):])
              else:
                showUpTo  = int(xMode[len("runNumbers"):])
                if showUpTo >= nRuns:   showEvery = nRuns
                else:                   showEvery = showUpTo
            except ValueError:
              print("Bad xMode syntax: %s" % xMode)
            axis = graph.GetXaxis()
            for (x,run) in zip(self.__x,self.__runs):
              if int(x-self.__x[0]) % showEvery == 0 or x==self.__x[-1]:
                axis.SetBinLabel(axis.FindFixBin(x), str(run))
            #axis.SetRangeUser(self.__x[0], self.__x[-1])
        if self.__config.has_option(self.__section,"yMin") and self.__config.has_option(self.__section,"yMax") :
            graph.GetYaxis().SetRangeUser(float(self.__config.get(self.__section,"yMin")),
                                          float(self.__config.get(self.__section,"yMax")))

        if xMode.startswith("runNumber"):
            axis = graph.GetXaxis()
            axis.LabelsOption("v")
            axis.SetTitleOffset(1.9)


    def __getStyleOption(self, name):
        result = None
        if not self.__config.has_option("styleDefaults", name):
            print("there is no default style option for '%s'"%name)
        result = self.__config.get("styleDefaults", name)
        if self.__config.has_option(self.__section, name):
            result = self.__config.get(self.__section, name)
        return result

def getRunsFromDQM(config, dsets, epochs, reco, tag, datatier,runMask="all", runlistfile=[],jsonfile=[]):
    from src.dqmjson import dqm_get_samples,dqm_getTFile_Version
#    import simplejson as jsonn
    import json as jsonn
    serverUrl = config.get("dqmServer","url")
    dataType = config.get("dqmServer","type")

    maskList=[]
    for epoch in epochs:
        for dset in dsets:
            maskList.append(".*/" + dset +"/"+epoch+".*"+reco+"*.*"+tag+"/"+datatier)
    print("dsetmask = ", maskList)
    
    json=[]
    for mask in maskList:
        #print "------------------------------------------------------> ",mask
        json+=dqm_get_samples(serverUrl, mask, dataType)
        #print json

    masks = []
    if runlistfile!=[]:
       runs1 = [x.strip() for x in open(runlistfile,"r")]

    if jsonfile!=[]:
        if runMask=="all":
            print("file:",jsonfile)
            aaf = open(jsonfile)
            info = aaf.read()
            decoded = jsonn.loads(info)
            runs1=[]
            for item in decoded:
                runs1.append(item)           
        else:
            print("file:",jsonfile)
            aaf = open(jsonfile)
            info = aaf.read()
            decoded = jsonn.loads(info)
            runs1=[]
            print("Start selection")
            for item in decoded:
                if eval(runMask,{"all":True,"run":int(item)}):
                    runs1.append(item)


    for runNr, dataset in json:
        if dataset not in masks: masks.append(dataset)
    for m in masks:
        print(m)
    
    result = {}
    for mask in masks :
        json=dqm_get_samples(serverUrl, mask, dataType)
        for epoch in epochs:
            if epoch in mask: 
                runEpoch=epoch
        for runNr, dataset in json:
            if runlistfile==[] and jsonfile==[]:
                if eval(runMask,{"all":True,"run":runNr}):
                    result[runNr] = (serverUrl, runNr, dataset, runEpoch)
            else:
                 for run_temp in runs1:
                        if int(run_temp)==int(runNr):
                                #print "test1=",run_temp,runNr
                                result[runNr] = (serverUrl, runNr, dataset, runEpoch)
    if not result :
        print("*** WARNING: YOUR REQUEST DOESNT MATCH ANY EXISTING DATASET ***")
        print("-> check your settings in ./cfg/trendPlots.py")
        print("--> check your runmask!")
        print("===> maybe choose a different primary dataset")
        print("--> or check the runrange!")
        print("*** end of warning *********************************************")
        return
    return result

def initPlots( config ):
    from os.path import exists as pathExisits
    result = []
    cachePath = config.get("output","cachePath")
    cache = {}
    if pathExisits(cachePath):
        cacheFile = open(cachePath,"r")
        cache.update( eval(cacheFile.read()) )
        cacheFile.close()
    for section in sorted(config.sections()):
        if section.startswith("plot:"):
            result.append(TrendPlot(section, config, cache))
    return result, cache

def initStyle(config):
    from ROOT import gROOT, gStyle, TStyle, TGaxis
    gROOT.SetBatch(True)        
    gROOT.SetStyle('Plain')
    gStyle.SetOptStat(0)
    gStyle.SetPalette(1)
    gStyle.SetPaintTextFormat(".2g")
    TGaxis.SetMaxDigits(3)
    pageSize = config.get("styleDefaults","pageSize")
    if    pageSize.lower() == "a4":     gStyle.SetPaperSize(TStyle.kA4)
    elif  pageSize.lower() == "letter": gStyle.SetPaperSize(TStyle.kUSLetter)
    else:
      pageSize = [int(i) for i in pageSize.split("x")]
      gStyle.SetPaperSize(pageSize[0],pageSize[1])


def main(argv=None):
    import sys
    import os
    from optparse import OptionParser
    from ROOT import TCanvas,TFile
    from src.dqmjson import dqm_get_json,dqm_getTFile,dqm_getTFile_Version2
    from src.cacheParsing import getRunListFromCache
    if argv == None:
        argv = sys.argv[1:]
    parser = OptionParser()
    parser.add_option("-C", "--config", dest="config", default=[], action="append", 
                      help="configuration defining the plots to make")
    parser.add_option("-o", "--output", dest="outPath", default=None, 
                      help="path to output plots. If it does not exsist it is created")
    parser.add_option("-r", "--runs", dest="runs", default="all", 
                      help="mask for the run (full boolean and math capabilities e.g. run > 10 and run *2 < -1)")
    parser.add_option("-D", "--dataset", dest="dset", default=[], action="append",
                      help="mask for the primary dataset (default is Jet), e.g. Cosmics, MinimumBias")
    parser.add_option("-E", "--epoch", dest="epoch", default=[], action="append",
                      help="mask for the data-taking epoch (default is Run2012), e.g. Run2011B, Run2011A, etc.")
    parser.add_option("-R", "--reco", dest="reco", default="Prompt",
                      help="mask for the reconstruction type (default is Prompt), e.g. 08Nov2011, etc.")
    parser.add_option("-t", "--tag", dest="tag", default="v*",
                      help="mask for the reco dataset tag (default is v*), e.g. v5")
    parser.add_option("-d", "--datatier", dest="datatier", default="DQMIO",
                      help="mask for the datatier name (default is DQMIO)")
    parser.add_option("-s", "--state", dest="state", default="ALL",
                      help="mask for strip state, options are ALL, PEAK, DECO, or MIXED -- only applicable if dataset is 'Cosmics'")
    parser.add_option("-L", "--list", dest="list", type="string", default=[] , action="store")
    parser.add_option("-J", "--json", dest="json", type="string", default=[] , action="store")
    (opts, args) = parser.parse_args(argv)
    if opts.config ==[]:
        opts.config = "trendPlots.ini"
    config = BetterConfigParser()
    config.read(opts.config)
 
    initStyle(config)
    print("opts.state = ",opts.state)
    print("opts.runs = ",opts.runs)
    print("opts.list = ",opts.list)
    print("opts.json = ",opts.json)

    runs = getRunsFromDQM(config, opts.dset, opts.epoch, opts.reco, opts.tag, opts.datatier,opts.runs,opts.list,opts.json)
    if not runs : print("*** Number of runs matching run/mask/etc criteria is equal to zero!!!")


    print("got %s run between %s and %s"%(len(runs), min(runs.keys()), max(runs.keys())))
    plots, cache = initPlots(config)

    print("Loading cache........",len(cache.keys())," items")
    runInCache =getRunListFromCache(cache)
#    runInCache = []
#    for itest in range(0,len(cache.keys())):
#        runInCache.append(cache.keys()[itest][1])
    print("Cache loaded!")
    for run in sorted(runs.keys()):
        if cache == None or runs[run][1] not in runInCache:
            print("------------>>> RUN %s NOT IN CACHE"%(runs[run][1]))
            rc = dqm_get_json(runs[run][0],runs[run][1],runs[run][2], "Info/ProvInfo")
            print("------------>>> RunIsComplete flag: " , rc['runIsComplete']['value'])
            isDone = int(rc['runIsComplete']['value'])
            if opts.datatier != "DQMIO" :
                isDone = 1
        else:
            isDone = 1
            print("------------>>> RUN %s IN CACHE"%(runs[run][1]))
        if isDone == 1 :
            fopen = False
            fpresent= True
            incache= False
            fchecked=False
            tfile= None
            for plot in plots:
                cacheLocation = (runs[run][0],runs[run][1],runs[run][2], plot.getPath(),plot.getMetric())
                incache=(cacheLocation in cache)
                if (cache == None and not fchecked) or (not incache and not fchecked):
                    print("{0} {1} {2} {3} {4}".format(runs[run][0],runs[run][1],runs[run][2],runs[run][3],opts.datatier))
                    version=dqm_getTFile_Version2(runs[run][0],runs[run][1],runs[run][2],runs[run][3],opts.datatier)
                    if (version != 0):
                        tfile=dqm_getTFile(runs[run][0],runs[run][1],runs[run][2],version,runs[run][3],opts.datatier)
                        print("### Openning ROOT File Version {0} for Run{1}".format(version,runs[run][1]))
                        fopen=True
                    else:
                        fpresent=False
                        print("### ROOT file not present for Run{0} -> JSON information will be used".format(runs[run][1]))
                    fchecked=True
                plot.addRun(runs[run][0],runs[run][1],runs[run][2],tfile)
            if fopen :
                tfile.Close()
        else:
            print("############ RUN %s NOT FULLY PROCESSED, SKIP ############"%(runs[run][1]))

    cachePath = config.get("output","cachePath")
    cacheFile = open(cachePath,"w")
    cacheFile.write(str(cache))
    cacheFile.close()

    for plot in plots:
        plot.dumpJSON()

    

    outPath = "fig/"+opts.reco+"/"+opts.dset[0]
    if 'Cosmics' in opts.dset[0]:
        outPath = outPath + "/" + opts.state
    ##outPath = config.get("output","defautlOutputPath")
    if not opts.outPath == None: outPath  = opts.outPath
    if not os.path.exists(outPath): os.makedirs(outPath)
    makeSummary = config.getboolean("output","makeSummary")
    canvasSize = [int(i) for i in config.get("styleDefaults","canvasSize").split("x")]
    canvas = TCanvas("trendplot","trendplot", canvasSize[0], canvasSize[1])
    canvas.Clear()
    canvas.SetBottomMargin(0.14)
    canvas.SetGridy()


    if makeSummary: canvas.Print(os.path.join(outPath,"trendPlots.ps["))
    for plot in plots:
        #(graph, legend, refLabel) = plot.getGraph()
        try: plot.getGraph()
        except:
            print("Error producing plot:", plot.getName())
            print("Possible cause: no entries, or non-existing plot name")
            continue
        (graph, legend) = plot.getGraph()
        canvas.Clear()
        graph.Draw("AP")
        graph.GetYaxis().SetTitleOffset(1.6)
        plot.formatGraphAxis(graph)
        legend.Draw()
        canvas.SetLeftMargin(0.125)
        canvas.Modified()
        canvas.Update()
        for formatExt in config.get("output","formats").split():
            if formatExt=='root':
                (histotemp, legend) = plot.getHISTO()
                F_out=TFile.Open(os.path.join(outPath,"%s.%s"%(plot.getName(), formatExt)),"RECREATE")
                F_out.cd()
                histotemp.Write()
                graph.Write()
                F_out.Close()
            else:
                canvas.Print(os.path.join(outPath,"%s.%s"%(plot.getName(), formatExt)))

        if makeSummary: canvas.Print(os.path.join(outPath,"trendPlots.ps"))
        
        if makeSummary: canvas.Print(os.path.join(outPath,"trendPlots.ps]"))


if __name__ == '__main__':
    main()
