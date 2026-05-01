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

# Archive

### August 22, 2013, Autumn Website Banner Contest

Welcome art-inclined readers of this rather technical website!

Again it is time for a contest to select a new banner for the coming autumn season.
It is your chance to display your art to the world and make this site a little bit
more artistic for the coming months.

Please read [ticket 2891](https://trac.ffmpeg.org/ticket/2891) for further
directions.

Deadline is on 20th of September.

And as always: Happy painting!

### July 10, 2013, FFmpeg 2.0

We have made a new major release (**[2.0](download.html#release_2.0)**)
It contains all features and bugfixes of the git master branch from 10th July.
A partial list of new stuff is below:

```
    - curves filter
    - reference-counting for AVFrame and AVPacket data
    - ffmpeg now fails when input options are used for output file
    or vice versa
    - support for Monkey's Audio versions from 3.93
    - perms and aperms filters
    - audio filtering support in ffplay
    - 10% faster aac encoding on x86 and MIPS
    - sine audio filter source
    - WebP demuxing and decoding support
    - new ffmpeg options -filter_script and -filter_complex_script, which allow a
    filtergraph description to be read from a file
    - OpenCL support
    - audio phaser filter
    - separatefields filter
    - libquvi demuxer
    - uniform options syntax across all filters
    - telecine filter
    - new interlace filter
    - smptehdbars source
    - inverse telecine filters (fieldmatch and decimate)
    - colorbalance filter
    - colorchannelmixer filter
    - The matroska demuxer can now output proper verbatim ASS packets. It will
    become the default at the next libavformat major bump.
    - decent native animated GIF encoding
    - asetrate filter
    - interleave filter
    - timeline editing with filters
    - vidstabdetect and vidstabtransform filters for video stabilization using
    the vid.stab library
    - astats filter
    - trim and atrim filters
    - ffmpeg -t and -ss (output-only) options are now sample-accurate when
    transcoding audio
    - Matroska muxer can now put the index at the beginning of the file.
    - extractplanes filter
    - avectorscope filter
    - ADPCM DTK decoder
    - ADP demuxer
    - RSD demuxer
    - RedSpark demuxer
    - ADPCM IMA Radical decoder
    - zmq filters
    - DCT denoiser filter (dctdnoiz)
    - Wavelet denoiser filter ported from libmpcodecs as owdenoise (formerly "ow")
    - Apple Intermediate Codec decoder
    - Escape 130 video decoder
    - FTP protocol support
    - V4L2 output device
    - 3D LUT filter (lut3d)
    - SMPTE 302M audio encoder
    - support for slice multithreading in libavfilter
    - Hald CLUT support (generation and filtering)
    - VC-1 interlaced B-frame support
    - support for WavPack muxing (raw and in Matroska)
    - XVideo output device
    - vignette filter
    - True Audio (TTA) encoder
    - Go2Webinar decoder
    - mcdeint filter ported from libmpcodecs
    - sab filter ported from libmpcodecs
    - ffprobe -show_chapters option
    - WavPack encoding through libwavpack
    - rotate filter
    - spp filter ported from libmpcodecs
    - libgme support
    - psnr filter
```

We recommend users, distributors and system integrators to upgrade unless they use
current git master.

### June 5, 2013, Request for speech codec samples

FFmpeg developers want to support more voice and speech codecs.
We are looking for samples of EVRC-WB , EVRC-B and SMV codecs.
Some cell phones may record the audio in qcp, mp4 or 3g2 formats.

Please upload these codec samples to us (ftp, trac, etc) so we may take a look.
Or you can email them to projects@mplayerhq.hu , thanks!

### April 28, 2013, LinuxTag

We happily announce that FFmpeg will be represented at LinuxTag in
Berlin, Germany. The event will take place from 22nd to 25th of May.

We will have a shared booth with XBMC. So just come over and visit our
booth to have a chat with us. And please bring along your media samples
if you possess any that do not work correctly with FFmpeg!

More information about LinuxTag can be found [here](http://www.linuxtag.org/2013/en/)

We are looking forward to see you in Berlin!

### March 15, 2013, FFmpeg 1.2

We have made a new major release (**[1.2](download.html#release_1.2)**)
It contains all features and bugfixes of the git master branch from 7th march.
A partial list of new stuff is below:

```
    - VDPAU hardware acceleration through normal hwaccel
    - SRTP support
    - Error diffusion dither in Swscale
    - Chained Ogg support
    - Theora Midstream reconfiguration support
    - EVRC decoder
    - audio fade filter
    - filtering audio with unknown channel layout
    - allpass, bass, bandpass, bandreject, biquad, equalizer, highpass, lowpass
    and treble audio filter
    - improved showspectrum filter, with multichannel support and sox-like colors
    - histogram filter
    - tee muxer
    - il filter ported from libmpcodecs
    - support ID3v2 tags in ASF files
    - encrypted TTA stream decoding support
    - RF64 support in WAV muxer
    - noise filter ported from libmpcodecs
    - Subtitles character encoding conversion
    - blend filter
    - stereo3d filter ported from libmpcodecs
```

We recommend users, distributors and system integrators to upgrade unless they use
current git master.

### February 10, 2013, Spring Website Banner Contest

Spring is approaching on the northern hemisphere. So it is time to announce another episode of our
seasonal art contest.

Please read [ticket 2255](https://trac.ffmpeg.org/ticket/2255) for further
directions.

The deadline is on March 15th.

Happy painting!

### February 4, 2013, Chemnitzer Linux-Tage

We happily announce that FFmpeg will be represented at `Chemnitzer Linux-Tage'
in Chemnitz, Germany. The event will take place on 16th and 17th of March.

More information can be found [here](http://chemnitzer.linux-tage.de/2013/info/index?cookielang=en)

We hereby invite you to visit us at our booth located in the Linux-Live area!
There we will demonstrate usage of FFmpeg, answer your questions and listen to
your problems and wishes.

We are looking forward to meet you (again)!

### January, 7, 2013, FFmpeg 1.1

We have made a new major release (**[1.1](download.html#release_1.1)**)
It contains all features and bugfixes of the git master branch. A partial list of
new stuff is below:

```
    - stream disposition information printing in ffprobe
    - filter for loudness analysis following EBU R128
    - Opus encoder using libopus
    - ffprobe -select_streams option
    - Pinnacle TARGA CineWave YUV16 decoder
    - TAK demuxer, decoder and parser
    - DTS-HD demuxer
    - remove -same_quant, it hasn't worked for years
    - FFM2 support
    - X-Face image encoder and decoder
    - 24-bit FLAC encoding
    - multi-channel ALAC encoding up to 7.1
    - metadata (INFO tag) support in WAV muxer
    - subtitles raw text decoder
    - support for building DLLs using MSVC
    - LVF demuxer
    - ffescape tool
    - metadata (info chunk) support in CAF muxer
    - field filter ported from libmpcodecs
    - AVR demuxer
    - geq filter ported from libmpcodecs
    - remove ffserver daemon mode
    - AST muxer/demuxer
    - new expansion syntax for drawtext
    - BRender PIX image decoder
    - ffprobe -show_entries option
    - ffprobe -sections option
    - ADPCM IMA Dialogic decoder
    - BRSTM demuxer
    - animated GIF decoder and demuxer
    - PVF demuxer
    - subtitles filter
    - IRCAM muxer/demuxer
    - Paris Audio File demuxer
    - Virtual concatenation demuxer
    - VobSub demuxer
    - JSON captions for TED talks decoding support
    - SOX Resampler support in libswresample
    - aselect filter
    - SGI RLE 8-bit decoder
    - Silicon Graphics Motion Video Compressor 1 & 2 decoder
    - Silicon Graphics Movie demuxer
    - apad filter
    - Resolution & pixel format change support with multithreading for H.264
    - documentation split into per-component manuals
    - pp (postproc) filter ported from MPlayer
    - NIST Sphere demuxer
    - MPL2, VPlayer, MPlayer, AQTitle, PJS and SubViewer v1 subtitles demuxers and decoders
    - Sony Wave64 muxer
    - adobe and limelight publisher authentication in RTMP
    - data: URI scheme
    - support building on the Plan 9 operating system
    - kerndeint filter ported from MPlayer
    - histeq filter ported from VirtualDub
    - Megalux Frame demuxer
    - 012v decoder
    - Improved AVC Intra decoding support
```

We recommend users, distributors and system integrators to upgrade unless they use
current git master.

### December 30, 2012, Recent Developments

Before this year ends we want to use the occasion and give you some news about
recent developments in FFmpeg.

#### - [subtitles filter](/ffmpeg-filters.html#subtitles)

The subtitles filter makes it possible to merge subtitles supported by
libavformat/libavcodec into a video stream. This process is also known
as burning them into the video or simply hardsubbing. This filter depends
on libass and thus is only available in builds configured with --enable-ass.

The subtitles filter is also useful to play external subtitle files with
ffplay. An example of this usage can be found in the following entry about
TED captions.

#### - JSON [captions for TED talks](ffmpeg-formats.html#tedcaptions) decoding support

[TED](http://www.ted.com/) provides video downloads for their talks.
Not all of these are available with subtitles and when they are the subtitles
are burnt into the video. Now with this new FFmpeg feature you can download the
subtitle files and just display them on the fly when playing the video with ffplay:

```
    ffplay ted.mp4 -vf subtitles=ted.json
```

#### - [geq filter](/ffmpeg-filters.html#geq) ported from libmpcodecs

This is another filter ported from MPlayer. It allows you to arbitrarily
change luma and chroma values for each pixel of the movie individually.
To learn more look at the
[geq documentation](/ffmpeg-filters.html#geq)
and
[the evaluation syntax description](ffmpeg-utils.html#Expression-Evaluation).
Do not forget to give it a try:

```
    ffplay input.movie -vf "geq=p(X\,Y):if(gt(Y\,H/2)\,128)+ifnot(gt(Y\,H/2)\,cr(X\,Y)):if(gt(Y\,H/2)\,128)+ifnot(gt(Y\,H/2)\,cb(X\,Y))"
```

#### - filter for [loudness analysis following EBU R128](/ffmpeg-filters.html#ebur128)

This filter analyses audio streams as recommended by EBU recommendation R128.
The output can be either logged or visualized in a generated video stream.

#### - [FFM2](/ffserver.html#What-is-FFM_002c-FFM2) support

The FFM2 format has been introduced to provide better interoperability
between different versions of the FFmpeg tools. It is usually used to
provide input to ffserver. It improves on its predecessor FFM by making
the format backward-compatible and extensible. This means the generated
files are are no longer dependant on specific FFmpeg versions.

#### - Opus encoder using libopus

You can encode Opus now via Xiph's
[libopus](http://opus-codec.org/development/).

#### - VobSub demuxer

IDX/SUB file pairs can now be played back or be remuxed into other formats such as MKV.

#### - Resolution & pixel format change support with multithreading for H.264

Finally H.264 with resolution and/or pixel format changes can be decoded multithreaded.

#### - [documentation](documentation.html) split into per-component manuals

In an on-going effort, the documentation is split, reordered and extended
to make it more accessible and more complete.

Of course we can't possibly cover all changes since our last release in a single news
article, but we encourage you to read the
[Changelog](http://git.videolan.org/?p=ffmpeg.git;a=blob_plain;f=Changelog)
yourself.

*We wish you all a happy new year!*

### November 14, 2012, Winter Website Banner Contest

As the days are getting shorter for some of us, we are proud to announce
a new episode of our FFmpeg seasonal banners contest! This is your chance
to get your art on top of this website for the coming winter season.

Please read on [here](https://trac.ffmpeg.org/ticket/1756) for further directions.

The deadline is on December 14th.

If you are member of an artist community we encourage you to spread the word
about this contest.

Frosty painting!

### September, 28, 2012, FFmpeg 1.0

We have made a new major release (**[1.0](download.html#release_1.0)**)
It contains all features and bugfixes of the git master branch. A partial list of
new stuff is below:

```
    - INI and flat output in ffprobe
    - Scene detection in libavfilter
    - Indeo Audio decoder
    - channelsplit audio filter
    - setnsamples audio filter
    - atempo filter
    - ffprobe -show_data option
    - RTMPT protocol support
    - iLBC encoding/decoding via libilbc
    - Microsoft Screen 1 decoder
    - join audio filter
    - audio channel mapping filter
    - Microsoft ATC Screen decoder
    - RTSP listen mode
    - TechSmith Screen Codec 2 decoder
    - AAC encoding via libfdk-aac
    - Microsoft Expression Encoder Screen decoder
    - RTMPS protocol support
    - RTMPTS protocol support
    - RTMPE protocol support
    - RTMPTE protocol support
    - showwaves and showspectrum filter
    - LucasArts SMUSH playback support
    - SAMI, RealText and SubViewer demuxers and decoders
    - Heart Of Darkness PAF playback support
    - iec61883 device
    - asettb filter
    - new option: -progress
    - 3GPP Timed Text encoder/decoder
    - GeoTIFF decoder support
    - ffmpeg -(no)stdin option
    - Opus decoder using libopus
    - caca output device using libcaca
    - alphaextract and alphamerge filters
    - concat filter
    - flite filter
    - Canopus Lossless Codec decoder
    - bitmap subtitles in filters (experimental and temporary)
    - MP2 encoding via TwoLAME
    - bmp parser
    - smptebars source
    - asetpts filter
    - hue filter
    - ICO muxer
    - SubRip encoder and decoder without embedded timing
    - edge detection filter
    - framestep filter
    - ffmpeg -shortest option is now per-output f