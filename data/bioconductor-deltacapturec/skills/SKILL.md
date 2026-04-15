---
name: bioconductor-deltacapturec
description: This tool analyzes meso-scale changes in chromatin conformation from 3C data by identifying significant regional shifts in interaction levels between conditions. Use when user asks to normalize 3C interaction counts, calculate delta mean normalized values, or identify statistically significant regions of differential interaction using a permutation-based approach.
homepage: https://bioconductor.org/packages/release/bioc/html/deltaCaptureC.html
---

# bioconductor-deltacapturec

name: bioconductor-deltacapturec
description: Analysis of meso-scale changes in chromatin conformation from 3C data (e.g., Capture-C, Tri-C). Use this skill to normalize 3C interaction counts, calculate delta mean normalized values between conditions, and identify statistically significant regions of differential interaction using a permutation-based approach.

# bioconductor-deltacapturec

## Overview

The `deltaCaptureC` package is designed to detect meso-scale changes in chromatin conformation by comparing 3C data (interaction counts between digestion fragments and a specific viewpoint) across different treatments or cell types. Unlike methods that look at individual fragments, this package exploits the co-location of fragments to identify significant regional shifts in interaction levels.

## Core Workflow

### 1. Data Preparation and Normalization

The starting point is a `SummarizedExperiment` object containing raw interaction counts for digestion fragments across replicates and conditions.

```r
library(deltaCaptureC)
library(SummarizedExperiment)

# Calculate delta mean normalized values
# This estimates size factors (via DESeq2) and calculates the difference 
# between the mean normalized counts of two conditions.
deltaSE <- getDeltaSE(yourSummarizedExperiment)
```

### 2. Identifying Significant Regions

The package uses a permutation-based algorithm to assess the significance of "runs" (consecutive bins with the same sign of delta) and "lopsidedness" near the viewpoint.

```r
# Define genomic ranges for analysis
# regionOfInterest: 500kb up/downstream of viewpoint
# viewpointRegion: immediate vicinity of the viewpoint
significantRegions <- getSignificantRegions(
    deltaSE = deltaSE,
    regionOfInterest = regionOfInterest,
    viewpointRegion = viewpointRegion,
    smallBinSize = 1000,      # e.g., 1kb
    bigBinSize = 10000,       # e.g., 10kb (must be multiple of smallBinSize)
    numPermutations = 1000,
    pValue = 0.05
)
```

### 3. Visualization

Results can be visualized to show the binned delta values and highlighted significant regions.

```r
# Plotting significant regions
# significanceType can be "runs", "lopsidedness", or "both"
significantRegionsPlot <- plotSignificantRegions(
    significantRegions,
    significanceType = "runs",
    plotTitle = "Differential Interactions: Condition A vs B"
)

print(significantRegionsPlot)
```

## Key Functions

- `getDeltaSE()`: Automates normalization and calculates the difference in mean counts between two groups.
- `getSignificantRegions()`: The main engine for detecting differential regions using binned data and permutations.
- `binSummarizedExperiment()`: Maps fragment-level data into fixed-width genomic bins.
- `rebinToMultiple()`: Efficiently aggregates small bins into larger bins (used during permutations).
- `plotSignificantRegions()`: Generates ggplot2-based visualizations of the results.

## Technical Tips

- **Bin Sizes**: The `bigBinSize` must be an integer multiple of `smallBinSize`. Binning into small bins is computationally expensive, while rebinning into larger bins is fast.
- **Viewpoint Handling**: The algorithm treats the viewpoint region specially, calculating "lopsidedness" (asymmetry) rather than runs, as interaction counts are naturally highest and most variable near the viewpoint.
- **Normalization**: `getDeltaSE` uses `DESeq2::estimateSizeFactorsForMatrix`. If your data requires custom normalization, you can manually construct the delta `SummarizedExperiment` by subtracting mean normalized assays.

## Reference documentation

- [Delta Capure-C](./references/deltaCaptureC.md)