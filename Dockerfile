FROM akamai/purge

LABEL "com.github.actions.name"="Akamai Purge Cache"
LABEL "com.github.actions.description"="Purge cache via the Akamai API"
LABEL "com.github.actions.icon"="trash-2"
LABEL "com.github.actions.color"="orange"

LABEL version="0.1.0"
LABEL repository="https://github.com/jdmevo123/akamai-purge-action"
LABEL homepage=""
LABEL maintainer="Dale Lenard <dale_lenard@outlook.com>"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
