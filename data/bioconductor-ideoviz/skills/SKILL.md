---
name: bioconductor-ideoviz
description: bioconductor-ideoviz visualizes continuous or discrete genomic data along chromosomal ideograms. Use when user asks to plot binned genomic metrics against chromosome structures, visualize spatial distributions of data across the genome, or generate multi-series trendlines and barplots on cytobands.
homepage: https://bioconductor.org/packages/release/bioc/html/IdeoViz.html
---

# bioconductor-ideoviz

name: bioconductor-ideoviz
description: Visualization of genomic data (continuous or discrete) along chromosomal ideograms. Use this skill to plot binned genomic metrics—such as gene expression, epigenetic marks, or copy number variations—against chromosome structures. It supports downloading ideograms from UCSC, binning raw data, and generating multi-series trendlines or barplots in horizontal or vertical orientations.

## Overview
The `IdeoViz` package is designed to visualize genomic data in its chromosomal context. It allows for the identification of spatial distributions (e.g., telomeric enrichment) and comparison of multiple data series across the genome. The workflow typically involves retrieving ideogram information, binning data to a uniform resolution, and plotting the results.

## Core Workflow

### 1. Prepare Ideogram Data
Ideogram tables (cytobands) are required for plotting. You can download them directly from UCSC or use provided datasets.
```r
library(IdeoViz)
# Download for a specific build (e.g., hg19, mm10)
ideo_hg19 <- getIdeo("hg19")

# Or use built-in example data
data(hg18_ideo)
```

### 2. Binning Data
Data must be binned before plotting. If your data is not already binned, use `getBins()` to create a target grid and `avgByBin()` to aggregate your values.
```r
# 1. Create bins (e.g., 500kb steps)
chroms <- c("chr1", "chr2", "chrX")
bins <- getBins(chroms, ideo_hg19, stepSize = 500000)

# 2. Aggregate data (xpr = data.frame of values, featureData = coordinates)
# featureData columns: chrom, start, end
binned_data <- avgByBin(xpr = my_values_df, 
                        featureData = my_coords_df, 
                        target_GR = bins, 
                        FUN = mean)
```

### 3. Plotting on Ideograms
The primary function is `plotOnIdeo()`. It expects a `GRanges` object where data series are stored in the metadata columns (`mcols`).

```r
# Basic trendline plot for multiple series
plotOnIdeo(chrom = c("chr1", "chr2"),
           ideoTable = ideo_hg19,
           values_GR = binned_data,
           value_cols = c("sample1", "sample2"), # Metadata column names
           col = c("blue", "red"),
           plotType = "lines",
           vertical = FALSE)

# Barplot (rect) - recommended for single series only
plotOnIdeo(chrom = "chr1",
           ideoTable = ideo_hg19,
           values_GR = binned_data,
           value_cols = "sample1",
           plotType = "rect",
           col = "orange")
```

## Key Function Parameters
- `plotType`: "lines" (trendlines), "rect" (barplots), or "seg_tracks" (GenomicRanges tracks).
- `vertical`: Set to `TRUE` for vertical chromosome orientation.
- `val_range`: A numeric vector `c(min, max)` to fix the y-axis scale across chromosomes.
- `bpLim`: A numeric vector `c(start, end)` to zoom into a specific chromosomal region.
- `smoothVals`: Set to `TRUE` to apply loess smoothing to trendlines.
- `addOneToStart`: Set to `TRUE` if your input data is 0-based (UCSC style) to convert to 1-based R coordinates.

## Tips for Effective Visualization
- **Context Limits**: The number of chromosomes that can be plotted simultaneously is limited by the size of the R graphics device. If the plot is crowded, set `addScale = FALSE` or plot chromosomes in smaller batches.
- **Data Consistency**: Ensure the coordinate system (0-based vs 1-based) of your data matches the ideogram table. `getIdeo()` returns UCSC coordinates which may require `addOneToStart = TRUE`.
- **Custom Aggregation**: `avgByBin()` accepts custom functions via the `FUN` argument (e.g., `median`, `max`).

## Reference documentation
- [IdeoViz Reference Manual](./references/reference_manual.md)