FROM alpine:3.12 as base

WORKDIR /opt
COPY . .
RUN apk add --no-cache bash

ENTRYPOINT /opt/entrypoint.sh
