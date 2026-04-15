---
name: bioconductor-mixomics
description: This tool performs multivariate analysis and integration of biological datasets using sparse methods for variable selection. Use when user asks to perform PCA, PLS-DA, or multi-omics integration to identify key biological signatures and explain relationships between different data types.
homepage: https://bioconductor.org/packages/release/bioc/html/mixOmics.html
---

# bioconductor-mixomics

name: bioconductor-mixomics
description: Multivariate analysis and integration of biological datasets using sparse methods. Use this skill when you need to perform (s)PCA, (s)PLS, (s)PLS-DA, or multi-omics integration (DIABLO/MINT) to identify key variables and explain biological outcomes.

# bioconductor-mixomics

## Overview

The `mixOmics` package provides a suite of multivariate methods for the exploration and integration of large biological datasets. It specializes in variable selection (sparsity) to identify the most influential features (genes, proteins, metabolites) that characterize sample groups or explain relationships between different data types.

## Core Workflow

Most analyses in `mixOmics` follow a three-step pattern:
1. **Run the method**: Execute the multivariate model (e.g., `pca`, `plsda`).
2. **Sample Plotting**: Visualize sample clusters using `plotIndiv`.
3. **Variable Plotting**: Visualize feature contributions using `plotVar` or `plotLoadings`.

## Key Functions and Methods

### 1. Unsupervised Analysis (Single Dataset)
Used for exploratory data analysis to find the main sources of variation.
- `pca(X, ncomp, center, scale)`: Standard Principal Component Analysis.
- `spca(X, ncomp, keepX)`: Sparse PCA for variable selection.
- `tune.pca(X, ncomp)`: Uses a scree plot to help choose the number of components.

### 2. Supervised Analysis (Classification)
Used when samples belong to known groups (e.g., Disease vs. Control).
- `plsda(X, Y, ncomp)`: PLS Discriminant Analysis where Y is a factor.
- `splsda(X, Y, ncomp, keepX)`: Sparse PLS-DA to find a minimal diagnostic signature.
- `tune.splsda(X, Y, ...)`: Optimizes `ncomp` and `keepX` using cross-validation error rates (BER/Overall).

### 3. Data Integration (Two Datasets)
Used to find correlations between two different omics layers (e.g., Transcriptomics and Proteomics) measured on the same samples.
- `pls(X, Y, ncomp, mode = 'regression')`: Relates two datasets.
- `spls(X, Y, ncomp, keepX, keepY)`: Sparse PLS for simultaneous variable selection in both blocks.

### 4. Multi-Omics Integration (N-integration)
- `block.splsda(X, Y, keepX)`: Also known as **DIABLO**. Integrates multiple data blocks (list `X`) to discriminate classes in `Y`.

## Visualization Tools

- `plotIndiv()`: Creates score plots. Use `ellipse = TRUE` for confidence regions and `star = TRUE` to connect samples to centroids.
- `plotVar()`: Correlation circle plots. Variables close to the outer circle (radius 1) contribute strongly to the components.
- `plotLoadings()`: Barplots showing the loading weights of selected variables. Use `contrib = 'max'` to color bars by the group in which the variable is most abundant.
- `cim()`: Clustered Image Maps (heatmaps) for visualizing the expression of selected features.
- `network()`: Relevance networks showing associations between variables across different datasets.

## Critical Parameters

- **Scaling**: Always consider `scale = TRUE` if variables have different units or high variance differences.
- **keepX**: In sparse methods, this is a vector of integers specifying how many variables to select on each component (e.g., `keepX = c(50, 20)`).
- **Distance Metrics**: For classification (`predict` or `perf`), choose between `max.dist`, `centroids.dist`, or `mahalanobis.dist`.

## Performance Evaluation

Use the `perf()` function to validate your model:
- It provides Error Rates (Overall and Balanced Error Rate - BER).
- It calculates **Stability**: How often a variable is selected across cross-validation folds. High stability (>0.8) indicates a robust biomarker.

## Reference documentation
- [mixOmics vignette](./references/vignette.md)