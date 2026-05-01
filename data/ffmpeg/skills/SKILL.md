---
name: ffmpeg
description: FFmpeg is a comprehensive multimedia framework used to process, transcode, and analyze video and audio streams. Use when user asks to convert media formats, scale video resolution, trim clips, extract audio, concatenate files, or apply complex filtergraphs.
homepage: https://www.ffmpeg.org/ffmpeg.html
metadata:
  docker_image: "quay.io/biocontainers/ffmpeg:7.1.1"
---


# ffmpeg

## Overview

FFmpeg is the industry-standard multimedia framework for handling video, audio, and other multimedia streams. This skill provides procedural knowledge for constructing efficient transcoding pipelines, applying complex filtergraphs, and performing deep stream analysis. It transforms general media requests into precise, high-performance command-line operations that leverage FFmpeg's modular architecture of demuxers, decoders, filters, and encoders.

## Core Command Structure

The `ffmpeg` command follows a strict order of operations. Options applied to an input do not carry over to the output.

```bash
ffmpeg [global_options] {[input_file_options] -i input_url} ... {[output_file_options] output_url} ...
```

- **Global Options**: Verbosity (`-loglevel`), overwriting files (`-y`), or hardware acceleration (`-hwaccel`).
- **Input Options**: Seek position (`-ss`), duration (`-t`), or forced format (`-f`).
- **Output Options**: Codecs (`-c:v`, `-c:a`), bitrates (`-b:v`), and mapping (`-map`).

## Stream Selection and Mapping

By default, FFmpeg selects only one stream of each type. Use the `-map` option for precise control.

- **Manual Selection**: `-map 0:v:0` (first video stream of first input) or `-map 0:a` (all audio streams of first input).
- **Streamcopy**: Use `-c copy` to bypass decoding and encoding. This is lossless and extremely fast.
  - *Example*: `ffmpeg -i input.mkv -map 0 -c copy output.mp4` (re-wraps all streams into a new container).

## Common CLI Patterns

### Transcoding and Scaling
To change format while resizing:
```bash
ffmpeg -i input.mov -vf "scale=1280:720" -c:v libx264 -crf 23 -c:a aac output.mp4
```

### Trimming and Seeking
- **Input Seeking (Fast)**: `ffmpeg -ss 00:01:00 -i input.mp4 ...` (jumps to keyframe).
- **Output Seeking (Accurate)**: `ffmpeg -i input.mp4 -ss 00:01:00 ...` (decodes until timestamp).

### Extracting Audio
```bash
ffmpeg -i video.mp4 -vn -c:a libmp3lame -q:a 2 audio.mp3
```

### Concatenation
For files with identical codecs, use the `concat` demuxer to avoid re-encoding:
```bash
ffmpeg -f concat -safe 0 -i filelist.txt -c copy output.mp4
```

## Filtergraphs

Filters process raw frames between the decoder and encoder.

- **Simple Filtergraphs**: Single input/output. Use `-vf` (video) or `-af` (audio).
  - *Example*: `-vf "yadif,scale=640:480"` (deinterlace then scale).
- **Complex Filtergraphs**: Multiple inputs or outputs. Use `-filter_complex`.
  - *Example (Overlaying a logo)*: `ffmpeg -i video.mp4 -i logo.png -filter_complex "[0:v][1:v]overlay=10:10" output.mp4`

## Media Analysis with ffprobe

Use `ffprobe` to inspect stream properties without processing.

- **JSON Output**: `ffprobe -v error -show_format -show_streams -of json input.mp4`
- **Check Duration**: `ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 input.mp4`

## Expert Tips

1. **Order Matters**: Always place `-ss` before `-i` for fast seeking unless frame-accuracy is failing.
2. **CRF vs Bitrate**: For H.264/H.265, prefer `-crf` (Constant Rate Factor) for quality-based encoding over `-b:v` for bitrate-based encoding.
3. **Hardware Acceleration**: Check available decoders with `ffmpeg -decoders | grep h264`. Use `-hwaccel` (e.g., `cuda`, `videotoolbox`, `vaapi`) to reduce CPU load.
4. **Diagnostic Logs**: If a command fails, use `-report` to generate a full log file for debugging.
5. **Twitter/X Uploads**: Recommend `-vf "scale=1920:-2" -pix_fmt yuv420p -r 30` to cap width at 1920 px, preserve aspect ratio with an even height, use broad player-compatible pixel format, and normalize frame rate to 30 fps.



## Subcommands

| Command | Description |
|---------|-------------|
| ffmpeg | Universal media converter |

## Reference documentation
- [ffmpeg Documentation](./references/www_ffmpeg_org_documentation.html.md)
- [ffmpeg Tool Manual](./references/www_ffmpeg_org_ffmpeg.html.md)
- [ffprobe Analysis Tool](./references/www_ffmpeg_org_ffprobe.html.md)
- [FFmpeg Filters Reference](./references/www_ffmpeg_org_ffmpeg-filters.html.md)