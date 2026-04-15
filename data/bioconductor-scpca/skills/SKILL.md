---
name: bioconductor-scpca
description: This tool performs Sparse Contrastive Principal Component Analysis and Contrastive PCA to extract relevant signals from high-dimensional biological data by comparing target and background datasets. Use when user asks to remove technical effects or batch noise, isolate biological signals using a control dataset, or perform dimensionality reduction with sparse feature selection.
homepage: https://bioconductor.org/packages/release/bioc/html/scPCA.html
---

# bioconductor-scpca

name: bioconductor-scpca
description: Perform Sparse Contrastive Principal Component Analysis (scPCA) and Contrastive PCA (cPCA) to extract stable, interpretable, and relevant signals from high-dimensional biological data. Use this skill when you need to remove technical effects (like batch effects or cell cycle noise) by comparing a target dataset against a background (control) dataset, or when you require sparse loadings for better feature interpretability in dimensionality reduction.

# bioconductor-scpca

## Overview

The `scPCA` package provides methods for dimensionality reduction that specifically target variation present in a "target" dataset but absent in a "background" dataset. It combines the strengths of Contrastive PCA (cPCA) for signal enrichment and Sparse PCA (sPCA) for feature selection. This is particularly useful in single-cell genomics for removing batch effects or isolating specific biological responses while ensuring the resulting principal components are composed of a small, interpretable subset of genes.

## Main Functions and Workflows

### Core Function: `scPCA()`

The primary interface is the `scPCA()` function. It can perform both cPCA (by setting penalties to 0) and scPCA (by providing a range of L1 penalties).

```r
library(scPCA)

# Basic cPCA (Contrastive only)
cpca_results <- scPCA(
  target = target_matrix,      # n x p matrix (observations x features)
  background = background_matrix, # m x p matrix
  n_centers = 4,               # Expected number of clusters (for hyperparameter tuning)
  penalties = 0,               # No sparsification
  n_eigen = 2                  # Number of components to return
)

# Basic scPCA (Sparse and Contrastive)
scpca_results <- scPCA(
  target = target_matrix,
  background = background_matrix,
  n_centers = 4,
  penalties = exp(seq(log(0.01), log(0.5), length.out = 10)),
  alg = "var_proj"             # Recommended algorithm for speed
)
```

### Key Arguments

- `target`: The dataset containing the signal of interest.
- `background`: The control dataset representing background noise or technical effects.
- `n_centers`: A critical hyperparameter used by the internal clustering-based heuristic to select the optimal contrastive parameter ($\gamma$).
- `penalties`: A vector of L1 penalty terms. If multiple are provided, the best is selected via the internal heuristic.
- `alg`: The optimization framework. Options include `"iterative"` (Zou et al.), `"var_proj"` (Erichson et al.), and `"rand_var_proj"` (Randomized, best for very large datasets).
- `cv`: Number of folds for cross-validation (e.g., `cv = 3`) to ensure hyperparameter generalizability.

### Integration with SingleCellExperiment

`scPCA` integrates directly with Bioconductor containers. Results are typically stored in the `reducedDims` slot.

```r
library(SingleCellExperiment)

# Assuming tg_sce and bg_sce are SingleCellExperiment objects
# Extract log-counts (features in columns)
target_data <- t(log1p(counts(tg_sce)))
bg_data <- t(log1p(counts(bg_sce)))

scpca_out <- scPCA(
  target = target_data,
  background = bg_data,
  n_centers = 2,
  n_eigen = 2,
  alg = "var_proj"
)

# Store back in the SCE object
reducedDim(tg_sce, "scPCA") <- scpca_out$x
```

## Performance and Parallelization

For large genomic datasets, use the following optimizations:

1.  **Algorithm Choice**: Use `alg = "rand_var_proj"` for the fastest performance on high-dimensional data.
2.  **Parallelization**: Set `parallel = TRUE`. This requires registering a backend via `BiocParallel`.
    ```r
    library(BiocParallel)
    register(MulticoreParam())
    res <- scPCA(..., parallel = TRUE)
    ```
3.  **Approximation**: Set `scaled_matrix = TRUE` to use the `ScaledMatrix` framework, which speeds up covariance calculations at a slight cost to numerical precision.

## Interpreting Results

The output object contains:
- `x`: The reduced-dimension embeddings (principal components).
- `rotation`: The loadings matrix. In `scPCA`, many entries in this matrix will be zero, indicating the specific features (genes) that contribute to that component.
- `contrast`: The optimal contrastive parameter selected.
- `penalty`: The optimal L1 penalty selected.

## Reference documentation

- [Sparse contrastive principal component analysis](./references/scpca_intro.md)
- [Sparse contrastive principal component analysis (RMarkdown source)](./references/scpca_intro.Rmd)