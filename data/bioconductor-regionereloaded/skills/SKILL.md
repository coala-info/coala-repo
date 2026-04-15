---
name: bioconductor-regionereloaded
description: This package evaluates statistical associations between multiple genomic region sets using permutation tests and normalized z-scores. Use when user asks to perform crosswise association analysis, calculate normalized z-scores for region set comparisons, conduct dimensionality reduction on genomic associations, or analyze local z-score profiles across multiple datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/regioneReloaded.html
---

# bioconductor-regionereloaded

name: bioconductor-regionereloaded
description: Statistical evaluation of associations between multiple sets of genomic regions using permutation tests. Use when Claude needs to perform crosswise association analysis, calculate normalized z-scores for comparing different region sets, perform dimensionality reduction (PCA, tSNE, UMAP) on genomic associations, or analyze local z-score profiles across multiple datasets.

# bioconductor-regionereloaded

## Overview

`regioneReloaded` is an evolution of the `regioneR` package, designed to handle multiple pairwise association tests (crosswise analysis) simultaneously. It addresses the limitation of standard z-scores—which depend on region set size—by introducing **normalized z-scores (nZS)**, allowing for direct comparison between different experiments. The package provides an S4 framework (`genoMatriXeR` and `multiLocalZScore` objects) to manage, cluster, and visualize complex genomic association matrices.

## Core Workflows

### 1. Crosswise Permutation Testing
To test associations between all combinations of region sets in one or two lists.

```r
library(regioneReloaded)

# Perform crosswise permutation tests
# Alist: List of GRanges objects
# ranFUN: randomization function (e.g., "resampleGenome", "randomizeRegions")
# evFUN: evaluation function (default "numOverlaps")
cw_results <- crosswisePermTest(Alist = my_region_list,
                                 genome = my_genome,
                                 ntimes = 1000,
                                 mc.cores = 4)

# Create the association matrix (calculates normalized z-scores and clusters)
cw_results <- makeCrosswiseMatrix(cw_results, pvcut = 0.05)

# Visualize the matrix
plotCrosswiseMatrix(cw_results, matrix_type = "association")
```

### 2. Normalized Z-Score (nZS)
The package automatically calculates `norm_zscore = ZS / sqrt(n)`, where `n` is the number of regions in the first set. This value is stable even when sampling only a portion (e.g., 30%) of large datasets to save time.

### 3. Dimensionality Reduction
Visualize how different region sets cluster based on their association profiles.

```r
# Supports "PCA", "tSNE", or "UMAP"
plotCrosswiseDimRed(cw_results, type = "PCA", nc = 5, clust_met = "hclust")
```

### 4. Multi-Local Z-Score Analysis
Analyze the spatial dependency of an association within a specific genomic window.

```r
# Calculate local z-scores for one region set against a list
mlz_results <- multiLocalZscore(A = target_regions,
                                Blist = reference_list,
                                window = 1000,
                                step = 50,
                                genome = my_genome)

# Generate matrix and plot
mlz_results <- makeLZMatrix(mlz_results)
plotLocalZScoreMatrix(mlz_results)

# Plot specific profiles
plotSingleLZ(mlz_results, RS = c("Set1", "Set2"), smoothing = TRUE)
```

## Key Functions and Parameters

- `crosswisePermTest()`: Main function for multi-set association. Use `sampling = TRUE` and `fraction` to speed up calculations on large datasets.
- `makeCrosswiseMatrix()`: Converts permutation results into a matrix. It automatically selects the best clustering method (average, complete, etc.) using `chooseHclustMet()`.
- `plotSinglePT()`: Visualizes the results of a single pairwise comparison from a `genoMatriXeR` object, showing the random distribution vs. observed value.
- `similarRegionSet()`: Useful for creating "artificial" associations for testing by perturbing an existing region set.

## Tips for Success

- **Permutations**: Use at least `ntimes = 5000` for publication-quality, reproducible p-values.
- **Parallelization**: Use the `mc.cores` parameter in `crosswisePermTest` to distribute the workload.
- **Non-Square Matrices**: The package supports comparing `Alist` and `Blist` of different lengths; `makeCrosswiseMatrix` will handle the asymmetric clustering.
- **Accessing Data**: Use `getParameters()`, `getMatrix()`, and `getMultiEvaluation()` to extract data from the S4 objects rather than accessing slots directly.

## Reference documentation

- [regioneReloaded](./references/regioneReloaded.md)
- [regioneReloaded Vignette](./references/regioneReloaded.Rmd)