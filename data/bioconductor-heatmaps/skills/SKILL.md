---
name: bioconductor-heatmaps
description: The heatmaps package visualizes functional genomics data and sequence features over genomic windows using customizable heatmap plots. Use when user asks to create heatmaps for ChIP-seq coverage, visualize sequence patterns or PWM matches, smooth genomic signal data, and generate publication-ready multi-panel heatmap figures.
homepage: https://bioconductor.org/packages/release/bioc/html/heatmaps.html
---


# bioconductor-heatmaps

## Overview

The `heatmaps` package is designed for visualizing functional genomics data and sequence features over genomic windows. It excels at creating heatmaps for coverage tracks (like ChIP-seq signal) and sequence-based features (like TATA-box PWM matches or kmer density). It provides built-in smoothing algorithms and a flexible plotting system for combining multiple heatmaps into complex, publication-ready figures.

## Core Workflow

### 1. Data Preparation
The package works with standard Bioconductor objects. You typically need a `GRanges` object defining your windows of interest and a signal source (e.g., `RleList` from `coverage()`).

```r
library(heatmaps)
library(GenomicRanges)

# Define windows (e.g., 500bp around promoters)
coords <- c(-500, 500)
windows <- promoters(my_ranges, upstream=-coords[1], downstream=coords[2])
windows <- windows[width(trim(windows)) == 1000] # Ensure uniform width
```

### 2. Creating Heatmap Objects
Use `CoverageHeatmap` for signal data and `PatternHeatmap` or `PWMScanHeatmap` for sequence features.

```r
# For ChIP-seq/Coverage data
hm_coverage <- CoverageHeatmap(windows, signal_rle, coords=coords, label="H3K4me3")

# For Sequence Patterns (kmers)
seqs <- getSeq(BSgenome.Species, windows)
hm_kmer <- PatternHeatmap(seqs, "TA", coords=coords, label="TA Content")

# For PWMs
hm_pwm <- PatternHeatmap(seqs, my_pwm, coords=coords, min.score="60%", label="TATA")
```

### 3. Smoothing and Scaling
Raw genomic data is often sparse or high-resolution. Smoothing makes patterns visible and reduces file size.

```r
# Smooth using kernel density (for binary/sparse data) or Gaussian blur
hm_smoothed <- smoothHeatmap(hm_kmer, output.size=c(250, 500), algorithm="kernel")

# Set color scales manually
scale(hm_coverage) <- c(0, 100)
```

### 4. Plotting
`plotHeatmapList` is the primary function for rendering. It handles margins and device setup automatically.

```r
# Plot a single heatmap
plotHeatmapList(hm_coverage, color="Greens", legend=TRUE)

# Plot a meta-region (average signal) plot
plotHeatmapMeta(hm_coverage)

# Plot multiple heatmaps in a row with grouped scaling
hm_list <- list(hm_kmer, hm_pwm, hm_coverage)
plotHeatmapList(hm_list, 
                groups=c(1, 1, 2), 
                color=list("Blues", "Greens"),
                cex.label=1.2)
```

## Advanced Features

### Clustering and Partitions
While the package doesn't perform clustering internally, it can display user-defined partitions (e.g., from k-means).

```r
raw_mat <- image(hm_coverage)
clusters <- kmeans(raw_mat, 3)$cluster
# Reorder matrix by cluster
mat_ordered <- raw_mat[order(clusters),]
hm_clustered <- Heatmap(mat_ordered, coords=coords, label="Clustered")

plotHeatmapList(hm_clustered, 
                partition=table(clusters), 
                partition.lines=TRUE, 
                partition.legend=TRUE)
```

### Custom Layouts
For complex figures, use `plotHeatmap` directly with R's `layout()` or `par(mfrow=...)`. Use `heatmapOptions()` to customize specific plot elements like ticks and label colors.

```r
upperOpts <- heatmapOptions(label.col="white", x.ticks=FALSE)
plotHeatmap(hm_smoothed, options=upperOpts)
```

## Tips for Success
- **Smoothing**: Always use `smoothHeatmap` before plotting to a standard device to prevent massive PDF file sizes and improve rendering speed.
- **Out-of-bounds**: Always `trim()` your `GRanges` and filter for uniform width before creating a heatmap to avoid errors.
- **Color Schemes**: Use `RColorBrewer` names (e.g., "Spectral", "Blues") or a vector of colors for interpolation (e.g., `c("red", "white", "blue")`).
- **Coordinate System**: In the plot canvas, the y-axis units correspond to individual windows (rows), and x-axis units correspond to base pairs.

## Reference documentation
- [heatmaps](./references/heatmaps.md)