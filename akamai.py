import requests
from akamai.edgegrid import EdgeGridAuth, EdgeRc

#Setup API Client
edge_session = requests.Session()
edge_session.auth = EdgeGridAuth(
    client_token="$client_token",
    client_secret="$client_secret",
    access_token="$access_token"
)
api_baseurl = 'https://%s' % "$host"
api_headers = {
    'Content-Type': 'application/json',
    'Accept': 'application / vnd.akamai.cps.enrollments.v4 + json'
}

#Make Request
uri = '/ccu/v3/delete/cpcode/%s' % "$network"
PARAMS = {"objects": [$cp_code]}
result = edge_session.post(
        urljoin(api_baseurl, '%s' % uri),
        headers={'Content-Type': 'application/json'}, data = PARAMS)
r = result.content
print (r)
