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

# FFmpeg Scaler Documentation

## Table of Contents

* [1 Description](#Description)
* [2 Scaler Options](#Scaler-Options)
* [3 See Also](#See-Also)
* [4 Authors](#Authors)

## [1 Description](#toc-Description)

The FFmpeg rescaler provides a high-level interface to the libswscale
library image conversion utilities. In particular it allows one to perform
image rescaling and pixel format conversion.

## [2 Scaler Options](#toc-Scaler-Options)

The video scaler supports the following named options.

Options may be set by specifying -option value in the
FFmpeg tools, with a few API-only exceptions noted below.
For programmatic use, they can be set explicitly in the
`SwsContext` options or through the `libavutil/opt.h` API.

`scaler, scaler_sub`
:   Choose the scaling algorithm to use. Default value is ‘`auto`’ for both.
    It accepts the following values:

    ‘`auto`’
    :   Aumotic choice. For ‘`scaler_sub`’, this means the same algorithm as
        ‘`scaler`’. For ‘`scaler`’, this defaults to the scaler flag selected
        by ‘`sws_flags`’.

    ‘`bilinear`’
    :   Bilinear filter. (AKA triangle filter)

    ‘`bicubic`’
    :   2-tap cubic BC-spline (AKA Mitchell-Netravali spline). The B and C parameters
        can be configured by setting `param0` and `param1`, defaulting to
        0.0 and 0.6 respectively.

    ‘`point, neighbor`’
    :   Point sampling (AKA nearest neighbor).

    ‘`area`’
    :   Area averaging. Equivalent to ‘`bilinear`’ for upscaling.

    ‘`gaussian`’
    :   2-tap Gaussian filter approximation. The sharpness parameter can be configured
        by setting `param0`, defaulting to 3.0.

    ‘`sinc`’
    :   Unwindowed sinc filter.

    ‘`lanczos`’
    :   Lanczos resampling (sinc windowed sinc). The number of filter taps can
        be configured by setting `param0`, defaulting to 3.

    ‘`spline`’
    :   Unwindowed natural bicubic spline.

`sws_flags`
:   Set the scaler flags. This is also used to set the scaling
    algorithm, though this usage is deprecated in favor of setting ‘`scaler`’.
    Only a single algorithm may be selected. Default value is ‘`bicubic`’.

    It accepts the following values:

    ‘`fast_bilinear`’
    :   Select fast bilinear scaling algorithm. (Deprecated)

    ‘`bilinear`’
    :   Select bilinear scaling algorithm. (Deprecated)

    ‘`bicubic`’
    :   Select bicubic scaling algorithm. (Deprecated)

    ‘`experimental`’
    :   Select experimental scaling algorithm. (Deprecated)

    ‘`neighbor`’
    :   Select nearest neighbor rescaling algorithm. (Deprecated)

    ‘`area`’
    :   Select averaging area rescaling algorithm. (Deprecated)

    ‘`bicublin`’
    :   Select bicubic scaling algorithm for the luma component, bilinear for
        chroma components. (Deprecated)

    ‘`gauss`’
    :   Select Gaussian rescaling algorithm. (Deprecated)

    ‘`sinc`’
    :   Select sinc rescaling algorithm. (Deprecated)

    ‘`lanczos`’
    :   Select Lanczos rescaling algorithm. The default width (alpha) is 3 and can be
        changed by setting `param0`. (Deprecated)

    ‘`spline`’
    :   Select natural bicubic spline rescaling algorithm. (Deprecated)

    ‘`print_info`’
    :   Enable printing/debug logging.

    ‘`accurate_rnd`’
    :   Enable accurate rounding.

    ‘`full_chroma_int`’
    :   Enable full chroma interpolation.

    ‘`full_chroma_inp`’
    :   Select full chroma input.

    ‘`bitexact`’
    :   Enable bitexact output.

    ‘`unstable`’
    :   Allow the use of experimental new code. May subtly affect the output or even
        produce wrong results. For testing only.

`srcw (API only)`
:   Set source width.

`srch (API only)`
:   Set source height.

`dstw (API only)`
:   Set destination width.

`dsth (API only)`
:   Set destination height.

`src_format (API only)`
:   Set source pixel format (must be expressed as an integer).

`dst_format (API only)`
:   Set destination pixel format (must be expressed as an integer).

`src_range (boolean)`
:   If value is set to `1`, indicates source is full range. Default value is
    `0`, which indicates source is limited range.

`dst_range (boolean)`
:   If value is set to `1`, enable full range for destination. Default value
    is `0`, which enables limited range.

`gamma (boolean)`
:   If value is set to `1`, enable gamma correct scaling. Default value is `0`.

`param0, param1`
:   Set scaling algorithm parameters. The specified values are specific of
    some scaling algorithms and ignored by others. The specified values
    are floating point number values.

`sws_dither`
:   Set the dithering algorithm. Accepts one of the following
    values. Default value is ‘`auto`’.

    ‘`auto`’
    :   automatic choice

    ‘`none`’
    :   no dithering

    ‘`bayer`’
    :   bayer dither

    ‘`ed`’
    :   error diffusion dither

    ‘`a_dither`’
    :   arithmetic dither, based using addition

    ‘`x_dither`’
    :   arithmetic dither, based using xor (more random/less apparent patterning that
        a\_dither).

`alphablend`
:   Set the alpha blending to use when the input has alpha but the output does not.
    Default value is ‘`none`’.

    ‘`uniform_color`’
    :   Blend onto a uniform background color

    ‘`checkerboard`’
    :   Blend onto a checkerboard

    ‘`none`’
    :   No blending

## [3 See Also](#toc-See-Also)

[ffmpeg](ffmpeg.html), [ffplay](ffplay.html), [ffprobe](ffprobe.html),
[libswscale](libswscale.html)

## [4 Authors](#toc-Authors)

The FFmpeg developers.

For details about the authorship, see the Git history of the project
(https://git.ffmpeg.org/ffmpeg), e.g. by typing the command
`git log` in the FFmpeg source directory, or browsing the
online repository at <https://git.ffmpeg.org/ffmpeg>.

Maintainers for the specific components are listed in the file
`MAINTAINERS` in the source code tree.

This document was generated on *May 1, 2026* using [*makeinfo*](http://www.gnu.org/software/texinfo/).

Hosting provided by [telepoint.bg](https://telepoint.bg)