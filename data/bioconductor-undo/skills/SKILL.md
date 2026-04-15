---
name: bioconductor-undo
description: This tool performs unsupervised deconvolution of two-source mixed gene expression profiles to recover pure tumor and stroma signals. Use when user asks to estimate cell proportions, recover pure expression profiles from heterogeneous tissue samples, or perform unsupervised deconvolution without marker genes.
homepage: https://bioconductor.org/packages/release/bioc/html/UNDO.html
---

# bioconductor-undo

name: bioconductor-undo
description: Unsupervised deconvolution of tumor-stroma mixed gene expression profiles. Use this skill when you need to estimate cell proportions (mixing matrix) and recover pure expression profiles from heterogeneous tissue samples without prior knowledge of marker genes or proportions.

## Overview

The UNDO package implements a completely unsupervised method for deconvoluting two-source mixed expressions (typically tumor and stroma). It identifies marker genes located on the scatter radii of the mixed expressions based on the principle of expression non-negativity. The workflow involves data validation, dimension reduction (if more than two samples), marker gene selection, and matrix inversion to recover pure profiles.

## Core Workflow

The primary interface is the `two_source_deconv` function, which wraps the entire pipeline.

### 1. Data Preparation
Input data must be normalized (e.g., via PLIER or RMA) but **not** logarithmically transformed. The algorithm requires raw-scale non-negative values.

```r
library(UNDO)
# Input can be a matrix or an ExpressionSet
# Rows = Genes, Columns = Samples
data(NumericalMixMCF7HS27)
X <- NumericalMixMCF7HS27 
```

### 2. Main Deconvolution
Use `two_source_deconv()` to estimate the mixing matrix and pure profiles.

```r
# Basic usage
result <- two_source_deconv(X, return=1)

# Advanced usage with filtering and tuning
result <- two_source_deconv(X, 
    lowper=0.4,    # Percentage of genes with small norms to remove (noise)
    highper=0.1,   # Percentage of genes with large norms to remove (outliers)
    epsilon1=0.01, # Controls number of marker genes for source 1
    epsilon2=0.01, # Controls number of marker genes for source 2
    return=1)      # 1 returns pure profiles, 0 returns only mixing matrix
```

### 3. Interpreting Results
The function returns a list containing:
- `Estimated_Mixing_Matrix`: The proportions of the two sources across samples.
- `Estimated_Pure_Expressions`: (If `return=1`) The deconvoluted expression profiles.
- `E1`: (If ground truth `A` is provided) A measurement of estimation error (closer to 0 is better).

## Sub-functions and Utilities

While `two_source_deconv` is recommended, specific steps can be accessed individually:

- `gene_expression_input(X)`: Validates the input matrix for negative values, missing data, or identical samples.
- `dimension_reduction(X)`: Uses PCA to reduce $m$ samples to 2 dimensions if $m > 2$.
- `marker_gene_selection(X, ...)`: Identifies the genes specific to each source.
- `mixing_matrix_computation(X, ...)`: Calculates the final proportions and profiles.
- `calc_E1(A_est, A_real)`: Computes the error between estimated and real mixing matrices.

## Tips for Success

- **Non-negativity**: Ensure your data does not contain negative values. If the input is log-transformed, use `2^X` to return to raw scale before processing.
- **Sample Size**: While the algorithm works with as few as 2 samples, having more samples generally improves the stability of the dimension reduction step.
- **Filtering**: Adjust `lowper` if the data is noisy and `highper` if there are significant outliers or platform artifacts.

## Reference documentation

- [UNDO: An open-source software tool for unsupervised deconvolution of tumor-stromal mixed expressions](./references/UNDO-vignette.md)