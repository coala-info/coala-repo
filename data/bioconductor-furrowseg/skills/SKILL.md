---
name: bioconductor-furrowseg
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/furrowSeg.html
---

# bioconductor-furrowseg

name: bioconductor-furrowseg
description: Image segmentation and feature extraction for embryo furrowing data. Use when analyzing time-lapse microscopy of Drosophila embryos to identify cell boundaries, calculate A-P (Anterior-Posterior) anisotropy, and track cell area evolution over time.

# bioconductor-furrowseg

## Overview

The `furrowSeg` package provides tools for the automated segmentation of cells during embryo furrowing. It utilizes adaptive thresholding and propagation algorithms to identify cell boundaries from membrane markers. It is specifically designed to quantify cell shape changes, such as apical constriction and anisotropy, in the context of tissue invagination.

## Typical Workflow

### 1. Parameter Setup
Segmentation requires physical-to-pixel conversions and thresholding offsets.
```r
px <- 0.293 # microns per pixel
threshOffset <- 0.0005
filterSize <- makeOdd(round(microns2px(1, px=px)))
L <- makeOdd(round(microns2px(5, px=px)))
minObjectSize <- area2px(4, px=px)
maxObjectSize <- area2px(400, px=px)
```

### 2. Segmentation
You can perform segmentation step-by-step (smoothing, thresholding, closing, inverting, and propagating) or use the high-level wrapper:
```r
# Using the wrapper for a movie (4D array)
x <- segmentFurrowAllStacks(x=img, L=L, filterSize=filterSize, 
                            threshOffset=threshOffset, closingSize=filterSize, 
                            minObjectSize=minObjectSize, maxObjectSize=maxObjectSize)
# The result contains the segmentation mask
mask <- x$mask[[1]]
```

### 3. Feature Extraction
Extract morphological features using `EBImage` and calculate A-P anisotropy. Note: Images must be aligned so the A-P axis is horizontal.
```r
# Extract features for a specific time point
fts <- computeFeatures(x=mask, ref=img_slice, 
                       methods.noref=c("computeFeatures.moment", "computeFeatures.shape"))
fts <- as.data.frame(fts)

# Calculate A-P anisotropy (e.x)
fts$e.x <- cos(fts$x.0.m.theta) * fts$x.0.m.eccentricity
```

### 4. Spatial and Temporal Analysis
Isolate specific regions (e.g., the furrowing line) and track feature evolution.
```r
# Define a box (xleft, xright, ybottom, ytop)
box <- c("xleft"=64, "xright"=448, "ybottom"=128, "ytop"=384)
fts_subset <- isolateBoxCells(fts, box)

# Plot area and anisotropy over time
plotFeatureEvolution(fts_subset, tMax=10, dt=4.22/60, px=0.293)
```

## Key Functions

- `segmentFurrowAllStacks`: Main wrapper for segmenting time-lapse image stacks.
- `identifyFurrowPosition`: Identifies the d-v position of the furrow based on minimum cell area.
- `identifyTimeMinArea`: Determines the time point of tissue invagination.
- `isolateBoxCells`: Subsets a feature data frame to cells within a specific rectangular coordinate box.
- `microns2px` / `area2px`: Utility functions for converting physical units to pixel units.

## Tips
- **Alignment**: Anisotropy calculations (`e.x`) assume the embryo's A-P axis is parallel to the x-axis. Rotate images before processing if necessary.
- **Smoothing**: Use a Gaussian filter (`makeBrush` and `filter2`) before thresholding to reduce pixel noise.
- **Filtering**: Use `furrowSeg:::filterObjects` to remove artifacts that are too small or too large to be valid nuclei/cells.

## Reference documentation

- [Example furrow segmentation](./references/exampleFurrowSegmentation.md)
- [Automatic generation of paper figures](./references/genPaperFigures.md)