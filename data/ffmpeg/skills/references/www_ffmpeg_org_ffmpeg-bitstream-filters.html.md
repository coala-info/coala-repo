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

# FFmpeg Bitstream Filters Documentation

## Table of Contents

* [1 Description](#Description)
* [2 Bitstream Filters](#Bitstream-Filters)
  + [2.1 aac\_adtstoasc](#aac_005fadtstoasc)
  + [2.2 av1\_metadata](#av1_005fmetadata)
  + [2.3 chomp](#chomp)
  + [2.4 dca\_core](#dca_005fcore)
  + [2.5 dovi\_rpu](#dovi_005frpu)
  + [2.6 dump\_extra](#dump_005fextra)
  + [2.7 dv\_error\_marker](#dv_005ferror_005fmarker)
  + [2.8 eac3\_core](#eac3_005fcore)
  + [2.9 eia608\_to\_smpte436m](#eia608_005fto_005fsmpte436m)
  + [2.10 extract\_extradata](#extract_005fextradata)
  + [2.11 filter\_units](#filter_005funits)
  + [2.12 hapqa\_extract](#hapqa_005fextract)
  + [2.13 h264\_metadata](#h264_005fmetadata)
  + [2.14 h264\_mp4toannexb](#h264_005fmp4toannexb)
  + [2.15 h264\_redundant\_pps](#h264_005fredundant_005fpps)
  + [2.16 hevc\_metadata](#hevc_005fmetadata)
  + [2.17 hevc\_mp4toannexb](#hevc_005fmp4toannexb)
  + [2.18 imxdump](#imxdump)
  + [2.19 mjpeg2jpeg](#mjpeg2jpeg)
  + [2.20 mjpegadump](#mjpegadump)
  + [2.21 mov2textsub](#mov2textsub-1)
  + [2.22 mpeg2\_metadata](#mpeg2_005fmetadata)
  + [2.23 mpeg4\_unpack\_bframes](#mpeg4_005funpack_005fbframes)
  + [2.24 noise](#noise)
    - [2.24.1 Examples](#Examples)
  + [2.25 null](#null)
  + [2.26 pcm\_rechunk](#pcm_005frechunk)
  + [2.27 pgs\_frame\_merge](#pgs_005fframe_005fmerge)
  + [2.28 prores\_metadata](#prores_005fmetadata)
  + [2.29 remove\_extra](#remove_005fextra)
  + [2.30 setts](#setts)
  + [2.31 showinfo](#showinfo)
  + [2.32 smpte436m\_to\_eia608](#smpte436m_005fto_005feia608)
  + [2.33 text2movsub](#text2movsub-1)
  + [2.34 trace\_headers](#trace_005fheaders)
  + [2.35 truehd\_core](#truehd_005fcore)
  + [2.36 vp9\_metadata](#vp9_005fmetadata)
  + [2.37 vp9\_superframe](#vp9_005fsuperframe)
  + [2.38 vp9\_superframe\_split](#vp9_005fsuperframe_005fsplit)
  + [2.39 vp9\_raw\_reorder](#vp9_005fraw_005freorder)
* [3 See Also](#See-Also)
* [4 Authors](#Authors)

## [1 Description](#toc-Description)

This document describes the bitstream filters provided by the
libavcodec library.

A bitstream filter operates on the encoded stream data, and performs
bitstream level modifications without performing decoding.

## [2 Bitstream Filters](#toc-Bitstream-Filters)

When you configure your FFmpeg build, all the supported bitstream
filters are enabled by default. You can list all available ones using
the configure option `--list-bsfs`.

You can disable all the bitstream filters using the configure option
`--disable-bsfs`, and selectively enable any bitstream filter using
the option `--enable-bsf=BSF`, or you can disable a particular
bitstream filter using the option `--disable-bsf=BSF`.

The option `-bsfs` of the ff\* tools will display the list of
all the supported bitstream filters included in your build.

The ff\* tools have a -bsf option applied per stream, taking a
comma-separated list of filters, whose parameters follow the filter
name after a ’=’.

```
ffmpeg -i INPUT -c:v copy -bsf:v filter1[=opt1=str1:opt2=str2][,filter2] OUTPUT
```

Below is a description of the currently available bitstream filters,
with their parameters, if any.

### [2.1 aac\_adtstoasc](#toc-aac_005fadtstoasc)

Convert MPEG-2/4 AAC ADTS to an MPEG-4 Audio Specific Configuration
bitstream.

This filter creates an MPEG-4 AudioSpecificConfig from an MPEG-2/4
ADTS header and removes the ADTS header.

This filter is required for example when copying an AAC stream from a
raw ADTS AAC or an MPEG-TS container to MP4A-LATM, to an FLV file, or
to MOV/MP4 files and related formats such as 3GP or M4A. Please note
that it is auto-inserted for MP4A-LATM and MOV/MP4 and related formats.

### [2.2 av1\_metadata](#toc-av1_005fmetadata)

Modify metadata embedded in an AV1 stream.

`td`
:   Insert or remove temporal delimiter OBUs in all temporal units of the
    stream.

    ‘`insert`’
    :   Insert a TD at the beginning of every TU which does not already have one.

    ‘`remove`’
    :   Remove the TD from the beginning of every TU which has one.

`color_primaries`

`transfer_characteristics`

`matrix_coefficients`
:   Set the color description fields in the stream (see AV1 section 6.4.2).

`color_range`
:   Set the color range in the stream (see AV1 section 6.4.2; note that
    this cannot be set for streams using BT.709 primaries, sRGB transfer
    characteristic and identity (RGB) matrix coefficients).

    ‘`tv`’
    :   Limited range.

    ‘`pc`’
    :   Full range.

`chroma_sample_position`
:   Set the chroma sample location in the stream (see AV1 section 6.4.2).
    This can only be set for 4:2:0 streams.

    ‘`vertical`’
    :   Left position (matching the default in MPEG-2 and H.264).

    ‘`colocated`’
    :   Top-left position.

`tick_rate`
:   Set the tick rate (*time\_scale / num\_units\_in\_display\_tick*) in
    the timing info in the sequence header.

`num_ticks_per_picture`
:   Set the number of ticks in each picture, to indicate that the stream
    has a fixed framerate. Ignored if `tick_rate` is not also set.

`delete_padding`
:   Deletes Padding OBUs.

### [2.3 chomp](#toc-chomp)

Remove zero padding at the end of a packet.

### [2.4 dca\_core](#toc-dca_005fcore)

Extract the core from a DCA/DTS stream, dropping extensions such as
DTS-HD.

### [2.5 dovi\_rpu](#toc-dovi_005frpu)

Manipulate Dolby Vision metadata in a HEVC/AV1 bitstream, optionally enabling
metadata compression.

`strip`
:   If enabled, strip all Dolby Vision metadata (configuration record + RPU data
    blocks) from the stream.

`compression`
:   Which compression level to enable.

    ‘`none`’
    :   No metadata compression.

    ‘`limited`’
    :   Limited metadata compression scheme. Should be compatible with most devices.
        This is the default.

    ‘`extended`’
    :   Extended metadata compression. Devices are not required to support this. Note
        that this level currently behaves the same as ‘`limited`’ in libavcodec.

### [2.6 dump\_extra](#toc-dump_005fextra)

Add extradata to the beginning of the filtered packets except when
said packets already exactly begin with the extradata that is intended
to be added.

`freq`
:   The additional argument specifies which packets should be filtered.
    It accepts the values:

    ‘`k`’

    ‘`keyframe`’
    :   add extradata to all key packets

    ‘`e`’

    ‘`all`’
    :   add extradata to all packets

If not specified it is assumed ‘`k`’.

For example the following `ffmpeg` command forces a global
header (thus disabling individual packet headers) in the H.264 packets
generated by the `libx264` encoder, but corrects them by adding
the header stored in extradata to the key packets:

```
ffmpeg -i INPUT -map 0 -flags:v +global_header -c:v libx264 -bsf:v dump_extra out.ts
```

### [2.7 dv\_error\_marker](#toc-dv_005ferror_005fmarker)

Blocks in DV which are marked as damaged are replaced by blocks of the specified color.

`color`
:   The color to replace damaged blocks by

`sta`
:   A 16 bit mask which specifies which of the 16 possible error status values are
    to be replaced by colored blocks. 0xFFFE is the default which replaces all non 0
    error status values.

    ‘`ok`’
    :   No error, no concealment

    ‘`err`’
    :   Error, No concealment

    ‘`res`’
    :   Reserved

    ‘`notok`’
    :   Error or concealment

    ‘`notres`’
    :   Not reserved

    ‘`Aa, Ba, Ca, Ab, Bb, Cb, A, B, C, a, b, erri, erru`’
    :   The specific error status code

    see page 44-46 or section 5.5 of
    [http://web.archive.org/web/20060927044735/http://www.smpte.org/smpte\_store/standards/pdf/s314m.pdf](http://web.archive.org/web/20060927044735/http%3A//www.smpte.org/smpte_store/standards/pdf/s314m.pdf)

### [2.8 eac3\_core](#toc-eac3_005fcore)

Extract the core from a E-AC-3 stream, dropping extra channels.

### [2.9 eia608\_to\_smpte436m](#toc-eia608_005fto_005fsmpte436m)

Convert from a `EIA_608` stream to a `SMPTE_436M_ANC` data stream, wrapping the closed captions in CTA-708 CDP VANC packets.

`line_number`
:   Choose which line number the generated VANC packets should go on. You generally want either line 9 (the default) or 11.

`wrapping_type`
:   Choose the SMPTE 436M wrapping type, defaults to ‘`vanc_frame`’.
    It accepts the values:

    ‘`vanc_frame`’
    :   VANC frame (interlaced or segmented progressive frame)

    ‘`vanc_field_1`’

    ‘`vanc_field_2`’

    ‘`vanc_progressive_frame`’

`sample_coding`
:   Choose the SMPTE 436M sample coding, defaults to ‘`8bit_luma`’.
    It accepts the values:

    ‘`8bit_luma`’
    :   8-bit component luma samples

    ‘`8bit_color_diff`’
    :   8-bit component color difference samples

    ‘`8bit_luma_and_color_diff`’
    :   8-bit component luma and color difference samples

    ‘`10bit_luma`’
    :   10-bit component luma samples

    ‘`10bit_color_diff`’
    :   10-bit component color difference samples

    ‘`10bit_luma_and_color_diff`’
    :   10-bit component luma and color difference samples

    ‘`8bit_luma_parity_error`’
    :   8-bit component luma samples with parity error

    ‘`8bit_color_diff_parity_error`’
    :   8-bit component color difference samples with parity error

    ‘`8bit_luma_and_color_diff_parity_error`’
    :   8-bit component luma and color difference samples with parity error

`initial_cdp_sequence_cntr`
:   The initial value of the CDP’s 16-bit unsigned integer `cdp_hdr_sequence_cntr` and `cdp_ftr_sequence_cntr` fields. Defaults to 0.

`cdp_frame_rate`
:   Set the CDP’s `cdp_frame_rate` field. This doesn’t actually change the timing of the data stream, it just changes the values inserted in that field in the generated CDP packets. Defaults to ‘`30000/1001`’.

### [2.10 extract\_extradata](#toc-extract_005fextradata)

Extract the in-band extradata.

Certain codecs allow the long-term headers (e.g. MPEG-2 sequence headers,
or H.264/HEVC (VPS/)SPS/PPS) to be transmitted either "in-band" (i.e. as a part
of the bitstream containing the coded frames) or "out of band" (e.g. on the
container level). This latter form is called "extradata" in FFmpeg terminology.

This bitstream filter detects the in-band headers and makes them available as
extradata.

`remove`
:   When this option is enabled, the long-term headers are removed from the
    bitstream after extraction.

### [2.11 filter\_units](#toc-filter_005funits)

Remove units with types in or not in a given set from the stream.

`pass_types`
:   List of unit types or ranges of unit types to pass through while removing
    all others. This is specified as a ’|’-separated list of unit type values
    or ranges of values with ’-’.

`remove_types`
:   Identical to `pass_types`, except the units in the given set
    removed and all others passed through.

The types used by pass\_types and remove\_types correspond to NAL unit types
(nal\_unit\_type) in H.264, HEVC and H.266 (see Table 7-1 in the H.264
and HEVC specifications or Table 5 in the H.266 specification), to
marker values for JPEG (without 0xFF prefix) and to start codes without
start code prefix (i.e. the byte following the 0x000001) for MPEG-2.
For VP8 and VP9, every unit has type zero.

Extradata is unchanged by this transformation, but note that if the stream
contains inline parameter sets then the output may be unusable if they are
removed.

For example, to remove all non-VCL NAL units from an H.264 stream:

```
ffmpeg -i INPUT -c:v copy -bsf:v 'filter_units=pass_types=1-5' OUTPUT
```

To remove all AUDs, SEI and filler from an H.265 stream:

```
ffmpeg -i INPUT -c:v copy -bsf:v 'filter_units=remove_types=35|38-40' OUTPUT
```

To remove all user data from a MPEG-2 stream, including Closed Captions:

```
ffmpeg -i INPUT -c:v copy -bsf:v 'filter_units=remove_types=178' OUTPUT
```

To remove all SEI from a H264 stream, including Closed Captions:

```
ffmpeg -i INPUT -c:v copy -bsf:v 'filter_units=remove_types=6' OUTPUT
```

To remove all prefix and suffix SEI from a HEVC stream, including Closed Captions and dynamic HDR:

```
ffmpeg -i INPUT -c:v copy -bsf:v 'filter_units=remove_types=39|40' OUTPUT
```

### [2.12 hapqa\_extract](#toc-hapqa_005fextract)

Extract Rgb or Alpha part of an HAPQA file, without recompression, in order to create an HAPQ or an HAPAlphaOnly file.

`texture`
:   Specifies the texture to keep.

    `color`

    `alpha`

Convert HAPQA to HAPQ

```
ffmpeg -i hapqa_inputfile.mov -c copy -bsf:v hapqa_extract=texture=color -tag:v HapY -metadata:s:v:0 encoder="HAPQ" hapq_file.mov
```

Convert HAPQA to HAPAlphaOnly

```
ffmpeg -i hapqa_inputfile.mov -c copy -bsf:v hapqa_extract=texture=alpha -tag:v HapA -metadata:s:v:0 encoder="HAPAlpha Only" hapalphaonly_file.mov
```

### [2.13 h264\_metadata](#toc-h264_005fmetadata)

Modify metadata embedded in an H.264 stream.

`aud`
:   Insert or remove AUD NAL units in all access units of the stream.

    ‘`pass`’

    ‘`insert`’

    ‘`remove`’

    Default is pass.

`sample_aspect_ratio`
:   Set the sample aspect ratio of the stream in the VUI parameters.
    See H.264 table E-1.

`overscan_appropriate_flag`
:   Set whether the stream is suitable for display using overscan
    or not (see H.264 section E.2.1).

`video_format`

`video_full_range_flag`
:   Set the video format in the stream (see H.264 section E.2.1 and
    table E-2).

`colour_primaries`

`transfer_characteristics`

`matrix_coefficients`
:   Set the colour description in the stream (see H.264 section E.2.1
    and tables E-3, E-4 and E-5).

`chroma_sample_loc_type`
:   Set the chroma sample location in the stream (see H.264 section
    E.2.1 and figure E-1).

`tick_rate`
:   Set the tick rate (time\_scale / num\_units\_in\_tick) in the VUI
    parameters. This is the smallest time unit representable in the
    stream, and in many cases represents the field rate of the stream
    (double the frame rate).

`fixed_frame_rate_flag`
:   Set whether the stream has fixed framerate - typically this indicates
    that the framerate is exactly half the tick rate, but the exact
    meaning is dependent on interlacing and the picture structure (see
    H.264 section E.2.1 and table E-6).

`