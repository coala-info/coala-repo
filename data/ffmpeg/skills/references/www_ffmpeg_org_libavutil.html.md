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

# Libavutil Documentation

## Table of Contents

* [1 Description](#Description)
* [2 See Also](#See-Also)
* [3 Authors](#Authors)

## [1 Description](#toc-Description)

The libavutil library is a utility library to aid portable
multimedia programming. It contains safe portable string functions,
random number generators, data structures, additional mathematics
functions, cryptography and multimedia related functionality (like
enumerations for pixel and sample formats). It is not a library for
code needed by both libavcodec and libavformat.

The goals for this library is to be:

**Modular**
:   It should have few interdependencies and the possibility of disabling individual
    parts during `./configure`.

**Small**
:   Both sources and objects should be small.

**Efficient**
:   It should have low CPU and memory usage.

**Useful**
:   It should avoid useless features that almost no one needs.

## [2 See Also](#toc-See-Also)

[ffmpeg](ffmpeg.html), [ffplay](ffplay.html), [ffprobe](ffprobe.html),
[ffmpeg-utils](ffmpeg-utils.html)

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