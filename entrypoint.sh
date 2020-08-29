#!/bin/sh -l
set -e
set -o pipefail

_CLI_COMMAND=$1
_PURGE_TYPE=$2
_PURGE_REF=$3


case ${_PURGE_TYPE} in
  cpcode)
    _CLI_OPT="--cpcode"
  ;;

  tag)
    _CLI_OPT="--tag"
  ;;

  *)
    echo "Unknown ${_PURGE_TYPE} ... exiting"
    exit 123
  ;;
esac

# Create /root/.edgerc file from env variable
echo -e "${EDGERC}" > /root/.edgerc

# Send purge request
akamai purge \
  --edgerc /root/.edgerc \
  --section ccu \
  ${_CLI_COMMAND} \
  ${_CLI_OPT} "${_PURGE_REF}"
