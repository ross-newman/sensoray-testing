# Sensoray 1012 V4l2 API capture example.
Capture example using V4L API. 

8-channel frame grabber with audio capture | Model 1012 
* Simultaneously captures 8 composite video + 8 analog audio
* 8 NTSC/PAL inputs captured to YUYV, UYVY, RGB555, or RGB565
* 8 audio inputs captured to PCM
* Real-time image resize and H/V flip
* Ultra-compact footprint

 <img src="http://www.sensoray.com/assets/images/1012_photo.jpg" alt="Sensoray 1012"> 

This example is based on the V4L2 capture example and has been modified to work with the Sensoray 1012 mini PCIe capture card.
This was tested on the Nvidia Jetson AGX Xavier SoM.

## Building
To build the example using gcc:
 gcc capture.c -lv4l2 -o capture
 
## Execution
To capture 100 frames and pipe them to a file use:
 ./capture -d /dev/video1 -f -c 100 -o > input.yuv
 
## Testing
To rebuild and run a simple test script is provided [capture-test.sh](capture-test.sh).

The test platform was the Nvidia Jetson AGX Xavier with the framegrabber installed into the PCIe slot. For testing the [StarTech PCIe to mPCIe](https://www.startech.com/uk/Cards-Adapters/Slot-Extension/PCI-Express-to-Mini-PCI-Express-Card-Adapter~PEX2MPEX) interposer was used.

Decode .yuv file with vlc:
 vlc --demux rawvideo --rawvid-fps 25 --rawvid-width 704 --rawvid-height 576 --rawvid-chroma UYVY input.yuv  

Decode .yuv file with Gstreamer1.0:
 gst-launch-1.0 filesrc location=./input.yuv ! videoparse height=576 width=704 format=uyvy framerate=1/25 ! queue ! videoconvert ! xvimagesink sync=false

## Probing
You can probe your capture interfaces using v4l2-ctl, I was using PAL cameras:
```
nvidia@jetson-0423418010151:~/sensoray$ v4l2-ctl -d /dev/video1 -D -V
Driver Info (not using libv4l2):
	Driver name   : TW6869
	Card type     : TW6869
	Bus info      : PCI:0003:01:00.0
	Driver version: 4.9.108
	Capabilities  : 0x85200001
		Video Capture
		Read/Write
		Streaming
		Extended Pix Format
		Device Capabilities
	Device Caps   : 0x05200001
		Video Capture
		Read/Write
		Streaming
		Extended Pix Format
Format Video Capture:
	Width/Height      : 704/576
	Pixel Format      : 'YUYV'
	Field             : Interlaced
	Bytes per Line    : 1408
	Size Image        : 811008
	Colorspace        : SMPTE 170M
	Transfer Function : Default (maps to Rec. 709)
	YCbCr/HSV Encoding: Default (maps to ITU-R 601)
	Quantization      : Default (maps to Limited Range)
	Flags             : 
```
# Links
* http://www.sensoray.com
* http://www.sensoray.com/products/1012.htm
