import requests
import os
import sys
import json
#from urlparse import urljoin
from urllib.parse import urljoin
from akamai.edgegrid import EdgeGridAuth, EdgeRc

#Setup API Client
edge_session = requests.Session()
edge_session.auth = EdgeGridAuth(
    client_token=os.environ('client_token'),
    client_secret=os.environ('secret'),
    access_token=os.environ('access_token')
)
api_baseurl = 'https://%s' % os.environ('host')
print('-------------')
print (os.environ('host'))
api_headers = {
    'Content-Type': 'application/json',
    'Accept': 'application / vnd.akamai.cps.enrollments.v4 + json'
}

#Make Request
uri = '/ccu/v3/delete/cpcode/%s' % os.environ('network')
data = {"objects": [os.environ('cp_code')]}
result = edge_session.post(
        urljoin(api_baseurl, '%s' % uri), json = data,headers={'Content-Type': 'application/json'})
r = result.content
print (r)
