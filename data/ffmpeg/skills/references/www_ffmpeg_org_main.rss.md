xml version="1.0" encoding="UTF-8" ?

FFmpeg RSS
http://ffmpeg.org
FFmpeg RSS

March 16th, 2026, FFmpeg 8.1 "Hoare"
http://ffmpeg.org/index.html#pr8.1
http://ffmpeg.org/index.html#pr8.1

<p>
A new minor release, <a href="download.html#release\_8.1">FFmpeg 8.1 <span title="Sir Charles Antony Richard Hoare">"Hoare"</span></a>,
is now available for download. Here are some of the highlights:
<ul>
<li>Decoders: xHE-AAC Mps212 (experimental) MPEG-H decoding via libmpeghdec</li>
<li>EXIF Metadata Parsing</li>
<li>LCEVC: support for parsing and forwarding metadata</li>
<li>Vulkan compute-based codecs: ProRes encoding and decoding, DPX decoding</li>
<li>D3D12: D3D12 H.264/AV1 encoding, scale\_d3d12, mestimate\_d3d12, deinterlace\_d3d12 filters</li>
<li>Rockchip H.264/HEVC hardware encoding</li>
<li>IAMF: Projection mode Ambisonic Audio Elements muxing and demuxing</li>
<li>Formats: hxvs demuxer</li>
<li>Filters: drawvg, vpp\_amf</li>
</ul>
</p>
<p>
This release features a lot of internal changes and bugfixes. The groundwork for the upcoming swscale rewrite is progressing.
The Vulkan compute-based codecs, and a few filters, no longer depend on runtime GLSL compilation, which speeds up their initialization.
</p>
<p>
A companion post about the Vulkan Compute-based codec implementations has been published on the
<a href="https://www.khronos.org/blog/video-encoding-and-decoding-with-vulkan-compute-shaders-in-ffmpeg">Khronos blog</a>,
featuring technical details on the implementations and future plans.
</p>
<p>
We recommend users, distributors, and system integrators to upgrade unless they use current git master.
</p>

August 22nd, 2025, FFmpeg 8.0 "Huffman"
http://ffmpeg.org/index.html#pr8.0
http://ffmpeg.org/index.html#pr8.0

<p>
A new major release, <a href="download.html#release\_8.0">FFmpeg 8.0 <span title="David A. Huffman">"Huffman"</span></a>,
is now available for download.
Thanks to several delays, and modernization of our entire infrastructure, this release ended up
being one of our largest releases to date. In short, its new features are:
<ul>
<li>Native decoders: <span title="Advanced Professional Video">APV</span>, ProRes RAW, RealVideo 6.0, Sanyo LD-ADPCM, G.728</li>
<li>VVC decoder improvements: <span title="Intra Block Copy">IBC</span>,
<span title="Adaptive Color Transform">ACT</span>,
Palette Mode</li>
<li>Vulkan compute-based codecs: FFv1 (encode and decode), ProRes RAW (decode only)</li>
<li>Hardware accelerated decoding: Vulkan VP9, VAAPI VVC, OpenHarmony H264/5</li>
<li>Hardware accelerated encoding: Vulkan AV1, OpenHarmony H264/5</li>
<li>Formats: MCC, G.728, Whip, APV</li>
<li>Filters: colordetect, pad\_cuda, scale\_d3d11, Whisper, and others</li>
</ul>
</p>
<p>
A new class of decoders and encoders based on pure Vulkan compute implementation have been added.
Vulkan is a cross-platform, open standard set of APIs that allows programs to use GPU hardware in various ways,
from drawing on screen, to doing calculations, to decoding video via custom hardware accelerators.
Rather than using a custom hardware accelerator present, these codecs are based on compute shaders, and work
on any implementation of Vulkan 1.3.<br>
Decoders use the same hwaccel API and commands, so users do not need to do anything special to enable them,
as enabling <a href="https://trac.ffmpeg.org/wiki/HWAccelIntro#Vulkan">Vulkan decoding</a> is sufficient to use them.<br>
Encoders, like our hardware accelerated encoders, require specifying a new encoder (ffv1\_vulkan).
Currently, the only codecs supported are: FFv1 (encoding and decoding) and ProRes RAW (decode only).
ProRes (encode+decode) and VC-2 (encode+decode) implementations are complete and currently in review,
to be merged soon and available with the next minor release.<br>
Only codecs specifically designed for parallelized decoding can be implemented in such a way, with
more mainstream codecs not being planned for support.<br>
Depending on the hardware, these new codecs can provide very significant speedups, and open up
possibilities to work with them for situations like non-linear video editors and
lossless screen recording/streaming, so we are excited to learn what our downstream users can make with them.
</p>
<p>
The project has recently started to modernize its infrastructure. Our mailing list servers have been
fully upgraded, and we have recently started to accept contributions via a new forge, available on
<a href="https://code.ffmpeg.org/">code.ffmpeg.org</a>, running a Forgejo instance.
</p>
<p>
As usual, we recommend that users, distributors, and system integrators to upgrade unless they use current git master.
</p>

September 30th, 2024, FFmpeg 7.1 "Péter"
http://ffmpeg.org/index.html#pr7.1
http://ffmpeg.org/index.html#pr7.1

<p>
<a href="download.html#release\_7.1">FFmpeg 7.1 "Péter"</a>, a new
major release, is now available! A full list of changes can be found in the release
<a href="https://git.ffmpeg.org/gitweb/ffmpeg.git/blob/refs/heads/release/7.1:/Changelog">changelog</a>.
</p>
<p>
The more important highlights of the release are that the VVC decoder, merged as experimental in version 7.0,
has had enough time to mature and be optimized enough to be declared as stable. The codec is starting to gain
traction with broadcast standardization bodies.<br>
Support has been added for a native AAC USAC (part of the xHE-AAC coding system) decoder, with the format starting
to be adopted by streaming websites, due to its extensive volume normalization metadata.<br>
MV-HEVC decoding is now supported. This is a stereoscopic coding tool that begun to be shipped and generated
by recent phones and VR headsets.<br>
LC-EVC decoding, an enhancement metadata layer to attempt to improve the quality of codecs, is now supported via an
external library.<br>
</p>
<p>
Support for Vulkan encoding, with H264 and HEVC was merged. This finally allows fully Vulkan-based decode-filter-encode
pipelines, by having a sink for Vulkan frames, other than downloading or displaying them. The encoders have feature-parity
with their VAAPI implementation counterparts. Khronos has announced that support for AV1 encoding is also coming soon to Vulkan,
and FFmpeg is aiming to have day-one support.
</p>
<p>
In addition to the above, this release has had a lot of important internal work done. By far, the standout internally
are the improvements made for full-range images. Previously, color range data had two paths, no negotiation,
and was unreliably forwarded to filters, encoders, muxers. Work on cleaning the system up started more than 10
years ago, however this stalled due to how fragile the system was, and that breaking behaviour would be unacceptable.
The new system fixes this, so now color range is forwarded correctly and consistently everywhere needed, and also
laid the path for more advanced forms of negotiation.<br>
Cropping metadata is now supported with Matroska and MP4 formats. This metadata is important not only for archival,
but also with AV1, as hardware encoders require its signalling due to the codec not natively supporting one.
</p>
<p>
As usual, we recommend that users, distributors, and system integrators to upgrade unless they use current git master.
</p>

September 11th, 2024, Coverity
http://ffmpeg.org/index.html#coverity
http://ffmpeg.org/index.html#coverity

<p>
The number of issues FFmpeg has in <a href="https://scan.coverity.com/projects/ffmpeg">Coverity (a static analyzer)</a> is now lower than it has been since 2016.
Our defect density is less than one 30th of the average in OSS with over a million code
lines. All this was possible thanks to a grant from the <a href="https://www.sovereigntechfund.de/">Sovereign Tech Fund</a>.
</p>
<img src="img/coverity-lifetime-2024-08.PNG" alt="Coverity Lifetime Graph till 2024-08" style="width: 80%; display: block; margin-left: auto; margin-right: auto;" />

June 2nd, 2024, native xHE-AAC decoder
http://ffmpeg.org/index.html#xheaac
http://ffmpeg.org/index.html#xheaac

<p>
FFmpeg now implements a native xHE-AAC decoder. Currently, streams without (e)SBR, USAC or MPEG-H Surround
are supported, which means the majority of xHE-AAC streams in use should work. Support for USAC and (e)SBR is
coming soon. Work is also ongoing to improve its stability and compatibility.
During the process we found several specification issues, which were then submitted back to the authors
for discussion and potential inclusion in a future errata.
</p>

May 13th, 2024, Sovereign Tech Fund
http://ffmpeg.org/index.html#stf24
http://ffmpeg.org/index.html#stf24

<p>
The FFmpeg community is excited to announce that Germany's
<a href="https://www.sovereigntechfund.de/tech/ffmpeg">Sovereign Tech Fund</a>
has become its first governmental sponsor. Their support will help
sustain the maintainance of the FFmpeg project, a critical open-source
software multimedia component essential to bringing audio and video to
billions around the world everyday.
</p>

April 5th, 2024, FFmpeg 7.0 "Dijkstra"
http://ffmpeg.org/index.html#pr7.0
http://ffmpeg.org/index.html#pr7.0

<p>
A new major release, <a href="download.html#release\_7.0">FFmpeg 7.0 "Dijkstra"</a>,
is now available for download. The most noteworthy changes for most users are
a <a href="#vvcdec">native VVC decoder</a> (currently experimental, until more
fuzzing is done), <a href="#iamf">IAMF support</a>, or a
<a href="#cli\_threading">multi-threaded <code>ffmpeg</code> CLI tool</a>.
</p>
<p>
This release is <em>not</em> backwards compatible, removing APIs deprecated before 6.0.
The biggest change for most library callers will be the removal of the old bitmask-based
channel layout API, replaced by the <code>AVChannelLayout</code> API allowing such
features as custom channel ordering, or Ambisonics. Certain deprecated <code>ffmpeg</code>
CLI options were also removed, and a C11-compliant compiler is now required to build
the code.
</p>
<p>
As usual, there is also a number of new supported formats and codecs, new filters, APIs,
and countless smaller features and bugfixes. Compared to 6.1, the <code>git</code> repository
contains almost &sim;2000 new commits by &sim;100 authors, touching &gt;100000 lines in
&sim;2000 files &mdash; thanks to everyone who contributed. See the
<a href="https://git.videolan.org/?p=ffmpeg.git;a=blob\_plain;f=Changelog;hb=n7.0">Changelog</a>,
<a href="https://git.videolan.org/?p=ffmpeg.git;a=blob\_plain;f=doc/APIchanges;hb=n7.0">APIchanges</a>,
and the git log for more comprehensive lists of changes.
</p>

January 3rd, 2024, native VVC decoder
http://ffmpeg.org/index.html#vvcdec
http://ffmpeg.org/index.html#vvcdec

<p>
The <code>libavcodec</code> library now contains a native VVC (Versatile Video Coding)
decoder, supporting a large subset of the codec's features. Further optimizations and
support for more features are coming soon. The code was written by Nuo Mi, Xu Mu,
Frank Plowman, Shaun Loo, and Wu Jianhua.
</p>

December 18th, 2023, IAMF support
http://ffmpeg.org/index.html#iamf
http://ffmpeg.org/index.html#iamf

<p>
The <code>libavformat</code> library can now read and write <a href="https://aomediacodec.github.io/iamf/">IAMF</a>
(Immersive Audio) files. The <code>ffmpeg</code> CLI tool can configure IAMF structure with the new
<code>-stream\_group</code> option. IAMF support was written by James Almer.
</p>

December 12th, 2023, multi-threaded `ffmpeg` CLI tool
http://ffmpeg.org/index.html#cli\_threading
http://ffmpeg.org/index.html#cli\_threading

<p>
Thanks to a major refactoring of the <code>ffmpeg</code> command-line tool, all the major
components of the transcoding pipeline (demuxers, decoders, filters, encodes, muxers) now
run in parallel. This should improve throughput and CPU utilization, decrease latency,
and open the way to other exciting new features.
</p>
<p>
Note that you should <em>not</em> expect significant performance improvements in cases
where almost all computational time is spent in a single component (typically video
encoding).
</p>

November 10th, 2023, FFmpeg 6.1 "Heaviside"
http://ffmpeg.org/index.html#pr6.1
http://ffmpeg.org/index.html#pr6.1

<p>
<a href="download.html#release\_6.1">FFmpeg 6.1 "Heaviside"</a>, a new
major release, is now available! Some of the highlights:
</p>
<ul>
<li>libaribcaption decoder</li>
<li>Playdate video decoder and demuxer</li>
<li>Extend VAAPI support for libva-win32 on Windows</li>
<li>afireqsrc audio source filter</li>
<li>arls filter</li>
<li>ffmpeg CLI new option: -readrate\_initial\_burst</li>
<li>zoneplate video source filter</li>
<li>command support in the setpts and asetpts filters</li>
<li>Vulkan decode hwaccel, supporting H264, HEVC and AV1</li>
<li>color\_vulkan filter</li>
<li>bwdif\_vulkan filter</li>
<li>nlmeans\_vulkan filter</li>
<li>RivaTuner video decoder</li>
<li>xfade\_vulkan filter</li>
<li>vMix video decoder</li>
<li>Essential Video Coding parser, muxer and demuxer</li>
<li>Essential Video Coding frame merge bsf</li>
<li>bwdif\_cuda filter</li>
<li>Microsoft RLE video encoder</li>
<li>Raw AC-4 muxer and demuxer</li>
<li>Raw VVC bitstream parser, muxer and demuxer</li>
<li>Bitstream filter for editing metadata in VVC streams</li>
<li>Bitstream filter for converting VVC from MP4 to Annex B</li>
<li>scale\_vt filter for videotoolbox</li>
<li>transpose\_vt filter for videotoolbox</li>
<li>support for the P\_SKIP hinting to speed up libx264 encoding</li>
<li>Support HEVC,VP9,AV1 codec in enhanced flv format</li>
<li>apsnr and asisdr audio filters</li>
<li>OSQ demuxer and decoder</li>
<li>Support HEVC,VP9,AV1 codec fourcclist in enhanced rtmp protocol</li>
<li>CRI USM demuxer</li>
<li>ffmpeg CLI '-top' option deprecated in favor of the setfield filter</li>
<li>VAAPI AV1 encoder</li>
<li>ffprobe XML output schema changed to account for multiple variable-fields elements within the same parent element</li>
<li>ffprobe -output\_format option added as an alias of -of</li>
</ul>
<p>
This release had been overdue for at least half a year, but due to constant activity in the repository,
had to be delayed, and we were finally able to branch off the release recently, before some of the large
changes scheduled for 7.0 were merged.
</p>
<p>
Internally, we have had a number of changes too. The FFT, MDCT, DCT and DST implementation used for codecs
and filters has been fully replaced with the faster libavutil/tx (full article about it coming soon).<br>
This also led to a reduction in the the size of the compiled binary, which can be noticeable in small builds.<br>
There was a very large reduction in the total amount of allocations being done on each frame throughout video decoders,
reducing overhead.<br>
RISC-V optimizations for many parts of our DSP code have been merged, with mainly the large decoders being left.<br>
There was an effort to improve the correctness of timestamps and frame durations of each packet, increasing the
accurracy of variable frame rate video.
</p>
<p>
Next major release will be version 7.0, scheduled to be released in Feb