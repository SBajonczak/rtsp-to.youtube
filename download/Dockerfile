# Usage docker run -it --restart=always -v /etc/localtime:/etc/localtime  beejay/stream.downloader -- https://youtube.com/live/0qPRKqRp-ys 5 120
FROM jrottenberg/ffmpeg
MAINTAINER Sascha Bajonczaj <xbeejayx@hotmail.com>
ADD entrypoint.sh /entrypoint.sh
RUN apt-get update && apt-get install -y wget python && \
    wget https://yt-dl.org/downloads/latest/youtube-dl  --no-check-certificate -O /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt
ENTRYPOINT /entrypoint.sh $@