---
name: bioconductor-epistack
description: This tool visualizes genomic signal distributions by creating coordinated plots that combine average profiles, heatmaps, and quantitative metrics centered on genomic regions of interest. Use when user asks to create epistack plots, visualize genomic tracks centered on anchors, or integrate ChIP-seq signal heatmaps with gene expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/epistack.html
---


# bioconductor-epistack

name: bioconductor-epistack
description: Visualizing stacks of genomic tracks (ChIP-seq, DNA methylation, etc.) centered at genomic regions of interest. Use this skill to create "epistack" plots, which combine average profiles, heatmaps, and metric scores (like gene expression) into a single coordinated visualization.

# bioconductor-epistack

## Overview

The `epistack` package is designed to visualize genomic signal distributions (stacks) centered on specific anchor regions (e.g., TSS, peaks). It integrates three primary data types into a single `RangedSummarizedExperiment` object:
1. **Genomic Scores**: Signal matrices (e.g., coverage from BigWig/BAM).
2. **Features of Interest**: Anchor coordinates (GRanges).
3. **Sorting Metrics**: Quantitative values used to order the features (e.g., expression levels).

## Core Workflow

### 1. Data Preparation
The package requires a `RangedSummarizedExperiment` where assays are matrices representing genomic windows around anchors.

```r
library(epistack)
library(EnrichedHeatmap) # Common dependency for matrix generation

# 1. Define anchors (e.g., TSS)
tss <- promoters(genes, upstream = 0, downstream = 1)

# 2. Generate signal matrices (using EnrichedHeatmap or similar)
mat <- normalizeToMatrix(signal_gr, tss, value_column = "score", extend = 5000, w = 250)

# 3. Assemble the epistack object
se <- SummarizedExperiment(
    rowRanges = tss,
    assays = list(Signal = mat)
)
```

### 2. Adding Metrics and Bins
To sort the plot or group regions, add metadata to the `rowRanges`.

```r
# Add a sorting metric and arrange
se <- addMetricAndArrangeGRanges(se, score_df, gr_key = "id", order_key = "id", order_value = "score")

# Divide into bins (e.g., quintiles based on the metric)
se <- addBins(se, nbins = 5)
```

### 3. Plotting with plotEpistack
The primary function `plotEpistack()` generates a multi-panel figure.

```r
plotEpistack(
    se,
    assay = "Signal",
    metric_col = "score",
    zlim = c(0, 10),           # Heatmap scale
    ylim = c(0, 10),           # Average profile scale
    x_labels = c("-5kb", "Center", "+5kb"),
    titles = "ChIP-seq Signal",
    tints = "dodgerblue",
    metric_title = "Expression",
    metric_transfunc = log10   # Optional transformation
)
```

## Key Functions

- `plotEpistack()`: The main high-level plotting function.
- `addBins()`: Adds a `bin` column to the rowRanges based on a metric.
- `addMetricAndArrangeGRanges()`: Merges external data frames with GRanges and sorts them.
- `plotAverageProfile()`: Plots only the top panel (summary line plot).
- `plotStackProfile()`: Plots only the middle panel (heatmap).
- `plotStackProfileLegend()`: Generates the color scale legend.

## Customization Tips

- **Multiple Tracks**: Pass a vector of assay names to `assays` in `plotEpistack()` to display side-by-side heatmaps.
- **Binning**: If a `bin` column exists in `rowRanges(se)`, `plotEpistack` automatically generates per-bin average profiles.
- **Graphical Parameters**: Use `cex`, `cex.main`, and other standard `par()` arguments within `plotEpistack` to control text sizes.
- **Manual Layouts**: For complex multi-figure compositions, use `layout()` and call the individual panel functions (`plotAverageProfile`, etc.) sequentially.

## Reference documentation

- [An overview of the epistack package](./references/using_epistack.md)
- [Using epistack (RMarkdown source)](./references/using_epistack.Rmd)