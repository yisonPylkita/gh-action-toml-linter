FROM alpine:3.13.1 as base

RUN wget -q -P /usr/bin https://raw.githubusercontent.com/yisonPylkita/gh-action-toml-linter/master/taplo_bin/taplo
COPY entrypoint.sh entrypoint.sh

CMD ["./entrypoint.sh"]
