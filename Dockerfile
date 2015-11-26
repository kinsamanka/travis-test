FROM debian:jessie
RUN mkdir /data
VOLUME /data
ENTRYPOINT /usr/bin/tail -f /dev/null