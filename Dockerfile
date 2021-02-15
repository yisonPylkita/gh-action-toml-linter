FROM alpine:3.13.1 as base

WORKDIR /opt
COPY . .
RUN apk add --no-cache bash git

ENTRYPOINT bash /opt/entrypoint.sh
