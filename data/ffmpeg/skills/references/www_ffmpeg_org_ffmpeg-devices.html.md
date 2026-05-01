* [![FFmpeg](img/ffmpeg3d_white_20.png)
  FFmpeg](.)
* [About](about.html)
* [News](index.html#news)
* [Download](download.html)
* [Documentation](documentation.html)
* [Community](community.html)
  + [Code of Conduct](community.html#Code-of-Conduct)
  + [Mailing Lists](contact.html#MailingLists)
  + [IRC](contact.html#IRCChannels)
  + [Forums](contact.html#Forums)
  + [Bug Reports](bugreports.html)
  + [Wiki](https://trac.ffmpeg.org)
  + [Conferences](https://trac.ffmpeg.org/wiki/Conferences)
* [Developers](developer.html)
  + [Source Code](download.html#get-sources)+ [Contribute](developer.html#Introduction)
    + [FATE](http://fate.ffmpeg.org)
    + [Code Coverage](http://coverage.ffmpeg.org)
    + [Funding through SPI](spi.html)
* More
  + [Donate](donations.html)
  + [Hire Developers](consulting.html)
  + [Contact](contact.html)
  + [Security](security.html)
  + [Legal](legal.html)

# FFmpeg Devices Documentation

## Table of Contents

* [1 Description](#Description)
* [2 Device Options](#Device-Options)
* [3 Input Devices](#Input-Devices)
  + [3.1 alsa](#alsa)
    - [3.1.1 Options](#Options)
  + [3.2 android\_camera](#android_005fcamera)
    - [3.2.1 Options](#Options-1)
  + [3.3 avfoundation](#avfoundation)
    - [3.3.1 Options](#Options-2)
    - [3.3.2 Examples](#Examples)
  + [3.4 decklink](#decklink)
    - [3.4.1 Options](#Options-3)
    - [3.4.2 Examples](#Examples-1)
  + [3.5 dshow](#dshow)
    - [3.5.1 Options](#Options-4)
    - [3.5.2 Examples](#Examples-2)
  + [3.6 fbdev](#fbdev)
    - [3.6.1 Options](#Options-5)
  + [3.7 gdigrab](#gdigrab)
    - [3.7.1 Options](#Options-6)
  + [3.8 iec61883](#iec61883)
    - [3.8.1 Options](#Options-7)
    - [3.8.2 Examples](#Examples-3)
  + [3.9 jack](#jack)
    - [3.9.1 Options](#Options-8)
  + [3.10 kmsgrab](#kmsgrab)
    - [3.10.1 Options](#Options-9)
    - [3.10.2 Examples](#Examples-4)
  + [3.11 lavfi](#lavfi)
    - [3.11.1 Options](#Options-10)
    - [3.11.2 Examples](#Examples-5)
  + [3.12 libcdio](#libcdio)
    - [3.12.1 Options](#Options-11)
  + [3.13 libdc1394](#libdc1394)
    - [3.13.1 Options](#Options-12)
  + [3.14 openal](#openal)
    - [3.14.1 Options](#Options-13)
    - [3.14.2 Examples](#Examples-6)
  + [3.15 oss](#oss)
    - [3.15.1 Options](#Options-14)
  + [3.16 pulse](#pulse)
    - [3.16.1 Options](#Options-15)
    - [3.16.2 Examples](#Examples-7)
  + [3.17 sndio](#sndio)
    - [3.17.1 Options](#Options-16)
  + [3.18 video4linux2, v4l2](#video4linux2_002c-v4l2)
    - [3.18.1 Options](#Options-17)
  + [3.19 vfwcap](#vfwcap)
    - [3.19.1 Options](#Options-18)
  + [3.20 x11grab](#x11grab)
    - [3.20.1 Options](#Options-19)
* [4 Output Devices](#Output-Devices)
  + [4.1 alsa](#alsa-1)
    - [4.1.1 Examples](#Examples-8)
  + [4.2 AudioToolbox](#AudioToolbox)
    - [4.2.1 Options](#Options-20)
    - [4.2.2 Examples](#Examples-9)
  + [4.3 caca](#caca)
    - [4.3.1 Options](#Options-21)
    - [4.3.2 Examples](#Examples-10)
  + [4.4 decklink](#decklink-1)
    - [4.4.1 Options](#Options-22)
    - [4.4.2 Examples](#Examples-11)
  + [4.5 fbdev](#fbdev-1)
    - [4.5.1 Options](#Options-23)
    - [4.5.2 Examples](#Examples-12)
  + [4.6 oss](#oss-1)
  + [4.7 pulse](#pulse-1)
    - [4.7.1 Options](#Options-24)
    - [4.7.2 Examples](#Examples-13)
  + [4.8 sndio](#sndio-1)
  + [4.9 v4l2](#v4l2)
  + [4.10 xv](#xv)
    - [4.10.1 Options](#Options-25)
    - [4.10.2 Examples](#Examples-14)
* [5 See Also](#See-Also)
* [6 Authors](#Authors)

## [1 Description](#toc-Description)

This document describes the input and output devices provided by the
libavdevice library.

## [2 Device Options](#toc-Device-Options)

The libavdevice library provides the same interface as
libavformat. Namely, an input device is considered like a demuxer, and
an output device like a muxer, and the interface and generic device
options are the same provided by libavformat (see the ffmpeg-formats
manual).

In addition each input or output device may support so-called private
options, which are specific for that component.

Options may be set by specifying -option value in the
FFmpeg tools, or by setting the value explicitly in the device
`AVFormatContext` options or using the `libavutil/opt.h` API
for programmatic use.

## [3 Input Devices](#toc-Input-Devices)

Input devices are configured elements in FFmpeg which enable accessing
the data coming from a multimedia device attached to your system.

When you configure your FFmpeg build, all the supported input devices
are enabled by default. You can list all available ones using the
configure option "–list-indevs".

You can disable all the input devices using the configure option
"–disable-indevs", and selectively enable an input device using the
option "–enable-indev=INDEV", or you can disable a particular
input device using the option "–disable-indev=INDEV".

The option "-devices" of the ff\* tools will display the list of
supported input devices.

A description of the currently available input devices follows.

### [3.1 alsa](#toc-alsa)

ALSA (Advanced Linux Sound Architecture) input device.

To enable this input device during configuration you need libasound
installed on your system.

This device allows capturing from an ALSA device. The name of the
device to capture has to be an ALSA card identifier.

An ALSA identifier has the syntax:

```
hw:CARD[,DEV[,SUBDEV]]
```

where the DEV and SUBDEV components are optional.

The three arguments (in order: CARD,DEV,SUBDEV)
specify card number or identifier, device number and subdevice number
(-1 means any).

To see the list of cards currently recognized by your system check the
files `/proc/asound/cards` and `/proc/asound/devices`.

For example to capture with `ffmpeg` from an ALSA device with
card id 0, you may run the command:

```
ffmpeg -f alsa -i hw:0 alsaout.wav
```

For more information see:
<http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html>

#### [3.1.1 Options](#toc-Options)

`sample_rate`
:   Set the sample rate in Hz. Default is 48000.

`channels`
:   Set the number of channels. Default is 2.

### [3.2 android\_camera](#toc-android_005fcamera)

Android camera input device.

This input devices uses the Android Camera2 NDK API which is
available on devices with API level 24+. The availability of
android\_camera is autodetected during configuration.

This device allows capturing from all cameras on an Android device,
which are integrated into the Camera2 NDK API.

The available cameras are enumerated internally and can be selected
with the camera\_index parameter. The input file string is
discarded.

Generally the back facing camera has index 0 while the front facing
camera has index 1.

#### [3.2.1 Options](#toc-Options-1)

`video_size`
:   Set the video size given as a string such as 640x480 or hd720.
    Falls back to the first available configuration reported by
    Android if requested video size is not available or by default.

`framerate`
:   Set the video framerate.
    Falls back to the first available configuration reported by
    Android if requested framerate is not available or by default (-1).

`camera_index`
:   Set the index of the camera to use. Default is 0.

`input_queue_size`
:   Set the maximum number of frames to buffer. Default is 5.

### [3.3 avfoundation](#toc-avfoundation)

AVFoundation input device.

AVFoundation is the currently recommended framework by Apple for streamgrabbing on OSX >= 10.7 as well as on iOS.

The input filename has to be given in the following syntax:

```
-i "[[VIDEO]:[AUDIO]]"
```

The first entry selects the video input while the latter selects the audio input.
The stream has to be specified by the device name or the device index as shown by the device list.
Alternatively, the video and/or audio input device can be chosen by index using the
`-video_device_index <INDEX>`
and/or
`-audio_device_index <INDEX>`
, overriding any
device name or index given in the input filename.

All available devices can be enumerated by using `-list_devices true`, listing
all device names and corresponding indices.

There are two device name aliases:

`default`
:   Select the AVFoundation default device of the corresponding type.

`none`
:   Do not record the corresponding media type.
    This is equivalent to specifying an empty device name or index.

#### [3.3.1 Options](#toc-Options-2)

AVFoundation supports the following options:

`-list_devices <TRUE|FALSE>`
:   If set to true, a list of all available input devices is given showing all
    device names and indices.

`-video_device_index <INDEX>`
:   Specify the video device by its index. Overrides anything given in the input filename.

`-audio_device_index <INDEX>`
:   Specify the audio device by its index. Overrides anything given in the input filename.

`-pixel_format <FORMAT>`
:   Request the video device to use a specific pixel format.
    If the specified format is not supported, a list of available formats is given
    and the first one in this list is used instead. Available pixel formats are:
    `monob, rgb555be, rgb555le, rgb565be, rgb565le, rgb24, bgr24, 0rgb, bgr0, 0bgr, rgb0,
    bgr48be, uyvy422, yuva444p, yuva444p16le, yuv444p, yuv422p16, yuv422p10, yuv444p10,
    yuv420p, nv12, yuyv422, gray`

`-framerate`
:   Set the grabbing frame rate. Default is `ntsc`, corresponding to a
    frame rate of `30000/1001`.

`-video_size`
:   Set the video frame size.

`-capture_cursor`
:   Capture the mouse pointer. Default is 0.

`-capture_mouse_clicks`
:   Capture the screen mouse clicks. Default is 0.

`-capture_raw_data`
:   Capture the raw device data. Default is 0.
    Using this option may result in receiving the underlying data delivered to the AVFoundation framework. E.g. for muxed devices that sends raw DV data to the framework (like tape-based camcorders), setting this option to false results in extracted video frames captured in the designated pixel format only. Setting this option to true results in receiving the raw DV stream untouched.

#### [3.3.2 Examples](#toc-Examples)

* Print the list of AVFoundation supported devices and exit:

  ```
  $ ffmpeg -f avfoundation -list_devices true -i ""
  ```
* Record video from video device 0 and audio from audio device 0 into out.avi:

  ```
  $ ffmpeg -f avfoundation -i "0:0" out.avi
  ```
* Record video from video device 2 and audio from audio device 1 into out.avi:

  ```
  $ ffmpeg -f avfoundation -video_device_index 2 -i ":1" out.avi
  ```
* Record video from the system default video device using the pixel format bgr0 and do not record any audio into out.avi:

  ```
  $ ffmpeg -f avfoundation -pixel_format bgr0 -i "default:none" out.avi
  ```
* Record raw DV data from a suitable input device and write the output into out.dv:

  ```
  $ ffmpeg -f avfoundation -capture_raw_data true -i "zr100:none" out.dv
  ```

### [3.4 decklink](#toc-decklink)

The decklink input device provides capture capabilities for Blackmagic
DeckLink devices.

To enable this input device, you need the Blackmagic DeckLink SDK and you
need to configure with the appropriate `--extra-cflags`
and `--extra-ldflags`.
On Windows, you need to run the IDL files through `widl`.

DeckLink is very picky about the formats it supports. Pixel format of the
input can be set with `raw_format`.
Framerate and video size must be determined for your device with
`-list_formats 1`. Audio sample rate is always 48 kHz and the number
of channels can be 2, 8 or 16. Note that all audio channels are bundled in one single
audio track.

#### [3.4.1 Options](#toc-Options-3)

`list_devices`
:   If set to `true`, print a list of devices and exit.
    Defaults to `false`. This option is deprecated, please use the
    `-sources` option of ffmpeg to list the available input devices.

`list_formats`
:   If set to `true`, print a list of supported formats and exit.
    Defaults to `false`.

`format_code <FourCC>`
:   This sets the input video format to the format given by the FourCC. To see
    the supported values of your device(s) use `list_formats`.
    Note that there is a FourCC `'pal '` that can also be used
    as `pal` (3 letters).
    Default behavior is autodetection of the input video format, if the hardware
    supports it.

`raw_format`
:   Set the pixel format of the captured video.
    Available values are:

    ‘`auto`’
    :   This is the default which means 8-bit YUV 422 or 8-bit ARGB if format
        autodetection is used, 8-bit YUV 422 otherwise.

    ‘`uyvy422`’
    :   8-bit YUV 422.

    ‘`yuv422p10`’
    :   10-bit YUV 422.

    ‘`argb`’
    :   8-bit RGB.

    ‘`bgra`’
    :   8-bit RGB.

    ‘`rgb10`’
    :   10-bit RGB.

`teletext_lines`
:   If set to nonzero, an additional teletext stream will be captured from the
    vertical ancillary data. Both SD PAL (576i) and HD (1080i or 1080p)
    sources are supported. In case of HD sources, OP47 packets are decoded.

    This option is a bitmask of the SD PAL VBI lines captured, specifically lines 6
    to 22, and lines 318 to 335. Line 6 is the LSB in the mask. Selected lines
    which do not contain teletext information will be ignored. You can use the
    special `all` constant to select all possible lines, or
    `standard` to skip lines 6, 318 and 319, which are not compatible with
    all receivers.

    For SD sources, ffmpeg needs to be compiled with `--enable-libzvbi`. For
    HD sources, on older (pre-4K) DeckLink card models you have to capture in 10
    bit mode.

`channels`
:   Defines number of audio channels to capture. Must be ‘`2`’, ‘`8`’ or ‘`16`’.
    Defaults to ‘`2`’.

`duplex_mode`
:   Sets the decklink device duplex/profile mode. Must be ‘`unset`’, ‘`half`’, ‘`full`’,
    ‘`one_sub_device_full`’, ‘`one_sub_device_half`’, ‘`two_sub_device_full`’,
    ‘`four_sub_device_half`’
    Defaults to ‘`unset`’.

    Note: DeckLink SDK 11.0 have replaced the duplex property by a profile property.
    For the DeckLink Duo 2 and DeckLink Quad 2, a profile is shared between any 2
    sub-devices that utilize the same connectors. For the DeckLink 8K Pro, a profile
    is shared between all 4 sub-devices. So DeckLink 8K Pro support four profiles.

    Valid profile modes for DeckLink 8K Pro(with DeckLink SDK >= 11.0):
    ‘`one_sub_device_full`’, ‘`one_sub_device_half`’, ‘`two_sub_device_full`’,
    ‘`four_sub_device_half`’

    Valid profile modes for DeckLink Quad 2 and DeckLink Duo 2:
    ‘`half`’, ‘`full`’

`timecode_format`
:   Timecode type to include in the frame and video stream metadata. Must be
    ‘`none`’, ‘`rp188vitc`’, ‘`rp188vitc2`’, ‘`rp188ltc`’,
    ‘`rp188hfr`’, ‘`rp188any`’, ‘`vitc`’, ‘`vitc2`’, or ‘`serial`’.
    Defaults to ‘`none`’ (not included).

    In order to properly support 50/60 fps timecodes, the ordering of the queried
    timecode types for ‘`rp188any`’ is HFR, VITC1, VITC2 and LTC for >30 fps
    content. Note that this is slightly different to the ordering used by the
    DeckLink API, which is HFR, VITC1, LTC, VITC2.

`video_input`
:   Sets the video input source. Must be ‘`unset`’, ‘`sdi`’,