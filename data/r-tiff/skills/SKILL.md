---
name: r-tiff
description: The r-tiff package provides an interface for reading and writing TIFF images in R using the libtiff library. Use when user asks to read TIFF files into arrays, write matrices to TIFF format, handle multi-page TIFFs, or process image data in memory.
homepage: https://cloud.r-project.org/web/packages/tiff/index.html
---

# r-tiff

## Overview
The `tiff` package provides an efficient interface between R and the `libtiff` library. It allows for the reading and writing of TIFF images, supporting various color spaces (grayscale, RGB, RGBA), bit depths, and multi-directory (multi-page) TIFF files. It can process data from files or directly from raw vectors in memory.

## Installation
To install the package from CRAN:
```R
install.packages("tiff")
```

## Core Functions

### Reading TIFF Images
Use `readTIFF()` to import images. By default, it returns a numeric array with values ranging from 0 to 1.

*   **Basic Read**: `img <- readTIFF("image.tif")`
*   **As Native Raster**: `img <- readTIFF("image.tif", native = TRUE)` (preferred for plotting with `rasterImage()`).
*   **Multi-page TIFFs**: `img_list <- readTIFF("multi.tif", all = TRUE)` returns a list of arrays/rasters.
*   **Metadata**: `img <- readTIFF("image.tif", info = TRUE)` attaches TIFF tags as attributes.

### Writing TIFF Images
Use `writeTIFF()` to export data. It accepts matrices (grayscale) or 3D arrays (RGB/RGBA).

*   **Basic Write**: `writeTIFF(img_array, "output.tif")`
*   **Compression**: `writeTIFF(img_array, "output.tif", compression = "LZW")` (Supports "none", "packbits", "LZW", "Deflate", "JPEG").
*   **Bit Depth**: Control output depth via `bits.per.sample` (e.g., 8 or 16).
*   **Append**: `writeTIFF(img_array, "existing.tif", append = TRUE)` to create multi-page files.

## Common Workflows

### Displaying a TIFF Image
```R
library(tiff)
img <- readTIFF("image.tif", native = TRUE)
plot(1:2, type='n', xlab="", ylab="")
rasterImage(img, 1, 1, 2, 2)
```

### Converting Between Formats
To process a TIFF and save it back:
```R
img <- readTIFF("input.tif")
# Apply a transformation (e.g., darken)
processed_img <- img * 0.5
writeTIFF(processed_img, "output.tif", compression = "Deflate")
```

### Handling In-Memory Data
The package can bypass the file system using raw vectors:
```R
# Write to a raw vector instead of a file
raw_data <- writeTIFF(img_array, raw())

# Read from a raw vector
img <- readTIFF(raw_data)
```

## Tips and Constraints
*   **Color Channels**: For RGB images, the array dimensions are `[height, width, channels]`.
*   **Memory**: Large TIFF files (especially uncompressed or high-bit-depth) can consume significant RAM. Use `native = TRUE` to reduce memory overhead if only displaying the image.
*   **Indexing**: R arrays are indexed `[row, column]`, which corresponds to `[y, x]` in image coordinates.

## Reference documentation
- [tiff: Read and Write TIFF Images](./references/home_page.md)
- [Package Index](./references/index.html.md)