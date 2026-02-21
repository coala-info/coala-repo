---
name: r-png
description: This package provides an easy and simple way to read, write and display bitmap images stored in the PNG format. It can read and write both files and in-memory raw vectors.</p>
homepage: https://cloud.r-project.org/web/packages/png/index.html
---

# r-png

## Overview
The `png` package provides a streamlined interface for reading and writing PNG (Portable Network Graphics) images in R. It supports conversion between PNG files/raw vectors and R arrays, handling various color spaces (Grayscale, GA, RGB, RGBA) and metadata.

## Installation
```R
install.packages("png")
```

## Core Functions

### Reading PNG Images
Use `readPNG()` to import images.
- **Default behavior**: Returns a numeric array/matrix with values between 0 and 1.
- **Dimensions**: `[height, width, channels]`.
- **Native Raster**: Set `native = TRUE` for a `nativeRaster` object, which is optimized for `rasterImage()` plotting but not for mathematical manipulation.
- **Metadata**: Set `info = TRUE` to extract bit depth, resolution, and custom text chunks.

```R
library(png)

# Read from file
img <- readPNG("path/to/image.png")

# Read with metadata
img_with_info <- readPNG("path/to/image.png", info = TRUE)
metadata <- attr(img_with_info, "info")
```

### Writing PNG Images
Use `writePNG()` to export R arrays or matrices to PNG format.
- **Input**: A matrix (grayscale) or 3D array (RGB/RGBA) with values 0-1.
- **Target**: Can be a file path or `raw()` to return a raw vector.
- **Metadata**: Supports `text` (named character vector) and `metadata` (any R object).

```R
# Write array to file
writePNG(img, target = "output.png")

# Write to a raw vector (in-memory)
png_raw <- writePNG(img, target = raw())

# Include metadata and DPI
writePNG(img, "output.png", dpi = 300, text = c(source = "R stats"))
```

## Common Workflows

### Displaying Images
To plot a PNG image using R's base graphics:
```R
img <- readPNG(system.file("img", "Rlogo.png", package="png"))
plot(1:2, type='n', xlab="", ylab="")
rasterImage(img, 1, 1, 2, 2)
```

### Handling Transparency (Alpha Channel)
If an image has 4 channels (RGBA), the 4th slice represents transparency.
- `img[,,4]` contains alpha values.
- Note: Some R devices (like older Windows devices) may require flattening the alpha channel or converting to a raster object with `NA` values for transparency before plotting.

### Embedding R Objects
You can store and retrieve actual R objects within a PNG file's metadata:
```R
# Save with an R object
writePNG(img, "data.png", metadata = list(model_results = my_lm_fit))

# Read back the object
img_in <- readPNG("data.png", info = TRUE)
my_fit <- attr(img_in, "metadata")
```

## Tips and Constraints
- **Value Clipping**: `writePNG` clips values outside the 0-1 range. Ensure data is normalized before writing.
- **Bit Depth**: `readPNG` supports 16-bit channels, but `writePNG` currently exports 8-bit images (truncating the 8 least significant bits).
- **Color Spaces**: 
  - 1 channel: Grayscale
  - 2 channels: Grayscale + Alpha
  - 3 channels: RGB
  - 4 channels: RGB + Alpha
- **Performance**: For high-speed plotting without manipulation, always use `native = TRUE` in `readPNG`.

## Reference documentation
- [Package Manual](./references/reference_manual.md)