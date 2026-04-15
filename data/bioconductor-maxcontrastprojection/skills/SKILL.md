---
name: bioconductor-maxcontrastprojection
description: This tool performs 3D to 2D image projections by identifying the focal plane based on local variance. Use when user asks to project 3D image stacks into 2D, perform maximum contrast projections, or identify in-focus z-layers using local contrast.
homepage: https://bioconductor.org/packages/3.8/bioc/html/MaxContrastProjection.html
---

# bioconductor-maxcontrastprojection

name: bioconductor-maxcontrastprojection
description: Perform 3D to 2D image projections using the MaxContrastProjection R package. Use this skill when you need to project 3D image stacks into 2D, specifically when standard maximum intensity projections (MIP) fail to capture fine structures or when you need to identify the focal plane based on local variance (contrast).

# bioconductor-maxcontrastprojection

## Overview

The `MaxContrastProjection` package provides tools for projecting 3D image stacks into 2D images. While it supports standard methods like maximum, minimum, and mean intensity projections, its primary innovation is the **Maximum Contrast Projection**. This method determines the "in-focus" z-layer for every pixel by calculating the local variance (contrast) within a specified window. This is particularly useful for biological samples like organoids or thick tissue sections where fine details are often obscured by out-of-focus blur in traditional intensity-based projections.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MaxContrastProjection")
```

## Core Workflow: Maximum Contrast Projection

The primary function is `contrastProjection()`. It requires a 3D array where the first two dimensions are spatial (x, y) and the third is the z-stack.

### Basic Usage
```r
library(MaxContrastProjection)
library(EBImage) # Often used for image handling

# Load example data
data(cells)

# Perform projection
max_contrast <- contrastProjection(
  imageStack = cells, 
  w_x = 15,           # Window radius x
  w_y = 15,           # Window radius y
  smoothing = 5,      # Median filter radius for the index map
  brushShape = "box"  # "box" or "disc"
)

display(max_contrast)
```

### Key Parameters
- `w_x`, `w_y`: The radii of the window used to calculate variance. The window should be large enough to encompass the structures of interest to avoid artifacts.
- `smoothing`: Applies a median filter to the projection index map. This prevents "harsh jumps" between z-layers in the final 2D image, ensuring spatial continuity.
- `brushShape`: Use `"box"` for rectangular windows or `"disc"` for radially symmetrical structures.

## Advanced Workflows

### Manual Step-by-Step Projection
You can decompose the process to inspect the contrast values or the index map (which z-layer was chosen for each pixel).

```r
# 1. Generate a stack of contrast values
contrastStack <- getContrastStack(cells, w_x = 15, w_y = 15, brushShape = "box")

# 2. Generate the index map (the z-layer indices)
indexMap <- getIndexMap(contrastStack, smoothing = 5)

# 3. Create the projection from the map
max_contrast_custom <- projection_fromMap(cells, indexMap = indexMap)
```

### Interpolation
To avoid artificial boundaries between discrete focal planes, the package supports linear interpolation if the `indexMap` contains non-integer values (e.g., from blurring the map). The `projection_fromMap` function handles this by calculating a weighted linear combination of adjacent layers.

## Standard Intensity Projections

The package also provides a wrapper for traditional projection methods via `intensityProjection()`:

```r
# Supported types: "max", "min", "mean", "median", "sd", "sum"
max_int  <- intensityProjection(cells, projType = "max")
sd_proj  <- intensityProjection(cells, projType = "sd")
sum_proj <- intensityProjection(cells, projType = "sum")
```

## Tips for Success
- **Window Size**: If you see "salt and pepper" artifacts where pixels seem to come from random z-layers, increase `w_x` and `w_y`.
- **Smoothing**: If the projection looks "patchy," increase the `smoothing` parameter to force neighboring pixels to be selected from similar z-layers.
- **Data Format**: Ensure your input is a 3D array. If using `EBImage` objects, they are typically compatible as they inherit from the array class.

## Reference documentation
- [MaxContrastProjection](./references/MaxContrastProjection.md)