---
name: bioconductor-spatialcpie
description: SpatialCPie evaluates and visualizes cluster assignments in spatial transcriptomics data across multiple resolutions. Use when user asks to explore cluster ancestry, visualize spatial distributions of clusters using pie charts, or interactively assess cluster granularity.
homepage: https://bioconductor.org/packages/release/bioc/html/SpatialCPie.html
---

# bioconductor-spatialcpie

## Overview
SpatialCPie (Cluster Propagation and Interactive Exploration) is a tool for evaluating cluster assignments in spatial transcriptomics data. It addresses the challenge of selecting an appropriate cluster resolution by visualizing how clusters split and merge across different levels of granularity. The package provides a Shiny gadget for interactive exploration and functions to generate static plots of cluster "ancestry" and spatial distributions.

## Core Workflow

### 1. Data Preparation
SpatialCPie requires three main components:
- **Counts**: A gene expression matrix (genes as rows, spots as columns). Data should be normalized (e.g., using Seurat's `SCTransform`).
- **Image**: A JPEG image of the tissue section (loaded via `jpeg::readJPEG`).
- **Spot Coordinates**: A data frame with `x` and `y` pixel coordinates for each spot, where row names match the column names of the count matrix.

```r
library(SpatialCPie)

# Load spot coordinates
spots <- parseSpotFile("path/to/spot_data.tsv")

# Subset counts to match spots under tissue
counts <- counts[, colnames(counts) %in% rownames(spots)]
```

### 2. Interactive Exploration
The primary entry point is `runCPie`. This launches a Shiny gadget that computes clusters at multiple resolutions and allows for interactive visualization.

```r
result <- runCPie(
    counts,
    image = tissue_image,
    spotCoordinates = spots,
    resolutions = 2:6, # Range of cluster numbers to evaluate
    assignmentFunction = function(k, x) cluster::pam(x, k = k)$clustering # Optional: custom clustering
)
```

### 3. Visualizing Results
The object returned by `runCPie` contains both the cluster assignments and ggplot2 objects.

- **Cluster Graph**: Shows the relationship between resolutions. Nodes represent clusters; edges represent the flow of spots between resolutions.
  ```r
  result$clusterGraph
  ```
- **Spatial Array Plots**: Displays spots on the tissue image. Each spot is a pie chart showing its affinity to various clusters.
  ```r
  # View spatial plot for resolution 4
  result$arrayPlot$`4`
  ```

### 4. Sub-clustering
To refine an analysis, you can extract specific spots from a cluster of interest and re-run the pipeline.

```r
library(dplyr)

# Extract spots assigned to clusters 1 and 4 at resolution 4
sub_spots <- result$clusters %>%
    filter(resolution == 4, cluster %in% c(1, 4)) %>%
    pull(unit)

# Re-run analysis on subset
sub_result <- runCPie(
    counts = counts[, sub_spots],
    image = tissue_image,
    spotCoordinates = spots
)
```

## Key Parameters
- `resolutions`: Numeric vector specifying the number of clusters ($k$) to compute.
- `margin`: Either `"spot"` (default) or `"gene"`. Determines how cluster affinity scores are calculated.
- `assignmentFunction`: A function taking `(k, x)` and returning cluster labels. Defaults to `kmeans`.
- `scoreMultiplier` ($\lambda$): Used to tune the contrast in pie charts. High values (e.g., 10.0) lead to "harder" cluster assignments in the visualization.

## Reference documentation
- [Spatial transcriptomics cluster analysis with SpatialCPie](./references/SpatialCPie.md)