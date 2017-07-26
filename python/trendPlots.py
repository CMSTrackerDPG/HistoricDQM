#!/usr/bin/env python
#import os, sys, string
#from ROOT import TStyle
#from ROOT import TFile, TCanvas, TLegend
#from ROOT import TH1, MakeNuos.makedirs(dir_path)llPointer
#from ROOT import TGraphAsymmErrors, TMultiGraph

import re

import json
import os
import ConfigParser
class BetterConfigParser(ConfigParser.ConfigParser):
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

        #self.__allReferenceRunNrs = sorted([int(i) for i in self.__config.get("reference","runs").split(",")])
        #self.__reference = None 
	self.__threshold = int(self.__config.get("styleDefaults","histoThreshold"))
        if self.__config.has_option(self.__section,"threshold"):
            self.__threshold = int(self.__config.get(self.__section,"threshold"))
        
        metricString = "metrics."+self.__config.get(self.__section,"metric")
        metrics =__import__(".".join(metricString.split("(")[0].split(".")[:-1]))
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

    def __addAnnotaion(self,run, x, y, yErr):
        from math import sqrt, fabs
        #(refY, refYErr) = self.__metric(self.__reference[1])
        #err = sqrt(yErr[0]**2+refYErr[1]**2)
        #if refY > y:
        #    err = sqrt(yErr[1]**2+refYErr[0]**2)
        #significance = fabs(y-refY)/err if not err == 0 else 0.
        err=0
        significance=0
        if significance > float(self.__config.get("styleDefaults","significanceThreshold")):
            self.__labels.append((x,y," %s %.2f#sigma"%(run,significance)))
        if y < float(self.__config.get("styleDefaults","ksThreshold")) and 'Kolmogorov' in self.__yTitle:
            self.__labels.append((x,y," %s ks=%.2f"%(run,y)))
        if self.__config.has_option(self.__section,"yMin") and self.__config.has_option(self.__section,"yMax") :
            yMin = float(self.__config.get(self.__section,"yMin"))
            yMax = float(self.__config.get(self.__section,"yMax"))
            yDelta = yMax-yMin
            #TOMAS - COMMENTED OUT the vertical out-of-range labels 
            #if y < yMin : self.__labels.append((x,yMin+0.05*yDelta,"run %s, value=%.2f"%(run,y)))    
            #if y > yMax : self.__labels.append((x,yMax-0.40*yDelta,"run %s, value=%.2f"%(run,y)))    

    def drawAnnotation(self):
        from ROOT import TLatex
        latex = TLatex()
        latex.SetTextSize(float(self.__config.get("styleDefaults","annotationSize")))
        latex.SetTextColor(int(self.__config.get("styleDefaults","annotationColor")))
        if self.__config.has_option("styleDefaults","annotationAngle"):
            latex.SetTextAngle(float(self.__config.get("styleDefaults","annotationAngle")))
        for label in self.__labels:
            latex.DrawLatex(*label)
    
    def addRun(self, serverUrl, runNr, dataset):
        from math import sqrt
        from ROOT import TH1,TFile,TObject
#        import ROOT
        import os, sys, string
        
        self.__count = self.__count + 1
        histoPath = self.__config.get(self.__section, "relativePath")

        print "in addRun, histoPath = ", histoPath
                
        #refNr = self.__allReferenceRunNrs[-1]
        #if len(self.__allReferenceRunNrs) > 1:
        #    #refNr = [i for i in self.__allReferenceRunNrs if i <= runNr][-1]
        #    refNr=min(self.__allReferenceRunNrs)
        #    for refRunNr in self.__allReferenceRunNrs:
        #        if refRunNr>refNr and refRunNr<runNr:
        #            refNr = refRunNr
        #            print "refNr = " , refNr
        #if self.__reference ==  None or refNr > self.__reference[0]:
        #    print "refNr = " , refNr
        #    print "getting histo from DQM for ref run"
        #    #refHisto = getHistoFromDQM( serverUrl, refNr, dataset, histoPath)
        #    #self.__reference = (refNr, refHisto)
        #    #self.__metric.setReference( self.__reference[1] )

        cacheLocation = (serverUrl, runNr, dataset, histoPath, self.__config.get(self.__section,"metric"))
        print "cachelocation = ", cacheLocation
        print "dataset = ", dataset
        
        if self.__config.has_option(self.__section, "saveHistos"):
          try:
              histo1 = getHistoFromDQM( serverUrl, runNr, dataset, histoPath)
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

          except StandardError as msg :
              print "WARNING: something went wrong getting the histogram ", runNr, msg

        try:
            if self.__cache == None or cacheLocation not in self.__cache:
                histo = getHistoFromDQM( serverUrl, runNr, dataset, histoPath)
                if self.__config.has_option(self.__section,"histo1Path"):
                    h1Path=self.__config.get(self.__section,"histo1Path")
                    h1=getHistoFromDQM( serverUrl, runNr, dataset, h1Path)
                    self.__metric.setOptionalHisto1(h1)
                    print h1
                if self.__config.has_option(self.__section,"histo2Path"):
                    h2Path=self.__config.get(self.__section,"histo2Path")
                    h1=getHistoFromDQM( serverUrl, runNr, dataset, h2Path)
                    self.__metric.setOptionalHisto2(h2)
                    print h2
                Entr=0
                Entr=histo.GetEntries()
                print "###############    GOT HISTO #################" 
                y=0
                yErr    = (0.0,0.0)
                if Entr>self.__threshold:
                    (y, yErr) = self.__metric(histo, cacheLocation)
                else:
                    self.__cache[cacheLocation] = ((0.,0.),0.)
            elif cacheLocation in self.__cache:
                (y, yErr) = self.__metric(None, cacheLocation)
        except StandardError as msg :
            print "WARNING: something went wrong calculating", self.__metric, msg
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
        ##To turn off Errors, uncomment below...
        ##yErr    = (0.0,0.0)
        ##ySysErr = (0.0,0.0)

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
            print "*** appending run to x"
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
            raise StandardError, "Unknown xMode: %s in %s"%(xMode, self__section)

        self.__addAnnotaion(runNr,self.__x[-1],y,(sqrt(yErr[0]**2+ySysErr[0]**2),sqrt(yErr[1]**2+ySysErr[1]**2)))

    def getName(self):
        return self.__section.split("plot:")[1]

    def getGraph(self):
        from array import array
        from ROOT import TMultiGraph, TLegend, TGraphAsymmErrors
        n = len(self.__x)
        if n != len(self.__y) or n != len(self.__yErrLow) or n != len(self.__yErrHigh):
            raise StandardError, "The length of the x(%s), y(%s) and y error(%s,%s) lists does not match"%(len(self.__x), len(self.__y), len(self.__yErrLow), len(self.__yErrHigh))

        result = TMultiGraph()
        legendPosition = [float(i) for i in self.__getStyleOption("legendPosition").split()]
        legend = TLegend(*legendPosition)
        legend.SetFillColor(0)
        result.SetTitle("%s;%s;%s"%(self.__title,self.__xTitle,self.__yTitle))
        #(refArrays, refLabel) = self.__getRefernceGraphArrays()
        #refGraph = TGraphAsymmErrors(*refArrays)

        #refGraph.SetLineWidth(2)
        #refGraph.SetLineColor(int(self.__config.get("reference","lineColor")))
        #refGraph.SetFillColor(int(self.__config.get("reference","fillColor")))
        #result.Add(refGraph,"L3")
        #legend.AddEntry(refGraph,self.__config.get("reference","name"))

        xErr = array("d",[0 for i in range(n)])
        print "__x = ", self.__x
        print "__y = ", self.__y
        lst = []

        for inc in range (0,n):
            d={}
            d['run']=self.__runs[inc]
            d['x']=self.__x[inc]
            d['y']=self.__y[inc]
            d['yErr']=self.__yErrLow[inc]
            d['yTitle']=self.__yTitle
            if self.__config.has_option(self.__section,"yMin") and self.__config.has_option(self.__section,"yMax") :
                d['ymin']=float(self.__config.get(self.__section,"yMin"))
                d['ymax']=float(self.__config.get(self.__section,"yMax"))
            else:
                d['ymin']=0
                d['ymax']=0
            lst.append(d)


        obj ={}
        obj[self.__title]=lst
 #finalObj[self.__title]=lst                                                                                                                           
        #finalList.append(finalObj)                                                                                                                   

       # save_path = './JSON/'
        #completeName = os.path.join(save_path, self.__title+".json")
        if not os.path.exists("JSON"):
            os.makedirs("JSON")
        with open("./JSON/"+self.__title+".json", 'w') as outfile:
            json.dump(obj, outfile,indent=4)
        print  json.dumps(obj,indent=2)

        graph = TGraphAsymmErrors(n, self.__x, self.__y, xErr, xErr, self.__yErrLow,self.__yErrHigh)
        graph.SetLineWidth(2)
        graph.SetFillColor(0)
        graph.SetLineColor(int(self.__getStyleOption("lineColor")))
        graph.SetMarkerColor(int(self.__getStyleOption("markerColor")))
        graph.SetMarkerStyle(int(self.__getStyleOption("markerStyle")))
        graph.SetMarkerSize(float(self.__getStyleOption("markerSize")))

        sysGraph = TGraphAsymmErrors(n, self.__x, self.__y, xErr, xErr, self.__ySysErrLow,self.__ySysErrHigh)
        sysGraph.SetLineWidth(1)
        sysGraph.SetFillColor(0)
        sysGraph.SetLineColor(int(self.__getStyleOption("lineColor")))
        sysGraph.SetMarkerColor(int(self.__getStyleOption("markerColor")))
        sysGraph.SetMarkerStyle(int(self.__getStyleOption("markerStyle")))
        sysGraph.SetMarkerSize(float(self.__getStyleOption("markerSize")))
        #TOMAS removed sys error from the plot
        #result.Add(sysGraph,"[]")
        result.Add(graph,"P")
#        result.SetName("MultiPlots")
#         result.SetTitle("%s;%s;%s"%(self.__title,self.__xTitle,self.__yTitle))
        result.SetName("MG_%s"%(self.__title))
        legend.AddEntry(graph, self.__getStyleOption("name"))
        
        #for (x,y,yErr) in zip(self.__x, self.__y, zip(self.__yErrLow,self.__yErrHigh)):
        #    self.__addAnnotaion("hallo",x,y,yErr)

        return (result, legend)
        #return (graph, legend)
        #return (result, legend, refLabel)

    def getGraphSimple(self):
        from array import array
        from ROOT import TMultiGraph, TLegend, TGraphAsymmErrors
        n = len(self.__x)
        if n != len(self.__y) or n != len(self.__yErrLow) or n != len(self.__yErrHigh):
            raise StandardError, "The length of the x(%s), y(%s) and y error(%s,%s) lists does not match"%(len(self.__x), len(self.__y), len(self.__yErrLow), len(self.__yErrHigh))

        legendPosition = [float(i) for i in self.__getStyleOption("legendPosition").split()]
        legend = TLegend(*legendPosition)
        legend.SetFillColor(0)

        xErr = array("d",[0 for i in range(n)])
        print "__x = ", self.__x
        print "__y = ", self.__y
        graph = TGraphAsymmErrors(n, self.__x, self.__y, xErr, xErr, self.__yErrLow,self.__yErrHigh)
        graph.SetTitle("%s;%s;%s"%(self.__title,self.__xTitle,self.__yTitle))
        graph.SetLineWidth(2)
        graph.SetFillColor(0)
        graph.SetLineColor(int(self.__getStyleOption("lineColor")))
        graph.SetMarkerColor(int(self.__getStyleOption("markerColor")))
        graph.SetMarkerStyle(int(self.__getStyleOption("markerStyle")))
        graph.SetMarkerSize(float(self.__getStyleOption("markerSize")))
        graph.SetDrawOption("AP")

        return (graph, legend)


    def getHISTO(self):
        from array import array
        from ROOT import TMultiGraph, TLegend, TGraphAsymmErrors
        from ROOT import TH1,TH1F,TAxis
        from math import sqrt 
        n = len(self.__x)
        if n != len(self.__y) or n != len(self.__yErrLow):
            raise StandardError, "The length of the x(%s), y(%s) and y error(%s,%s) lists does not match"%(len(self.__x), len(self.__y), len(self.__yErrLow), len(self.__yErrHigh))
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
              raise StandardError, "Bad xMode syntax: %s" % xMode
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


    def __getRefernceGraphArrays(self):
        from array import array
        #from Numeric import minimum, maximum
        width = max(self.__x) - min(self.__x)
        (y, yErr) = self.__metric(self.__reference[1])
        
        relPadding = 0.01
        result = (2,
                  array("d",[min(self.__x)-width*relPadding, max(self.__x)+width*relPadding,]),
                  array("d",[y,y]),
                  array("d",[0,0]),
                  array("d",[0,0]),
                  array("d",[yErr[0],yErr[0]]),
                  array("d",[yErr[1],yErr[1]]))

        from ROOT import TLatex
        refLabel = TLatex(max(self.__x)+width*2*relPadding, y, "%.4g" % y)
        refLabel.SetTextSize(float(self.__config.get("styleDefaults","annotationSize")))

        return (result, refLabel)
            
    def __getStyleOption(self, name):
        result = None
        if not self.__config.has_option("styleDefaults", name):
            raise StandardError, "there is no default style option for '%s'"%name
        result = self.__config.get("styleDefaults", name)
        if self.__config.has_option(self.__section, name):
            result = self.__config.get(self.__section, name)
        return result

def getReferenceRun(config, runs):
    """deprecated"""
    print "******************************** in GETREFERENCERUN ??? ********************************************"
    if config.has_option("reference","count"):
      if config.has_option("reference","path"):
        raise StandardError, "Only one of 'count' or 'path' options in the 'reference' section can be specified at a time."

      maxCount = -9
      bestRefPath = None
      bestRefDir = None
      bestRunNo = None
      for runNo, candidate in runs.iteritems():
        file = TFile.Open(candidate, "READ")
        directories = findDirectory(file, config.get("general","dataDirPattern"))
        if len(directories) > 0:
          histo = MakeNullPointer(TH1)
          file.GetObject(os.path.join(directories[0],config.get("reference","count")), histo)
          try:
            file.GetObject(os.path.join(directories[0],config.get("reference","count")), histo)
            if histo.GetEntries() > maxCount:
              maxCount = histo.GetEntries()
              bestRefPath = candidate
              bestRefDir = directories[0]
              bestRunNo = runNo
          except LookupError:
              print "WARNING: problem loading '%s'"%(os.path.join(directories[0],config.get("reference","count")))
        file.Close()
      if bestRefPath:
        refName = config.get("reference","name", bestRefDir)
        config.set("reference","name", refName%{"runNo":bestRunNo})
        config.set("reference","path", bestRefPath)
      else:
        raise StandardError, "No reference histogram with maximum number of entries in %s could be found." % config.get("reference","count")

    else:
      file = TFile.Open(config.get("reference","path"), "READ")
      directories = findDirectory(file,config.get("reference","name"))
      if len(directories) < 1:
        raise StandardError, "Reference histograms directory %s does not exist in %s." % (config.get("reference","name"),file)
      config.set("reference","name", directories[0])
      file.Close()

def getRunsFromDQM(config, mask, pd, mode, runMask="all",runlistfile=[],jsonfile=[]):
    from src.dqmjson import dqm_get_samples
#    import simplejson as jsonn
    import json as jsonn
    serverUrl = config.get("dqmServer","url")
    dataType = config.get("dqmServer","type")

    json = dqm_get_samples(serverUrl, mask, dataType)
    masks = []
    if runlistfile!=[]:
       runs1 = [x.strip() for x in open(runlistfile,"r")]

    if jsonfile!=[]:
        print "file:",jsonfile
        aaf = open(jsonfile)
        info = aaf.read()
        decoded = jsonn.loads(info)
        print decoded
        runs1=[]
        for item in decoded:
            runs1.append(item)           

    for runNr, dataset in json:
        if dataset not in masks: masks.append(dataset)
    for m in masks:
        print m
    
    result = {}
    for mask in masks :
        json = dqm_get_samples(serverUrl, mask, dataType)
        for runNr, dataset in json:
            if 'Cosmics' in pd and mode != 'ALL':
              ##For this to run correctly, I need autoRunDecoDetector.py checked out (UserCode/TkDQM/Tools)
                if checkStripMode(runNr) != mode:
                    continue
            if runlistfile==[] and jsonfile==[]:
                if eval(runMask,{"all":True,"run":runNr}):
                    result[runNr] = (serverUrl, runNr, dataset)
            else:
                 for run_temp in runs1:
                        if int(run_temp)==int(runNr):
                                print "test1=",run_temp,runNr
                                result[runNr] = (serverUrl, runNr, dataset)
    if not result :
        print "*** WARNING: YOUR REQUEST DOESNT MATCH ANY EXISTING DATASET ***"
        print "-> check your settings in ./cfg/trendPlots.py"
        print "--> check your runmask!"
        print "===> maybe choose a different primary dataset"
        print "--> or check the runrange!"
        print "*** end of warning *********************************************"
        return
    return result

def getHistoFromDQM(serverUrl, runNr, dataset, histoPath):
    print "**************>>>> GETTING HISTO"
    from src.dqmjson import dqm_get_json
    from os.path import split as splitPath
    print "fetching",serverUrl, runNr, dataset, histoPath
    print "*** histoPath = ", histoPath
    paths  = re.split('[,]',histoPath)
    print "paths = ", paths
    print "histoPath = ", histoPath
    if len(paths)>1 :
        print "paths[0] = ", paths[0]
        print "paths[1] = ", paths[1]
        for path in paths:
            print "splitPath(path)[1] = ", splitPath(path)[1] 
            if splitPath(path)[1] :
                #histoPath=path
                print "path = ", path
                
    #print "DEBUUUUG1"
    #print dataset
    #print "histoPath[0]: ", histoPath[0]
    #print "histoPath: " , histoPath
    #json = dqm_get_json( serverUrl, runNr, dataset, histoPath[0], rootContent=True)

    result = None
    for path in paths:
        print "looping over histo paths, path = ", path 
        print "DEBUUUUG2"
        print dataset
        print splitPath(histoPath)[0]
        json = dqm_get_json( serverUrl, runNr, dataset, splitPath(histoPath)[0], rootContent=True)
        #jsonT = dqm_get_json( serverUrl, runNr, dataset, splitPath(path)[0], rootContent=True)


        #if ( path == "SiStrip/MechanicalView/TIB/Summary_ClusterStoNCorr_OnTrack__TIB" ):
            #print "JSOOOOON " , jsonT
            #print "JSOOOOON REPR " , repr(jsonT)
            #print "OK?"
            #data_string = json.dumps(jsonT)
            #print "OK!"
            #print "JSOOOOON STRING " , data_string
            #with open('testjson.txt', 'w') as outfile:
             #   json.dump(jsonT, outfile)
                #outfile.write(data_string)
            #outfile.close()
      
        #print "===> if this crashes you might consider changing the relativePats in ./cfg/trendPlotsTracker.py"
        #print "test = ", splitPath(path)[1] in json
        #if splitPath(histoPath)[1] in json :
        if splitPath(path)[1] in json :
            print "path in json = ", path
            #assert splitPath(histoPath)[1] in json, "could not find '%s' in run %s of '%s'"%(histoPath, runNr, dataset)
            assert splitPath(path)[1] in json, "could not find '%s' in run %s of '%s'"%(path, runNr, dataset)
#            print "using split path"
            #result = json[splitPath(histoPath)[1]]["rootobj"]
            result = json[splitPath(path)[1]]["rootobj"]
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

def checkStripMode(runNo):
    Output = ['PEAK','DECO','MIXED']
    Runs = []
    try :
        fin = open("StripReadoutMode4Cosmics.txt","r")
        lines = fin.readlines()
        fin.close()
    except :
        print "No file"
        return "NONE"
    for i in range(len(lines)):
        Runs.append(re.split(",",lines[i][1:-2]))
    for i in range(len(Runs)):
        for pair in Runs[i]:
            if pair.find(":") > -1:
                pair = pair.replace("'","")
                fromrun = re.split(":",pair)[0]
                tillrun = re.split(":",pair)[1]
                if int(runNo) >= int(fromrun) and int(runNo) <= int(tillrun):
                    return Output[i]
    return "NONE"

def main(argv=None):
    import sys
    import os
    from optparse import OptionParser
    from ROOT import TCanvas,TFile
    from src.dqmjson import dqm_get_json    

    if argv == None:
        argv = sys.argv[1:]
    parser = OptionParser()
    parser.add_option("-C", "--config", dest="config", default=[], action="append", 
                      help="configuration defining the plots to make")
    parser.add_option("-o", "--output", dest="outPath", default=None, 
                      help="path to output plots. If it does not exsist it is created")
    parser.add_option("-r", "--runs", dest="runs", default="all", 
                      help="mask for the run (full boolean and math capabilities e.g. run > 10 and run *2 < -1)")
    parser.add_option("-D", "--dataset", dest="dset", default="Jet",
                      help="mask for the primary dataset (default is Jet), e.g. Cosmics, MinimumBias")
    parser.add_option("-E", "--epoch", dest="epoch", default="Run2012",
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
#    if opts.json!=[]:
#        import simplejson as json
#        aaf = open("Cert_190456-191276_8TeV_PromptReco_Collisions12_JSON_MuonPhys.txt","r")
#        tempF=open("temp.txt")
 
    initStyle(config)

    dsetmask = ".*/" + opts.dset +"/"+opts.epoch+".*"+opts.reco+"*.*"+opts.tag+"/"+opts.datatier
    print "dsetmask = ",dsetmask
    print "opts.state = ",opts.state
    print "opts.runs = ",opts.runs
    print "opts.list = ",opts.list
    print "opts.json = ",opts.json
     
    runs = getRunsFromDQM(config, dsetmask, opts.dset, opts.state, opts.runs,opts.list,opts.json)
    if not runs : raise StandardError, "*** Number of runs matching run/mask/etc criteria is equal to zero!!!"

    print "runs= ", runs

    print "got %s run between %s and %s"%(len(runs), min(runs.keys()), max(runs.keys()))
#    getReferenceRun(config, runs)
    plots, cache = initPlots(config)

    runInCache = []
    for itest in range(0,len(cache.keys())):
        runInCache.append(cache.keys()[itest][1])

    for run in sorted(runs.keys()):
        if cache == None or runs[run][1] not in runInCache:
            print "............------------>>> RUN %s NOT IN CACHE"%(runs[run][1])
            rc = dqm_get_json(runs[run][0],runs[run][1],runs[run][2], "Info/ProvInfo")
            print "............------------>>> RunIsComplete flag: " , rc['runIsComplete']['value']
            isDone = int(rc['runIsComplete']['value'])
        else:
            isDone = 1
            print "............------------>>> RUN %s IN CACHE"%(runs[run][1])
        if isDone == 1 :
            for plot in plots:
                plot.addRun(*(runs[run]))
        else:
            print "################### RUN %s NOT FULLY PROCESSED, SKIP #############"%(runs[run][1])

    cachePath = config.get("output","cachePath")
    cacheFile = open(cachePath,"w")
    cacheFile.write(str(cache))
    cacheFile.close()

    outPath = "fig/"+opts.reco+"/"+opts.epoch+"/"+opts.dset
    if 'Cosmics' in opts.dset:
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
            print "Error producing plot:", plot.getName()
            print "Possible cause: no entries, or non-existing plot name"
            continue
        (graph, legend) = plot.getGraph()
        canvas.Clear()
        graph.Draw("AP")
        graph.GetYaxis().SetTitleOffset(1.6)
        plot.formatGraphAxis(graph)
        #refLabel.Draw()
        legend.Draw()
        canvas.SetLeftMargin(0.125)
        plot.drawAnnotation()
        canvas.Modified()
        canvas.Update()
        for formatExt in config.get("output","formats").split():
            if formatExt=='root':
                (histotemp, legend) = plot.getHISTO()
                #(graphtemp, legend1) = plot.getGraphSimple()
            #plot.formatGraphAxis(graphtemp)
                F_out=TFile.Open(os.path.join(outPath,"%s.%s"%(plot.getName(), formatExt)),"RECREATE")
                F_out.cd()
                histotemp.Write()
                graph.Write()
#                graphtemp.SetDrawOption("AP")
#                graphtemp.Write("P")
                F_out.Close()

            else:
                canvas.Print(os.path.join(outPath,"%s.%s"%(plot.getName(), formatExt)))

        if makeSummary: canvas.Print(os.path.join(outPath,"trendPlots.ps"))
        
        if makeSummary: canvas.Print(os.path.join(outPath,"trendPlots.ps]"))


if __name__ == '__main__':
    main()
