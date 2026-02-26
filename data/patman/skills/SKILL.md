---
name: patman
description: Patman is a specialized fork of the x265 HEVC encoder that enhances input pipeline management and progress monitoring for video compression. Use when user asks to encode video using Avisynth or Vapoursynth frame-servers, process Y4M inputs with XLENGTH tags, or utilize an enhanced CLI progress bar.
homepage: https://github.com/Patman86/x265-Mod-by-Patman
---


# patman

## Overview

The `patman` skill facilitates the use of Patman's specialized fork of the x265 HEVC encoder. This mod is a drop-in replacement for standard x265 that introduces critical enhancements for video enthusiasts and professionals. It is primarily used to improve the input pipeline—specifically for users of frame-servers like Avisynth and Vapoursynth—and to provide more detailed feedback during the compression of high-definition video content.

## Tool-Specific Best Practices

### Input Pipeline Management
*   **Y4M XLENGTH Support**: When using Y4M (YUV4MPEG2) inputs, this mod correctly interprets the `XLENGTH` tag. Use this to ensure the encoder accurately calculates total frames and time estimates when the input header provides length metadata.
*   **External Library Loading**: Unlike standard builds that may be statically linked or restricted to system-path libraries, this mod allows for loading external Avisynth and Vapoursynth libraries. This is essential for portable encoding setups or when testing specific versions of these frame-servers.

### Monitoring and UI
*   **Extended Progress Bar**: The mod features an enhanced CLI progress bar. Use this to get more granular feedback on the encoding status compared to the standard x265 output.
*   **Log Level Awareness**: The mod adjusts CLI logging for Avisynth and Vapoursynth based on the global x265 log level. Use `--log-level` to control the verbosity of the frame-server initialization messages.

## Common CLI Patterns

The tool follows the standard x265 command-line structure while incorporating mod-specific logic internally:

```bash
x265 [options] --input <input_file> -o <output_file>
```

### Recommended Usage Scenarios
*   **For Avisynth/Vapoursynth Users**: Use this mod if you encounter issues with the encoder recognizing your frame-server environment. It is designed to be more robust in detecting and linking to these external libraries.
*   **For Accurate Progress Tracking**: If you are encoding a stream where the frame count is only known via the Y4M header's `XLENGTH` tag, this mod will provide a correct progress percentage and ETA where other builds might fail or show "unknown."

## Expert Tips
*   **Drop-in Compatibility**: Since this is a mod of x265, all standard x265 parameters (e.g., `--crf`, `--preset`, `--tune`, `--profile`) remain fully functional.
*   **Build Verification**: When troubleshooting, check the version string. Patman's builds typically include a specific version suffix (e.g., `+Mod-by-Patman`) to confirm the modded features are active.
*   **Performance**: The core encoding engine is identical to the upstream x265; performance gains or losses are generally negligible, as the mod focuses on the "wrapper" functionality (I/O and UI).

## Reference documentation
- [Main Repository README](./references/github_com_Patman86_x265-Mod-by-Patman.md)
- [Project Wiki](./references/github_com_Patman86_x265-Mod-by-Patman_wiki.md)