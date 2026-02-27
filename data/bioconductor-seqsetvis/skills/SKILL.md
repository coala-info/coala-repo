---
name: bioconductor-seqsetvis
description: The bioconductor-seqsetvis package provides tools for the comparison, visualization, and signal analysis of multiple genomic datasets such as ChIP-seq and ATAC-seq. Use when user asks to overlap peak sets, fetch signal from BigWig or BAM files, create heatmaps, generate Venn diagrams, or produce aggregated profile plots for genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/seqsetvis.html
---


# bioconductor-seqsetvis

name: bioconductor-seqsetvis
description: Expert guidance for the seqsetvis Bioconductor package. Use this skill when you need to visualize and analyze multiple genomic datasets (ChIP-seq, ATAC-seq, etc.), compare peak sets, fetch signal from bigwig/BAM files, and create publication-ready ggplot2 visualizations like heatmaps, Venn diagrams, and profile plots.

# bioconductor-seqsetvis

## Overview

The `seqsetvis` package (seq - set - vis) is designed for the comparison and visualization of multiple genomic datasets. It excels at integrating coordinate-based data (BED/narrowPeak) with signal data (BigWig/BAM). It leverages `data.table` for performance and `ggplot2` for flexible, publication-quality plotting.

Key capabilities include:
- Overlapping multiple GRanges sets to find common and unique regions.
- Fetching signal profiles from BigWig or BAM files for specific genomic intervals.
- Generating standardized visualizations: Venn diagrams, Euler diagrams, heatmaps, and aggregated line plots.
- Clustering genomic regions based on signal patterns.

## Core Workflows

### 1. Defining and Comparing Sets
To compare multiple peak sets (e.g., from different cell lines or treatments), use `ssvOverlapIntervalSets`.

```r
library(seqsetvis)
library(GenomicRanges)

# Load peak files (supports narrowPeak, BED, etc.)
peak_files <- c(A = "path/to/A.narrowPeak", B = "path/to/B.narrowPeak")
peak_grs <- easyLoad_narrowPeak(peak_files)

# Create overlap object (GRanges with membership metadata)
olaps <- ssvOverlapIntervalSets(peak_grs)

# Visualize overlaps
ssvFeatureBars(olaps)
ssvFeatureVenn(olaps) # Limited to 3 sets
ssvFeatureEuler(olaps) # Better for >3 sets
```

### 2. Fetching Signal Data
Retrieve signal from BigWig or BAM files for a set of regions.

```r
bw_files <- c(sample1 = "s1.bw", sample2 = "s2.bw")
# Define regions (e.g., centered on peaks with fixed width)
query_gr <- centerFixedSizeGRanges(olaps, width = 2000)

# Fetch signal (win_size determines resolution/binning)
bw_gr <- ssvFetchBigwig(bw_files, query_gr, win_size = 50)
```

### 3. Signal Visualization
Once signal is fetched, use the `ssvSignal*` family of functions.

```r
# Aggregated line plot (Mean signal across all regions)
ssvSignalLineplotAgg(bw_gr)

# Heatmap with automatic k-means clustering
ssvSignalHeatmap(bw_gr, nclust = 5)

# Scatterplot comparing two samples
ssvSignalScatterplot(bw_gr, x_name = "sample1", y_name = "sample2")
```

### 4. Advanced Clustering and Centering
To improve heatmaps, you can center regions at the point of maximum signal.

```r
# Center regions at max signal within a 150bp window
centered_gr <- centerAtMax(bw_gr, view_size = 150)

# Perform manual clustering to reuse cluster IDs
clust_gr <- ssvSignalClustering(centered_gr, nclust = 3)
ssvSignalHeatmap(clust_gr)
```

## Tips and Best Practices
- **Data Structure**: Most `ssvFetch` functions return a GRanges object where signal values are in the `y` column and relative coordinates are in the `x` column.
- **Customization**: Since all plots are `ggplot2` objects, you can add themes, labels, or scales using the `+` operator (e.g., `+ theme_bw()`).
- **Factorizing**: Use `ssvFactorizeMembTable(mcols(olaps))` to create a single factor column representing the unique overlap combination for each region, which is useful for coloring plots.
- **Performance**: For large datasets, `ssvFetchBigwig` is significantly faster than processing BAM files directly. Convert BAMs to BigWig for iterative visualization.

## Reference documentation
- [seqsetvis_overview.md](./references/seqsetvis_overview.md)