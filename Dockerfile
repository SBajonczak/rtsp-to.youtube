FROM jrottenberg/ffmpeg
#MAINTAINER Sascha Bajonczak <xbeejayx@hotmail.com>
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh $@