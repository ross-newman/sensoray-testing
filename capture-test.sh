#!/bin/bash
WIDTH=704
HEIGHT=576

rm ./capture
rm ./input.yuv
gcc capture.c -lv4l2 -o capture
./capture -d /dev/video1 -f -o > input.yuv

# cvlc --demux rawvideo --rawvid-fps 25 --rawvid-width $WIDTH --rawvid-height $HEIGHT --rawvid-chroma UYVY input.yuv  

gst-launch-1.0 filesrc location=./input.yuv ! videoparse height=$HEIGHT width=$WIDTH format=uyvy framerate=1/25 ! queue ! videoconvert ! xvimagesink sync=false

