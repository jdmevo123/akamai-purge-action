#!/bin/sh

set -e

######## Check for Environment parameters. ########
echo ">>>> ENVIRONMENT VARIABLES"
env
echo "CP Code coming through"
echo $cp_code
# Check if cp codes is set.
if [ -z "$cp_code" ]; then
  echo "cp codes are not set. Quitting."
  exit 1
fi
if [ "$cp_code" != '970236' ]; then
  echo "cp code is not 970236"
  exit 1
fi
# # If URL array is passed, only purge those. Otherwise, purge everything.
# if [ -n "$PURGE_URLS" ]; then
#   set -- --data '{"files":'"${PURGE_URLS}"'}'
# else
#   set -- --data '{"purge_everything":true}'
# fi


######## Call the API and store the response for later. ########
HTTP_RESPONSE=$(python /usr/bin/akamai.py)

######## Poll for purge success ########
#progressUri = $(echo "${HTTP_RESPONSE}" | jq -r '.progressUri')

######## Format response for a pretty command line output. ########

# Store result and HTTP status code separately to appropriately throw CI errors.
HTTP_BODY=$(echo "${HTTP_RESPONSE}" | sed -E 's/HTTP_STATUS\:[0-9]{3}$//')
HTTP_STATUS=$(echo "${HTTP_RESPONSE}" | tr -d '\n' | sed -E 's/.*HTTP_STATUS:([0-9]{3})$/\1/')

# Fail pipeline and print errors if API doesn't return an OK status.
if [ "${HTTP_STATUS}" -eq "201" ]; then
  echo "Successfully purged!"
  exit 0
else
  echo "Purge failed. API response was: "
  echo "${HTTP_BODY}"
  exit 1
fi
