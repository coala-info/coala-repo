---
name: bioconductor-deltagseg
description: This tool identifies subpopulations and macrostates in time-series data using multiscale analysis, segmentation, and clustering. Use when user asks to identify distinct states in molecular dynamics simulations, perform wavelet-based denoising on time-series, or detect regime shifts through data segmentation.
homepage: https://bioconductor.org/packages/release/bioc/html/deltaGseg.html
---

# bioconductor-deltagseg

name: bioconductor-deltagseg
description: Identify subpopulations and macrostates in time-series data (specifically molecular dynamics simulation free binding energies) using multiscale time-series analysis, segmentation, denoising, and clustering. Use this skill when analyzing time-series measurements to detect regime shifts, perform wavelet-based denoising, or estimate ergodic subpopulations.

# bioconductor-deltagseg

## Overview
The `deltaGseg` package is designed to identify distinct subpopulations (macrostates) within time-series data. While originally developed for molecular dynamics (MD) simulation free binding energies, it is applicable to any time-series data where identifying coexistence of different states is required. The workflow involves testing for stationarity, splitting or differentiating non-stationary series, segmenting data using Segment Neighborhoods, denoising via wavelets, and grouping segments into subpopulations through hierarchical clustering.

## Core Workflow

### 1. Data Loading and Stationarity Testing
Data should be 2-column, space-separated files (Time, Measurement).
```R
library(deltaGseg)

# Load trajectories from a directory
dir <- system.file("extdata", package="deltaGseg")
traj <- parseTraj(path=dir, files=c("file1", "file2"))

# Check contents and Augmented Dickey-Fuller (ADF) p-values
# p-value <= 0.05 suggests the series is weakly stationary
traj
plot(traj, name='all')
```

### 2. Transforming Non-Stationary Series
If a series is not weakly stationary (ADF p-value > 0.05), it must be transformed.
- **Splitting**: Breaks the series into stationary sub-series.
- **Differentiation**: Uses $B_t - B_{t-1}$ to remove trends.
- **Manual Splitting**: Use `splitTraj` and `chooseBreaks` for custom breakpoints.

```R
# Automatic splitting
traj.tr <- transformSeries(object = traj, method = "splitting", breakpoints = 1)

# Manual splitting for long series
all_breaks <- splitTraj(traj, segsplits = c(5, 5))
my_breaks <- chooseBreaks(all_breaks, numbreaks = 3)
traj.sp <- transformSeries(object = traj, method = "override_splitting", breakpoints = my_breaks)

# Differentiation (for trend-heavy data)
traj.diff <- transformSeries(object = traj, method = "differentiation")
```

### 3. Segmentation and Denoising
Segments the series and applies wavelet shrinkage to remove autocorrelation.
```R
traj.denoise <- denoiseSegments(object = traj.tr, 
                                seg_method = "SegNeigh", 
                                maxQ = 15, 
                                minobs = 200)
```

### 4. Subpopulation Estimation
Clusters segments to identify macrostates. Using `pvclust` provides multiscale bootstrap p-values for cluster significance.
```R
# Estimate bootstrap p-values
pvals <- clusterPV(object = traj.denoise, bootstrap = 500)

# Interactive clustering (requires user to click on the dendrogram to group)
traj.ss <- clusterSegments(object = traj.denoise, intervention = "pvclust", pv = pvals)

# Visualize results
plot(traj.ss)

# Extract intervals for each subpopulation
intervals <- getIntervals(traj.ss)
```

### 5. Diagnostics
Validate the wavelet modeling by checking residuals for normality and lack of autocorrelation.
```R
diagnosticPlots(object = traj.ss, norm.test = "KS", single.series = TRUE)
```

## Tips and Constraints
- **Minimum Observations**: The `minobs` parameter in `denoiseSegments` defaults to 200; segments shorter than this may be rejected.
- **Stationarity**: Always ensure sub-series have ADF p-values $\leq 0.05$ before proceeding to segmentation.
- **Clustering**: In `clusterSegments`, the "Approximately Unbiased" (AU) p-values (red) are more reliable than "Bootstrap Probability" (BP) values (green).
- **Memory**: For very long series (>50,000 points), use `splitTraj` to break data into manageable chunks to improve R's computation time.

## Reference documentation
- [deltaGseg](./references/deltaGseg.md)