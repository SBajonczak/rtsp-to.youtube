FROM jrottenberg/ffmpeg
MAINTAINER Sascha Bajonczak <xbeejayx@hotmail.com>
COPY ./* /
RUN apt-get update && apt-get install -y coreutils && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt
ENTRYPOINT /entrypoint.sh $@