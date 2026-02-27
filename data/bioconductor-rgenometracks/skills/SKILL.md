---
name: bioconductor-rgenometracks
description: This tool creates high-quality, publication-ready genomic visualizations by combining multiple data tracks like bigWig, BED, and Hi-C matrices into synchronized plots within R. Use when user asks to visualize epigenetic data, create genomic track plots, plot Hi-C matrices, or display gene annotations alongside signal data.
homepage: https://bioconductor.org/packages/release/bioc/html/rGenomeTracks.html
---


# bioconductor-rgenometracks

name: bioconductor-rgenometracks
description: Visualizing epigenetic and genomic data tracks using rGenomeTracks. Use this skill to create high-quality, publication-ready genomic plots including Hi-C matrices, TADs, bigWig signals, gene annotations (GTF), and bed files within an R environment.

# bioconductor-rgenometracks

## Overview

The `rGenomeTracks` package is an R wrapper for the `pyGenomeTracks` python software. It allows users to construct complex genomic visualizations by defining individual "tracks" (e.g., bigWig, BED, Hi-C) as R objects, combining them using standard operators, and rendering them through a unified plotting function. It is particularly useful for integrating diverse epigenetic data types into a single synchronized view.

## Installation and Setup

The package requires a Python backend. If not already configured, install the necessary dependencies:

```r
library(rGenomeTracks)
# Install the required python backend
install_pyGenomeTracks()
```

## Core Workflow

### 1. Define Individual Tracks
Create track objects using specific functions for each data type. Common track functions include:

*   **Signal/Quantitative:** `track_bigwig()`, `track_bedgraph()`
*   **Features/Intervals:** `track_bed()`, `track_gtf()`, `track_narrowPeak()`
*   **Chromatin Interaction:** `track_hic_matrix()`, `track_links()` (for arcs/loops), `track_domains()` (for TADs)
*   **Annotation/Utility:** `track_x_axis()`, `track_scalebar()`, `track_spacer()`, `track_vlines()`

Example of creating a track:
```r
bw_track <- track_bigwig(file = "data.bw", color = "blue", height = 3, title = "RNA-seq")
```

### 2. Combine Tracks
Use the `+` operator to stack tracks in the order you want them to appear (top to bottom).

```r
# Combine multiple tracks into one object
my_tracks <- track_x_axis() + bw_track + track_spacer() + track_gene_annots
```

### 3. Plotting
Use `plot_gtracks()` to render the visualization. You must specify the genomic coordinates (`chr`, `start`, `end`).

```r
plot_gtracks(my_tracks, chr = "chr1", start = 1000000, end = 1500000)
```

## Advanced Usage and Tips

### Batch Track Creation
To load multiple files of the same type efficiently, use `lapply` and `Reduce`:

```r
files <- list.files(pattern = "*.bed")
bed_tracks <- Reduce("+", lapply(files, track_bed))
```

### Overlaying Tracks
Many track functions support the `overlay_previous` argument (values: "no", "share-y", or "yes"). This allows you to plot multiple data sources on the same Y-axis or physical space.

### Complex Layouts
For multi-panel figures, use R's standard `layout()` or `par(mfrow=...)` functions. Note that when using custom R layouts, do not use the `dir` argument in `plot_gtracks()`; instead, use R's standard device saving (e.g., `pdf()`, `png()`).

```r
layout(matrix(c(1,2), nrow = 2))
plot_gtracks(tracks_set_A, chr = "chr1", start = 1e6, end = 2e6)
plot_gtracks(tracks_set_B, chr = "chr1", start = 1e6, end = 2e6)
```

## Reference documentation

- [rGenomeTracks](./references/rGenomeTracks.md)