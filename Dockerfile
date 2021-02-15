FROM alpine:3.13.1 as base

WORKDIR /opt
COPY . .
RUN apk add --no-cache bash

ENTRYPOINT /opt/entrypoint.sh
