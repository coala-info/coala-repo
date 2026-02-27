---
name: bioconductor-corral
description: bioconductor-corral performs dimensionality reduction and batch integration for single-cell data using Correspondence Analysis. Use when user asks to perform CA-based dimension reduction on count matrices, integrate multiple single-cell datasets, or address overdispersion in sparse genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/corral.html
---


# bioconductor-corral

name: bioconductor-corral
description: Dimensionality reduction and batch integration for single-cell data using Correspondence Analysis (CA). Use this skill to perform CA-based dimension reduction on count matrices or SingleCellExperiment objects, and to align/integrate multiple single-cell datasets (batch correction) using the corralm multi-table adaptation.

## Overview

The `corral` package implements Correspondence Analysis (CA) for single-cell 'omics data. CA is a matrix factorization method similar to PCA but specifically designed for non-negative count data. It is particularly effective for high-dimensional, sparse single-cell data. The package also provides `corralm` for multi-batch integration and alignment.

## Core Workflows

### 1. Dimension Reduction with `corral`

Use `corral` to reduce dimensions of a single dataset. It supports `matrix`, `SingleCellExperiment` (SCE), and `SummarizedExperiment` objects.

**On SingleCellExperiment:**
```r
library(corral)
# Runs on 'counts' assay by default; result stored in reducedDim(sce, 'corral')
sce <- corral(sce, whichmat = 'counts')

# Visualize using built-in helper
plot_embedding_sce(sce, which_embedding = 'corral', color_attr = 'cell_type')
```

**On Matrix:**
```r
# Returns a list with SVD components (u, d, v) and coordinates (SCu, PCu, etc.)
result <- corral(count_matrix)
# Cell embeddings are in 'v' if rows are genes and columns are cells
plot_embedding(result$v, color_vec = clusters)
```

### 2. Batch Integration with `corralm`

Use `corralm` to align multiple datasets (e.g., different sequencing platforms or batches).

**On a single SCE with batch labels:**
```r
# 'splitby' identifies the column in colData containing batch info
sce <- corralm(sce, splitby = 'batch_id')
```

**On a list of matrices or SCEs:**
```r
# Matrices must be matched by features (intersecting rows)
list_of_mats <- list(batch1 = mat1, batch2 = mat2)
integration_result <- corralm(list_of_mats)
```

### 3. Addressing Overdispersion

Standard CA can be sensitive to rare features or outliers. `corral` provides several parameters to tune this:

*   **Residual Type (`rtype`):** Use `'freemantukey'` for more robustness compared to the default `'standardized'` (Pearson) residuals.
*   **Smoothing (`smooth`):** Set `smooth = TRUE` to trim extreme values (top 1% by default).
*   **Power Deflation (`powdef_alpha`):** Apply a "soft" smoothing by setting alpha (e.g., `0.95`).
*   **Variance Stabilization (`vst_mth`):** Options include `'sqrt'`, `'anscombe'`, or `'freemantukey'`.

### 4. Visualization and Evaluation

*   **Biplots:** Use `biplot_corral` to visualize relationships between features (genes) and observations (cells) in the same space.
*   **Scaled Variance:** Use `scal_var(corralm_obj)` to evaluate integration quality. Values close to 1 across batches indicate good integration.
*   **Downstream:** Embeddings can be used directly for `runUMAP` or `runTSNE` by specifying `dimred = 'corral'`.

## Tips for Success

*   **Feature Selection:** While CA handles sparsity well, it is often beneficial to subset to Highly Variable Genes (HVGs) before running `corralm` to ensure batches are aligned on biological signal.
*   **Matrix Orientation:** In the output list, if genes are rows and cells are columns, cell embeddings are in the `v` matrix. If cells are rows, embeddings are in `u`.
*   **Fast Approximation:** `corral` uses `irlba` for fast SVD. Because it is an approximation, the sign of axes may flip between runs; this does not affect the relative distances or downstream clustering.

## Reference documentation

- [Dimension reduction of single cell data with corral](./references/corral_dimred.md)
- [Alignment & batch integration of single cell data with corralm](./references/corralm_alignment.md)