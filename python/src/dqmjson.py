from x509auth import * #use cctrack certificate if working on vocms061
#from x509auth_lxplus import * #use your personal certificate if working on lxplus
from ROOT import TBufferFile, TH1F, TProfile, TH1F, TH2F
import re

X509CertAuth.ssl_key_file, X509CertAuth.ssl_cert_file = x509_params()
print X509CertAuth.ssl_key_file
print X509CertAuth.ssl_cert_file
print x509_params()

def dqm_get_json(server, run, dataset, folder, rootContent=False):
    postfix = "?rootcontent=1" if rootContent else ""
    datareq = urllib2.Request(('%s/data/json/archive/%s/%s/%s%s') % (server, run, dataset, folder, postfix))
    datareq.add_header('User-agent', ident)
    # Get data
    data = eval(re.sub(r"\bnan\b", "0", urllib2.build_opener(X509CertOpen()).open(datareq).read()),
               { "__builtins__": None }, {})
    if rootContent:
        # Now convert into real ROOT histograms   
        print "Now convert into real ROOT histograms 1"  
        for idx,item in enumerate(data['contents']):
            #print "Now convert into real ROOT histograms 2"  
            if 'obj' in item.keys():
               #print "Now convert into real ROOT histograms 3"  
               if 'rootobj' in item.keys(): 
                    #print "Now convert into real ROOT histograms 4"  
                    a = array('B')
                    #print "Now convert into real ROOT histograms 5"  
                    a.fromstring(item['rootobj'].decode('hex'))
                    #print "Now convert into real ROOT histograms 6"  
                    t = TBufferFile(TBufferFile.kRead, len(a), a, False)
                    #print "Now convert into real ROOT histograms 7"  
                    rootType = item['properties']['type']
                    #print "Now convert into real ROOT histograms 8"  
                    if rootType == 'TPROF': rootType = 'TProfile'
                    #print "Now convert into real ROOT histograms 9"  
                    if rootType == 'TPROF2D': rootType = 'TProfile'
		    #print "Now convert into real ROOT histograms 10"
                    data['contents'][idx]['rootobj'] = t.ReadObject(eval(rootType+'.Class()'))
		    #print "Now convert into real ROOT histograms 11"
    return dict( [ (x['obj'], x) for x in data['contents'][1:] if 'obj' in x] )

def dqm_get_samples(server, match, type="offline_data"):
    datareq = urllib2.Request(('%s/data/json/samples?match=%s') % (server, match))
    datareq.add_header('User-agent', ident)
    # Get data
    data = eval(re.sub(r"\bnan\b", "0", urllib2.build_opener(X509CertOpen()).open(datareq).read()),
               { "__builtins__": None }, {})
    ret = []
    for l in data['samples']:
        if l['type'] == type:
            ret += [ (int(x['run']), x['dataset']) for x in l['items'] ]
    return ret
