---
name: ffmpeg
description: FFmpeg is a command-line tool for processing audio and video files. Use when user asks to convert video and audio formats, transcode media streams, perform basic video editing, resize video, apply filters, or extract media information.
homepage: https://github.com/FFmpeg/FFmpeg
metadata:
  docker_image: "quay.io/biocontainers/ffmpeg:7.1.1"
---

# ffmpeg

yaml
name: ffmpeg
description: |
  A powerful command-line tool for processing audio and video files.
  Use this skill when Claude needs to perform tasks such as:
  - Converting video and audio formats.
  - Transcoding media streams.
  - Basic video editing (trimming, concatenating).
  - Resizing or scaling video.
  - Applying filters to audio or video.
  - Extracting information from media files.
```
## Overview
FFmpeg is a versatile and robust command-line utility for handling multimedia files and streams. It excels at a wide range of tasks including format conversion, transcoding, basic editing operations like trimming and joining clips, resizing video, applying complex audio and video filters, and extracting detailed metadata from media. It's the go-to tool for programmatic manipulation of audio and video content.

## Core Usage and Best Practices

FFmpeg's power lies in its extensive command-line options. The general syntax is:

```bash
ffmpeg [global_options] {[input_file_options] -i input_url} ... {[output_file_options] output_url} ...
```

### Common Operations and Tips

1.  **Format Conversion:**
    *   Convert MP4 to AVI:
        ```bash
        ffmpeg -i input.mp4 output.avi
        ```
    *   Convert MP3 to AAC:
        ```bash
        ffmpeg -i input.mp3 output.aac
        ```

2.  **Video Transcoding (Changing Codec):**
    *   Convert H.264 to VP9:
        ```bash
        ffmpeg -i input.mp4 -c:v libvpx-vp9 -c:a libopus output.webm
        ```
        *   `-c:v`: specifies the video codec.
        *   `-c:a`: specifies the audio codec.

3.  **Trimming/Cutting Videos:**
    *   Extract a segment from 10 seconds to 20 seconds:
        ```bash
        ffmpeg -ss 00:00:10 -i input.mp4 -to 00:00:20 -c copy output.mp4
        ```
        *   `-ss`: start time.
        *   `-to`: end time.
        *   `-c copy`: avoids re-encoding, making it very fast and lossless for keyframes. For precise cuts, re-encoding might be necessary (remove `-c copy`).

4.  **Concatenating Videos:**
    *   **Method 1: Using `concat` demuxer (preferred for same codecs/parameters):**
        Create a text file (e.g., `mylist.txt`):
        ```
        file 'input1.mp4'
        file 'input2.mp4'
        ```
        Then run:
        ```bash
        ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.mp4
        ```
        *   `-f concat`: specifies the concat demuxer.
        *   `-safe 0`: required for relative paths in `mylist.txt`.

    *   **Method 2: Using `concat` filter (more flexible, handles different codecs):**
        ```bash
        ffmpeg -i input1.mp4 -i input2.mp4 -filter_complex "[0:v:0][0:a:0][1:v:0][1:a:0]concat=n=2:v=1:a=1[outv][outa]" -map "[outv]" -map "[outa]" output.mp4
        ```
        *   `n=2`: number of input files.
        *   `v=1`: number of video streams.
        *   `a=1`: number of audio streams.

5.  **Resizing Videos:**
    *   Resize to 1280x720:
        ```bash
        ffmpeg -i input.mp4 -vf scale=1280:720 output.mp4
        ```
    *   Resize to a width of 640, maintaining aspect ratio:
        ```bash
        ffmpeg -i input.mp4 -vf scale=640:-1 output.mp4
        ```
        *   `-1` tells FFmpeg to calculate the height automatically.

6.  **Extracting Audio:**
    *   Extract audio from a video to MP3:
        ```bash
        ffmpeg -i input.mp4 -vn -acodec libmp3lame -q:a 2 output.mp3
        ```
        *   `-vn`: disables video recording.
        *   `-acodec libmp3lame`: specifies MP3 encoder.
        *   `-q:a 2`: sets audio quality (lower is better, 0-9).

7.  **Extracting Thumbnails:**
    *   Extract a single thumbnail at 1 second:
        ```bash
        ffmpeg -i input.mp4 -ss 00:00:01 -vframes 1 output.png
        ```
        *   `-vframes 1`: extracts only one video frame.

8.  **Getting Media Information:**
    *   Use `ffprobe` (often bundled with FFmpeg) for detailed analysis:
        ```bash
        ffprobe input.mp4
        ```
        *   To get specific info like duration:
            ```bash
            ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 input.mp4
            ```

### Expert Tips

*   **`-hide_banner`**: Suppresses printing the FFmpeg version and configuration information, useful for cleaner output.
*   **`-loglevel error`**: Reduces verbose output, showing only errors. Use `-loglevel warning`, `-loglevel info`, or `-loglevel debug` for more detail.
*   **`-y`**: Overwrite output files without asking. Use with caution.
*   **`-map`**: Explicitly select streams (video, audio, subtitle) to include in the output. Essential for complex multiplexing.
*   **`-threads`**: Control the number of threads used for encoding. `0` usually means auto-detection.
*   **`-progress`**: Show real-time progress information.
*   **Filters (`-vf`, `-af`)**: FFmpeg's filter system is extremely powerful. Explore the documentation for complex operations like overlaying images, adding text, color correction, audio mixing, etc.

## Reference documentation
- [FFmpeg Documentation](https://ffmpeg.org/documentation.html)