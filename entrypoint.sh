#!/bin/sh

set -e

######## Check for Environment parameters. ########
# Check if section is set.
if [ -z "$section" ]; then
  echo "section is not set. Quitting."
  exit 1
fi

# Check if domain is set.
if [ -z "$domain" ]; then
  echo "domain is not set. Quitting."
  exit 1
fi

# Check if action is set.
if [ -z "$action" ]; then
  echo "action is not set. Quitting."
  exit 1
fi

# Check if purge type is set.
if [ -z "$purge_type" ]; then
  echo "purge type is not set. Quitting."
  exit 1
fi

# Check if objects is set.
if [ -z "$objects" ]; then
  echo "objects is not set. Quitting."
  exit 1
fi

# If URL array is passed, only purge those. Otherwise, purge everything.
if [ -n "$PURGE_URLS" ]; then
  set -- --data '{"files":'"${PURGE_URLS}"'}'
else
  set -- --data '{"purge_everything":true}'
fi


######## Call the API and store the response for later. ########
if [ "$API_METHOD" -eq 1 ]; then
  HTTP_RESPONSE=$(http -a ${section}: POST :/ccu/v2/queues/default \
                  objects:=${objects} \
                  action=${action} type=${purge_type} domain=${domain})
fi

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
