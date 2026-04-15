---
name: bioconductor-stjoincount
description: The stJoincount package quantifies spatial relationships between categorical labels in spatial transcriptomics data using join count statistics. Use when user asks to identify spatial enrichment or exclusion of cell types, calculate join count statistics for cluster assignments, or visualize spatial correlations in Visium datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/stJoincount.html
---

# bioconductor-stjoincount

## Overview

The `stJoincount` package provides a framework for quantifying spatial relationships between categorical labels (clusters) in spatial transcriptomics data. It utilizes the join count statistic to determine if neighboring spots share the same or different cluster assignments more often than expected by chance. This is particularly useful for identifying spatial enrichment, exclusion, or random distribution of cell types or tissue domains in Visium datasets.

## Core Workflow

### 1. Data Preparation
The package requires a `data.frame` containing `imagerow`, `imagecol`, and `Cluster` columns. It provides utility functions to extract this from common Bioconductor/Seurat objects.

```r
library(stJoincount)

# From Seurat
df <- dataPrepFromSeurat(seurat_obj, "cluster_column_name")

# From SpatialExperiment
df <- dataPrepFromSpE(spe_obj, "cluster_column_name")
```

### 2. Rasterization
To perform join count analysis, the irregular spatial grid is converted into a raster object.

```r
# Calculate optimal resolution
res <- resolutionCalc(df)

# Convert to raster
mosaicIntegration <- rasterizeEachCluster(df)
```

### 3. Join Count Analysis
The analysis identifies "joins" (adjacent pixels) and compares observed counts to expected counts under spatial randomness.

```r
# Perform the join count test
joincount.result <- joincountAnalysis(mosaicIntegration)
```

### 4. Visualization and Interpretation
Results are typically interpreted via z-scores. A high positive z-score for a cluster pair (e.g., Cluster A - Cluster A) indicates significant spatial aggregation (homophilic joins).

```r
# Generate z-score matrix
matrix <- zscoreMatrix(df, joincount.result)

# Plot heatmap of spatial correlations
zscorePlot(matrix)

# Plot the rasterized tissue map
mosaicIntPlot(df, mosaicIntegration)
```

## Key Functions

- `dataPrepFromSeurat` / `dataPrepFromSpE`: Converters for standard spatial objects.
- `resolutionCalc`: Determines the pixel size for rasterization based on spot coordinates.
- `rasterizeEachCluster`: Creates the raster representation required for the neighbor list.
- `joincountAnalysis`: The core statistical engine; calculates observed/expected counts and variance.
- `zscoreMatrix`: Formats the results into a square matrix for easy visualization.

## Tips for Success
- **Column Names**: Ensure the input dataframe has exactly `imagerow`, `imagecol`, and `Cluster` as column names if not using the provided preparation functions.
- **Resolution Warnings**: If `rasterizeEachCluster` warns that no optimal number was found, it defaults to `n = 110`. This is usually acceptable but may result in minor deviations in high-resolution samples.
- **Interpretation**: 
    - **Positive Z-score**: Spatial clustering (more joins than expected).
    - **Negative Z-score**: Spatial dispersion/avoidance (fewer joins than expected).

## Reference documentation

- [Introduction to stJoincount](./references/stJoincount-vignette.md)
- [stJoincount Vignette Source](./references/stJoincount-vignette.Rmd)