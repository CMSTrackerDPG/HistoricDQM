import json
import math
from pprint import pprint
from rhapi import DEFAULT_URL, RhApi

def main(argv=None):
      
      lst = []

      input_file =open('json_DCSONLY.txt','r')
      json_outfile = "Run_LHCFill_RunDuration.json"
      
          
      data = json.load(input_file)
      
      api = RhApi(DEFAULT_URL, debug = False)
            
      for key in data.keys(): 
         #print "Run = ",key
	 q = "select r.lhcfill from runreg_tracker.runs r where r.runnumber between " + key[:6]  + " and " + key[:6] 
         p = {"class": "Collisions17" }
         #print "RR Query = ",q 
	 lhcfill_init = api.json(q, p)[u'data']
         lhcfill_middle = lhcfill_init[0] 

	 q1 = "select r.duration from runreg_tracker.runs r where r.runnumber between " + key[:6]  + " and " + key[:6] 
         p1 = {"class": "Collisions17" }
         #print "RR Query = ",q 
	 dur_init = api.json(q1, p1)[u'data']
         dur_middle = dur_init[0] 

	 print key," ",lhcfill_middle[0], "  ", dur_middle[0]
        
	 d={}
         d['run']=key
         d['lhcfill']=lhcfill_middle[0]
         d['rundur']=dur_middle[0]
         lst.append(d)
	 
      lst=sorted(lst,key=lambda x:x['run'])    
      
      obj ={}		
      obj[json_outfile]=lst		
      print  json.dumps(obj,indent=2)		

      outfile=open(json_outfile, 'w')
      json.dump(obj, outfile,indent=4)
    
if __name__ == '__main__':
    main()
