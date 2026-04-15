---
name: graphicsmagick
description: GraphicsMagick is a multi-threaded image processing system used to convert, transform, and inspect images across numerous formats. Use when user asks to convert image formats, resize images, batch process files, extract metadata, create montages, or composite images.
homepage: http://www.graphicsmagick.org/
metadata:
  docker_image: "quay.io/biocontainers/graphicsmagick:1.3.46"
---

# graphicsmagick

## Overview
GraphicsMagick is a robust, multi-threaded image processing system designed for efficiency and stability. It is often referred to as the "Swiss Army knife" of image processing. This skill provides guidance on using the `gm` utility to execute common image tasks such as converting between over 92 formats, applying transformations, and inspecting image metadata. It is particularly useful for high-volume production environments where performance and low resource consumption are critical.

## Core CLI Patterns
All GraphicsMagick operations are executed through the primary `gm` executable followed by a sub-command.

### 1. Image Conversion and Resizing (`convert`)
The `convert` command is the most versatile tool for transforming images.
- **Basic Conversion**: `gm convert input.tiff output.jpg`
- **Resize with Aspect Ratio**: `gm convert input.jpg -resize 800x600 output.jpg`
- **Resize to Fixed Width**: `gm convert input.jpg -resize 800x output.jpg`
- **Change Quality/Compression**: `gm convert input.jpg -quality 85 output.jpg`

### 2. Batch Processing (`mogrify`)
Use `mogrify` to apply transformations to multiple files in place. **Warning**: This overwrites the original files.
- **Batch Resize**: `gm mogrify -resize 50% *.png`
- **Batch Format Conversion**: `gm mogrify -format jpg *.tiff`

### 3. Image Inspection (`identify`)
Use `identify` to extract metadata and characteristics.
- **Basic Info**: `gm identify image.png`
- **Detailed Metadata**: `gm identify -verbose image.jpg`
- **Format Specifics**: `gm identify -format "%w x %h %m" image.png` (Outputs width, height, and format)

### 4. Creating Montages (`montage`)
Combine multiple images into a single tiled grid.
- **Basic Grid**: `gm montage *.jpg output.png`
- **Thumbnail Grid with Labels**: `gm montage -label "%f" -frame 5 -tile 4x -geometry 120x120+10+10 *.jpg archive.png`

### 5. Image Composition (`composite`)
Overlay one image on top of another.
- **Watermarking**: `gm composite -gravity center watermark.png base_image.jpg result.jpg`

## Expert Tips and Best Practices
- **OpenMP Acceleration**: GraphicsMagick automatically uses multiple CPU cores. You can limit threads for resource-constrained environments using `-limit threads 2` or the `OMP_NUM_THREADS` environment variable.
- **Memory Limits**: For very large images (gigapixel scale), use `-limit memory 1GB -limit map 2GB` to prevent the process from consuming all system RAM.
- **Input/Output Efficiency**: When processing many small files, use the `gm batch` command to execute multiple commands in a single process, reducing startup overhead.
- **Color Profiles**: To ensure color accuracy during conversion, use `-profile` to attach or transform ICC color profiles.
- **In-Memory Processing**: Use the `logo:` or `granite:` patterns for testing without needing external files (e.g., `gm convert logo: test.png`).

## Reference documentation
- [GraphicsMagick Utilities](./references/www_graphicsmagick_org_utilities.html.md)
- [GraphicsMagick Overview](./references/www_graphicsmagick_org_index.html.md)
- [OpenMP in GraphicsMagick](./references/www_graphicsmagick_org_OpenMP.html.md)