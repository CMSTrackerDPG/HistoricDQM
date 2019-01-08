#!/usr/bin/env python
import os
import json

runlist=[]
dirlist = os.listdir('/afs/cern.ch/cms/tracker/sistrvalidation/WWW/CalibrationValidation/HitEfficiency/GR18')
dirlist.remove('TrendPlots')
dirlist.remove('SummaryBadModules')

for dir in dirlist:
     runlist.append(dir.replace("run_",""))
runlist.sort()

subsyslist=["Tracker","TIB","TOB","TID","TEC",
            "TIBLayer1","TIBLayer2","TIBLayer3","TIBLayer4",
            "TOBLayer1","TOBLayer2","TOBLayer3","TOBLayer4","TOBLayer5","TOBLayer6",
            "TIDpDisk1","TIDpDisk2","TIDpDisk3","TIDmDisk1","TIDmDisk2","TIDmDisk3",
            "TECpDisk1","TECpDisk2","TECpDisk3","TECpDisk4","TECpDisk5","TECpDisk6",
            "TECpDisk7","TECpDisk8","TECpDisk9",
            "TECmDisk1","TECmDisk2","TECmDisk3","TECmDisk4","TECmDisk5","TECmDisk6",
            "TECmDisk7","TECmDisk8","TECmDisk9"]

for sys in subsyslist:
     command=""
     command=sys+"list=[]"
     exec(command)

rundict={}

for m, run in enumerate(runlist,0):
     rundict.update({run:m})
     filename = '/afs/cern.ch/cms/tracker/sistrvalidation/WWW/CalibrationValidation/HitEfficiency/GR18/'+'run_'+run+'/standard/QualityLog/'+'InefficientModules_'+run+'.txt'
     file = open(filename, "r")
     BadComponent = {}
     for n, line in enumerate(file):
        if n == 8:
                info=line.split()
                Tracker={}
                Tracker['x']=m+1
                Tracker['y']=int(info[1])
                Tracker['run']=int(run)
                Tracker['yErr']=0
                Tracker['yTitle']=info[0].replace(":","")+" Inefficient Modules"
                Tracker['hTitle']=info[0].replace(":","")+" Inefficient Modules"
                Trackerlist.append(Tracker)
        if n == 10:
                info=line.split()    
                TIB={}
                TIB['x']=m+1
                TIB['y']=int(info[1])
                TIB['run']=int(run)
                TIB['yErr']=0
                TIB['yTitle']=info[0].replace(":","")+" Inefficient Modules"
                TIB['hTitle']=info[0].replace(":","")+" Inefficient Modules"
                TIBlist.append(TIB)
        if n == 11:
                info=line.split()
                TID={}
                TID['x']=m+1
                TID['y']=int(info[1])
                TID['run']=int(run)
                TID['yErr']=0
                TID['yTitle']=info[0].replace(":","")+" Inefficient Modules"
                TID['hTitle']=info[0].replace(":","")+" Inefficient Modules"
                TIDlist.append(TID)
        if n == 12:
                info=line.split()
                TOB={}
                TOB['x']=m+1
                TOB['y']=int(info[1])
                TOB['run']=int(run)
                TOB['yErr']=0
                TOB['yTitle']=info[0].replace(":","")+" Inefficient Modules"
                TOB['hTitle']=info[0].replace(":","")+" Inefficient Modules"
                TOBlist.append(TOB)
        if n == 13:
                info=line.split()
                TEC={}
                TEC['x']=m+1
                TEC['y']=int(info[1])
                TEC['run']=int(run)
                TEC['yErr']=0
                TEC['yTitle']=info[0].replace(":","")+" Inefficient Modules"
                TEC['hTitle']=info[0].replace(":","")+" Inefficient Modules"
                TEClist.append(TEC)

        if n == 15:
                info=line.split()
                TIBLayer1={}
                TIBLayer1['x']=m+1
                TIBLayer1['y']=int(info[4])
                TIBLayer1['run']=int(run)
                TIBLayer1['yErr']=0
                TIBLayer1['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer1['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer1list.append(TIBLayer1)
        if n == 16:
                info=line.split()
                TIBLayer2={}
                TIBLayer2['x']=m+1
                TIBLayer2['y']=int(info[4])
                TIBLayer2['run']=int(run)
                TIBLayer2['yErr']=0
                TIBLayer2['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer2['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer2list.append(TIBLayer2)
        if n == 17:
                info=line.split()
                TIBLayer3={}
                TIBLayer3['x']=m+1
                TIBLayer3['y']=int(info[4])
                TIBLayer3['run']=int(run)
                TIBLayer3['yErr']=0
                TIBLayer3['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer3['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer3list.append(TIBLayer3)
        if n == 18:
                info=line.split()
                TIBLayer4={}
                TIBLayer4['x']=m+1
                TIBLayer4['y']=int(info[4])
                TIBLayer4['run']=int(run)
                TIBLayer4['yErr']=0
                TIBLayer4['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer4['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIBLayer4list.append(TIBLayer4)

        if n == 20:
                info=line.split()
                TIDpDisk1={}
                TIDpDisk1['x']=m+1
                TIDpDisk1['y']=int(info[4])
                TIDpDisk1['run']=int(run)
                TIDpDisk1['yErr']=0
                TIDpDisk1['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDpDisk1['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDpDisk1list.append(TIDpDisk1)
        if n == 21:
                info=line.split()
                TIDpDisk2={}
                TIDpDisk2['x']=m+1
                TIDpDisk2['y']=int(info[4])
                TIDpDisk2['run']=int(run)
                TIDpDisk2['yErr']=0
                TIDpDisk2['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDpDisk2['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDpDisk2list.append(TIDpDisk2)
        if n == 22:
                info=line.split()
                TIDpDisk3={}
                TIDpDisk3['x']=m+1
                TIDpDisk3['y']=int(info[4])
                TIDpDisk3['run']=int(run)
                TIDpDisk3['yErr']=0
                TIDpDisk3['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDpDisk3['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDpDisk3list.append(TIDpDisk3)

        if n == 23:
                info=line.split()
                TIDmDisk1={}
                TIDmDisk1['x']=m+1
                TIDmDisk1['y']=int(info[4])
                TIDmDisk1['run']=int(run)
                TIDmDisk1['yErr']=0
                TIDmDisk1['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDmDisk1['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDmDisk1list.append(TIDmDisk1)
        if n == 24:
                info=line.split()
                TIDmDisk2={}
                TIDmDisk2['x']=m+1
                TIDmDisk2['y']=int(info[4])
                TIDmDisk2['run']=int(run)
                TIDmDisk2['yErr']=0
                TIDmDisk2['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDmDisk2['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDmDisk2list.append(TIDmDisk2)
        if n == 25:
                info=line.split()
                TIDmDisk3={}
                TIDmDisk3['x']=m+1
                TIDmDisk3['y']=int(info[4])
                TIDmDisk3['run']=int(run)
                TIDmDisk3['yErr']=0
                TIDmDisk3['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDmDisk3['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TIDmDisk3list.append(TIDmDisk3)

        if n == 27:
                info=line.split()
                TOBLayer1={}
                TOBLayer1['x']=m+1
                TOBLayer1['y']=int(info[4])
                TOBLayer1['run']=int(run)
                TOBLayer1['yErr']=0
                TOBLayer1['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer1['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer1list.append(TOBLayer1)
        if n == 28:
                info=line.split()
                TOBLayer2={}
                TOBLayer2['x']=m+1
                TOBLayer2['y']=int(info[4])
                TOBLayer2['run']=int(run)
                TOBLayer2['yErr']=0
                TOBLayer2['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer2['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer2list.append(TOBLayer2)
        if n == 29:
                info=line.split()
                TOBLayer3={}
                TOBLayer3['x']=m+1
                TOBLayer3['y']=int(info[4])
                TOBLayer3['run']=int(run)
                TOBLayer3['yErr']=0
                TOBLayer3['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer3['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer3list.append(TOBLayer3)
        if n == 30:
                info=line.split()
                TOBLayer4={}
                TOBLayer4['x']=m+1
                TOBLayer4['y']=int(info[4])
                TOBLayer4['run']=int(run)
                TOBLayer4['yErr']=0
                TOBLayer4['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer4['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer4list.append(TOBLayer4)
        if n == 31:
                info=line.split()
                TOBLayer5={}
                TOBLayer5['x']=m+1
                TOBLayer5['y']=int(info[4])
                TOBLayer5['run']=int(run)
                TOBLayer5['yErr']=0
                TOBLayer5['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer5['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer5list.append(TOBLayer5)
        if n == 32:
                info=line.split()
                TOBLayer6={}
                TOBLayer6['x']=m+1
                TOBLayer6['y']=int(info[4])
                TOBLayer6['run']=int(run)
                TOBLayer6['yErr']=0
                TOBLayer6['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer6['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TOBLayer6list.append(TOBLayer6)

        if n == 34:
                info=line.split()
                TECpDisk1={}
                TECpDisk1['x']=m+1
                TECpDisk1['y']=int(info[4])
                TECpDisk1['run']=int(run)
                TECpDisk1['yErr']=0
                TECpDisk1['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk1['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk1list.append(TECpDisk1)
        if n == 35:
                info=line.split()
                TECpDisk2={}
                TECpDisk2['x']=m+1
                TECpDisk2['y']=int(info[4])
                TECpDisk2['run']=int(run)
                TECpDisk2['yErr']=0
                TECpDisk2['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk2['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk2list.append(TECpDisk2)
        if n == 36:
                info=line.split()
                TECpDisk3={}
                TECpDisk3['x']=m+1
                TECpDisk3['y']=int(info[4])
                TECpDisk3['run']=int(run)
                TECpDisk3['yErr']=0
                TECpDisk3['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk3['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk3list.append(TECpDisk3)
        if n == 37:
                info=line.split()
                TECpDisk4={}
                TECpDisk4['x']=m+1
                TECpDisk4['y']=int(info[4])
                TECpDisk4['run']=int(run)
                TECpDisk4['yErr']=0
                TECpDisk4['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk4['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk4list.append(TECpDisk4)
        if n == 38:
                info=line.split()
                TECpDisk5={}
                TECpDisk5['x']=m+1
                TECpDisk5['y']=int(info[4])
                TECpDisk5['run']=int(run)
                TECpDisk5['yErr']=0
                TECpDisk5['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk5['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk5list.append(TECpDisk5)
        if n == 39:
                info=line.split()
                TECpDisk6={}
                TECpDisk6['x']=m+1
                TECpDisk6['y']=int(info[4])
                TECpDisk6['run']=int(run)
                TECpDisk6['yErr']=0
                TECpDisk6['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk6['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk6list.append(TECpDisk6)
        if n == 40:
                info=line.split()
                TECpDisk7={}
                TECpDisk7['x']=m+1
                TECpDisk7['y']=int(info[4])
                TECpDisk7['run']=int(run)
                TECpDisk7['yErr']=0
                TECpDisk7['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk7['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk7list.append(TECpDisk7)
        if n == 41:
                info=line.split()
                TECpDisk8={}
                TECpDisk8['x']=m+1
                TECpDisk8['y']=int(info[4])
                TECpDisk8['run']=int(run)
                TECpDisk8['yErr']=0
                TECpDisk8['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk8['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk8list.append(TECpDisk8)
        if n == 42:
                info=line.split()
                TECpDisk9={}
                TECpDisk9['x']=m+1
                TECpDisk9['y']=int(info[4])
                TECpDisk9['run']=int(run)
                TECpDisk9['yErr']=0
                TECpDisk9['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk9['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECpDisk9list.append(TECpDisk9)

        if n == 43:
                info=line.split()
                TECmDisk1={}
                TECmDisk1['x']=m+1
                TECmDisk1['y']=int(info[4])
                TECmDisk1['run']=int(run)
                TECmDisk1['yErr']=0
                TECmDisk1['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk1['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk1list.append(TECmDisk1)
        if n == 44:
                info=line.split()
                TECmDisk2={}
                TECmDisk2['x']=m+1
                TECmDisk2['y']=int(info[4])
                TECmDisk2['run']=int(run)
                TECmDisk2['yErr']=0
                TECmDisk2['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk2['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk2list.append(TECmDisk2)
        if n == 45:
                info=line.split()
                TECmDisk3={}
                TECmDisk3['x']=m+1
                TECmDisk3['y']=int(info[4])
                TECmDisk3['run']=int(run)
                TECmDisk3['yErr']=0
                TECmDisk3['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk3['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk3list.append(TECmDisk3)
        if n == 46:
                info=line.split()
                TECmDisk4={}
                TECmDisk4['x']=m+1
                TECmDisk4['y']=int(info[4])
                TECmDisk4['run']=int(run)
                TECmDisk4['yErr']=0
                TECmDisk4['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk4['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk4list.append(TECmDisk4)
        if n == 47:
                info=line.split()
                TECmDisk5={}
                TECmDisk5['x']=m+1
                TECmDisk5['y']=int(info[4])
                TECmDisk5['run']=int(run)
                TECmDisk5['yErr']=0
                TECmDisk5['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk5['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk5list.append(TECmDisk5)
        if n == 48:
                info=line.split()
                TECmDisk6={}
                TECmDisk6['x']=m+1
                TECmDisk6['y']=int(info[4])
                TECmDisk6['run']=int(run)
                TECmDisk6['yErr']=0
                TECmDisk6['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk6['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk6list.append(TECmDisk6)
        if n == 49:
                info=line.split()
                TECmDisk7={}
                TECmDisk7['x']=m+1
                TECmDisk7['y']=int(info[4])
                TECmDisk7['run']=int(run)
                TECmDisk7['yErr']=0
                TECmDisk7['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk7['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk7list.append(TECmDisk7)
        if n == 50:
                info=line.split()
                TECmDisk8={}
                TECmDisk8['x']=m+1
                TECmDisk8['y']=int(info[4])
                TECmDisk8['run']=int(run)
                TECmDisk8['yErr']=0
                TECmDisk8['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk8['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk8list.append(TECmDisk8)
        if n == 51:
                info=line.split()
                TECmDisk9={}
                TECmDisk9['x']=m+1
                TECmDisk9['y']=int(info[4])
                TECmDisk9['run']=int(run)
                TECmDisk9['yErr']=0
                TECmDisk9['yTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk9['hTitle']=info[0]+info[1]+info[2]+" Inefficient Modules"
                TECmDisk9list.append(TECmDisk9)
     file.close()

for sys in subsyslist:
     obj={}
     command=""
     command="obj['"+sys+"']="+sys+"list"
#     print(command)
     exec(command)
     command=""
     command="outfile=open('JSON/"+sys+" Inefficient Modules.json','w')"
#     print(command)
     exec(command)
     json.dump(obj, outfile,indent=4)
