---
name: bioconductor-spotsegmentation
description: This package performs automated microarray image segmentation using model-based clustering to distinguish spots from background. Use when user asks to identify spot boundaries, segment microarray images into foreground and background pixels, or extract quantitative intensity data from microarray spots.
homepage: https://bioconductor.org/packages/3.6/bioc/html/spotSegmentation.html
---


# bioconductor-spotsegmentation

## Overview

The `spotSegmentation` package provides tools for the automated processing of microarray images. It uses model-based clustering (via the `mclust` package) to segment spots from the background, offering a robust alternative to fixed-circle or simple thresholding methods. The workflow typically involves three main stages: image preprocessing (transformation), gridding (identifying spot boundaries), and segmentation (classifying pixels as background, sample, or uncertain).

## Core Workflow

### 1. Data Preparation
Microarray data often requires transformation before processing. The package includes a test dataset `spotSegTest` which demonstrates a common transformation for 16-bit TIFF intensities.

```r
library(spotSegmentation)
data(spotSegTest)

# Example transformation for the test data
dataTransformation <- function(x) (256*256-1-x)^2*4.71542407E-05

# Convert vectors to matrices (e.g., 144x199 for the test set)
chan1 <- matrix(dataTransformation(spotSegTest[,1]), 144, 199)
chan2 <- matrix(dataTransformation(spotSegTest[,2]), 144, 199)
```

### 2. Gridding with `spotgrid`
Before segmenting individual spots, you must define the grid. `spotgrid` determines the row and column delimiters.

```r
# rows and cols refer to the number of spots in the block
grid <- spotgrid(chan1, chan2, rows = 4, cols = 6, show = TRUE)
# Returns a list with rowcut and colcut
```

### 3. Segmentation with `spotseg`
The `spotseg` function performs the actual clustering. It requires the `mclust` package to be loaded.

```r
library(mclust)

# Segment the entire block
seg_results <- spotseg(chan1, chan2, grid$rowcut, grid$colcut)

# Segment a specific spot (e.g., Row 1, Column 1)
spot_1_1 <- spotseg(chan1, chan2, grid$rowcut, grid$colcut, R = 1, C = 1)
```

### 4. Visualization and Summary
The package provides S3 methods to interpret the `spotseg` object.

```r
# Plot the segmentation results
plot(seg_results)

# Get mean/median foreground and background intensities
stats <- summary(seg_results)
# Access via: stats$channel1$foreground$mean
```

## Key Functions

- `spotgrid(chan1, chan2, rows, cols, ...)`: Estimates the horizontal and vertical lines separating spots.
- `spotseg(chan1, chan2, rowcut, colcut, ...)`: Labels pixels: 1=background, 2=uncertain, 3=sample.
- `plotBlockImage(z)`: A utility to display a matrix as a microarray image block.
- `summary.spotseg(object)`: Extracts quantitative intensity data from the segmented pixels.

## Usage Tips

- **Memory Management**: For very large images, segmenting the entire block at once can be memory-intensive. Use the `R` and `C` arguments in `spotseg` to process spots individually or in subsets if necessary.
- **Thresholding**: The `threshold` argument in `spotseg` (default 100) ignores connected components smaller than the specified size, which helps filter out noise.
- **Initialization**: By default, `hc = FALSE` uses quantiles for EM initialization, which is faster and uses less memory than hierarchical clustering.

## Reference documentation

- [spotSegmentation Reference Manual](./references/reference_manual.md)