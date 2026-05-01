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

# ffmpeg Documentation

## Table of Contents

* [1 Synopsis](#Synopsis)
* [2 Description](#Description)
* [3 Detailed description](#Detailed-description)
  + [3.1 Streamcopy](#Streamcopy)
  + [3.2 Transcoding](#Transcoding)
  + [3.3 Filtering](#Filtering)
    - [3.3.1 Simple filtergraphs](#Simple-filtergraphs)
    - [3.3.2 Complex filtergraphs](#Complex-filtergraphs)
  + [3.4 Loopback decoders](#Loopback-decoders-1)
* [4 Stream selection](#Stream-selection-1)
  + [4.1 Description](#Description-1)
    - [4.1.1 Automatic stream selection](#Automatic-stream-selection)
    - [4.1.2 Manual stream selection](#Manual-stream-selection)
    - [4.1.3 Complex filtergraphs](#Complex-filtergraphs-1)
    - [4.1.4 Stream handling](#Stream-handling)
  + [4.2 Examples](#Examples)
* [5 Options](#Options)
  + [5.1 Stream specifiers](#Stream-specifiers-1)
  + [5.2 Generic options](#Generic-options)
  + [5.3 AVOptions](#AVOptions)
  + [5.4 Main options](#Main-options)
  + [5.5 Video Options](#Video-Options)
  + [5.6 Advanced Video options](#Advanced-Video-options)
  + [5.7 Audio Options](#Audio-Options)
  + [5.8 Advanced Audio options](#Advanced-Audio-options)
  + [5.9 Subtitle options](#Subtitle-options)
  + [5.10 Advanced Subtitle options](#Advanced-Subtitle-options)
  + [5.11 Advanced options](#Advanced-options)
  + [5.12 Preset files](#Preset-files)
    - [5.12.1 ffpreset files](#ffpreset-files)
    - [5.12.2 avpreset files](#avpreset-files)
  + [5.13 vstats file format](#vstats-file-format)
* [6 Examples](#Examples-1)
  + [6.1 Video and Audio grabbing](#Video-and-Audio-grabbing)
  + [6.2 X11 grabbing](#X11-grabbing)
  + [6.3 Video and Audio file format conversion](#Video-and-Audio-file-format-conversion)
* [7 See Also](#See-Also)
* [8 Authors](#Authors)

## [1 Synopsis](#toc-Synopsis)

ffmpeg [global\_options] {[input\_file\_options] -i `input_url`} ... {[output\_file\_options] `output_url`} ...

## [2 Description](#toc-Description)

`ffmpeg` is a universal media converter. It can read a wide variety of
inputs - including live grabbing/recording devices - filter, and transcode them
into a plethora of output formats.

`ffmpeg` reads from an arbitrary number of inputs (which can be regular
files, pipes, network streams, grabbing devices, etc.), specified by the
`-i` option, and writes to an arbitrary number of outputs, which are
specified by a plain output url. Anything found on the command line which cannot
be interpreted as an option is considered to be an output url.

Each input or output can, in principle, contain any number of elementary streams
of different types (video/audio/subtitle/attachment/data), though the allowed
stream counts and/or types may be limited by the container format. Selecting
which streams from which inputs will go into which output is either done
automatically or with the `-map` option (see the [Stream selection](#Stream-selection)
chapter).

To refer to inputs/outputs in options, you must use their indices (0-based).
E.g. the first input is `0`, the second is `1`, etc. Similarly,
streams within an input/output are referred to by their indices. E.g. `2:3`
refers to the fourth stream in the third input or output. Also see the
[Stream specifiers](#Stream-specifiers) chapter.

As a general rule, options are applied to the next specified
file. Therefore, order is important, and you can have the same
option on the command line multiple times. Each occurrence is
then applied to the next input or output file.
Exceptions from this rule are the global options (e.g. verbosity level),
which should be specified first.

Do not mix input and output files – first specify all input files, then all
output files. Also do not mix options which belong to different files. All
options apply ONLY to the next input or output file and are reset between files.

Some simple examples follow.

* Convert an input media file to a different format, by re-encoding media streams:

  ```
  ffmpeg -i input.avi output.mp4
  ```
* Set the video bitrate of the output file to 64 kbit/s:

  ```
  ffmpeg -i input.avi -b:v 64k -bufsize 64k output.mp4
  ```
* Force the frame rate of the output file to 24 fps:

  ```
  ffmpeg -i input.avi -r 24 output.mp4
  ```
* Force the frame rate of the input file (valid for raw formats only) to 1 fps and
  the frame rate of the output file to 24 fps:

  ```
  ffmpeg -r 1 -i input.m2v -r 24 output.mp4
  ```

The format option may be needed for raw input files.

## [3 Detailed description](#toc-Detailed-description)

`ffmpeg` builds a transcoding pipeline out of the components listed
below. The program’s operation then consists of input data chunks flowing from
the sources down the pipes towards the sinks, while being transformed by the
components they encounter along the way.

The following kinds of components are available:

* *Demuxers* (short for "demultiplexers") read an input source in order to
  extract
  + global properties such as metadata or chapters;
  + list of input elementary streams and their properties

  One demuxer instance is created for each `-i` option, and sends encoded
  *packets* to *decoders* or *muxers*.

  In other literature, demuxers are sometimes called *splitters*, because
  their main function is splitting a file into elementary streams (though some
  files only contain one elementary stream).

  A schematic representation of a demuxer looks like this:

  ```
  ┌──────────┬───────────────────────┐
  │ demuxer  │                       │ packets for stream 0
  ╞══════════╡ elementary stream 0   ├──────────────────────►
  │          │                       │
  │  global  ├───────────────────────┤
  │properties│                       │ packets for stream 1
  │   and    │ elementary stream 1   ├──────────────────────►
  │ metadata │                       │
  │          ├───────────────────────┤
  │          │                       │
  │          │     ...........       │
  │          │                       │
  │          ├───────────────────────┤
  │          │                       │ packets for stream N
  │          │ elementary stream N   ├──────────────────────►
  │          │                       │
  └──────────┴───────────────────────┘
       ▲
       │
       │ read from file, network stream,
       │     grabbing device, etc.
       │
  ```
* *Decoders* receive encoded (compressed) *packets* for an audio, video,
  or subtitle elementary stream, and decode them into raw *frames* (arrays of
  pixels for video, PCM for audio). A decoder is typically associated with (and
  receives its input from) an elementary stream in a *demuxer*, but sometimes
  may also exist on its own (see [Loopback decoders](#Loopback-decoders)).

  A schematic representation of a decoder looks like this:

  ```
            ┌─────────┐
   packets  │         │ raw frames
  ─────────►│ decoder ├────────────►
            │         │
            └─────────┘
  ```
* *Filtergraphs* process and transform raw audio or video *frames*. A
  filtergraph consists of one or more individual *filters* linked into a
  graph. Filtergraphs come in two flavors - *simple* and *complex*,
  configured with the `-filter` and `-filter_complex` options,
  respectively.

  A simple filtergraph is associated with an *output elementary stream*; it
  receives the input to be filtered from a *decoder* and sends filtered
  output to that output stream’s *encoder*.

  A simple video filtergraph that performs deinterlacing (using the `yadif`
  deinterlacer) followed by resizing (using the `scale` filter) can look like
  this:

  ```
               ┌────────────────────────┐
               │  simple filtergraph    │
   frames from ╞════════════════════════╡ frames for
   a decoder   │  ┌───────┐  ┌───────┐  │ an encoder
  ────────────►├─►│ yadif ├─►│ scale ├─►│────────────►
               │  └───────┘  └───────┘  │
               └────────────────────────┘
  ```

  A complex filtergraph is standalone and not associated with any specific stream.
  It may have multiple (or zero) inputs, potentially of different types (audio or
  video), each of which receiving data either from a decoder or another complex
  filtergraph’s output. It also has one or more outputs that feed either an
  encoder or another complex filtergraph’s input.

  The following example diagram represents a complex filtergraph with 3 inputs and
  2 outputs (all video):

  ```
            ┌─────────────────────────────────────────────────┐
            │               complex filtergraph               │
            ╞═════════════════════════════════════════════════╡
   frames   ├───────┐  ┌─────────┐      ┌─────────┐  ┌────────┤ frames
  ─────────►│input 0├─►│ overlay ├─────►│ overlay ├─►│output 0├────────►
            ├───────┘  │         │      │         │  └────────┤
   frames   ├───────┐╭►│         │    ╭►│         │           │
  ─────────►│input 1├╯ └─────────┘    │ └─────────┘           │
            ├───────┘                 │                       │
   frames   ├───────┐ ┌─────┐ ┌─────┬─╯              ┌────────┤ frames
  ─────────►│input 2├►│scale├►│split├───────────────►│output 1├────────►
            ├───────┘ └─────┘ └─────┘                └────────┤
            └─────────────────────────────────────────────────┘
  ```

  Frames from second input are overlaid over those from the first. Frames from the
  third input are rescaled, then the duplicated into two identical streams. One of
  them is overlaid over the combined first two inputs, with the result exposed as
  the filtergraph’s first output. The other duplicate ends up being the
  filtergraph’s second output.
* *Encoders* receive raw audio, video, or subtitle *frames* and encode
  them into encoded *packets*. The encoding (compression) process is
  typically *lossy* - it degrades stream quality to make the output smaller;
  some encoders are *lossless*, but at the cost of much higher output size. A
  video or audio encoder receives its input from some filtergraph’s output,
  subtitle encoders receive input from a decoder (since subtitle filtering is not
  supported yet). Every encoder is associated with some muxer’s *output
  elementary stream* and sends its output to that muxer.

  A schematic representation of an encoder looks like this:

  ```
               ┌─────────┐
   raw frames  │         │ packets
  ────────────►│ encoder ├─────────►
               │         │
               └─────────┘
  ```
* *Muxers* (short for "multiplexers") receive encoded *packets* for
  their elementary streams from encoders (the *transcoding* path) or directly
  from demuxers (the *streamcopy* path), interleave them (when there is more
  than one elementary stream), and write the resulting bytes into the output file
  (or pipe, network stream, etc.).

  A schematic representation of a muxer looks like this:

  ```
                         ┌──────────────────────┬───────────┐
   packets for stream 0  │                      │   muxer   │
  ──────────────────────►│  elementary stream 0 ╞═══════════╡
                         │                      │           │
                         ├──────────────────────┤  global   │
   packets for stream 1  │                      │properties │
  ──────────────────────►│  elementary stream 1 │   and     │
                         │                      │ metadata  │
                         ├──────────────────────┤           │
                         │                      │           │
                         │     ...........      │           │
                         │                      │           │
                         ├──────────────────────┤           │
   packets for stream N  │                      │           │
  ──────────────────────►│  elementary stream N │           │
                         │                      │           │
                         └──────────────────────┴─────┬─────┘
                                                      │
                       write to file, network stream, │
                           grabbing device, etc.      │
                                                      │
                                                      ▼
  ```

### [3.1 Streamcopy](#toc-Streamcopy)

The simplest pipeline in `ffmpeg` is single-stream
*streamcopy*, that is copying one *input elementary stream*’s packets
without decoding, filtering, or encoding them. As an example, consider an input
file called `INPUT.mkv` with 3 elementary streams, from which we take the
second and write it to file `OUTPUT.mp4`. A schematic representation of
such a pipeline looks like this:

```
┌──────────┬─────────────────────┐
│ demuxer  │                     │ unused
╞══════════╡ elementary stream 0 ├────────╳
│          │                     │
│INPUT.mkv ├─────────────────────┤          ┌──────────────────────┬───────────┐
│          │                     │ packets  │                      │   muxer   │
│          │ elementary stream 1 ├─────────►│  elementary stream 0 ╞═══════════╡
│          │                     │          │                      │OUTPUT.mp4 │
│          ├─────────────────────┤          └──────────────────────┴───────────┘
│          │                     │ unused
│          │ elementary stream 2 ├────────╳
│          │                     │
└──────────┴─────────────────────┘
```

The above pipeline can be constructed with the following commandline:

```
ffmpeg -i INPUT.mkv -map 0:1 -c copy OUTPUT.mp4
```

In this commandline

* there is a single input `INPUT.mkv`;
* there are no input options for this input;
* there is a single output `OUTPUT.mp4`;
* there are two output options for this output:
  + `-map 0:1` selects the input stream to be used - from input with index 0
    (i.e. the first one) the stream with index 1 (i.e. the second one);
  + `-c copy` selects the `copy` encoder, i.e. streamcopy with no decoding
    or encoding.

Streamcopy is useful for changing the elementary stream count, container format,
or modifying container-level metadata. Since there is no decoding or encoding,
it is very fast and there is no quality loss. However, it might not work in s