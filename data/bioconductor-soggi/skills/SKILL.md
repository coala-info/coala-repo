---
name: bioconductor-soggi
description: The bioconductor-soggi package visualizes and analyzes genomic signal enrichment profiles across specific genomic intervals. Use when user asks to create average profiles, generate heatmaps of genomic signal, or compare ChIP-seq, ATAC-seq, and RNA-seq data across genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/soGGi.html
---

# bioconductor-soggi

name: bioconductor-soggi
description: Visualizing and analyzing genomic interval summaries (profiles) over genomic features. Use this skill when performing ChIP-seq, ATAC-seq, or RNA-seq data visualization, specifically for creating average profiles, heatmaps, and comparing signal enrichment across different genomic regions or samples.

# bioconductor-soggi

## Overview
The `soGGi` (Summary of Genome Genomic Intervals) package is designed to create visual representations of genomic signal enrichment (from BAM or BigWig files) across sets of genomic intervals (like TSS, gene bodies, or enhancers). It excels at generating "average profiles" and heatmaps, supporting multi-sample comparisons and various normalization methods.

## Core Workflow

### 1. Data Preparation
To use `soGGi`, you typically need:
- Genomic regions of interest as a `GRanges` object.
- Signal data as BAM files or BigWig files.

```r
library(soGGi)
library(GenomicRanges)

# Define regions (e.g., TSS)
regions <- GRanges("chr1", IRanges(start = c(1000, 2000), end = c(1010, 2010)))

# Define samples
samples <- c("sample1.bam", "sample2.bam")
```

### 2. Creating Profiles
The primary function is `regionPlot()`. It summarizes signal across the specified regions.

```r
# Create a profile
# format: "bam" or "bigwig"
# distanceUp/Down: bases around the center or edges
# res: bin size for averaging
profiles <- regionPlot(bamFiles = samples, 
                       testRanges = regions, 
                       format = "bam", 
                       distanceUp = 1000, 
                       distanceDown = 1000, 
                       res = 10)
```

### 3. Visualization
`soGGi` provides specialized plotting functions that return `ggplot2` objects.

- **Average Profile Plot**: `plotRegion(profiles)`
- **Heatmap**: `plotRegion(profiles, outliers = 0.01, colourBy = "Sample") + geom_tile()`

### 4. Advanced Operations
- **Grouping**: You can add metadata to the `profiles` object (which is a `ChIPprofile` class) to group plots by experimental condition.
- **Transformations**: Use `log2()` or other arithmetic operations directly on the `ChIPprofile` object to normalize signal.
- **Merging**: Combine multiple profile objects using `c(profile1, profile2)`.

## Key Functions
- `regionPlot()`: The main engine for extracting signal over ranges.
- `plotRegion()`: The plotting wrapper for `ggplot2` output.
- `getCounts()`: Extracts the underlying matrix of scores.
- `manipulate()`: Allows for subsetting or reordering the profile data.

## Tips for Success
- **Memory Management**: For large BAM files, using BigWig format is significantly faster and more memory-efficient.
- **Resolution**: The `res` parameter in `regionPlot` determines the granularity. A `res = 1` is highest resolution but increases memory usage; `res = 10` or `50` is usually sufficient for broad peaks.
- **Style**: Since `plotRegion` returns a `ggplot` object, you can append standard ggplot2 layers like `+ theme_bw()` or `+ facet_wrap(~Group)`.

## Reference documentation
None