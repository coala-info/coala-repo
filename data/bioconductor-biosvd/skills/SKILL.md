---
name: bioconductor-biosvd
description: This tool performs Singular Value Decomposition on high-throughput biological data to identify major modes of variation and reduce data complexity. Use when user asks to compute eigensystems, filter noise or steady-state signals, and visualize data dynamics through polar plots or heatmaps.
homepage: https://bioconductor.org/packages/3.6/bioc/html/biosvd.html
---

# bioconductor-biosvd

name: bioconductor-biosvd
description: High-throughput data processing, outlier detection, noise removal, and dynamic modeling using Singular Value Decomposition (SVD). Use this skill when analyzing genome-wide expression, proteome abundance, or metabolome intensity data to identify major modes of variation (eigengenes/eigenfeatures), filter steady-state or noise components, and visualize data dynamics through polar plots and heatmaps.

# bioconductor-biosvd

## Overview

The `biosvd` package implements Singular Value Decomposition (SVD) for biological data analysis. It decomposes a feature-by-assay matrix into eigenfeatures and eigenassays. This allows for the reduction of data complexity, removal of experimental artifacts or steady-state signals, and the grouping of features/assays based on their correlation with dominant modes of variation.

## Core Workflow

### 1. Data Preparation
Input data should be a feature x assay matrix, a `data.frame`, or an `ExpressionSet`.

```r
library(biosvd)
# Example using an ExpressionSet
data(YeastData_alpha)
```

### 2. Compute Eigensystem
The `compute()` function performs the SVD. It can be applied to the raw data or to the variance.

```r
# Compute SVD on expression data
eigensystem <- compute(YeastData)

# Compute SVD on variance (for steady-scale normalization)
eigensystem_var <- compute(eigensystem, apply = 'variance')
```

### 3. Visualization and Inspection
Use `EigensystemPlotParam` to configure and `plot()` to visualize the results.

```r
params <- new("EigensystemPlotParam")
# Available plots: "fraction", "scree", "eigenfeatureHeatmap", "lines", "allLines", "eigenfeaturePolar", "sortedHeatmap"
plots(params) <- c("fraction", "allLines")
figure(params) <- TRUE # Display in R session
plot(eigensystem, params)
```

Key metrics to check:
- **Entropy**: `entropy(eigensystem)`. 0 is ordered/redundant; 1 is disordered/random.
- **Fractions**: `fractions(eigensystem)` shows the relative significance of each eigenfeature.

### 4. Filtering (Exclude)
Remove eigenfeatures representing steady-state (often the 1st eigenfeature), noise (rapidly varying), or artifacts.

```r
# Exclude specific eigenfeatures (e.g., 1 for steady state, 10-15 for noise)
eigensystem_filtered <- exclude(eigensystem, excludeEigenfeatures = c(1, 10:15))
```

### 5. Reporting
Generate a summary report containing feature coordinates, radius, and phase in the polar plot space.

```r
report(eigensystem_filtered, params)
```

## Plotting Parameters

The `EigensystemPlotParam` object controls visualization:
- `whichEigenfeatures`: Indices of eigenfeatures to plot (default 1:4).
- `whichPolarAxes`: The two eigenfeatures used for polar plots (default c(2, 1)).
- `assayColorMap` / `featureColorMap`: Named lists for coloring points based on metadata.
- `contrast`: Numeric value to adjust heatmap contrast.

```r
# Example: Custom coloring for polar plots
assayColorMap(params) <- list(Cellcycle.sample = NA) # NA uses default palette for the factor
plot(eigensystem, params)
```

## Reference documentation

- [biosvd](./references/biosvd.md)