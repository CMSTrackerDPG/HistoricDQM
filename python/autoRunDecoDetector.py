#!/usr/bin/python

import re
import subprocess
import sys

try:
    Run2Test = sys.argv[1]
except:
    print "You really need to give me a run here."
    print "Now I'm going to exit slowly and painfully"


Myrun    = 120000
DecoRuns = []
PeakRuns = []
MixdRuns = []
#Try to load file
fin = ''
try :
    fin = open("StripReadoutMode4Cosmics.txt","r").readlines()
except :
    pass
    #print "No file to load"

if len(fin) > 2:
    Myrun = 123456789
    PeakRuns = re.split(",",fin[0][1:-2])
    DecoRuns = re.split(",",fin[1][1:-2])
    MixdRuns = re.split(",",fin[2][1:-2])

##Now start the main program:
while Myrun < 500000:
    outrange = subprocess.Popen("python $CMSSW_BASE/src/CondFormats/SiStripObjects/test/SiStripLatencyInspector.py " +str(Myrun), shell=True, stdout=subprocess.PIPE).stdout.readline()[:-1]
    ##Now sort range into peak/deco
    ##Sample output: 
    ##since = 186145 , till = 4294967295 --> peak mode
    fromrun = re.split(" ",outrange)[2]
    tillrun = re.split(" ",outrange)[6]
    Myrun = int(tillrun) +1
    #print "From run "+ fromrun + " to run " + tillrun
    if outrange.find("peak") > -1:
        PeakRuns.append(fromrun+":"+tillrun)
    elif outrange.find("deco") > -1:
        DecoRuns.append(fromrun+":"+tillrun)
    elif outrange.find("mixed") > -1:
        MixdRuns.append(fromrun+":"+tillrun)

if len(fin) < 3:
    fout = open("StripReadoutMode4Cosmics.txt","w")
    fout.write(str(PeakRuns)+'\n')
    fout.write(str(DecoRuns)+'\n')
    fout.write(str(MixdRuns)+'\n')
    fout.close()

for pair in PeakRuns:
    if pair.find(":") > -1:
        pair = pair.replace("'","")
        fromrun = re.split(":",pair)[0]
        tillrun = re.split(":",pair)[1]
        if int(Run2Test) > int(fromrun) and int(Run2Test) < int(tillrun):
            print "PEAK"

for pair in DecoRuns:
    if pair.find(":") > -1:
        pair = pair.replace("'","")
        fromrun = re.split(":",pair)[0]
        tillrun = re.split(":",pair)[1]
        if int(Run2Test) > int(fromrun) and int(Run2Test) < int(tillrun):
            print "DECO"
        
for pair in MixdRuns:
    if pair.find(":") > -1:
        pair = pair.replace("'","")
        fromrun = re.split(":",pair)[0]
        tillrun = re.split(":",pair)[1]
        if int(Run2Test) > int(fromrun) and int(Run2Test) < int(tillrun):
            print "MIX"
        
