---
name: bioconductor-fastseg
description: bioconductor-fastseg performs fast and efficient segmentation of genomic data to identify regions of constant value using a cyber t-test based Bayesian framework. Use when user asks to detect copy number variations, identify transcripts from tiling arrays, or find breakpoints in numeric vectors and matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/fastseg.html
---

# bioconductor-fastseg

name: bioconductor-fastseg
description: Fast and efficient segmentation of genomic data (microarrays, NGS, RNA-seq) using a cyber t-test based Bayesian framework. Use this skill when you need to perform copy number variation (CNV) detection, transcript identification from tiling arrays, or general breakpoint detection in numeric vectors and matrices.

## Overview

The `fastseg` package provides a high-performance alternative to the Circular Binary Segmentation (CBS) algorithm found in `DNAcopy`. It is designed for speed and flexibility, capable of handling large-scale genomic datasets. It identifies segments of constant value (e.g., log2 ratios) within a sequence of genomic coordinates or general numeric data.

## Core Workflow

### 1. Data Preparation
`fastseg` accepts several input formats. The most common are `GRanges` (for genomic data) and numeric matrices/vectors.

```r
library(fastseg)
library(GenomicRanges)

# Example using a GRanges object
# chrom: vector of chromosome names
# maploc: vector of genomic positions
# data: matrix where columns are samples and rows are observations
gr <- GRanges(seqnames = chrom, ranges = IRanges(maploc, end = maploc))
mcols(gr) <- data
```

### 2. Running Segmentation
The primary function is `fastseg()`. It automatically detects the input type and performs segmentation.

```r
# Basic segmentation on a GRanges object
res <- fastseg(gr)

# Segmentation with specific parameters
# alpha: significance level for the test
# cyberWeight: weight for the prior variance (cyber t-test)
res <- fastseg(gr, alpha = 0.05, cyberWeight = 10)

# Segmentation on a simple numeric vector
vec_res <- fastseg(my_numeric_vector)
```

### 3. Visualizing Results
`fastseg` provides the `segPlot` function, which leverages `DNAcopy` plotting styles.

```r
# Plotting whole-genome view ("w") or single-chromosome view ("s")
segPlot(gr, res, plot.type = "w")
segPlot(gr, res, plot.type = "s")
```

## Key Functions and Parameters

- `fastseg(x, type, alpha, segMedianT, minSeg, ...)`:
    - `x`: The input data (GRanges, ExpressionSet, matrix, or vector).
    - `type`: Type of statistic (1 for cyber t-test, 2 for mean difference). Default is 1.
    - `alpha`: The significance level for the test to accept a new breakpoint.
    - `segMedianT`: A threshold for merging adjacent segments with similar medians.
    - `minSeg`: Minimum number of probes per segment.
- `toDNAcopyObj(segData, data, sampleNames, ...)`: Converts `fastseg` results into a `DNAcopy` object for compatibility with other Bioconductor tools.

## Tips for Success

- **Missing Values**: While `fastseg` can handle some NAs, it is often better to impute them (e.g., using the median) or remove them before segmentation if they are sparse.
- **Speed**: `fastseg` is significantly faster than `DNAcopy::segment`. Use it as the default choice for very high-density arrays or large NGS datasets.
- **Output Format**: The result is typically a `GRanges` object where each range represents a segment. The `seg.mean` column contains the average value of the segment, and `num.mark` indicates how many data points (probes/bins) are in that segment.

## Reference documentation

- [An R Package for fast segmentation](./references/fastseg.md)