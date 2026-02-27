---
name: bioconductor-tilingarray
description: This tool analyzes high-density tiling microarray data to measure transcript abundance and genomic architecture. Use when user asks to fit piecewise constant models for segmentation, calculate confidence intervals for change-points, perform probe-sequence dependent normalization, or visualize genomic data along chromosomes.
homepage: https://bioconductor.org/packages/release/bioc/html/tilingArray.html
---


# bioconductor-tilingarray

name: bioconductor-tilingarray
description: Analysis of high-density tiling microarray data for measuring transcript abundance and architecture. Use this skill for fitting piecewise constant models (segmentation), calculating confidence intervals for change-points, probe-sequence dependent normalization, and visualizing genomic data along chromosomes.

## Overview
The `tilingArray` package is designed for the analysis of tiling microarrays. Its core functionality revolves around a fast dynamic programming algorithm for segmentation, which partitions linear genomic data into segments of constant signal. This is particularly useful for identifying transcript boundaries or copy number variations. The package also provides specialized normalization methods that account for probe sequence effects using reference hybridizations (e.g., genomic DNA).

## Core Workflows

### 1. Data Normalization
Before segmentation, intensities should be normalized. The `normalizeByReference` function uses a reference (like genomic DNA) to adjust for probe-specific response factors.

```r
library(tilingArray)
# x: ExpressionSet with RNA data
# reference: ExpressionSet with DNA data
# pm: indices of perfect match probes
# background: indices of background probes (e.g., intergenic)

xn <- normalizeByReference(x, reference, pm = whPM, background = whBG)
```

### 2. Segmentation
The `segment` function fits a piecewise constant model. To handle large genomic datasets, use `maxk` (maximum segment length) and `maxseg` (maximum number of segments).

```r
# Basic segmentation on a numeric vector or matrix
seg <- segment(data_matrix, maxk = 500, maxseg = 20)

# Segmentation for a whole chromosome using segChrom
# nrBasesPerSegment helps estimate maxseg automatically
segEnv <- segChrom(xn, probeAnno = probeAnno, chr = "1", strands = "+", nrBasesPerSegment = 750)
```

### 3. Confidence Intervals and Model Selection
After segmentation, you can calculate confidence intervals for the change-points and use penalized likelihoods (AIC/BIC) to select the optimal number of segments.

```r
# Calculate CIs for a specific number of segments (S)
seg_with_ci <- confint(seg, parm = 15, level = 0.95)

# Visualize model selection criteria
plotPenLL(seg)
```

### 4. Visualization
The `plotAlongChrom` function is the primary tool for visualizing tiling data, segments, and genome annotations (GFF).

```r
# Plotting from a segmentation environment
grid.newpage()
plotAlongChrom(segEnv, chr = 1, coord = c(35000, 50000), what = "dots", gff = gffSub)

# Heatmap view for multiple replicates
plotAlongChrom(segEnv, chr = 1, what = "heatmap", rowNamesHeatmap = sampleNames(xn))
```

## Key Functions
- `segment`: Fits the piecewise constant model using dynamic programming.
- `segChrom`: High-level wrapper to run segmentation across chromosomes and strands.
- `normalizeByReference`: Normalizes RNA signal using DNA reference signal and probe sequences.
- `plotAlongChrom`: Creates grid-based plots of signal and segments along genomic coordinates.
- `confint`: Calculates confidence intervals for segment boundaries.
- `costMatrix`: Internal function to calculate the cost matrix for the segmentation algorithm.

## Reference documentation
- [Normalisation with the normalizeByReference function](./references/assessNorm.md)
- [Calculation of the cost matrix](./references/costMatrix.md)
- [The segment function to fit a piecewise constant curve](./references/findsegments.md)
- [Introduction to the plotAlongChrom function](./references/plotAlongChrom.md)
- [Segmentation demo](./references/segmentation.md)