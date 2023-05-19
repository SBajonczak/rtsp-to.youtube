#!/bin/sh
if [ "$#" -lt 2 ]; then
  >&2 echo "Arguments: IP_CAMERA_ADDRESS LIVE_ID [TIMELAPSE_ID]"
  exit 1
fi

if [ ! -d /data ]; then
  >&2 echo "Expected Docker mounted volume at /data for recordings"
  exit 1
fi
cd /data

IP_CAMERA_ADDRESS=$1
LIVE_ID=$2

>&2 echo "IP_CAMERA_ADDRESS=$IP_CAMERA_ADDRESS"
>&2 echo "LIVE_ID=$LIVE_ID"

## Note: YouTube will not accept a stream without audio, even if there is none
## Getting audio from /dev/zero to fill it in with something

exec ffmpeg \
  -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
  -thread_queue_size 128 -i $IP_CAMERA_ADDRESS \
  -shortest \
  -vf "fps=30" \
  -map 0:a:0 -c:a aac -b:a 16k \
  -map 1:v:0 -c:v libx264 -preset veryfast -crf 30 -g 90 \
  -f flv rtmp://a.rtmp.youtube.com/live2/$LIVE_ID \
  -f segment -reset_timestamps 1 -segment_time 600 -segment_format mp4 -segment_atclocktime 1 -strftime 1 \
    "%Y-%m-%d_%H-%M-%S.mp4"