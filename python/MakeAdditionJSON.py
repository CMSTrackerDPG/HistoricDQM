import json
import math
from pprint import pprint

def MakeRatio(directory,json_infile1,json_infile2,json_outfile,plot_outtitle): 
     
    #json_input1=open("./JSON/"+json_infile1+".json")
    #json_input2=open("./JSON/"+json_infile2+".json")
    json_input1=open(directory+json_infile1+".json")
    json_input2=open(directory+json_infile2+".json")

    data1 = json.load(json_input1)
    json_obj1 = json.dumps(data1, sort_keys=True, indent=4)
    counter1 = 0 
    for item1 in data1[json_infile1]:
#         print "Run1 = ", item1[u'run']
         counter1+=1  

# ---------------------------------------------------------------------
    data2 = json.load(json_input2)
    json_obj2 = json.dumps(data2, sort_keys=True, indent=4)
    counter2 = 0 
    for item2 in data2[json_infile2]:
         counter2+=1      
# ----------------------------------------------------------------------

    lst = []
	 	 
    for i in range(0,counter1):
         for j in range(0,counter2):
             if(data1[json_infile1][i][u'run'] == data2[json_infile2][j][u'run']):
#	        print "Run Coindidence at run = ", data1[json_infile1][i][u'run']
		Mean_One = data1[json_infile1][i][u'y']
		Mean_One_err = data1[json_infile1][i][u'yErr']
#                print "Mean Numerator = ", Mean_One, " with error = ",Mean_One_err
		Mean_Two = data2[json_infile2][j][u'y']
		Mean_Two_err = data2[json_infile2][j][u'yErr']
#                print "Mean Denominator = ",Mean_Two, " with error = ", Mean_Two_err
                Sum = 0
		Sum_err = 0
                if(Mean_Two != 0):
		   Sum = Mean_One+Mean_Two
                   if(Mean_One != 0):
		       Sum_err = math.sqrt( (Mean_One_err*Mean_One_err) + (Mean_Two_err*Mean_Two_err) )

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
    print  json.dumps(obj,indent=2)		

    #outfile=open("./JSON/"+json_outfile+".json", 'w')
    outfile=open(directory+json_outfile+".json", 'w')
    json.dump(obj, outfile,indent=4)

def main(argv=None):
    import sys
    import getopt
    import os
    
    json_infile1 = "NClust_OFFTk_TIB_mean"
    json_infile2 = "NClust_OFFTk_TOB_mean"
    json_outfile = "NClust_OFFTk_Barrel_mean"
    plot_outtitle = "Total Number of Clusters in Tracker Barrel"
# Read command line args
    myopts, args = getopt.getopt(sys.argv[1:],"h:n:d:f:t:")
 
###############################
# o == option
# a == argument passed to the o
###############################
    for o, a in myopts:
       if o == '-n':
         json_infile1=a
       elif o == '-d':
         json_infile2=a
       elif o == '-f':
         json_outfile=a
       elif o == '-t':
         plot_outtitle=a
       elif o == "-h":
         directory=a 
       else:
         print("Usage: %s -n First File -d Second File" % sys.argv[0])

     
#    print "Output JSON Name = ",json_outfile 
#    print "Output Plot Title = ",plot_outtitle
# Display input and output file name passed as the args
#    print ("Numeraror File : %s and  Denominator File: %s" % (json_infile1,json_infile2) )

    MakeRatio(directory,json_infile1,json_infile2,json_outfile,plot_outtitle)

if __name__ == '__main__':
    main()

