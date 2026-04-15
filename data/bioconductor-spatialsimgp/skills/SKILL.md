---
name: bioconductor-spatialsimgp
description: This tool simulates spatial transcriptomics data using Gaussian Processes and Poisson distributions to model spatial variation and mean-variance relationships. Use when user asks to generate synthetic spatial gene expression data, benchmark spatially variable gene detection methods, or create SpatialExperiment objects with controlled spatial patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/spatialSimGP.html
---

# bioconductor-spatialsimgp

name: bioconductor-spatialsimgp
description: A specialized tool for simulating spatial transcriptomics data using Gaussian Processes (GP) and Poisson distributions. Use this skill when you need to generate synthetic spatial gene expression data, benchmark spatially variable gene (SVG) detection methods, or create SpatialExperiment objects with controlled spatial patterns, length scales, and mean-variance relationships.

# bioconductor-spatialsimgp

## Overview

`spatialSimGP` is an R package designed to simulate spatial transcriptomics data that mimics the biases found in real biological samples, specifically the mean-variance relationship. It uses a Gaussian Process with a Matern kernel (squared exponential distance) to model spatial variation and a Poisson distribution for raw count generation. The package is fully integrated with the `SpatialExperiment` Bioconductor class.

## Core Workflow

### 1. Prepare Coordinates
The simulation requires a matrix of spatial coordinates (e.g., x and y positions). You can use coordinates from existing datasets or create a custom grid.

```r
# Example: Creating a 20x20 grid
n_side <- 20
coords <- cbind(
  pxl_col_in_fullres = rep(1:n_side, each = n_side),
  pxl_row_in_fullres = rep(1:n_side, times = n_side)
)
```

### 2. Define Simulation Parameters
- `n_genes`: Total number of genes to simulate.
- `proportion`: Fraction of genes with no spatial pattern (random noise).
- `range_sigma.sq`: Numeric vector `c(min, max)` for spatial variance.
- `range_beta`: Numeric vector `c(min, max)` for mean expression levels.
- `length_scale`: Controls the size/decay of spatial patterns.

### 3. Run Simulation
Use `spatial_simulate()` to generate a `SpatialExperiment` object.

**Option A: Fixed Length Scale (Faster)**
All genes share the same spatial decay parameter.
```r
spe <- spatial_simulate(
  n_genes = 10, 
  proportion = 0.2, 
  coords = coords,
  range_sigma.sq = c(1.5, 3), 
  range_beta = c(3, 7),
  length_scale = 60, 
  length_scale_option = "fixed"
)
```

**Option B: Unique Length Scale (More Flexible)**
Each gene receives a specific length scale, allowing for diverse spatial patterns.
```r
l_scales <- c(20, 40, 60, 80, 100)
spe <- spatial_simulate(
  n_genes = 5, 
  proportion = 0, 
  coords = coords,
  range_sigma.sq = c(1.5, 3), 
  range_beta = c(3, 7),
  length_scale = l_scales, 
  length_scale_option = "unique"
)
```

## Tips for Effective Simulation

- **Reproducibility**: Always use `set.seed()` before running `spatial_simulate` as the GP sampling is stochastic.
- **Single Gene Control**: To simulate a specific gene with exact parameters, set `n_genes = 1`, `proportion = 0`, and provide identical values for the ranges (e.g., `range_beta = c(5, 5)`).
- **Visualization**: Simulated counts can be extracted via `counts(spe)` and joined with `spatialCoords(spe)` for plotting with `ggplot2`.
- **Performance**: The "unique" length scale option is significantly slower because the covariance matrix must be recalculated for every gene. Use "fixed" for large-scale simulations unless pattern diversity is critical.

## Reference documentation

- [spatialSimGP Tutorial (Rmd)](./references/spatialSimGP.Rmd)
- [spatialSimGP Tutorial (Markdown)](./references/spatialSimGP.md)