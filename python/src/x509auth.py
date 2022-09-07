import os, sys, urllib.request, urllib.error, urllib.parse, http.client, json
from ROOT import *
from array import *

serverurl = 'https://cmsweb.cern.ch/dqm/offline'
ident = "DQMToJson/1.0 python/%d.%d.%d" % sys.version_info[:3]
HTTPS = http.client.HTTPSConnection

class X509CertAuth(HTTPS):
 ssl_key_file = None
 ssl_cert_file = None
 def __init__(self, host, *args, **kwargs):
   HTTPS.__init__(self, host,
                  key_file = X509CertAuth.ssl_key_file,
                  cert_file = X509CertAuth.ssl_cert_file,
                  **kwargs)

class X509CertOpen(urllib.request.AbstractHTTPHandler):
  def default_open(self, req):
    return self.do_open(X509CertAuth, req)

def x509_params():
 key_file = cert_file = None

 x509_path = os.getenv("X509_USER_PROXY", None)
 if x509_path and os.path.exists(x509_path):
##   key_file = cert_file = x509_path
   key_file = cert_file = "/tmp/x509up_u133079"

 if not key_file:
   x509_path = "/tmp/x509up_u133079"
   if os.path.exists(x509_path):
     key_file = x509_path

 if not cert_file:
   x509_path = "/tmp/x509up_u133079"
   if os.path.exists(x509_path):
     cert_file = x509_path     

 if not key_file:
   x509_path = os.getenv("X509_USER_KEY", None)
   if x509_path and os.path.exists(x509_path):
     key_file = x509_path

 if not cert_file:
   x509_path = os.getenv("X509_USER_CERT", None)
   if x509_path and os.path.exists(x509_path):
     cert_file = x509_path

 if not key_file:
   x509_path = os.getenv("HOME") + "/private/userkey.pem"
   if os.path.exists(x509_path):
     key_file = x509_path

 if not cert_file:
   x509_path = os.getenv("HOME") + "/private/usercert.pem"
   if os.path.exists(x509_path):
     cert_file = x509_path

 if not key_file or not os.path.exists(key_file):
   print >>sys.stderr, "no certificate private key file found"
   sys.exit(1)

 if not cert_file or not os.path.exists(cert_file):
   print >>sys.stderr, "no certificate public key file found"
   sys.exit(1)

 sys.stderr.write("Using SSL private key %s\n" % key_file)
 sys.stderr.write("Using SSL public  key %s\n" % cert_file)
 return key_file, cert_file

