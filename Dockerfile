FROM alpine:3.17.6 as base

WORKDIR /opt
COPY . .
RUN apk add --no-cache bash

ENTRYPOINT /opt/entrypoint.sh
