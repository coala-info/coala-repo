---
name: bioconductor-donapllp2013
description: This package provides data and code to reproduce lifetime-ratio fluorescence intensity analysis of the zebrafish posterior lateral line primordium. Use when user asks to analyze protein stability, calculate RFP/GFP fluorescence ratios from dual-color z-stacks, or perform spatial image analysis on migrating tissue.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DonaPLLP2013.html
---


# bioconductor-donapllp2013

name: bioconductor-donapllp2013
description: Analysis of lifetime-ratio fluorescence intensity in the posterior lateral line primordium (PLLP) using the DonaPLLP2013 experiment data package. Use when analyzing cxcr4b receptor stability, protein turnover, or reproducing the image analysis pipeline for dual-color z-stacks of zebrafish primordia.

# bioconductor-donapllp2013

## Overview

The `DonaPLLP2013` package provides the data and code required to reproduce the lifetime-ratio analysis of the posterior lateral line primordium (PLLP) as described in Donà et al. (2013). It focuses on extracting fluorescence intensity ratios from dual-color confocal z-stacks (GFP and RFP channels) to measure protein stability and age across the migration axis of the tissue.

## Core Workflow

### 1. Data Loading and Preprocessing
Load the package and example image data. The package uses `EBImage` for image manipulation.

```r
library(DonaPLLP2013)
library(EBImage)

# Load example GFP and RFP channels
xGFP <- readImage(system.file("extdata/cxcr4b_02C1.tif", package="DonaPLLP2013"))
xRFP <- readImage(system.file("extdata/cxcr4b_02C2.tif", package="DonaPLLP2013"))

# Background subtraction using background images
xbckGFP <- readImage(system.file("extdata/bgC1.tif", package="DonaPLLP2013"))
xGFP <- xGFP - mean(xbckGFP, na.rm=TRUE)
```

### 2. Segmentation and Masking
Create a membrane mask using adaptive thresholding on the GFP channel (the reference channel).

```r
# Adaptive thresholding
Leff <- 38 # Characteristic length in pixels
mask <- thresh(xGFP, w=Leff, h=Leff, offset=0.01)
mask <- erode(closing(mask, makeBrush(5, "disc")), makeBrush(3, "disc"))
```

### 3. Alignment and Spatial Analysis
Align the primordium along its axis of migration using Principal Component Analysis (PCA) on the tissue mask.

```r
# Rotate images to align with migration axis
# pc1.theta is calculated from PCA on organ coordinates
xGFP_rot <- rotate(xGFP, angle=pc1.theta)
xRFP_rot <- rotate(xRFP, angle=pc1.theta)
```

### 4. Lifetime Ratio Calculation
Calculate the RFP/GFP ratio. A running median is typically used to reduce noise and the influence of intracellular vesicles.

```r
# Calculate ratio on masked pixels
resultRatio <- resultRFP / resultGFP

# Correct for day-to-day variability using a fusion protein control
solRatio <- mean(solRFP) / mean(solGFP)
resultRatioCorrected <- resultRatio / solRatio
```

### 5. Statistical Analysis
The package includes a pre-compiled table of whole-tissue ratios for various genetic conditions (WT, mutants, etc.).

```r
data("statsTable")
# Perform t-tests between conditions
t.test(ratio ~ condition, data = statsTable, 
       subset = condition %in% c("WT", "Cxcr4b-/-"))
```

## Key Functions and Data
- `readImage`: From `EBImage`, used to load the `.tif` stacks in `extdata`.
- `statsTable`: A data frame containing `ratio` and `condition` for 216 primordia.
- `runningMedian`: (User-defined in vignette) Essential for spatial profile generation.

## Tips for Success
- **Voxel Dimensions**: Always define `Lpx` (microns per pixel) to convert physical scales (like the 5µm cell diameter) into pixel units for thresholding and smoothing.
- **Channel Selection**: Use the GFP channel for mask generation as it typically provides a better description of protein abundance and membrane localization.
- **Normalization**: Always normalize sample ratios by the mCherry-sfGFP fusion protein control ratio to account for laser fluctuations and different fluorophore brightnesses.

## Reference documentation
- [Lifetime-ratio analysis in the posterior lateral line primordium](./references/PLLPanalysis.md)
- [Statistical analysis of tissue-scale lifetime ratios](./references/PLLPstatistics.md)