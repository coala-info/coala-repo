---
name: bioconductor-snifter
description: "snifter provides an R wrapper for the fast interpolated t-SNE implementation to perform dimensionality reduction on large datasets. Use when user asks to run t-SNE embeddings, project new data points into an existing embedding, or perform fast manifold learning using the openTSNE backend."
homepage: https://bioconductor.org/packages/release/bioc/html/snifter.html
---


# bioconductor-snifter

## Overview

`snifter` is a Bioconductor package that provides an R wrapper for the `openTSNE` Python implementation of fast interpolated t-SNE (FI-tSNE). It utilizes the `basilisk` framework to manage the underlying Python environment automatically, ensuring reproducibility and ease of installation. Its primary advantages are speed and the ability to project new data points into a pre-calculated embedding without re-running the entire algorithm.

## Core Workflow

### 1. Installation and Setup
The package manages its own Python dependencies. Ensure you have `basilisk` installed to handle the backend.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("snifter")

library(snifter)
```

### 2. Running t-SNE with `fitsne`
The `fitsne` function is the primary entry point. It accepts a matrix or any object that can be coerced into one (rows as observations, columns as features).

```r
# Basic usage
# counts: matrix where rows are cells/samples and columns are genes/features
fit <- fitsne(counts, random_state = 42L)

# Common parameters:
# - random_state: Integer for reproducibility.
# - perplexity: Controls the balance between local and global aspects of the data (default 30).
# - n_iter: Number of iterations (default 500).
# - initialization: "pca" (default) or "random".
```

### 3. Projecting New Data
A unique feature of `snifter` is the ability to add new observations to an existing t-SNE map using the `project` function.

```r
# 1. Create initial embedding with training data
embedding <- fitsne(train_mat, random_state = 42L)

# 2. Project new (test) data into that same space
# 'new' is the matrix of new observations
# 'old' is the original matrix used to create 'embedding'
new_coords <- project(embedding, new = test_mat, old = train_mat)
```

## Usage Tips

- **Data Scaling**: Like most t-SNE implementations, it is highly recommended to perform PCA or log-normalization on your data before passing it to `fitsne` to reduce noise and improve performance.
- **Reproducibility**: Always set `random_state` (as an integer, e.g., `42L`) to ensure the stochastic nature of t-SNE doesn't change your results between runs.
- **Input Format**: Ensure your input matrix has observations as rows. If your data is in a standard Bioconductor format (like `SingleCellExperiment`), you may need to extract the reduced dimensions or transposed assay data first.
- **Memory/Speed**: FI-tSNE is significantly faster than standard t-SNE for large datasets (e.g., >50,000 cells) due to the interpolation optimization.

## Reference documentation

- [Introduction to snifter](./references/snifter.Rmd)
- [Introduction to snifter (Markdown)](./references/snifter.md)