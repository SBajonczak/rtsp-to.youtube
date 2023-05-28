#!/bin/sh
if [ "$#" -lt 2 ]; then
  >&2 echo "Arguments: IP_CAMERA_ADDRESS LIVE_ID [DURATION in secondse.g. '60']"
  exit 1
fi

IP_CAMERA_ADDRESS=$1
LIVE_ID=$2
DURATION_IN_SECONDS=$3

>&2 echo "IP_CAMERA_ADDRESS=$IP_CAMERA_ADDRESS"
>&2 echo "LIVE_ID=$LIVE_ID"
>&2 echo "DURATION=$DURATION_IN_SECONDS"
  

if [ -z "$DURATION_IN_SECONDS" ]; then
  >&2 echo "Limitation diabled: running forever" 
  timeout ffmpeg -i $IP_CAMERA_ADDRESS  -vcodec copy -acodec aac  -f flv rtmp://a.rtmp.youtube.com/live2/$LIVE_ID 
else
  >&2 echo "Limitation enabled: using Limitation of $DURATION_IN_SECONDS" 
  timeout $DURATION_IN_SECONDS ffmpeg -i $IP_CAMERA_ADDRESS  -vcodec copy -acodec aac  -f flv rtmp://a.rtmp.youtube.com/live2/$LIVE_ID 
fi