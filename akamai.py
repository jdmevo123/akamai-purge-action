import requests
import os
import json
#from urlparse import urljoin
from urllib.parse import urljoin
from akamai.edgegrid import EdgeGridAuth, EdgeRc

#Setup API Client
edge_session = requests.Session()
edge_session.auth = EdgeGridAuth(
    client_token=os.getenv('client_token'),
    client_secret=os.getenv('secret'),
    access_token=os.getenv('access_token')
)
api_baseurl = 'https://%s' % os.getenv('host')
print('-------------')
print (os.getenv('host'))
api_headers = {
    'Content-Type': 'application/json',
    'Accept': 'application / vnd.akamai.cps.enrollments.v4 + json'
}

#Make Request
uri = '/ccu/v3/delete/cpcode/%s' % os.getenv('network')
data = {"objects": [os.getenv('cp_code')]}
result = edge_session.post(
        urljoin(api_baseurl, '%s' % uri), json = data,headers={'Content-Type': 'application/json'})
r = result.content
print (r)
