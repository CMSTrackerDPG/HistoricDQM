import requests
import json
import os
import sys

# Suppress InsecureRequestWarning
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from requests.exceptions import ConnectionError
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)


headers = {"content-type": "application/x-www-form-urlencoded"}

def exchange_tokens(token):
    data = {
        "client_id": "dcsonly",
        "client_secret": "e4c56fdb-6494-4bce-a2cc-b170b9a6e910",
        "audience": "cmsoms-prod",
        "grant_type": "urn:ietf:params:oauth:grant-type:token-exchange",
        "requested_token_type": "urn:ietf:params:oauth:token-type:access_token",
        "subject_token": token,
    }
    data = requests.post(
        url="https://auth.cern.ch/auth/realms/cern/protocol/openid-connect/token",
        data=data,
        headers=headers,
    )

    try:
        data_ = data.json()
        access_token = data_["access_token"]
        expires_in = data_["expires_in"]
        return {"access_token": access_token, "expires_in": expires_in}

    except Exception as e:
        return "Error: " + str(e)



def get_token():
    data = {
        "client_id": "dcsonly",
        "client_secret": "e4c56fdb-6494-4bce-a2cc-b170b9a6e910",
        "audience": "cmsoms-prod",
        "grant_type": "client_credentials",
    }

    data = requests.post(
        url="https://auth.cern.ch/auth/realms/cern/protocol/openid-connect/token",
        data=data,
        headers=headers,
    )
    try:
        data_ = json.loads(data.text)
        access_token = data_["access_token"]
        data_access_token_and_expires_in = exchange_tokens(access_token)

        def get_expires_in_value():
            return data_access_token_and_expires_in["expires_in"]

        def get_access_token_value():
            return data_access_token_and_expires_in["access_token"]

        data_access_token = get_access_token_value()
        return data_access_token

    except Exception as e:
        print(str(e))
        return "Error: " + str(e)


def getInfo(run):
    token=get_token()
    headers = {"Authorization": "Bearer %s" % (token)}
    url=("https://cmsoms.cern.ch/agg/api/v1/runs?filter[run_number][eq]=%d&fields=b_field,duration,last_lumisection_number" % (run))
    data=requests.get(url,headers=headers,verify=False).json()
    bfield=data["data"][0]["attributes"]["b_field"]
    duration=data["data"][0]["attributes"]["duration"]
    lastLS=data["data"][0]["attributes"]["last_lumisection_number"]
    return (bfield,duration,lastLS)

def getDuration(run):
    token=get_token()
    headers = {"Authorization": "Bearer %s" % (token)}
    url=("https://cmsoms.cern.ch/agg/api/v1/runs?filter[run_number][eq]=%d&fields=b_field,duration,last_lumisection_number" % (run))
    data=requests.get(url,headers=headers,verify=False).json()
    duration=data["data"][0]["attributes"]["duration"]
    return duration
