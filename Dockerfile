FROM alpine:3.13.1 as base

RUN wget -P /usr/local/bin https://raw.githubusercontent.com/yisonPylkita/gh-action-toml-linter/master/taplo_bin/taplo
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
