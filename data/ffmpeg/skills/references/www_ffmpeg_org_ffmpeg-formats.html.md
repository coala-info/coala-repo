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

# FFmpeg Formats Documentation

## Table of Contents

* [1 Description](#Description)
* [2 Format Options](#Format-Options)
  + [2.1 Format stream specifiers](#Format-stream-specifiers-1)
* [3 Demuxers](#Demuxers)
  + [3.1 aa](#aa)
  + [3.2 aac](#aac)
  + [3.3 apng](#apng)
  + [3.4 asf](#asf-1)
  + [3.5 concat](#concat-1)
    - [3.5.1 Syntax](#Syntax)
    - [3.5.2 Options](#Options)
    - [3.5.3 Examples](#Examples)
  + [3.6 dash](#dash-1)
    - [3.6.1 Options](#Options-1)
  + [3.7 dvdvideo](#dvdvideo)
    - [3.7.1 Background](#Background)
    - [3.7.2 Options](#Options-2)
    - [3.7.3 Examples](#Examples-1)
  + [3.8 ea](#ea)
    - [3.8.1 Options](#Options-3)
  + [3.9 imf](#imf)
  + [3.10 flv, live\_flv, kux](#flv_002c-live_005fflv_002c-kux)
  + [3.11 gif](#gif-1)
  + [3.12 hls](#hls-1)
  + [3.13 image2](#image2-1)
    - [3.13.1 Examples](#Examples-2)
  + [3.14 libgme](#libgme)
  + [3.15 libmodplug](#libmodplug)
  + [3.16 libopenmpt](#libopenmpt)
  + [3.17 mcc](#mcc)
    - [3.17.1 Examples](#Examples-3)
  + [3.18 mov/mp4/3gp](#mov_002fmp4_002f3gp)
    - [3.18.1 Options](#Options-4)
    - [3.18.2 Audible AAX](#Audible-AAX)
  + [3.19 mpegts](#mpegts)
  + [3.20 mpjpeg](#mpjpeg)
  + [3.21 rawvideo](#rawvideo)
  + [3.22 rcwt](#rcwt)
    - [3.22.1 Examples](#Examples-4)
  + [3.23 sbg](#sbg)
  + [3.24 tedcaptions](#tedcaptions)
  + [3.25 vapoursynth](#vapoursynth)
  + [3.26 w64](#w64)
  + [3.27 wav](#wav-1)
* [4 Muxers](#Muxers)
  + [4.1 Raw muxers](#Raw-muxers)
    - [4.1.1 Examples](#Examples-5)
  + [4.2 Raw PCM muxers](#Raw-PCM-muxers)
  + [4.3 MPEG-1/MPEG-2 program stream muxers](#MPEG_002d1_002fMPEG_002d2-program-stream-muxers)
    - [4.3.1 Options](#Options-5)
  + [4.4 MOV/MPEG-4/ISOMBFF muxers](#MOV_002fMPEG_002d4_002fISOMBFF-muxers)
    - [4.4.1 Fragmentation](#Fragmentation)
    - [4.4.2 Options](#Options-6)
    - [4.4.3 Examples](#Examples-6)
  + [4.5 a64](#a64-1)
  + [4.6 ac4](#ac4)
    - [4.6.1 Options](#Options-7)
  + [4.7 adts](#adts-1)
    - [4.7.1 Options](#Options-8)
  + [4.8 aea](#aea-1)
  + [4.9 aiff](#aiff-1)
    - [4.9.1 Options](#Options-9)
  + [4.10 alp](#alp-1)
    - [4.10.1 Options](#Options-10)
  + [4.11 amr](#amr)
  + [4.12 amv](#amv)
  + [4.13 apm](#apm)
  + [4.14 apng](#apng-1)
    - [4.14.1 Options](#Options-11)
    - [4.14.2 Examples](#Examples-7)
  + [4.15 argo\_asf](#argo_005fasf)
    - [4.15.1 Options](#Options-12)
  + [4.16 argo\_cvg](#argo_005fcvg)
    - [4.16.1 Options](#Options-13)
  + [4.17 asf, asf\_stream](#asf_002c-asf_005fstream)
    - [4.17.1 Options](#Options-14)
  + [4.18 ass](#ass)
    - [4.18.1 Options](#Options-15)
  + [4.19 ast](#ast)
    - [4.19.1 Options](#Options-16)
  + [4.20 au](#au)
  + [4.21 avi](#avi-1)
    - [4.21.1 Options](#Options-17)
  + [4.22 avif](#avif)
    - [4.22.1 Options](#Options-18)
  + [4.23 avm2](#avm2)
  + [4.24 bit](#bit)
  + [4.25 caf](#caf)
  + [4.26 codec2](#codec2)
  + [4.27 chromaprint](#chromaprint-1)
    - [4.27.1 Options](#Options-19)
  + [4.28 crc](#crc-1)
    - [4.28.1 Examples](#Examples-8)
  + [4.29 dash](#dash-2)
    - [4.29.1 Options](#Options-20)
    - [4.29.2 Example](#Example)
  + [4.30 daud](#daud)
    - [4.30.1 Example](#Example-1)
  + [4.31 dv](#dv)
    - [4.31.1 Example](#Example-2)
  + [4.32 ffmetadata](#ffmetadata)
    - [4.32.1 Example](#Example-3)
  + [4.33 fifo](#fifo-1)
    - [4.33.1 Options](#Options-21)
    - [4.33.2 Example](#Example-4)
  + [4.34 film\_cpk](#film_005fcpk)
  + [4.35 filmstrip](#filmstrip)
  + [4.36 fits](#fits)
  + [4.37 flac](#flac)
    - [4.37.1 Options](#Options-22)
    - [4.37.2 Example](#Example-5)
  + [4.38 flv](#flv)
    - [4.38.1 Options](#Options-23)
  + [4.39 framecrc](#framecrc-1)
    - [4.39.1 Examples](#Examples-9)
  + [4.40 framehash](#framehash-1)
    - [4.40.1 Examples](#Examples-10)
  + [4.41 framemd5](#framemd5-1)
    - [4.41.1 Examples](#Examples-11)
  + [4.42 gif](#gif-2)
    - [4.42.1 Options](#Options-24)
    - [4.42.2 Example](#Example-6)
  + [4.43 gxf](#gxf)
  + [4.44 hash](#hash-1)
    - [4.44.1 Examples](#Examples-12)
  + [4.45 hds](#hds-1)
    - [4.45.1 Options](#Options-25)
    - [4.45.2 Example](#Example-7)
  + [4.46 hls](#hls-2)
    - [4.46.1 Options](#Options-26)
  + [4.47 iamf](#iamf)
  + [4.48 ico](#ico-1)
  + [4.49 ilbc](#ilbc)
  + [4.50 image2, image2pipe](#image2_002c-image2pipe)
    - [4.50.1 Options](#Options-27)
    - [4.50.2 Examples](#Examples-13)
  + [4.51 ircam](#ircam)
  + [4.52 ivf](#ivf)
  + [4.53 jacosub](#jacosub)
  + [4.54 kvag](#kvag)
  + [4.55 lc3](#lc3)
  + [4.56 lrc](#lrc)
    - [4.56.1 Metadata](#Metadata)
  + [4.57 matroska](#matroska)
    - [4.57.1 Metadata](#Metadata-1)
    - [4.57.2 Options](#Options-28)
  + [4.58 md5](#md5-1)
    - [4.58.1 Examples](#Examples-14)
  + [4.59 mcc](#mcc-1)
    - [4.59.1 Options](#Options-29)
    - [4.59.2 Examples](#Examples-15)
  + [4.60 microdvd](#microdvd)
  + [4.61 mmf](#mmf)
  + [4.62 mp3](#mp3)
  + [4.63 mpegts](#mpegts-1)
    - [4.63.1 Options](#Options-30)
    - [4.63.2 Example](#Example-8)
  + [4.64 mxf, mxf\_d10, mxf\_opatom](#mxf_002c-mxf_005fd10_002c-mxf_005fopatom)
    - [4.64.1 Options](#Options-31)
  + [4.65 null](#null)
  + [4.66 nut](#nut)
  + [4.67 ogg](#ogg)
  + [4.68 pdv](#pdv)
  + [4.69 rcwt](#rcwt-1)
    - [4.69.1 Examples](#Examples-16)
  + [4.70 segment, stream\_segment, ssegment](#segment_002c-stream_005fsegment_002c-ssegment)
    - [4.70.1 Options](#Options-32)
    - [4.70.2 Examples](#Examples-17)
  + [4.71 smoothstreaming](#smoothstreaming)
  + [4.72 streamhash](#streamhash-1)
    - [4.72.1 Examples](#Examples-18)
  + [4.73 tee](#tee-1)
    - [4.73.1 Options](#Options-33)
    - [4.73.2 Examples](#Examples-19)
  + [4.74 webm\_chunk](#webm_005fchunk)
    - [4.74.1 Options](#Options-34)
    - [4.74.2 Example](#Example-9)
  + [4.75 webm\_dash\_manifest](#webm_005fdash_005fmanifest)
    - [4.75.1 Options](#Options-35)
    - [4.75.2 Example](#Example-10)
  + [4.76 whip](#whip-1)
    - [4.76.1 Options](#Options-36)
* [5 Metadata](#Metadata-2)
* [6 See Also](#See-Also)
* [7 Authors](#Authors)

## [1 Description](#toc-Description)

This document describes the supported formats (muxers and demuxers)
provided by the libavformat library.

## [2 Format Options](#toc-Format-Options)

The libavformat library provides some generic global options, which
can be set on all the muxers and demuxers. In addition each muxer or
demuxer may support so-called private options, which are specific for
that component.

Options may be set by specifying -option value in the
FFmpeg tools, or by setting the value explicitly in the
`AVFormatContext` options or using the `libavutil/opt.h` API
for programmatic use.

The list of supported options follows:

`avioflags flags (input/output)`
:   Possible values:

    ‘`direct`’
    :   Reduce buffering.

`probesize integer (input)`
:   Set probing size in bytes, i.e. the size of the data to analyze to get
    stream information. A higher value will enable detecting more
    information in case it is dispersed into the stream, but will increase
    latency. Must be an integer not lesser than 32. It is 5000000 by default.

`max_probe_packets integer (input)`
:   Set the maximum number of buffered packets when probing a codec.
    Default is 2500 packets.

`packetsize integer (output)`
:   Set packet size.

`fflags flags`
:   Set format flags. Some are implemented for a limited number of formats.

    Possible values for input files:

    ‘`discardcorrupt`’
    :   Discard corrupted packets.

    ‘`fastseek`’
    :   Enable fast, but inaccurate seeks for some formats.

    ‘`genpts`’
    :   Generate missing PTS if DTS is present.

    ‘`igndts`’
    :   Ignore DTS if PTS is also set. In case the PTS is set, the DTS value
        is set to NOPTS. This is ignored when the `nofillin` flag is set.

    ‘`ignidx`’
    :   Ignore index.

    ‘`nobuffer`’
    :   Reduce the latency introduced by buffering during initial input streams analysis.

    ‘`nofillin`’
    :   Do not fill in missing values in packet fields that can be exactly calculated.

    ‘`noparse`’
    :   Disable AVParsers, this needs `+nofillin` too.

    ‘`sortdts`’
    :   Try to interleave output packets by DTS. At present, available only for AVIs with an index.

    Possible values for output files:

    ‘`autobsf`’
    :   Automatically apply bitstream filters as required by the output format. Enabled by default.

    ‘`bitexact`’
    :   Only write platform-, build- and time-independent data.
        This ensures that file and data checksums are reproducible and match between
        platforms. Its primary use is for regression testing.

    ‘`flush_packets`’
    :   Write out packets immediately.

    ‘`shortest`’
    :   Stop muxing at the end of the shortest stream.
        It may be needed to increase max\_interleave\_delta to avoid flushing the longer
        streams before EOF.

`seek2any integer (input)`
:   Allow seeking to non-keyframes on demuxer level when supported if set to 1.
    Default is 0.

`analyzeduration integer (input)`
:   Specify how many microseconds are analyzed to probe the input. A
    higher value will enable detecting more accurate information, but will
    increase latency. It defaults to 5,000,000 microseconds = 5 seconds.

`cryptokey hexadecimal string (input)`
:   Set decryption key.

`indexmem integer (input)`
:   Set max memory used for timestamp index (per stream).

`rtbufsize integer (input)`
:   Set max memory used for buffering real-time frames.

`fdebug flags (input/output)`
:   Print specific debug info.

    Possible values:

    ‘`ts`’

`max_delay integer (input/output)`
:   Set maximum muxing or demuxing delay in microseconds.

`fpsprobesize integer (input)`
:   Set number of frames used to probe fps.

`audio_preload integer (output)`
:   Set microseconds by which audio packets should be interleaved earlier.

`chunk_duration integer (output)`
:   Set microseconds for each chunk.

`chunk_size integer (output)`
:   Set size in bytes for each chunk.

`err_detect, f_err_detect flags (input)`
:   Set error detection flags. `f_err_detect` is deprecated and
    should be used only via the `ffmpeg` tool.

    Possible values:

    ‘`crccheck`’
    :   Verify embedded CRCs.

    ‘`bitstream`’
    :   Detect bitstream specification deviations.

    ‘`buffer`’
    :   Detect improper bitstream length.

    ‘`explode`’
    :   Abort decoding on minor error detection.

    ‘`careful`’
    :   Consider things that violate the spec and have not been seen in the
        wild as errors.

    ‘`compliant`’
    :   Consider all spec non compliancies as errors.

    ‘`aggressive`’
    :   Consider things that a sane encoder should not do as an error.

`max_interleave_delta integer (output)`
:   Set maximum buffering duration for interleaving. The duration is
    expressed in microseconds, and defaults to 10000000 (10 seconds).

    To ensure all the streams are interleaved correctly, libavformat will
    wait until it has at least one packet for each stream before actually
    writing any packets to the output file. When some streams are
    "sparse" (i.e. there are large gaps between successive packets), this
    can result in excessive buffering.

    This field specifies the maximum difference between the timestamps of the
    first and the last packet in the muxing queue, above which libavformat
    will output a packet regardless of whether it has queued a packet for all
    the streams.

    If set to 0, libavformat will continue buffering packets until it has
    a packet for each stream, regardless of the maximum timestamp
    difference between the buffered packets.

`use_wallclock_as_timestamps integer (input)`
:   Use wallclock as timestamps if set to 1. Default is 0.

`avoid_negative_ts integer (output)`
:   Possible values:

    ‘`make_non_negative`’
    :   Shift timestamps to make them non-negative.
        Also note that this affects only leading negative timestamps, and not
        non-monotonic negative timestamps.

    ‘`make_zero`’
    :   Shift timestamps so that the first timestamp is 0.

    ‘`auto (default)`’
    :   Enables shifting when required by the target format.

    ‘`disabled`’
    :   Disables shifting of timestamp.

    When shifting is enabled, all output timestamps are shifted by the
    same amount. Audio, video, and subtitles desynching and relative
    timestamp differences are preserved compared to how they would have
    been without shifting.

`skip_initial_bytes integer (input)`
:   Set number of bytes to skip before reading header and frames if set to 1.
    Default is 0.

`correct_ts_overflow integer (input)`
:   Correct single timestamp overflows if set to 1. Default is 1.

`flush_packets integer (output)`
:   Flush the underlying I/O stream after each packet. Default is -1 (auto), which
    means that the underlying protocol will decide, 1 enables it, and has the
    effect of reducing the latency, 0 disables it and may increase IO throughput in
    some cases.

`output_ts_offset offset (output)`
:   Set the output time offset.

    offset must be a time duration specification,
    see [(ffmpeg-utils)the Time duration section in the ffmpeg-utils(1) manual](ffmpeg-utils.html#time-duration-syntax).

    The offset is added by the muxer to the output timestamps.

    Specifying a positive offset means that the corresponding streams are
    delayed bt the time duration specified in offset. Default value
    is `0` (meaning that no offset is applied).

`format_whitelist list (input)`
:   "," separated list of allowed demuxers. By default all are allowed.

`dump_separator string (input)`
:   Separator used to separate the fields printed on the command line about the
    Stream parameters.
    For example, to separate the fields with newlines and indentation:

    ```
    ffprobe -dump_separator "
                              "  -i ~/videos/matrixbench_mpeg2.mpg
    ```

`max_streams integer (input)`
:   Specifies the maximum number of streams. This can be used to reject files that
    would require too many resources due to a large number of streams.

`skip_es