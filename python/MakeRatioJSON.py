import json
import math
#from pprint import pprint

def MakeRatio(json_infile1,json_infile2,json_outfile,plot_outtitle): 
     
    json_input1=open("./JSON/"+json_infile1+".json")
    json_input2=open("./JSON/"+json_infile2+".json")

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
                Mean_Num = data1[json_infile1][i][u'y']
                Mean_Num_err = data1[json_infile1][i][u'yErr']
                Mean_Den = data2[json_infile2][j][u'y']
                Mean_Den_err = data2[json_infile2][j][u'yErr']
                Ratio_N_over_D = 0
                Ratio_N_over_D_err = 0
                if(Mean_Den != 0):
                    Ratio_N_over_D = Mean_Num/Mean_Den
                    if(Mean_Num != 0):
                        Ratio_N_over_D_err = Ratio_N_over_D*math.sqrt( (Mean_Num_err/Mean_Num)*(Mean_Num_err/Mean_Num) + (Mean_Den_err/Mean_Den)*(Mean_Den_err/Mean_Den) )

                d={}
                d['x']=i+1
                d['y']=Ratio_N_over_D
                d['run']=data1[json_infile1][i][u'run']
                d['yErr']=Ratio_N_over_D_err
                d['yTitle']=plot_outtitle
                lst.append(d)
	   	
    obj ={}		
    obj[json_outfile]=lst		
#    print  json.dumps(obj,indent=2)		

    outfile=open("./JSON/"+json_outfile+".json", 'w')
    json.dump(obj, outfile,indent=4)

def main(argv=None):
    import sys
    import getopt
    import os
    
    json_infile1 = "NumberOfTrack_mean"
    json_infile2 = "NumberofPVertices_mean"
    json_outfile = "TrkOverPVertices_ratio"
    plot_outtitle = "Ratio Tracks Over PV vertices per RUN"
# Read command line args
    myopts, args = getopt.getopt(sys.argv[1:],"n:d:f:t:")
 
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
       else:
         print("Usage: %s -n Numeraror File -d Denominator File" % sys.argv[0])


    print("Numeraror File : {0} and  Denominator File: {1}".format(json_infile1,json_infile2))
    print("Output JSON Name = ",json_outfile)
#    print("Output Plot Title = ",plot_outtitle)
# Display input and output file name passed as the args


    MakeRatio(json_infile1,json_infile2,json_outfile,plot_outtitle)

if __name__ == '__main__':
    main()
		      
