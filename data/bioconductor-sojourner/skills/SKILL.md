---
name: bioconductor-sojourner
description: The sojourner package provides a comprehensive workflow for importing, processing, and performing biophysical analysis on single molecule tracking data. Use when user asks to import trajectories from tracking software, filter or mask tracks, calculate mean square displacement, estimate diffusion coefficients, or perform residence time analysis.
homepage: https://bioconductor.org/packages/3.10/bioc/html/sojourner.html
---


# bioconductor-sojourner

## Overview
The `sojourner` package is designed for the analysis of single molecule tracking data. It provides a comprehensive workflow for importing trajectories from various tracking softwares, processing those tracks (linking, filtering, and masking), and performing biophysical analyses such as Mean Square Displacement (MSD), Diffusion Coefficient (Dcoef) estimation, and Residence Time (RT) analysis.

## Core Data Structure: trackll
The primary data structure is a `trackll` (track list of lists).
- **Track**: A `data.frame` with x, y, z, and Frame.
- **trackl**: A list of tracks from a single video/file.
- **trackll**: A list of `trackl` objects, usually representing a folder of experiments.

## Workflow and Key Functions

### 1. Data Import
Import data from Diatrack (.txt/.mat), ImageJ Particle Tracker (.csv), SLIMfast (.txt), or u-track (.mat).
```R
library(sojourner)
folder <- "path/to/data"
# input = 3 for ImageJ Particle Tracker
trackll <- createTrackll(folder = folder, input = 3)
```

### 2. Track Manipulation
- **Link Skipped Frames**: Connect trajectories where the molecule disappeared briefly.
  ```R
  trackll.linked <- linkSkippedFrames(trackll, tolerance = 5, maxSkip = 10)
  ```
- **Filtering**: Keep tracks within a specific frame length range.
  ```R
  trackll.fi <- filterTrack(trackll, filter = c(min = 7, max = Inf))
  ```
- **Trimming**: Cut tracks to a specific length.
  ```R
  trackll.trim <- trimTrack(trackll, trimmer = c(1, 20))
  ```
- **Masking**: Apply binary image masks (e.g., nuclear masks) to exclude tracks.
  ```R
  trackll.masked <- maskTracks(folder = folder, trackll = trackll.fi)
  ```

### 3. Visualization
- **Overlay**: Plot tracks over nuclear or brightfield images.
  ```R
  plotNucTrackOverlay(folder = folder, trackll = trackll.fi)
  ```
- **Dcoef Heatmap**: Color-code tracks by their diffusion coefficient.
  ```R
  plotTrackOverlay_Dcoef(trackll = trackll.masked, Dcoef.range = c(-2, 1), resolution = 0.107)
  ```

### 4. Statistical Analysis
- **MSD**: Calculate Mean Square Displacement.
  ```R
  msd(trackll, dt = 20, resolution = 0.107, plot = TRUE)
  ```
- **Diffusion Coefficient**: Estimate Dcoef using static methods.
  ```R
  Dcoef(trackll, dt = 5, method = "static", plot = TRUE)
  ```
- **Displacement CDF**: Analyze the cumulative distribution function of displacements.
  ```R
  displacementCDF(trackll, dt = 1, plot = TRUE)
  ```
- **Residence Time**: Fit 1-CDF curves with exponential decay models.
  ```R
  fitRT(trackll, x.max = 100, t.interval = 0.5)
  ```

## Tips for Success
- **Merging**: Use `mergeTracks(folder, trackll)` to combine all files in a folder into a single track list for aggregate analysis.
- **Combining**: Use `combineTrackll(trackll = c(t1, t2))` to merge different experimental groups.
- **Units**: Ensure `resolution` (um/pixel) and `t.interval` (time between frames) are correctly set for your microscope setup to get accurate physical units.
- **GUI**: For interactive exploration, use `sojournerGUI()`.

## Reference documentation
- [Sojourner: an R package for statistical analysis of single molecule trajectories](./references/sojourner-vignette.md)
- [Sojourner Vignette Source](./references/sojourner-vignette.Rmd)