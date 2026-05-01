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

# FFmpeg

## A complete, cross-platform solution to record, convert and stream audio and video.

[Download](download.html)

### Converting **video** and **audio** has never been so easy.

```
$ ffmpeg -i input.mp4 output.avi
```

[Discover more](about.html)

# News

### March 16th, 2026, FFmpeg 8.1 "Hoare"

A new minor release, [FFmpeg 8.1 "Hoare"](download.html#release_8.1),
is now available for download. Here are some of the highlights:

* Decoders: xHE-AAC Mps212 (experimental) MPEG-H decoding via libmpeghdec
* EXIF Metadata Parsing
* LCEVC: support for parsing and forwarding metadata
* Vulkan compute-based codecs: ProRes encoding and decoding, DPX decoding
* D3D12: D3D12 H.264/AV1 encoding, scale\_d3d12, mestimate\_d3d12, deinterlace\_d3d12 filters
* Rockchip H.264/HEVC hardware encoding
* IAMF: Projection mode Ambisonic Audio Elements muxing and demuxing
* Formats: hxvs demuxer
* Filters: drawvg, vpp\_amf

This release features a lot of internal changes and bugfixes. The groundwork for the upcoming swscale rewrite is progressing.
The Vulkan compute-based codecs, and a few filters, no longer depend on runtime GLSL compilation, which speeds up their initialization.

A companion post about the Vulkan Compute-based codec implementations has been published on the
[Khronos blog](https://www.khronos.org/blog/video-encoding-and-decoding-with-vulkan-compute-shaders-in-ffmpeg),
featuring technical details on the implementations and future plans.

We recommend users, distributors, and system integrators to upgrade unless they use current git master.

### August 22nd, 2025, FFmpeg 8.0 "Huffman"

A new major release, [FFmpeg 8.0 "Huffman"](download.html#release_8.0),
is now available for download.
Thanks to several delays, and modernization of our entire infrastructure, this release ended up
being one of our largest releases to date. In short, its new features are:

* Native decoders: APV, ProRes RAW, RealVideo 6.0, Sanyo LD-ADPCM, G.728
* VVC decoder improvements: IBC,
  ACT,
  Palette Mode
* Vulkan compute-based codecs: FFv1 (encode and decode), ProRes RAW (decode only)
* Hardware accelerated decoding: Vulkan VP9, VAAPI VVC, OpenHarmony H264/5
* Hardware accelerated encoding: Vulkan AV1, OpenHarmony H264/5
* Formats: MCC, G.728, Whip, APV
* Filters: colordetect, pad\_cuda, scale\_d3d11, Whisper, and others

A new class of decoders and encoders based on pure Vulkan compute implementation have been added.
Vulkan is a cross-platform, open standard set of APIs that allows programs to use GPU hardware in various ways,
from drawing on screen, to doing calculations, to decoding video via custom hardware accelerators.
Rather than using a custom hardware accelerator present, these codecs are based on compute shaders, and work
on any implementation of Vulkan 1.3.
Decoders use the same hwaccel API and commands, so users do not need to do anything special to enable them,
as enabling [Vulkan decoding](https://trac.ffmpeg.org/wiki/HWAccelIntro#Vulkan) is sufficient to use them.
Encoders, like our hardware accelerated encoders, require specifying a new encoder (ffv1\_vulkan).
Currently, the only codecs supported are: FFv1 (encoding and decoding) and ProRes RAW (decode only).
ProRes (encode+decode) and VC-2 (encode+decode) implementations are complete and currently in review,
to be merged soon and available with the next minor release.
Only codecs specifically designed for parallelized decoding can be implemented in such a way, with
more mainstream codecs not being planned for support.
Depending on the hardware, these new codecs can provide very significant speedups, and open up
possibilities to work with them for situations like non-linear video editors and
lossless screen recording/streaming, so we are excited to learn what our downstream users can make with them.

The project has recently started to modernize its infrastructure. Our mailing list servers have been
fully upgraded, and we have recently started to accept contributions via a new forge, available on
[code.ffmpeg.org](https://code.ffmpeg.org/), running a Forgejo instance.

As usual, we recommend that users, distributors, and system integrators to upgrade unless they use current git master.

### September 30th, 2024, FFmpeg 7.1 "Péter"

[FFmpeg 7.1 "Péter"](download.html#release_7.1), a new
major release, is now available! A full list of changes can be found in the release
[changelog](https://git.ffmpeg.org/gitweb/ffmpeg.git/blob/refs/heads/release/7.1%3A/Changelog).

The more important highlights of the release are that the VVC decoder, merged as experimental in version 7.0,
has had enough time to mature and be optimized enough to be declared as stable. The codec is starting to gain
traction with broadcast standardization bodies.
Support has been added for a native AAC USAC (part of the xHE-AAC coding system) decoder, with the format starting
to be adopted by streaming websites, due to its extensive volume normalization metadata.
MV-HEVC decoding is now supported. This is a stereoscopic coding tool that begun to be shipped and generated
by recent phones and VR headsets.
LC-EVC decoding, an enhancement metadata layer to attempt to improve the quality of codecs, is now supported via an
external library.

Support for Vulkan encoding, with H264 and HEVC was merged. This finally allows fully Vulkan-based decode-filter-encode
pipelines, by having a sink for Vulkan frames, other than downloading or displaying them. The encoders have feature-parity
with their VAAPI implementation counterparts. Khronos has announced that support for AV1 encoding is also coming soon to Vulkan,
and FFmpeg is aiming to have day-one support.

In addition to the above, this release has had a lot of important internal work done. By far, the standout internally
are the improvements made for full-range images. Previously, color range data had two paths, no negotiation,
and was unreliably forwarded to filters, encoders, muxers. Work on cleaning the system up started more than 10
years ago, however this stalled due to how fragile the system was, and that breaking behaviour would be unacceptable.
The new system fixes this, so now color range is forwarded correctly and consistently everywhere needed, and also
laid the path for more advanced forms of negotiation.
Cropping metadata is now supported with Matroska and MP4 formats. This metadata is important not only for archival,
but also with AV1, as hardware encoders require its signalling due to the codec not natively supporting one.

As usual, we recommend that users, distributors, and system integrators to upgrade unless they use current git master.

### September 11th, 2024, Coverity

The number of issues FFmpeg has in [Coverity (a static analyzer)](https://scan.coverity.com/projects/ffmpeg) is now lower than it has been since 2016.
Our defect density is less than one 30th of the average in OSS with over a million code
lines. All this was possible thanks to a grant from the [Sovereign Tech Fund](https://www.sovereigntechfund.de/).

![Coverity Lifetime Graph till 2024-08](img/coverity-lifetime-2024-08.PNG)

### June 2nd, 2024, native xHE-AAC decoder

FFmpeg now implements a native xHE-AAC decoder. Currently, streams without (e)SBR, USAC or MPEG-H Surround
are supported, which means the majority of xHE-AAC streams in use should work. Support for USAC and (e)SBR is
coming soon. Work is also ongoing to improve its stability and compatibility.
During the process we found several specification issues, which were then submitted back to the authors
for discussion and potential inclusion in a future errata.

### May 13th, 2024, Sovereign Tech Fund

The FFmpeg community is excited to announce that Germany's
[Sovereign Tech Fund](https://www.sovereigntechfund.de/tech/ffmpeg)
has become its first governmental sponsor. Their support will help
sustain the maintainance of the FFmpeg project, a critical open-source
software multimedia component essential to bringing audio and video to
billions around the world everyday.

### April 5th, 2024, FFmpeg 7.0 "Dijkstra"

A new major release, [FFmpeg 7.0 "Dijkstra"](download.html#release_7.0),
is now available for download. The most noteworthy changes for most users are
a [native VVC decoder](#vvcdec) (currently experimental, until more
fuzzing is done), [IAMF support](#iamf), or a
[multi-threaded `ffmpeg` CLI tool](#cli_threading).

This release is *not* backwards compatible, removing APIs deprecated before 6.0.
The biggest change for most library callers will be the removal of the old bitmask-based
channel layout API, replaced by the `AVChannelLayout` API allowing such
features as custom channel ordering, or Ambisonics. Certain deprecated `ffmpeg`
CLI options were also removed, and a C11-compliant compiler is now required to build
the code.

As usual, there is also a number of new supported formats and codecs, new filters, APIs,
and countless smaller features and bugfixes. Compared to 6.1, the `git` repository
contains almost ∼2000 new commits by ∼100 authors, touching >100000 lines in
∼2000 files — thanks to everyone who contributed. See the
[Changelog](https://git.videolan.org/?p=ffmpeg.git;a=blob_plain;f=Changelog;hb=n7.0),
[APIchanges](https://git.videolan.org/?p=ffmpeg.git;a=blob_plain;f=doc/APIchanges;hb=n7.0),
and the git log for more comprehensive lists of changes.

### January 3rd, 2024, native VVC decoder

The `libavcodec` library now contains a native VVC (Versatile Video Coding)
decoder, supporting a large subset of the codec's features. Further optimizations and
support for more features are coming soon. The code was written by Nuo Mi, Xu Mu,
Frank Plowman, Shaun Loo, and Wu Jianhua.

### December 18th, 2023, IAMF support

The `libavformat` library can now read and write [IAMF](https://aomediacodec.github.io/iamf/)
(Immersive Audio) files. The `ffmpeg` CLI tool can configure IAMF structure with the new
`-stream_group` option. IAMF support was written by James Almer.

### December 12th, 2023, multi-threaded `ffmpeg` CLI tool

Thanks to a major refactoring of the `ffmpeg` command-line tool, all the major
components of the transcoding pipeline (demuxers, decoders, filters, encodes, muxers) now
run in parallel. This should improve throughput and CPU utilization, decrease latency,
and open the way to other exciting new features.

Note that you should *not* expect significant performance improvements in cases
where almost all computational time is spent in a single component (typically video
encoding).

### November 10th, 2023, FFmpeg 6.1 "Heaviside"

[FFmpeg 6.1 "Heaviside"](download.html#release_6.1), a new
major release, is now available! Some of the highlights:

* libaribcaption decoder
* Playdate video decoder and demuxer
* Extend VAAPI support for libva-win32 on Windows
* afireqsrc audio source filter
* arls filter
* ffmpeg CLI new option: -readrate\_initial\_burst
* zoneplate video source filter
* command support in the setpts and asetpts filters
* Vulkan decode hwaccel, supporting H264, HEVC and AV1
* color\_vulkan filter
* bwdif\_vulkan filter
* nlmeans\_vulkan filter
* RivaTuner video decoder
* xfade\_vulkan filter
* vMix video decoder
* Essential Video Coding parser, muxer and demuxer
* Essential Video Coding frame merge bsf
* bwdif\_cuda filter
* Microsoft RLE video encoder
* Raw AC-4 muxer and demuxer
* Raw VVC bitstream parser, muxer and demuxer
* Bitstream filter for editing metadata in VVC streams
* Bitstream filter for converting VVC from MP4 to Annex B
* scale\_vt filter for videotoolbox
* transpose\_vt filter for videotoolbox
* support for the P\_SKIP hinting to speed up libx264 encoding
* Support HEVC,VP9,AV1 codec in enhanced flv format
* apsnr and asisdr audio filters
* OSQ demuxer and decoder
* Support HEVC,VP9,AV1 codec fourcclist in enhanced rtmp protocol
* CRI USM demuxer
* ffmpeg CLI '-top' option deprecated in favor of the setfield filter
* VAAPI AV1 encoder
* ffprobe XML output schema changed to account for multiple variable-fields elements within the same parent element
* ffprobe -output\_format option added as an alias of -of

This release had been overdue for at least half a year, but due to constant activity in the repository,
had to be delayed, and we were finally able to branch off the release recently, before some of the large
changes scheduled for 7.0 were merged.

Internally, we have had a number of changes too. The FFT, MDCT, DCT and DST implementation used for codecs
and filters has been fully replaced with the faster libavutil/tx (full article about it coming soon).
This also led to a reduction in the the size of the compiled binary, which can be noticeable in small builds.
There was a very large reduction in the total amount of allocations being done on each frame throughout video decoders,
reducing overhead.
RISC-V optimizations for many parts of our DSP code have been merged, with mainly the large decoders being left.
There was an effort to improve the correctness of timestamps and frame durations of each packet, increasing the
accurracy of variable frame rate video.

Next major release will be version 7.0, scheduled to be released in February. We will attempt to better stick
to the new release schedule we announced at the start of this year.

We strongly recommend users, distributors, and system integrators to upgrade unless they use current git master.

### May 31st, 2023, Vulkan decoding

A few days ago, Vulkan-powered decoding hardware acceleration code was merged into the codebase.
This is the first vendor-generic and platform-generic decode acceleration API, enabling the
same code to be used on multiple platforms, with very minimal overhead.
This is also the first multi-threaded hardware decoding API, and our code makes full use of this,
saturating all available decode engines the hardware exposes.

Those wishing to test the code can read our
[documentation page](https://trac.ffmpeg.org/wiki/HWAccelIntro#Vulkan).
For those who would like to integrate FFmpeg's Vulkan code to demux, parse, decode, and receive
a VkImage to present or manipulate, documentation and examples are available in o