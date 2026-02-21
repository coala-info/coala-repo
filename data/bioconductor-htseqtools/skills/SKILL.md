---
name: bioconductor-htseqtools
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/htSeqTools.html
---

# bioconductor-htseqtools

## Overview

The `htSeqTools` package provides a suite of tools for the post-alignment processing of high-throughput sequencing data. It is particularly strong in Quality Control (QC) and data pre-processing for ChIP-Seq experiments. Key capabilities include Multi-Dimensional Scaling (MDS) for sample comparison, statistical measures for coverage evenness, data-adaptive filtering of PCR duplicates, and peak alignment to correct strand-specific biases.

## Core Workflows

### 1. Quality Control and Sample Comparison

Instead of standard PCA, use `cmds` to compare read coverage across samples using Multi-Dimensional Scaling.

```R
library(htSeqTools)
# htSample is a GRangesList
cmds1 <- cmds(htSample, k=2)
plot(cmds1)
# R-squared indicates the quality of the low-dimensional fit
```

### 2. Assessing Coverage Uniformity

To check if a ChIP-Seq experiment successfully enriched specific regions, compare the dispersion of coverage between IP and Control samples.

*   **SSD Coverage**: Reports the standard deviation of coverage normalized by the number of reads.
*   **Gini Coverage**: Measures unevenness of read distribution (0 = perfectly uniform, 1 = highly enriched).

```R
# Calculate SSD
ssdCoverage(htSample)

# Calculate Gini index with optional Lorenz curve plot
giniCoverage(htSample$ipBatch1, mk.plot=TRUE)
```

### 3. Detecting Over-amplification Artifacts

Use `filterDuplReads` to remove PCR artifacts. It uses a data-adaptive approach (truncated negative binomial mixture) to determine the repeat threshold rather than a fixed cutoff.

```R
# Automated filtering using False Discovery Rate (FDR)
# fdrOverAmp is the threshold for considering a repeat count an artifact
filteredData <- filterDuplReads(htSample$ctrlBatch1, fdrOverAmp=0.01, components=0)

# To just see the repeat counts
tabDuplReads(htSample$ctrlBatch1)
```

### 4. Data Pre-processing (Strand Bias Correction)

ChIP-Seq reads from + and - strands are typically shifted. `alignPeaks` corrects this by estimating the fragment length and shifting reads to provide sharper peaks.

```R
# Estimate shift and align peaks
ipAligned <- alignPeaks(htSample$ipBatch1, strand='strand', npeaks=100)

# Extend ranges to a specific fragment length (e.g., 300bp)
extendedReads <- extendRanges(ipAligned, length=300)
```

### 5. Enrichment Analysis

Identify genomic regions with significant read accumulation compared to a control.

```R
# Find enriched regions using Likelihood Ratio Test
mapped <- c(ip=length(ip_gr), ctrl=length(ctrl_gr))
regions <- enrichedRegions(sample1=ip_gr, sample2=ctrl_gr, minReads=10, 
                           mappedreads=mapped, p.adjust.method='BY')

# Find peaks within those regions
peaks <- enrichedPeaks(regions, sample1=ip_gr, sample2=ctrl_gr, minHeight=100)

# Merge nearby peaks (e.g., within 300bp)
merged <- mergeRegions(peaks, maxDist=300, score='height', aggregateFUN='median')
```

### 6. Visualization of Peak Locations

Visualize where peaks are located relative to genomic features (e.g., TSS).

```R
# Plot density of peaks relative to feature start/end
# Requires metadata columns: start_position, end_position, distance
PeakLocation(peaks_annotated, peakDistance=1000)

# Standardized coordinates (relative to feature length)
stdPeakLocation(peaks_annotated)
```

## Tips for Success

*   **Parallel Processing**: Many functions (like `giniCoverage`) support the `mc.cores` argument to speed up computations on Linux/Mac.
*   **Input Format**: Most functions expect `GRanges` or `GRangesList` objects from the `GenomicRanges` package.
*   **Chromosomal Hotspots**: Use `enrichedChrRegions` to find large-scale genomic areas (e.g., clusters of peaks) that are significantly enriched.
*   **Coverage Grids**: Use `gridCoverage` to normalize the length of different enriched regions into a fixed number of bins (e.g., 500) for easier comparison and clustering.

## Reference documentation

- [htSeqTools](./references/htSeqTools.md)