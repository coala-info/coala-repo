---
name: bioconductor-transformgampoi
description: This tool performs variance stabilizing transformations on count data using Gamma-Poisson models to handle heteroskedasticity. Use when user asks to apply delta-method transformations, calculate Pearson or randomized quantile residuals, or stabilize variance in single-cell RNA-seq datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/transformGamPoi.html
---


# bioconductor-transformgampoi

name: bioconductor-transformgampoi
description: Variance stabilizing transformations for count data (e.g., single-cell RNA-seq) using Gamma-Poisson models. Use this skill to handle heteroskedasticity in matrix-like objects, SummarizedExperiment, or SingleCellExperiment objects using delta-method or model-residual approaches.

# bioconductor-transformgampoi

## Overview

The `transformGamPoi` package provides specialized variance stabilizing transformations (VST) for heteroskedastic count data, particularly optimized for single-cell RNA sequencing (scRNA-seq). It addresses the mean-variance relationship typical of Gamma-Poisson (Negative Binomial) distributed data, where higher expression leads to higher variance. The package transforms counts into a space where variance is approximately independent of the mean, making the data suitable for downstream statistical methods like PCA or clustering.

## Main Functions and Workflows

### 1. Delta Method-Based Transformations
These functions apply a functional transformation to the data. They are fast and preserve sparsity.

*   `acosh_transform(data, overdispersion = 0.1)`: The recommended delta-method transformation for Gamma-Poisson data.
*   `shifted_log_transform(data, pseudo_count)`: A log-based transformation. Setting `pseudo_count = 1/(4 * overdispersion)` makes it closely approximate the `acosh` transformation.

```r
library(transformGamPoi)

# Works on matrices, DelayedArrays, or SingleCellExperiment
# If 'sce' is a SingleCellExperiment, it uses the 'counts' assay
assay(sce, "acosh") <- acosh_transform(sce)
```

### 2. Model Residual-Based Transformations
These approaches fit a model to the data and return residuals. They often provide better stabilization for lowly expressed genes than delta methods.

*   `residual_transform(data, type = c("pearson", "randomized_quantile"), ...)`:
    *   `type = "pearson"`: Calculates Pearson residuals from a Gamma-Poisson GLM.
    *   `type = "randomized_quantile"`: Calculates non-linear residuals that handle the discrete nature of counts better than Pearson residuals.

```r
# Pearson residuals (clipping is often used to limit the impact of outliers)
assay(sce, "pearson") <- residual_transform(sce, type = "pearson", clipping = TRUE)

# Randomized quantile residuals
assay(sce, "rqr") <- residual_transform(sce, type = "randomized_quantile")
```

## Implementation Tips

*   **Input Types**: The package is highly flexible and accepts `matrix`, `dgCMatrix` (sparse), `DelayedArray`, `SummarizedExperiment`, and `SingleCellExperiment`.
*   **Sparsity**: Delta-method functions (`acosh_transform`, `shifted_log_transform`) are designed to preserve sparsity (mapping 0 to 0).
*   **Overdispersion**: You can provide a fixed `overdispersion` value or let the functions estimate it from the data.
*   **Memory Management**: For large datasets, use the `on_disk = TRUE` parameter in `residual_transform` to handle computations without loading everything into RAM.
*   **Container Integration**: When passing a `SummarizedExperiment` or `SingleCellExperiment`, the functions automatically look for the `"counts"` assay and return an object of the same class with the transformed values.

## Reference documentation

- [transformGamPoi Quickstart](./references/transformGamPoi.md)