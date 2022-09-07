import json
import math
#from pprint import pprint

def MakeIncremental(directory,json_infile1,json_outfile,plot_outtitle): 
     
    json_input1=open(directory+json_infile1+".json")

    data1 = json.load(json_input1)
    json_obj1 = json.dumps(data1, sort_keys=True, indent=4)
    counter1 = 0 
    for item1 in data1[json_infile1]:
#         print "Run1 = ", item1[u'run']
         counter1+=1  


    lst = []
    Sum=0
    Sum_err2=0
    Sum_err=0
    for i in range(0,counter1):
        Sum += data1[json_infile1][i][u'y']
        Sum_err2 += data1[json_infile1][i][u'yErr']*data1[json_infile1][i][u'yErr']
        Sum_err = math.sqrt(Sum_err2)
#        print "Run {0} : {1} +- {2} --> {3} +- {4}".format(data1[json_infile1][i][u'run'],data1[json_infile1][i][u'y'],data1[json_infile1][i][u'yErr']*data1[json_infile1][i][u'yErr'],Sum,Sum_err)
        d={}
        d['x']=i+1
        d['y']=Sum
        d['run']=data1[json_infile1][i][u'run']
        d['yErr']=Sum_err
        d['yTitle']=plot_outtitle
        d['hTitle']=plot_outtitle
        lst.append(d)
	   	
    obj ={}		
    obj[json_outfile]=lst		
#    print  json.dumps(obj,indent=2)		

    outfile=open(directory+json_outfile+".json", 'w')
    json.dump(obj, outfile,indent=4)

def main(argv=None):
    import sys
    import getopt
    import os
    
    json_infile1 = ""
    json_outfile = ""
    plot_outtitle = ""
    directory="./JSON/"
# Read command line args
    myopts, args = getopt.getopt(sys.argv[1:],"h:i:o:t:")
 
###############################
# o == option
# a == argument passed to the o
###############################
    for o, a in myopts:
       if o == '-i':
         json_infile1=a
       elif o == '-o':
         json_outfile=a
       elif o == '-t':
         plot_outtitle=a
       elif o == "-h":
         directory=a 
       else:
         print("Usage: %s -i Input File -o OutFile -t OutPlot Title" % sys.argv[0])

    print("Incremental JSON file based on {0} will be created".format(json_infile1))
    print("Directory = ",directory)
    print("Output JSON Name = ",json_outfile)
    print("Output Plot Title = ",plot_outtitle)


    MakeIncremental(directory,json_infile1,json_outfile,plot_outtitle)

if __name__ == '__main__':
    main()

