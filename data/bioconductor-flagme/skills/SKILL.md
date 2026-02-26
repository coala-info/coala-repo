---
name: bioconductor-flagme
description: This tool processes, visualizes, and aligns GC-MS metabolomics data with a focus on fragment-level analysis. Use when user asks to import GC-MS data, perform peak detection, align peaks across multiple samples using dynamic programming, visualize chromatograms, or extract abundance matrices for statistical analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/flagme.html
---


# bioconductor-flagme

name: bioconductor-flagme
description: Comprehensive processing, visualization, and alignment of GC-MS metabolomics data. Use when Claude needs to: (1) Import GC-MS data (CDF/ELU) into R, (2) Perform peak detection or integrate results from AMDIS, ChromaTOF, or XCMS, (3) Align peaks across multiple samples using dynamic programming, (4) Visualize chromatograms and peak alignments, or (5) Extract abundance matrices for downstream statistical analysis.

## Overview

The `flagme` package provides a complete suite for the analysis of GC-MS metabolomics data. It specializes in fragment-level analysis, leveraging the rich fragmentation patterns of electron interaction (EI) ionization. The core workflow involves reading raw data, incorporating peak detection results, aligning features across samples using a scoring function that combines spectral similarity and retention time, and generating abundance matrices.

## Core Workflow

### 1. Data Import and Peak Detection

Data is managed using the `peaksDataset` object. You can import raw CDF files and then add peak information from various deconvolution algorithms.

```r
library(flagme)
# Define files
cdfFiles <- list.files(path, pattern=".CDF", full.names=TRUE)
eluFiles <- gsub(".CDF", ".ELU", cdfFiles)

# Create dataset object
pd <- peaksDataset(cdfFiles, mz=seq(50, 550), rtrange=c(7.5, 8.5))

# Add peaks from AMDIS
pd <- addAMDISPeaks(pd, eluFiles)

# Alternatively, add peaks using XCMS/CAMERA
# mfp <- xcms::MatchedFilterParam(fwhm = 10, snthresh = 5)
# pd <- addXCMSPeaks(cdfFiles, pd, settings = mfp)
```

### 2. Visualization

Use `plotChrom` for Total Ion Currents (TIC) and `plotImage` for 2D heatmaps.

```r
# Plot TIC with peak labels
plotChrom(pd, rtrange=c(7.5, 8.5), plotPeaks=TRUE, plotPeakLabels=TRUE)

# Plot 2D heatmap for a specific run
plotImage(pd, run=1, rtrange=c(7.5, 8.5))
```

### 3. Pairwise Alignment

Alignment uses dynamic programming based on a similarity score $S_{ij}$ considering spectral correlation and retention time distance.

```r
# Align two samples
# D: retention time penalty (seconds/minutes depending on scale)
# gap: gap penalty (0-1, typically 0.4-0.6)
pa <- peaksAlignment(pd@peaksdata[[1]], pd@peaksdata[[2]], 
                     pd@peaksrt[[1]], pd@peaksrt[[2]], 
                     D=0.1, gap=0.5, metric=1, type=1)

# Visualize alignment
plotAlignment(pa)
```

### 4. Multiple Alignment

For multiple groups, `flagme` performs alignment within replicates first, then between groups to reduce computational cost.

```r
# Align multiple groups
# wn: within-group parameters; bw: between-group parameters
ma <- multipleAlignment(pd, group=targets$Group, 
                        wn.gap=0.5, wn.D=0.05, 
                        bw.gap=0.6, bw.D=0.05, 
                        usePeaks=TRUE)
```

### 5. Extracting Results

Gather information into a list or matrix for statistical analysis.

```r
# Extract merged peak info (RT, m/z, intensities)
outList <- gatherInfo(pd, ma)

# Create a retention time matrix for all matched peaks
rtmat <- matrix(unlist(lapply(outList, .subset, "rt")), 
                nrow=length(outList), byrow=TRUE)
```

## Key Parameters for Alignment

- **D**: Modulates the impact of retention time differences. Set this slightly larger than the average peak width.
- **gap**: The penalty for introducing a gap in the peak list. High values (0.9) discourage gaps; low values (0.1) allow them easily.
- **metric**: The spectral similarity metric (default is 1 for normalized dot product).
- **type**: Alignment type (default is 1).

## Reference documentation

- [flagme: Fragment-level analysis of GC-MS-based metabolomics data](./references/flagme.md)
- [flagme: Fragment-level analysis of GC-MS-based metabolomics data (knitr version)](./references/flagme-knitr.md)