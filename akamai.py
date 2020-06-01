import requests
import os
import json
#from urlparse import urljoin
from urllib.parse import urljoin
from akamai.edgegrid import EdgeGridAuth, EdgeRc

#Setup API Client
edge_session = requests.Session()
edge_session.auth = EdgeGridAuth(
    client_token=os.getenv('INPUT_CLIENT_TOKEN'),
    client_secret=os.getenv('INPUT_CLIENT_SECRET'),
    access_token=os.getenv('INPUT_ACCESS_TOKEN')
)
api_baseurl = 'https://%s' % os.getenv('INPUT_HOST')
print('-------------')
print (api_baseurl)
api_headers = {
    'Content-Type': 'application/json',
    'Accept': 'application / vnd.akamai.cps.enrollments.v4 + json'
}

#Make Request
uri = '/ccu/v3/delete/cpcode/%s' % os.getenv('INPUT_NETWORK')
data = {"objects": [970236]}
result = edge_session.post(
        urljoin(api_baseurl, '%s' % uri), json = data,headers={'Content-Type': 'application/json'})
r = result.content
print (r)
