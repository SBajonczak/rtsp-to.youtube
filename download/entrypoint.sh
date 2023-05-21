#!/bin/sh

if [ "$#" -ne 1 ]; then
  >&2 echo "Required arguments: YOUTUBE_STREAM_URL"
  exit 1
fi

if [ ! -d /data ]; then
  >&2 echo "Expected Docker mounted volume at /data"
  exit 1
fi
cd /data

YOUTUBE_STREAM_URL=$1
echo "YOUTUBE_STREAM_URL=$YOUTUBE_STREAM_URL"

while :
do
  echo "Downloading video for 5 seconds"
  # option -f 93 is for 360p stream
  URL=$(youtube-dl -g -f 93 $YOUTUBE_STREAM_URL)
  echo "Stream internal address(es): $URL"
  echo "$URL" | xargs -n 1 -I {} ffmpeg -t 5 -i "{}" -f null -
  echo "Waiting for 10 minutes"
  sleep 600