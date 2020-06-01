#FROM python:latest
FROM python:3-slim AS builder

#LABEL "com.github.actions.name"="Akamai Purge Cache"
#LABEL "com.github.actions.description"="Purge cache via the Akamai API"
#LABEL "com.github.actions.icon"="trash-2"
#LABEL "com.github.actions.color"="orange"

#LABEL version="0.1.0"
#LABEL repository="https://github.com/jdmevo123/akamai-purge-action"
#LABEL homepage=""
#LABEL maintainer="Dale Lenard <dale_lenard@outlook.com>"

ADD . /app
WORKDIR /app
# We are installing a dependency here directly into our app source dir
RUN pip install --target=/app -r requirements.txt
FROM gcr.io/distroless/python3-debian10
COPY --from=builder /app /app
# WORKDIR /usr/local/bin
ADD akamai.py /akamai.py
CMD ["/akamai.py"]
