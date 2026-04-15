---
name: bioconductor-lemur
description: This tool analyzes multi-condition single-cell RNA-seq data using geodesic regression to disentangle global effects from latent cell states. Use when user asks to predict cell-specific gene expression changes, identify differential expression neighborhoods, or integrate latent spaces across multi-condition single-cell datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/lemur.html
---

# bioconductor-lemur

## Overview

The `lemur` package provides a framework for analyzing single-cell RNA-seq datasets with multiple conditions (e.g., treated vs. control, multiple patients). It uses geodesic regression on Grassmann manifolds to disentangle global effects (covariates) from latent cell states. Key capabilities include:
- Predicting gene expression changes for every individual cell as if it were in a different condition.
- Identifying cell neighborhoods with significant, consistent differential expression.
- Integrating/aligning latent spaces across samples while preserving condition-specific signals.

## Core Workflow

### 1. Model Fitting
The primary entry point is the `lemur()` function, which operates on a `SingleCellExperiment` (SCE) object.

```r
library(lemur)
# sce: SingleCellExperiment with logcounts
fit <- lemur(sce, 
             design = ~ patient_id + condition, 
             n_embedding = 15, 
             test_fraction = 0.5)
```
- `design`: Formula referencing `colData` columns.
- `n_embedding`: Number of latent dimensions (similar to PCA components).
- `test_fraction`: Fraction of cells reserved for statistical validation of DE neighborhoods.

### 2. Latent Space Alignment (Optional)
To ensure corresponding cell types from different samples overlap in the embedding, use alignment functions.

```r
# Automated alignment using Harmony
fit <- align_harmony(fit)

# Access the embedding for visualization (e.g., UMAP)
latent_coords <- fit$embedding
```

### 3. Predicting Differential Expression
The `test_de` function calculates predicted log fold changes (LFC) for every cell and gene based on a contrast.

```r
# Define contrast using the cond() helper
fit <- test_de(fit, contrast = cond(condition = "treated") - cond(condition = "ctrl"))

# Results are stored in a new assay named "DE"
de_matrix <- assay(fit, "DE")
```

### 4. Finding DE Neighborhoods
Identify groups of cells showing significant differential expression. This step uses the held-out `test_data` for validation.

```r
# group_by: variables defining the experimental units (e.g., replicates/patients)
neighborhoods <- find_de_neighborhoods(fit, group_by = vars(patient_id, condition))

# The result is a tibble with p-values, LFC, and cell indices
# 'did_lfc' (difference-in-difference) indicates if the effect is specific to the neighborhood
```

## Tips and Troubleshooting

- **Data Input**: Use unaligned data. `lemur` needs to see the original differences to model them. Log-transformed counts are recommended.
- **Performance**: 
    - Increase `test_fraction` to speed up model fitting (uses fewer cells for training).
    - Use `selection_procedure = "zscore"` in `find_de_neighborhoods` for faster results than `"contrast"`.
- **Integration Issues**: If conditions remain too separated or over-corrected, try `linear_coefficient_estimator = "zero"` in the `lemur()` call to prevent the initial linear regression from introducing shifts.
- **Accessing Data**: The `lemur_fit` object extends `SingleCellExperiment`. Use `fit$embedding` to get the low-dimensional representation and `assay(fit, "DE")` for predicted changes.

## Reference documentation

- [Introduction](./references/Introduction.md)