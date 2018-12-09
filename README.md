# sensoray-testing
Capture example using V4L API. 

8-channel frame grabber with audio capture | Model 1012 
* Simultaneously captures 8 composite video + 8 analog audio
* 8 NTSC/PAL inputs captured to YUYV, UYVY, RGB555, or RGB565
* 8 audio inputs captured to PCM
* Real-time image resize and H/V flip
* Ultra-compact footprint

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

# Links
* http://www.sensoray.com
* http://www.sensoray.com/products/1012.htm
