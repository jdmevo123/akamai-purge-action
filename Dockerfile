FROM alpine:latest

LABEL "com.github.actions.name"="Akamai Purge Cache"
LABEL "com.github.actions.description"="Purge cache via the Akamai API"
LABEL "com.github.actions.icon"="trash-2"
LABEL "com.github.actions.color"="orange"

LABEL version="0.1.0"
LABEL repository="https://github.com/jdmevo123/akamai-purge-action"
LABEL homepage=""
LABEL maintainer="Dale Lenard <dale_lenard@outlook.com>"

RUN apk upgrade --no-cache \
  && apk add --no-cache \
    git \
    bash \
    openssl \
    openssl-dev \
    curl \
    build-base \
    libzmq3-dev \
    python3 \
    python3-dev \
    python3-pip \
    bash \
    wget \
    jq \
    libffi \
    libffi-dev \
    util-linux \
  && pip3 install  --upgrade pip \
  && pip3 install --no-cache-dir httpie-edgegrid \
  && rm -rf /var/cache/* \
  && rm -rf /root/.cache/*

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
