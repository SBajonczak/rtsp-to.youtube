#!/bin/sh

if [ "$#" -ne 3 ]; then
  >&2 echo "Required arguments: YOUTUBE_STREAM_URL DURATION_IN_SECONDS DURATION_IN_SECONDS_TO_WAIT"
  exit 1
fi

# -f 93 is for 360p stream
YOUTUBE_STREAM_URL=$1
DURATION_IN_SECONDS=$2
DURATION_IN_SECONDS_TO_WAIT=$3
echo "YOUTUBE_STREAM_URL=$YOUTUBE_STREAM_URL"
echo "DURATION_IN_SECONDS=$DURATION_IN_SECONDS"
echo "DURATION_IN_SECONDS_TO_WAIT=$DURATION_IN_SECONDS_TO_WAIT"

while :
do
  echo "Downloading video for 5 seconds"
  URL=$(youtube-dl -g -f 93 $YOUTUBE_STREAM_URL)
  echo "Stream internal address(es): $URL"
  echo "$URL" | xargs -n 1 -I {} ffmpeg -t $DURATION_IN_SECONDS -i "{}" -f null -
  echo "Waiting for $DURATION_IN_SECONDS_TO_WAIT seconds"
  sleep $DURATION_IN_SECONDS_TO_WAIT
  rm /data/*.*
done