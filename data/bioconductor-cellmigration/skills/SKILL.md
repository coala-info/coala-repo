---
name: bioconductor-cellmigration
description: This tool tracks and analyzes cell movements over time from multi-stack TIFF images of fluorescent cells. Use when user asks to import TIFF files, optimize tracking parameters, compute cell tracks, and perform trajectory analysis including speed, directionality, and Mean Square Displacement.
homepage: https://bioconductor.org/packages/release/bioc/html/cellmigRation.html
---

# bioconductor-cellmigration

name: bioconductor-cellmigration
description: Analysis of cell movements over time using multi-stack TIFF images of fluorescent cells. Use this skill to import TIFF files, optimize tracking parameters (diameter, lnoise, threshold), compute cell tracks, and perform advanced trajectory analysis including persistence, speed, directionality, and Mean Square Displacement (MSD).

# bioconductor-cellmigration

## Overview

The `cellmigRation` package provides a complete pipeline for tracking and analyzing cell motility from fluorescent time-lapse microscopy. It is organized into two modules:
- **Module 1**: Image processing, cell detection, and track reconstruction.
- **Module 2**: Advanced trajectory metrics, visualization (2D/3D), and population-level statistics.

## Module 1: Data Import and Tracking

### 1. Loading Data
Import multi-stack TIFF files into `trackedCells` objects. You can attach metadata like experiment name or condition.

```r
library(cellmigRation)

# Load from file
tc <- LoadTiff("path/to/image.tif", experiment = "Exp1", condition = "Control")

# Or use built-in sample data
data(ThreeConditions)
tc <- ThreeConditions$ctrl01
```

### 2. Parameter Optimization
Cell detection depends on three key parameters: `lnoise` (smallest particle size), `diameter` (largest cell size), and `threshold` (background cutoff). Use `OptimizeParams` to find the best values.

```r
# Automated optimization
tc <- OptimizeParams(tc, threads = 1, plot = TRUE)

# View results
getOptimizedParams(tc)$auto_params
```

### 3. Cell Tracking
The `CellTracker` function identifies cells in each frame and links them across time.

```r
# Track using optimized parameters
tc <- CellTracker(tc, min_frames_per_cell = 3, threads = 1)

# Extract raw tracks
tracks_df <- getTracks(tc)
```

### 4. Basic Statistics
Compute standard migration metrics (Speed, Distance, etc.) similar to FastTracks.

```r
tc <- ComputeTracksStats(tc, time_between_frames = 10, resolution_pixel_per_micron = 1.24)
stats <- getCellsStats(tc)
```

## Module 2: Advanced Analysis

### 1. Pre-processing for Analysis
Aggregate tracks from multiple experiments and initialize a `CellMig` object.

```r
# Aggregate multiple trackedCells objects
all_tracks <- aggregateTrackedCells(tc1, tc2, meta_id_field = "tiff_file")

# Initialize CellMig object
rmTD <- CellMig(trajdata = all_tracks)
rmTD <- setExpName(rmTD, "MyExperiment")

# Pre-process (Random Migration or Wound Healing)
rmTD <- rmPreProcessing(rmTD, PixelSize = 1.24, TimeInterval = 10)
```

### 2. Trajectory Metrics
Perform deep analysis on cell behavior.

- **Directionality**: `DiRatio(rmTD, export = TRUE)`
- **Mean Square Displacement (MSD)**: `MSD(rmTD, sLAG = 0.25)`
- **Velocity AutoCorrelation**: `VeAutoCor(rmTD, TimeInterval = 10)`
- **Persistence and Speed**: `PerAndSpeed(rmTD)`

### 3. Visualization
- **2D Tracks**: `plotAllTracks(rmTD, Type = "l")`
- **Sample Tracks**: `plotSampleTracks(rmTD, celNum = 5)`
- **3D Interactive**: `plot3DAllTracks(rmTD)`

### 4. Final Results and Clustering
Consolidate all metrics into a single table or perform PCA-based clustering.

```r
# Generate final results table
rmTD <- FinRes(rmTD, ParCor = TRUE)
results <- getCellMigSlot(rmTD, "results")

# PCA and Clustering
rmTD <- CellMigPCA(rmTD)
rmTD <- CellMigPCAclust(rmTD)
```

## Reference documentation

- [cellmigRation Vignette](./references/cellmigRation.md)
- [cellmigRation R Markdown Source](./references/cellmigRation.Rmd)