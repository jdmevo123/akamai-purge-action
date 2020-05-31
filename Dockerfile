FROM alpine:latest

LABEL "com.github.actions.name"="Akamai Purge Cache"
LABEL "com.github.actions.description"="Purge cache via the Akamai API"
LABEL "com.github.actions.icon"="trash-2"
LABEL "com.github.actions.color"="orange"

LABEL version="0.1.0"
LABEL repository="https://github.com/jdmevo123/akamai-purge-action"
LABEL homepage=""
LABEL maintainer="Dale Lenard <dale_lenard@outlook.com>"

RUN apk add --no-cache --virtual .build-deps g++ python3-dev py3-pip libffi-dev openssl-dev git curl bash jq wget util-linux py3-setuptools && \
    apk add --no-cache --update python3 && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    pip3 install --upgrade pip setuptools
RUN pip3 install httpie-edgegrid

#Write Edgerc File
CMD touch ~/.edgerc
RUN echo "[default]" >> .edgerc
RUN echo "client_secret=$secret" >> .edgerc
RUN echo "host=$host" >> .edgerc
RUN echo "access_token=$access_token" >> .edgerc
RUN echo "client_token=$client_token" >> .edgerc
RUN echo $(ls -1 ~/.edgerc)

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
