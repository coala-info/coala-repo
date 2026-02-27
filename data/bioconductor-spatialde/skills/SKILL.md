---
name: bioconductor-spatialde
description: This package identifies genes with significant spatial variation in expression levels across tissue samples using a statistical framework. Use when user asks to identify spatially variable genes, stabilize expression variance, regress out library size effects, or cluster genes into spatial patterns using automatic expression histology.
homepage: https://bioconductor.org/packages/release/bioc/html/spatialDE.html
---


# bioconductor-spatialde

## Overview

The `spatialDE` package is an R wrapper for the SpatialDE Python method. It provides a statistical framework to identify genes that exhibit spatial variation in expression levels across a tissue. It decomposes gene expression variance into a spatial component and a non-spatial noise component. Key features include variance stabilization, regression of library size effects, significance testing for spatial variability, and automatic expression histology (AEH) to cluster genes into spatial patterns.

## Core Workflow

### 1. Data Preparation
The package requires a gene expression matrix (genes as rows, spots/cells as columns) and a corresponding data frame of spatial coordinates.

```r
library(spatialDE)

# Load example data
data("Rep11_MOB_0") # Expression matrix
data("MOB_sample_info") # Metadata with 'x' and 'y' columns

# Filter lowly expressed genes
counts <- Rep11_MOB_0[rowSums(Rep11_MOB_0) >= 3, ]

# Extract coordinates
X <- MOB_sample_info[, c("x", "y")]
```

### 2. Normalization and Pre-processing
SpatialDE assumes normally distributed data. Use Anscombe's transformation and regress out library size effects.

```r
# 1. Stabilize variance (Anscombe's approximation)
norm_expr <- stabilize(counts)

# 2. Regress out total counts (library size)
resid_expr <- regress_out(norm_expr, sample_info = MOB_sample_info)
```

### 3. Identifying Spatially Variable Genes (SVGs)
The `run` function performs the significance test.

```r
# Run SpatialDE test
results <- spatialDE::run(resid_expr, coordinates = X)

# Filter for significant SVGs (e.g., q-value < 0.05)
de_results <- results[results$qval < 0.05, ]
```

### 4. Model Search and Spatial Patterns
Classify genes into interpretable DE classes (e.g., linear, periodic) and group them into spatial patterns using Automatic Expression Histology (AEH).

```r
# Classify DE classes
ms_results <- model_search(resid_expr, coordinates = X, de_results = de_results)

# Group into spatial patterns
sp <- spatial_patterns(resid_expr, coordinates = X, de_results = de_results, 
                       n_patterns = 4L, length = 1.5)
# Access pattern membership
print(sp$pattern_results)
```

## SpatialExperiment Integration

If using the `SpatialExperiment` (SPE) class, the package provides high-level wrappers that handle the internal transpositions and metadata extraction.

```r
library(SpatialExperiment)

# Run full pipeline on SPE object
out <- spatialDE(spe, assay_type = "counts")

# Classify and cluster within SPE workflow
msearch <- modelSearch(spe, de_results = out, qval_thresh = 0.05)
spatterns <- spatialPatterns(spe, de_results = out, qval_thresh = 0.05, n_patterns = 4L)
```

## Visualization

The package includes utilities to visualize spatial variance and multi-gene expression patterns.

```r
# Plot Fraction Spatial Variance (FSV) vs Q-value
FSV_sig(results, ms_results)

# Plot top significant genes
multiGenePlots(norm_expr, coordinates = X, genes = de_results$g[1:6])
```

## Tips and Best Practices
- **Transposition**: The `stabilize` and `regress_out` functions expect samples in columns and genes in rows (standard Bioconductor format), but the underlying Python engine often transposes these. The R wrappers handle this, but ensure your input matrix is correctly oriented.
- **Performance**: Running `spatialDE::run` on the full genome can be time-consuming (approx. 10-20 minutes for 15k genes). Consider pre-filtering or testing on a subset of highly variable genes first.
- **Length Scale**: In `spatial_patterns`, the `length` parameter controls the smoothness of the patterns. Adjust this based on the expected scale of biological features in your tissue.

## Reference documentation
- [Introduction to spatialDE](./references/spatialDE.Rmd)
- [Introduction to spatialDE (Markdown)](./references/spatialDE.md)