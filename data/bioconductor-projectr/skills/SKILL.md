---
name: bioconductor-projectr
description: The projectR package provides a framework for projection analysis to transfer biological signatures and latent space definitions from a training dataset onto a target dataset. Use when user asks to project target data into a defined pattern space, transfer PCA or NMF loadings between datasets, or identify features driving differences within a specific latent space.
homepage: https://bioconductor.org/packages/release/bioc/html/projectR.html
---

# bioconductor-projectr

## Overview
The `projectR` package provides a framework for "projection" analysis, allowing users to transfer biological signatures (loadings/patterns) learned in one dataset (training) onto another (target). This circumvents many batch effect and technological variation issues by focusing on relative feature relationships. It supports various latent space definitions including Principal Component Analysis (PCA), Non-negative Matrix Factorization (NMF/CoGAPS), clustering, and gene-wise correlation.

## Core Workflow: The projectR Function
The primary function is `projectR()`. It maps target data into a previously defined pattern space.

```r
library(projectR)

# Basic usage
projection <- projectR(
  data = target_matrix,       # Target dataset (genes as rows)
  loadings = training_space,  # prcomp object, CogapsResult, or matrix
  dataNames = NULL,           # Optional: vector of gene names for target
  loadingsNames = NULL,       # Optional: vector of gene names for loadings
  full = FALSE                # TRUE returns full model (limma lmFit)
)
```

### Key Considerations
*   **Feature Matching:** Ensure row names (e.g., Gene Symbols) match between `data` and `loadings`. Use `dataNames` and `loadingsNames` if the objects themselves have mismatched or missing row names.
*   **Output:** By default, it returns `projectionPatterns` (relative weights for samples in the new space). If `full = TRUE`, it returns a list containing the patterns and the underlying `Projection` (usually a `limma` model).

## Specific Projection Methods

### 1. PCA Projection
Project new samples into PCs defined by a training set.
```r
# 1. Define PCs in training data
pc_train <- prcomp(t(training_data))

# 2. Project target data
pca_projected <- projectR(data = target_data, loadings = pc_train)
```

### 2. NMF / CoGAPS Projection
Uses fixed amplitude matrices (A) from NMF to estimate pattern usage (P) in target data via least-squares.
```r
# Assuming 'AP' is the Amean matrix from a CoGAPS result
nmf_projected <- projectR(data = target_data, loadings = AP)
```

### 3. Clustering Projection
Transfer cluster relationships using `cluster2pattern` to create a `pclust` object.
```r
# Convert kmeans clusters to a projection-ready pattern
k_pattern <- cluster2pattern(clusters = kClust_obj, NP = 5, data = training_data)

# Project
clust_projected <- projectR(data = target_data, loadings = k_pattern)
```

### 4. Correlation-based Projection
Use `correlateR` to find genes associated with a specific gene's expression pattern.
```r
# Find genes correlated to gene "T"
cor_weights <- correlateR(genes = "T", dat = training_data, threshold = 0.7)

# Project using the correlation matrix
cor_projected <- projectR(data = target_data, loadings = cor_weights@corM)
```

## Differential Feature Identification
Use `projectionDriveR` to identify which features (genes) drive the differences between two groups within a specific latent space (pattern).

```r
drivers <- projectionDriveR(
  cellgroup1 = matrix_a, 
  cellgroup2 = matrix_b,
  loadings = feature_loadings_matrix,
  pattern_name = "Pattern_1",
  mode = "CI" # "CI" for Confidence Intervals, "PV" for P-values/Volcano
)

# Visualize results
plotConfidenceIntervals(drivers$mean_ci, pattern_name = "Pattern_1")
```

## Tips for Success
*   **Normalization:** Target data should generally be processed (e.g., log-transformed, size-normalized) similarly to the training data for the most meaningful projections.
*   **Gene Overlap:** `projectR` automatically subsets to the intersection of genes between the target data and the loadings. Check the console output to see how many genes matched.
*   **Interpreting Weights:** Projected patterns represent the "strength" of a biological process in the target samples relative to the original training context.

## Reference documentation
- [projectR Vignette](./references/projectR.md)
- [projectR RMarkdown Source](./references/projectR.Rmd)