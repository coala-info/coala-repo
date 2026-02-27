---
name: bioconductor-scry
description: The scry package provides methods for feature selection and dimension reduction of single-cell RNA-seq data using multinomial and Poisson null models. Use when user asks to rank genes by biological variation using deviance, perform dimension reduction with GLM-PCA, or compute null residuals for large-scale count data analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/scry.html
---


# bioconductor-scry

## Overview

The `scry` package provides methods for single-cell RNA-seq analysis based on multinomial and Poisson null models. It is particularly effective for UMI counts where traditional log-normalization can introduce artifacts. The core workflow involves:
1. **Feature Selection**: Using binomial deviance to rank genes by biological variation.
2. **Dimension Reduction**: Using GLM-PCA (Generalized Linear Model Principal Component Analysis) or PCA on null residuals (deviance or Pearson) to visualize and cluster cells.

## Core Functions and Workflows

### Feature Selection with Deviance
Instead of using highly variable genes (HVGs) based on mean-variance relationships, `scry` uses deviance to identify genes that deviate from a constant expression null model.

```r
library(scry)
library(SingleCellExperiment)

# Apply to a SingleCellExperiment object
# assay="counts" is the default; sorted=TRUE ranks genes by deviance
sce <- devianceFeatureSelection(sce, assay="counts", sorted=TRUE)

# Results are stored in rowData
dev_stats <- rowData(sce)$binomial_deviance

# Filter for top 2000 informative genes
sce_sub <- sce[1:2000, ]
```

### Dimension Reduction with GLM-PCA
GLM-PCA performs dimensionality reduction directly on count data, accounting for the non-normal distribution of the data.

```r
# L is the number of latent dimensions (e.g., 2 for visualization)
sce <- GLMPCA(sce, L=2, assay="counts")

# Access factors (cell embeddings) from metadata
factors <- metadata(sce)$glmpca$factors
```

### Fast Approximation with Null Residuals
For very large datasets where GLM-PCA is computationally expensive, you can compute null residuals and then apply standard PCA.

```r
# Compute residuals (type can be "deviance" or "pearson")
sce <- nullResiduals(sce, assay="counts", type="deviance")

# The residuals are stored as a new assay
# You can then run standard PCA on these residuals
# Note: prcomp requires transposing the matrix (cells as rows)
res <- prcomp(t(assay(sce, "binomial_deviance_residuals")), rank.=2)
```

## Working with Large Datasets
`scry` supports `DelayedArray` and `HDF5Array` objects, allowing analysis of datasets that do not fit in memory.

- **Memory Efficiency**: Using `HDF5Array` saves memory but is slower than in-memory matrices.
- **Sparsity**: If the data fits in memory, converting to a sparse `Matrix` (e.g., `dgCMatrix`) provides the fastest computation times for `devianceFeatureSelection`.

```r
# Example with sparse matrix for speed
sparse_counts <- Matrix::Matrix(counts(sce), sparse=TRUE)
devs <- devianceFeatureSelection(sparse_counts)
```

## Tips for Success
- **Input Data**: Always use raw UMI counts. Do not use log-normalized or scaled data as input for `devianceFeatureSelection` or `GLMPCA`.
- **Gene Ranking**: The deviance curve often shows a "knee." Plotting `rowData(sce)$binomial_deviance` can help determine a threshold for how many genes to keep for downstream analysis.
- **Latent Factors**: While 2 factors are good for visualization, using 10-20 factors is often better for capturing subtle biological clusters before performing clustering.

## Reference documentation
- [Scry Methods For Larger Datasets](./references/bigdata.md)
- [Overview of Scry Methods](./references/scry.md)