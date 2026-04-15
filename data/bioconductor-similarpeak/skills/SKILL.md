---
name: bioconductor-similarpeak
description: The similaRpeak package provides a suite of metrics to quantify and compare the similarity between two ChIP-Seq profiles. Use when user asks to calculate similarity metrics between genomic profiles, compare histone modification shapes, or evaluate the overlap and correlation of transcription factor binding signals.
homepage: https://bioconductor.org/packages/release/bioc/html/similaRpeak.html
---

# bioconductor-similarpeak

## Overview

The `similaRpeak` package provides a suite of metrics to quantify the similarity between two ChIP-Seq profiles. These metrics are particularly useful for comparing different histone modifications or transcription factor binding profiles across the same genomic region. The package transforms standard similarity measures into pseudometrics, allowing for robust statistical comparison of ChIP-Seq signal shapes and magnitudes.

## Core Workflow

### 1. Data Preparation
The package requires two numerical vectors of equal length representing ChIP-Seq coverage (typically in Reads Per Million - RPM).

```r
library(similaRpeak)

# Example: Extracting coverage from BAM for a specific region
library(GenomicAlignments)
library(Rsamtools)

# Define region and extract coverage
region <- GRanges("chr1", IRanges(172081530, 172083529))
alignments <- readGAlignments("path/to/file.bam", param = ScanBamParam(which = region))
profile_vector <- as.numeric(coverage(alignments)[region]$chr1)
```

### 2. Calculating Similarity
The primary function is `similarity()`, which calculates all six metrics simultaneously.

```r
# Basic usage
results <- similarity(profile1, profile2)

# Usage with custom thresholds
results <- similarity(profile1, profile2, 
                      ratioAreaThreshold = 1, 
                      diffPosMaxTolerance = 0.01, 
                      ratioMaxMaxThreshold = 1,
                      spearmanCorrSDThreashold = 1e-8)
```

### 3. Interpreting the Metrics
The `similarity()` function returns a list containing profile metadata (area, max value, max position) and a `metrics` sub-list:

*   **RATIO_AREA**: Ratio of total areas. Values near 1 indicate similar overall enrichment.
*   **DIFF_POS_MAX**: Difference in peak positions. Useful for detecting "shifted" peaks.
*   **RATIO_MAX_MAX**: Ratio of peak heights. Detects differences in enrichment intensity.
*   **RATIO_INTERSECT**: Intersection area divided by total area. High values indicate high spatial overlap.
*   **RATIO_NORMALIZED_INTERSECT**: Intersection of profiles after normalizing by mean coverage. Best for comparing shapes when magnitudes differ significantly.
*   **SPEARMAN_CORRELATION**: Non-parametric correlation of the two profiles.

### 4. Using the MetricFactory
For repetitive tasks or when only a specific metric is needed, use the R6 `MetricFactory` class.

```r
# Initialize factory once
factory <- MetricFactory$new(diffPosMaxTolerance = 0.04)

# Calculate specific metrics
ratio_max <- factory$createMetric(metricType = "RATIO_MAX_MAX", 
                                  profile1 = p1, profile2 = p2)
norm_intersect <- factory$createMetric(metricType = "RATIO_NORMALIZED_INTERSECT", 
                                       profile1 = p1, profile2 = p2)
```

## Tips for Success
*   **Normalization**: If comparing profiles with very different sequencing depths, focus on `RATIO_NORMALIZED_INTERSECT` or `SPEARMAN_CORRELATION`.
*   **Thresholds**: If a profile's area or peak height is below the specified thresholds (e.g., `ratioAreaThreshold`), the function returns `NA`. Adjust these if working with low-signal regions.
*   **Peak Shifts**: Use `DIFF_POS_MAX` to identify if one protein binds slightly upstream or downstream of another.

## Reference documentation
- [Similarity between two ChIP-Seq profiles](./references/similaRpeak.Rmd)
- [Similarity between two ChIP-Seq profiles (Markdown)](./references/similaRpeak.md)