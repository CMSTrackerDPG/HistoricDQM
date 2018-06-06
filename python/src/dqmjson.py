#from x509auth import * #use cctrack certificate if working on vocms061
#from x509auth_lxplus import * #use your personal certificate if working on lxplus
import ROOT
from ROOT import TBufferFile, TH1F, TProfile, TProfile2D, TH2F, TFile, TH1D, TH2D
import re
import getpass
import platform
user = getpass.getuser()
node = platform.node()
if node.startswith("vocms061") and user.startswith("cctrack"):
    from x509auth import * #use cctrack certificate if working on vocms061
else:
    from x509auth_lxplus import * #use your personal certificate if working elsewhere

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
        #print "Now convert into real ROOT histograms 1"  
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


def dqm_get_json_hist(server, run, dataset, folder, histoName, rootContent=False):
    postfix = "?rootcontent=1" if rootContent else ""
    datareq = urllib2.Request(('%s/data/json/archive/%s/%s/%s%s') % (server, run, dataset, folder, postfix))
    datareq.add_header('User-agent', ident)
    # Get data
    data = eval(re.sub(r"\bnan\b", "0", urllib2.build_opener(X509CertOpen()).open(datareq).read()),
               { "__builtins__": None }, {})
    histoOut=None
    if rootContent:
        # Now convert into real ROOT histograms   
        #print "Now convert into real ROOT histograms 1"  
        for idx,item in enumerate(data['contents']):
            #print "Now convert into real ROOT histograms 2"  
            if 'obj' in item.keys():
               #print "Now convert into real ROOT histograms 3"
               if item['obj']==histoName:  
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
                       #data['contents'][idx]['rootobj'] = t.ReadObject(eval(rootType+'.Class()'))
                       histoOut = t.ReadObject(eval(rootType+'.Class()'))
		       #print "Now convert into real ROOT histograms 11"
                
    return histoOut


def dqm_getSingleHist_json(server, run, dataset, hist, rootContent=False):
    postfix = "?rootcontent=1" if rootContent else ""
    datareq = urllib2.Request(('%s/jsonfairy/archive/%s/%s/%s%s') % (server, run, dataset, hist, postfix))
    datareq.add_header('User-agent', ident)
    # Get data
    data = eval(re.sub(r"\bnan\b", "0", urllib2.build_opener(X509CertOpen()).open(datareq).read()),
               { "__builtins__": None }, {})
    histo = data['hist']
    # Now convert into real ROOT histogram object
    if 'TH1' in histo['type']:
        # The following assumes a TH1F object
        contents = histo['bins']['content']
        nbins = len(contents)
        xmin = histo['xaxis']['first']['value']
        xmax = histo['xaxis']['last']['value']
        roothist = TH1F(histo['stats']['name'],histo['title'],nbins,xmin,xmax)
        for xx in range(1,nbins+1):
            roothist.SetBinContent(xx, contents[xx-1])
            roothist.SetBinError(xx, histo['bins']['error'][xx-1])
        roothist.SetEntries(histo['stats']['entries']) 
        stats=array('d')
        stats.append(histo['stats']['entries'])
        stats.append(histo['stats']['entries'])
        stats.append(histo['stats']['entries']*histo['stats']['mean']['X']['value'])
        stats.append((histo['stats']['rms']['X']['value']*histo['stats']['rms']['X']['value']+histo['stats']['mean']['X']['value']*histo['stats']['mean']['X']['value'])*histo['stats']['entries'])
        roothist.PutStats(stats)
    elif(histo['type']=='TProfile'):
        contents = histo['bins']['content']
        nbins = len(contents)
        xmin = histo['xaxis']['first']['value']
        xmax = histo['xaxis']['last']['value']
        roothist = TProfile(histo['stats']['name'],histo['title'],nbins,xmin,xmax)
        roothist.SetErrorOption("g")
        for xx in range(0,nbins):
            if(histo['bins']['error'][xx]!=0):
                ww=1./(histo['bins']['error'][xx]*histo['bins']['error'][xx])
            else:
                ww=0.
            roothist.Fill(xmin+(2*xx+1)*((xmax-xmin)/(nbins*2.0)), contents[xx],ww)
#            roothist.SetBinContent(xx, contents[xx-1])
#            roothist.SetBinError(xx, histo['bins']['error'][xx-1])
        roothist.SetEntries(histo['stats']['entries']) 
        stats=array('d')
        for i in range(0,6):
            stats.append(i)
        roothist.GetStats(stats)
        stats[0]=(histo['stats']['entries'])
        stats[1]=(histo['stats']['entries'])
        stats[2]=(histo['stats']['entries']*histo['stats']['mean']['X']['value'])
        stats[3]=((histo['stats']['rms']['X']['value']*histo['stats']['rms']['X']['value']+histo['stats']['mean']['X']['value']*histo['stats']['mean']['X']['value'])*histo['stats']['entries'])
        roothist.PutStats(stats)
    elif 'TH2' in histo['type']:
        contents = histo['bins']['content']
        nbinsx = histo['xaxis']['last']['id']
        xmin = histo['xaxis']['first']['value']
        xmax = histo['xaxis']['last']['value']
        nbinsy = histo['yaxis']['last']['id']
        ymin = histo['yaxis']['first']['value']
        ymax = histo['yaxis']['last']['value']
        roothist = TH2F(histo['stats']['name'],histo['title'],nbinsx,xmin,xmax,nbinsy,ymin,ymax)
        for xx in range(1,nbinsx+1):
            for yy in range(1,nbinsy+1):
                roothist.SetBinContent(xx,yy, contents[yy-1][xx-1])
        roothist.SetEntries(histo['stats']['entries']) 
        stats=array('d')
        stats.append(histo['stats']['entries'])
        stats.append(histo['stats']['entries'])
        stats.append(histo['stats']['entries']*histo['stats']['mean']['X']['value'])
        stats.append((histo['stats']['rms']['X']['value']*histo['stats']['rms']['X']['value']+histo['stats']['mean']['X']['value']*histo['stats']['mean']['X']['value'])*histo['stats']['entries'])
        stats.append(histo['stats']['entries']*histo['stats']['mean']['Y']['value'])
        stats.append((histo['stats']['rms']['Y']['value']*histo['stats']['rms']['Y']['value']+histo['stats']['mean']['Y']['value']*histo['stats']['mean']['Y']['value'])*histo['stats']['entries'])
        roothist.PutStats(stats)

    elif(histo['type']=='TProfile2D'):
        contents = histo['bins']['content']
        nbinsx = histo['xaxis']['last']['id']
        xmin = histo['xaxis']['first']['value']
        xmax = histo['xaxis']['last']['value']
        nbinsy = histo['yaxis']['last']['id']
        ymin = histo['yaxis']['first']['value']
        ymax = histo['yaxis']['last']['value']
        roothist = TProfile2D(histo['stats']['name'],histo['title'],nbinsx,xmin,xmax,nbinsy,ymin,ymax)
        for xx in range(0,nbinsx):
            for yy in range(0,nbinsy):
                roothist.Fill(xmin+(2*xx+1)*((xmax-xmin)/(nbinsx*2.0)),ymin+(2*yy+1)*((ymax-ymin)/(nbinsy*2.0)),0,1)
        for xx in range(1,nbinsx+1):
            for yy in range(1,nbinsy+1):
                roothist.SetBinContent(xx,yy, contents[yy-1][xx-1])
                roothist.SetEntries(histo['stats']['entries']) 

    return roothist


def dqm_getTFile(server, run, dataset,version,epoch,datatier):


    ROOT.gEnv.SetValue("Davix.GSI.UserCert",X509CertAuth.ssl_cert_file)
    ROOT.gEnv.SetValue("Davix.GSI.UserKey",X509CertAuth.ssl_key_file)

    datainfo=dataset.split('/')
    runGen=('%.9d' % (run))

    tfile=TFile.Open(('%s/data/browse/ROOT/OfflineData/%s/%s/%sxx/DQM_V%.4d_R%.9d__%s__%s__%s.root') % (server, epoch,datainfo[1], runGen[0:-2],version, run, datainfo[1], datainfo[2],datatier))
    #print tfile
    
    return tfile


def dqm_getTFile_Version(server, run, dataset,datatier):

    datainfo=dataset.split('/')
    runGen=('%.9d' % (run))
    vers=0
    for i in range(1,30):
        urlpath=(('%s/data/browse/ROOT/OfflineData/%s/%s/%sxx/DQM_V%.4d_R%.9d__%s__%s__%s.root') % (server, datainfo[2][0:7],datainfo[1], runGen[0:-2],i, run, datainfo[1], datainfo[2],datatier))
#        print urlpath
        try:
            urllib2.build_opener(X509CertOpen()).open(urlpath)
            vers=i
#            print "Version ",vers," Exists!"
            break
        except urllib2.HTTPError:
 #           print 'Version ',i,' not found'
            continue

    return vers

def dqm_getTFile_Version2(server, run, dataset,epoch,datatier):

    datainfo=dataset.split('/')
    runGen=('%.9d' % (run))
        
    urlpath=(('%s/data/browse/ROOT/OfflineData/%s/%s/%sxx/') % (server, epoch,datainfo[1], runGen[0:-2]))
#    print datainfo[2]
#    print urlpath
    vers=0

    data = urllib2.build_opener(X509CertOpen()).open(urlpath)
    string = data.read().decode('utf-8')
    match = re.search((('[0-9]+(?=_R%.9d__%s__%s__%s.root)')%(run, datainfo[1], datainfo[2],datatier)),string)
    if match is None:
        vers=0
    else:
        vers=int(match.group(0))
    return vers
