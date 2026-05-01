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

# FFmpeg Codecs Documentation

## Table of Contents

* [1 Description](#Description)
* [2 Codec Options](#Codec-Options)
* [3 Decoders](#Decoders)
* [4 Video Decoders](#Video-Decoders)
  + [4.1 av1](#av1)
    - [4.1.1 Options](#Options)
  + [4.2 hevc](#hevc)
    - [4.2.1 Options](#Options-1)
  + [4.3 rawvideo](#rawvideo)
    - [4.3.1 Options](#Options-2)
  + [4.4 libdav1d](#libdav1d)
    - [4.4.1 Options](#Options-3)
  + [4.5 libdavs2](#libdavs2)
  + [4.6 libuavs3d](#libuavs3d)
    - [4.6.1 Options](#Options-4)
  + [4.7 libxevd](#libxevd)
    - [4.7.1 Options](#Options-5)
  + [4.8 QSV Decoders](#QSV-Decoders)
    - [4.8.1 Common Options](#Common-Options)
    - [4.8.2 HEVC Options](#HEVC-Options)
  + [4.9 v210](#v210)
    - [4.9.1 Options](#Options-6)
* [5 Audio Decoders](#Audio-Decoders)
  + [5.1 ac3](#ac3)
    - [5.1.1 AC-3 Decoder Options](#AC_002d3-Decoder-Options)
  + [5.2 flac](#flac-1)
    - [5.2.1 FLAC Decoder options](#FLAC-Decoder-options)
  + [5.3 ffwavesynth](#ffwavesynth)
  + [5.4 libcelt](#libcelt)
  + [5.5 libgsm](#libgsm)
  + [5.6 libilbc](#libilbc)
    - [5.6.1 Options](#Options-7)
  + [5.7 libmpeghdec](#libmpeghdec)
  + [5.8 libopencore-amrnb](#libopencore_002damrnb)
  + [5.9 libopencore-amrwb](#libopencore_002damrwb)
  + [5.10 libopus](#libopus)
* [6 Subtitles Decoders](#Subtitles-Decoders)
  + [6.1 libaribb24](#libaribb24)
    - [6.1.1 libaribb24 Decoder Options](#libaribb24-Decoder-Options)
  + [6.2 libaribcaption](#libaribcaption)
    - [6.2.1 libaribcaption Decoder Options](#libaribcaption-Decoder-Options)
    - [6.2.2 libaribcaption decoder usage examples](#libaribcaption-decoder-usage-examples)
  + [6.3 dvbsub](#dvbsub)
    - [6.3.1 Options](#Options-8)
  + [6.4 dvdsub](#dvdsub)
    - [6.4.1 Options](#Options-9)
  + [6.5 libzvbi-teletext](#libzvbi_002dteletext)
    - [6.5.1 Options](#Options-10)
* [7 Encoders](#Encoders)
* [8 Audio Encoders](#Audio-Encoders)
  + [8.1 aac](#aac)
    - [8.1.1 Options](#Options-11)
  + [8.2 ac3 and ac3\_fixed](#ac3-and-ac3_005ffixed)
    - [8.2.1 AC-3 Metadata](#AC_002d3-Metadata)
      * [8.2.1.1 Metadata Control Options](#Metadata-Control-Options)
      * [8.2.1.2 Downmix Levels](#Downmix-Levels)
      * [8.2.1.3 Audio Production Information](#Audio-Production-Information)
      * [8.2.1.4 Other Metadata Options](#Other-Metadata-Options)
    - [8.2.2 Extended Bitstream Information](#Extended-Bitstream-Information)
      * [8.2.2.1 Extended Bitstream Information - Part 1](#Extended-Bitstream-Information-_002d-Part-1)
      * [8.2.2.2 Extended Bitstream Information - Part 2](#Extended-Bitstream-Information-_002d-Part-2)
    - [8.2.3 Other AC-3 Encoding Options](#Other-AC_002d3-Encoding-Options)
    - [8.2.4 Floating-Point-Only AC-3 Encoding Options](#Floating_002dPoint_002dOnly-AC_002d3-Encoding-Options)
  + [8.3 flac](#flac-2)
    - [8.3.1 Options](#Options-12)
  + [8.4 opus](#opus)
    - [8.4.1 Options](#Options-13)
  + [8.5 libfdk\_aac](#libfdk_005faac)
    - [8.5.1 Options](#Options-14)
    - [8.5.2 Examples](#Examples)
  + [8.6 liblc3](#liblc3)
    - [8.6.1 Options](#Options-15)
  + [8.7 libmp3lame](#libmp3lame-1)
    - [8.7.1 Options](#Options-16)
  + [8.8 libopencore-amrnb](#libopencore_002damrnb-1)
    - [8.8.1 Options](#Options-17)
  + [8.9 libopus](#libopus-1)
    - [8.9.1 Option Mapping](#Option-Mapping)
  + [8.10 libshine](#libshine-1)
    - [8.10.1 Options](#Options-18)
  + [8.11 libtwolame](#libtwolame)
    - [8.11.1 Options](#Options-19)
  + [8.12 libvo-amrwbenc](#libvo_002damrwbenc)
    - [8.12.1 Options](#Options-20)
  + [8.13 libvorbis](#libvorbis)
    - [8.13.1 Options](#Options-21)
  + [8.14 mjpeg](#mjpeg)
    - [8.14.1 Options](#Options-22)
  + [8.15 wavpack](#wavpack)
    - [8.15.1 Options](#Options-23)
      * [8.15.1.1 Shared options](#Shared-options)
      * [8.15.1.2 Private options](#Private-options)
* [9 Video Encoders](#Video-Encoders)
  + [9.1 a64\_multi, a64\_multi5](#a64_005fmulti_002c-a64_005fmulti5)
  + [9.2 Cinepak](#Cinepak)
    - [9.2.1 Options](#Options-24)
  + [9.3 ffv1](#ffv1-1)
    - [9.3.1 Options](#Options-25)
  + [9.4 GIF](#GIF)
    - [9.4.1 Options](#Options-26)
  + [9.5 Hap](#Hap)
    - [9.5.1 Options](#Options-27)
  + [9.6 jpeg2000](#jpeg2000)
    - [9.6.1 Options](#Options-28)
  + [9.7 librav1e](#librav1e)
    - [9.7.1 Options](#Options-29)
  + [9.8 libaom-av1](#libaom_002dav1)
    - [9.8.1 Options](#Options-30)
  + [9.9 liboapv](#liboapv)
    - [9.9.1 Options](#Options-31)
  + [9.10 libsvtav1](#libsvtav1)
    - [9.10.1 Options](#Options-32)
  + [9.11 libsvtjpegxs](#libsvtjpegxs)
    - [9.11.1 Options](#Options-33)
  + [9.12 libjxl](#libjxl)
    - [9.12.1 Options](#Options-34)
  + [9.13 libkvazaar](#libkvazaar)
    - [9.13.1 Options](#Options-35)
  + [9.14 libopenh264](#libopenh264)
    - [9.14.1 Options](#Options-36)
  + [9.15 libtheora](#libtheora)
    - [9.15.1 Options](#Options-37)
    - [9.15.2 Examples](#Examples-1)
  + [9.16 libvpx](#libvpx)
    - [9.16.1 Options](#Options-38)
  + [9.17 libvvenc](#libvvenc)
    - [9.17.1 Supported Pixel Formats](#Supported-Pixel-Formats)
    - [9.17.2 Options](#Options-39)
  + [9.18 libwebp](#libwebp)
    - [9.18.1 Pixel Format](#Pixel-Format)
    - [9.18.2 Options](#Options-40)
  + [9.19 libx264, libx264rgb](#libx264_002c-libx264rgb)
    - [9.19.1 Supported Pixel Formats](#Supported-Pixel-Formats-1)
    - [9.19.2 Options](#Options-41)
  + [9.20 libx265](#libx265)
    - [9.20.1 Options](#Options-42)
  + [9.21 libxavs2](#libxavs2)
    - [9.21.1 Options](#Options-43)
  + [9.22 libxeve](#libxeve)
    - [9.22.1 Options](#Options-44)
  + [9.23 libxvid](#libxvid)
    - [9.23.1 Options](#Options-45)
  + [9.24 MediaCodec](#MediaCodec)
  + [9.25 MediaFoundation](#MediaFoundation)
    - [9.25.1 Options](#Options-46)
    - [9.25.2 Examples](#Examples-2)
  + [9.26 Microsoft RLE](#Microsoft-RLE)
    - [9.26.1 Options](#Options-47)
  + [9.27 mpeg2](#mpeg2)
    - [9.27.1 Options](#Options-48)
  + [9.28 png](#png)
    - [9.28.1 Options](#Options-49)
    - [9.28.2 Private options](#Private-options-1)
  + [9.29 ProRes](#ProRes)
    - [9.29.1 Private Options for prores-ks](#Private-Options-for-prores_002dks)
    - [9.29.2 Speed considerations](#Speed-considerations)
  + [9.30 QSV Encoders](#QSV-Encoders)
    - [9.30.1 Ratecontrol Method](#Ratecontrol-Method)
    - [9.30.2 Global Options -> MSDK Options](#Global-Options-_002d_003e-MSDK-Options)
    - [9.30.3 Common Options](#Common-Options-1)
    - [9.30.4 Runtime Options](#Runtime-Options)
    - [9.30.5 H264 options](#H264-options)
    - [9.30.6 HEVC Options](#HEVC-Options-1)
    - [9.30.7 MPEG2 Options](#MPEG2-Options)
    - [9.30.8 VP9 Options](#VP9-Options)
    - [9.30.9 AV1 Options](#AV1-Options)
  + [9.31 snow](#snow)
    - [9.31.1 Options](#Options-50)
  + [9.32 VAAPI encoders](#VAAPI-encoders)
  + [9.33 vbn](#vbn)
    - [9.33.1 Options](#Options-51)
  + [9.34 vc2](#vc2)
    - [9.34.1 Options](#Options-52)
* [10 Subtitles Encoders](#Subtitles-Encoders)
  + [10.1 dvbsub](#dvbsub-1)
    - [10.1.1 Options](#Options-53)
  + [10.2 dvdsub](#dvdsub-1)
    - [10.2.1 Options](#Options-54)
  + [10.3 lrc](#lrc)
    - [10.3.1 Options](#Options-55)
* [11 See Also](#See-Also)
* [12 Authors](#Authors)

## [1 Description](#toc-Description)

This document describes the codecs (decoders and encoders) provided by
the libavcodec library.

## [2 Codec Options](#toc-Codec-Options)

libavcodec provides some generic global options, which can be set on
all the encoders and decoders. In addition, each codec may support
so-called private options, which are specific for a given codec.

Sometimes, a global option may only affect a specific kind of codec,
and may be nonsensical or ignored by another, so you need to be aware
of the meaning of the specified options. Also some options are
meant only for decoding or encoding.

Options may be set by specifying -option value in the
FFmpeg tools, or by setting the value explicitly in the
`AVCodecContext` options or using the `libavutil/opt.h` API
for programmatic use.

The list of supported options follow:

`b integer (encoding,audio,video)`
:   Set bitrate in bits/s. Default value is 200K.

`ab integer (encoding,audio)`
:   Set audio bitrate (in bits/s). Default value is 128K.

`bt integer (encoding,video)`
:   Set video bitrate tolerance (in bits/s). In 1-pass mode, bitrate
    tolerance specifies how far ratecontrol is willing to deviate from the
    target average bitrate value. This is not related to min/max
    bitrate. Lowering tolerance too much has an adverse effect on quality.

`flags flags (decoding/encoding,audio,video,subtitles)`
:   Set generic flags.

    Possible values:

    ‘`mv4`’
    :   Use four motion vector by macroblock (mpeg4).

    ‘`qpel`’
    :   Use 1/4 pel motion compensation.

    ‘`loop`’
    :   Use loop filter.

    ‘`qscale`’
    :   Use fixed qscale.

    ‘`pass1`’
    :   Use internal 2pass ratecontrol in first pass mode.

    ‘`pass2`’
    :   Use internal 2pass ratecontrol in second pass mode.

    ‘`gray`’
    :   Only decode/encode grayscale.

    ‘`psnr`’
    :   Set error[?] variables during encoding.

    ‘`truncated`’
    :   Input bitstream might be randomly truncated.

    ‘`drop_changed`’
    :   Don’t output frames whose parameters differ from first decoded frame in stream.
        Error AVERROR\_INPUT\_CHANGED is returned when a frame is dropped.

    ‘`ildct`’
    :   Use interlaced DCT.

    ‘`low_delay`’
    :   Force low delay.

    ‘`global_header`’
    :   Place global headers in extradata instead of every keyframe.

    ‘`bitexact`’
    :   Only write platform-, build- and time-independent data. (except (I)DCT).
        This ensures that file and data checksums are reproducible and match between
        platforms. Its primary use is for regression testing.

    ‘`aic`’
    :   Apply H263 advanced intra coding / mpeg4 ac prediction.

    ‘`ilme`’
    :   Apply interlaced motion estimation.

    ‘`cgop`’
    :   Use closed gop.

    ‘`output_corrupt`’
    :   Output even potentially corrupted frames.

`time_base rational number`
:   Set codec time base.

    It is the fundamental unit of time (in seconds) in terms of which
    frame timestamps are represented. For fixed-fps content, timebase
    should be `1 / frame_rate` and timestamp increments should be
    identically 1.

`g integer (encoding,video)`
:   Set the group of picture (GOP) size. Default value is 12.

`ar integer (decoding/encoding,audio)`
:   Set audio sampling rate (in Hz).

`ac integer (decoding/encoding,audio)`
:   Set number of audio channels.

`cutoff integer (encoding,audio)`
:   Set cutoff bandwidth. (Supported only by selected encoders, see
    their respective documentation sections.)

`frame_size integer (encoding,audio)`
:   Set audio frame size.

    Each submitted frame except the last must contain exactly frame\_size
    samples per channel. May be 0 when the codec has
    CODEC\_CAP\_VARIABLE\_FRAME\_SIZE set, in that case the frame size is not
    restricted. It is set by some decoders to indicate constant frame
    size.

`frame_number integer`
:   Set the frame number.

`delay integer`

`qcomp float (encoding,video)`
:   Set video quantizer scale compression (VBR). It is used as a constant
    in the ratecontrol equation. Recommended range for default rc\_eq:
    0.0-1.0.

`qblur float (encoding,video)`
:   Set video quantizer scale blur (VBR).

`qmin integer (encoding,video)`
:   Set min video quantizer scale (VBR). Must be included between -1 and
    69, default value is 2.

`qmax integer (encoding,video)`
:   Set max video quantizer scale (VBR). Must be included between -1 and
    1024, default value is 31.

`qdiff integer (encoding,video)`
:   Set max difference between the quantizer scale (VBR).

`bf integer (encoding,video)`
:   Set max number of B frames between non-B-frames.

    Must be an integer between -1 and 16. 0 means that B-frames are
    disabled. If a value of -1 is used, it will choose an automatic value
    depending on the encoder.

    Default value is 0.

`b_qfactor float (encoding,video)`
:   Set qp factor between P and B frames.

`codec_tag integer`

`bug flags (decoding,video)`
:   Workaround not auto detected encoder bugs.

    Possible values:

    ‘`autodetect`’

    ‘`xvid_ilace`’
    :   Xvid interlacing bug (autodetected if fourcc==XVIX)

    ‘`ump4`’
    :   (autodetected if fourcc==UMP4)

    ‘`no_padding`’
    :   padding bug (autodetected)

    ‘`amv`’

    ‘`qpel_chroma`’

    ‘`std_qpel`’
    :   old standard qpel (autodetected per fourcc/version)

    ‘`qpel_chroma2`’

    ‘`direct_blocksize`’
    :   direct-qpel-blocksize bug (autodetected per fourcc/version)

    ‘`edge`’
    :   edge padding bug (autodetected per fourcc/version)

    ‘`hpel_chroma`’

    ‘`dc_clip`’

    ‘`ms`’
    :   Workaround various bugs in microsoft broken decoders.

    ‘`trunc`’
    :   trancated frames

`strict integer (decoding/encoding,audio,video)`
:   Specify how strictly to follow the standards.

    Possible values:

    ‘`very`’
    :   strictly conform to an older more strict version of the spec or reference software

    ‘`strict`’
    :   strictly conform to all the things in the spec no matter what consequences

    ‘`normal`’

    ‘`unofficial`’
    :   allow unofficial extensions

    ‘`experimental`’
    :   allow non standardized experimental things, experimental
        (unfinished/work in progress/not well tested) decoders and encoders.
        Note: experimental decoders can pose a security risk, do not use this for
        decoding untrusted input.

`b_qoffset float (encoding,video)`
:   Set QP offset between P and B frames.

`err_detect flags (decoding,audio,video)`
:   Set error detection flags.

    Possible values:

    ‘`crccheck`’
    :   verify embedded CRCs

    ‘`bitstream`’
    :   detect bitstream specification deviations

    ‘`buffer`’
    :   detect improper bitstream length

    ‘`explode`’
    :   abort decoding on minor error detection

    ‘`ignore_err`’
    :   ignore decoding errors, and continue decoding.
        This is useful if you want to