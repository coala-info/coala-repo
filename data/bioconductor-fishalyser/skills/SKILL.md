---
name: bioconductor-fishalyser
description: FISHalyseR provides automated processing of fluorescence in situ hybridisation images to identify nuclei and quantify probe signals. Use when user asks to process FISH images, detect probes in multiple color channels, calculate probe counts and distances, or perform image thresholding and particle analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/FISHalyseR.html
---

# bioconductor-fishalyser

## Overview

FISHalyseR is an R package designed for the automated processing of FISH (fluorescence in situ hybridisation) images. It provides a streamlined workflow to identify cell nuclei, detect FISH probes in multiple color channels, and output quantitative data including probe counts, areas, and inter-probe distances. It leverages the `EBImage` package for image manipulation.

## Loading the Package

```r
library(FISHalyseR)
```

## Core Workflow: processFISH

The primary function is `processFISH`, which handles the entire pipeline from image reading to CSV output.

### Key Parameters
- `combinedImg`: Path to the composite RGB image.
- `writedir`: Directory where results (CSV and annotated images) will be saved.
- `bgCorrMethod`: A list defining the illumination correction:
  - `list(0, '')`: No correction.
  - `list(1, sigma)`: Gaussian blur (e.g., `list(1, 100)`).
  - `list(2, "/path/to/image")`: User-provided illumination image.
  - `list(3, "/path/stack", "*.jpg", n)`: Multidimensional correction using a stack of $n$ images.
- `channelSignals`: A list of paths to individual probe channel images (or the composite image if only RGB is available).
- `channelColours`: A list of RGB vectors for visualization (e.g., `list(R=c(255,0,0), G=c(0,255,0))`).
- `sizeNucleus`: A vector `c(min, max)` defining the area range for nuclei.
- `sizeProbe`: A vector `c(min, max)` defining the area range for probes.

### Example Execution
```r
# Define paths
combinedImage <- system.file("extdata", "SampleFISH.jpg", package="FISHalyseR")
red_Ch <- system.file("extdata", "SampleFISH_R.jpg", package="FISHalyseR")
green_Ch <- system.file("extdata", "SampleFISH_G.jpg", package="FISHalyseR")

# Setup parameters
bgCorr <- list(0, '')
signals <- list(red_Ch, green_Ch)
colors <- list(R=c(255,0,0), G=c(0,255,0))
nucSize <- c(1000, 20000)
probeSize <- c(5, 20)

# Run analysis
processFISH(combinedImage, "output_dir", bgCorr, signals, colors, nucSize, probeSize)
```

## Image Thresholding and Particle Analysis

If manual preprocessing is required before using the main pipeline, use these modular functions:

### Thresholding Methods
- **Max Entropy**: `calculateMaxEntropy(img)` - Best for reliable probe detection by maximizing inter-class entropy.
- **Otsu**: `calculateThreshold(img)` - Standard method for separating nuclei from background by minimizing intra-class variance.

### Cleaning Images
Use `analyseParticles` to remove artifacts based on size constraints:
```r
# Remove components smaller than 5 and larger than 20 pixels
cleaned_img <- analyseParticles(binary_img, MaxSize=20, MinSize=5, is_label=0)
```

## Interpreting Results

The package generates a CSV file containing:
- **cell id**: Unique identifier for each nucleus.
- **eccentricity**: Shape feature of the nucleus.
- **number of [Color] probes**: Count of detected signals per channel.
- **[Color]1 [Color]2**: Distances (in pixels) between probes within the same or different channels.
- **X/Y center of mass**: Spatial coordinates of the nucleus.
- **AR[n]**: Area of the $n$-th probe in pixels.

An annotated image is also produced where nuclei outlines are shown in cyan and detected probes are highlighted in their respective colors.

## Reference documentation

- [FISHalyseR](./references/FISHalyseR.md)