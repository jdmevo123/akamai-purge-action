FROM alpine:latest

LABEL "com.github.actions.name"="Akamai Purge Cache"
LABEL "com.github.actions.description"="Purge cache via the Akamai API"
LABEL "com.github.actions.icon"="trash-2"
LABEL "com.github.actions.color"="orange"

LABEL version="0.1.0"
LABEL repository="https://github.com/jdmevo123/akamai-purge-action"
LABEL homepage=""
LABEL maintainer="Dale Lenard <dale_lenard@outlook.com>"

RUN apk update && apk add --no-cache git bash python3 python3-dev wget jq openssl openssl-dev curl libffi libffi-dev util-linux 
RUN pip3 install --upgrade pip
RUN pip3 install httpie-edgegrid

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
