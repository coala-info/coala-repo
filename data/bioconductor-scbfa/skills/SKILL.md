---
name: bioconductor-scbfa
description: This tool performs gene detection analysis and dimensionality reduction for scRNA-seq data using binary factor analysis and binary PCA. Use when user asks to model binary gene detection patterns, learn low-dimensional embeddings, or perform dimensionality reduction on single-cell datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/scBFA.html
---

# bioconductor-scbfa

name: bioconductor-scbfa
description: Perform gene detection analysis and dimensionality reduction for scRNA-seq data using Binary Factor Analysis (BFA) and Binary PCA. Use this skill when you need to model the binary gene detection pattern (presence/absence) to learn low-dimensional embeddings, classify cell types, or visualize single-cell datasets.

# bioconductor-scbfa

## Overview

The `scBFA` package implements a gene detection model designed for single-cell RNA-seq (scRNA-seq) data. Unlike methods that focus on transcript abundance (counts), `scBFA` focuses on the binary state of gene detection. It provides two primary methods for dimensionality reduction:
1. **Binary Factor Analysis (BFA)**: A latent variable model that can incorporate cell-level covariates (e.g., batch effects) and gene-level covariates (e.g., QC measures).
2. **Binary PCA**: A faster, non-probabilistic alternative for binary data dimensionality reduction.

## Typical Workflow

### 1. Data Preparation
The package accepts `SingleCellExperiment` objects, `SummarizedExperiment` objects, or raw count matrices.

```r
library(scBFA)
library(SingleCellExperiment)

# Assuming 'exprdata' is a matrix with genes as rows and cells as columns
sce <- SingleCellExperiment(assay = list(counts = exprdata))
```

### 2. Dimensionality Reduction with BFA
Use the `scBFA` function to fit the model. You can specify the number of latent dimensions (factors).

```r
# Fit BFA model with 2 latent factors
bfa_model <- scBFA(scData = sce, numFactors = 2)

# The model object contains:
# bfa_model$ZZ: The N x K embedding matrix (cells in low-dim space)
# bfa_model$AA: The G x K loading matrix (gene contributions)
# bfa_model$beta: Coefficients for cell-level covariates (if provided)
# bfa_model$gamma: Coefficients for gene-level covariates (if provided)
```

### 3. Dimensionality Reduction with Binary PCA
For a quicker analysis without covariate modeling, use `BinaryPCA`.

```r
bpca_model <- BinaryPCA(scData = sce)

# Access the embedding (principal components)
embeddings <- bpca_model$x[, 1:2]
```

### 4. Visualization
The resulting embeddings are typically visualized using ggplot2, often after applying further non-linear projection like t-SNE or UMAP on the BFA/BinaryPCA coordinates.

```r
library(ggplot2)
df <- as.data.frame(bfa_model$ZZ)
ggplot(df, aes(x = V1, y = V2)) + 
  geom_point() + 
  theme_minimal() +
  labs(title = "BFA Embedding")
```

## Key Functions

- `scBFA()`: Main function for Binary Factor Analysis. Supports `numFactors` and covariate integration.
- `BinaryPCA()`: Performs PCA optimized for binary detection matrices.
- `get_Z()`: Utility to extract the cell embedding matrix from a model.

## Tips for Success
- **Input Data**: While the package handles raw counts, it internally converts them to a binary detection matrix (0 for zero counts, 1 for non-zero).
- **Feature Selection**: For large datasets, it is recommended to subset to the most variable genes (e.g., top 500-2000) before running `scBFA` to improve computational efficiency.
- **Covariates**: If your data has known batch effects, include them in the `scBFA` call to ensure the latent space represents biological signal rather than technical noise.

## Reference documentation
- [Gene Detection Analysis for scRNA-seq](./references/vignette.md)