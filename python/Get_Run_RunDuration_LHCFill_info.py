import json
import math
from pprint import pprint
from rhapi import DEFAULT_URL, RhApi
from optparse import OptionParser

def main(argv=None):
      parser = OptionParser()
      parser.add_option("-c", "--cosmics", dest="cosmics", action="store_true", default=False, help="cosmic runs")
      (option, args) = parser.parse_args()

      
      lst = []
      if option.cosmics :
            input_file =open('json_DCSONLY_cosmics.txt','r')
            json_outfile = "Run_LHCFill_RunDuration_Cosmics.json"
      else :
            input_file =open('json_DCSONLY.txt','r')
            json_outfile = "Run_LHCFill_RunDuration.json"

      
          
      data = json.load(input_file)
      
      api = RhApi(DEFAULT_URL, debug = False)
      print "Getting run duration info........"
      for key in data.keys(): 
         #print "Run = ",key
	 q = "select r.lhcfill from runreg_tracker.runs r where r.runnumber between " + key[:6]  + " and " + key[:6] 
         if option.cosmics :
               p = {"class": "Cosmics18CRUZET || Cosmics18" }
         else :
               p = {"class": "Collisions18" }

         #print "RR Query = ",q 
	 lhcfill_init = api.json(q, p)[u'data']
         lhcfill_middle = lhcfill_init[0] 

	 q1 = "select r.duration from runreg_tracker.runs r where r.runnumber between " + key[:6]  + " and " + key[:6] 
         if option.cosmics :
               p1 = {"class": "Cosmics18CRUZET || Cosmics18" }
         else :
               p1 = {"class": "Collisions18" }
         #print "RR Query = ",q 
	 dur_init = api.json(q1, p1)[u'data']
         dur_middle = dur_init[0] 

#	 print key," ",lhcfill_middle[0], "  ", dur_middle[0]
        
	 d={}
         d['run']=key
         d['lhcfill']=lhcfill_middle[0]
         d['rundur']=dur_middle[0]
         lst.append(d)
	 
      lst=sorted(lst,key=lambda x:x['run'])    
      
      obj ={}		
      obj[json_outfile]=lst		
#      print  json.dumps(obj,indent=2)		

      outfile=open(json_outfile, 'w')
      json.dump(obj, outfile,indent=4)
      print ".....done! Output on {0}".format(json_outfile)
if __name__ == '__main__':
    main()
