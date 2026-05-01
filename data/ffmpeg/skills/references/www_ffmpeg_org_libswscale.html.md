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

# Libswscale Documentation

## Table of Contents

* [1 Description](#Description)
* [2 See Also](#See-Also)
* [3 Authors](#Authors)

## [1 Description](#toc-Description)

The libswscale library performs highly optimized image scaling and
colorspace and pixel format conversion operations.

Specifically, this library performs the following conversions:

* *Rescaling*: is the process of changing the video size. Several
  rescaling options and algorithms are available. This is usually a
  lossy process.
* *Pixel format conversion*: is the process of converting the image
  format and colorspace of the image, for example from planar YUV420P to
  RGB24 packed. It also handles packing conversion, that is converts
  from packed layout (all pixels belonging to distinct planes
  interleaved in the same buffer), to planar layout (all samples
  belonging to the same plane stored in a dedicated buffer or "plane").

  This is usually a lossy process in case the source and destination
  colorspaces differ.

## [2 See Also](#toc-See-Also)

[ffmpeg](ffmpeg.html), [ffplay](ffplay.html), [ffprobe](ffprobe.html),
[ffmpeg-scaler](ffmpeg-scaler.html),
[libavutil](libavutil.html)

## [3 Authors](#toc-Authors)

The FFmpeg developers.

For details about the authorship, see the Git history of the project
(https://git.ffmpeg.org/ffmpeg), e.g. by typing the command
`git log` in the FFmpeg source directory, or browsing the
online repository at <https://git.ffmpeg.org/ffmpeg>.

Maintainers for the specific components are listed in the file
`MAINTAINERS` in the source code tree.

This document was generated on *May 1, 2026* using [*makeinfo*](http://www.gnu.org/software/texinfo/).

Hosting provided by [telepoint.bg](https://telepoint.bg)