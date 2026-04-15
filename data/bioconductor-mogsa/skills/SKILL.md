---
name: bioconductor-mogsa
description: The mogsa package provides a framework for the integrative analysis and gene set enrichment of multiple omics datasets. Use when user asks to perform multi-omics gene set analysis, identify joint structures across different data types, or conduct integrative clustering using multi-block PCA.
homepage: https://bioconductor.org/packages/release/bioc/html/mogsa.html
---

# bioconductor-mogsa

## Overview

The `mogsa` package provides a framework for the integrative analysis of multiple "omics" datasets. It allows for the summarization of multi-platform data into biological gene sets and the identification of joint structures across different data types. The package supports two primary workflows:
1.  **MOGSA**: Gene set enrichment analysis across multiple omics tables.
2.  **moCluster**: Integrative clustering using multi-block PCA (mbpca) to define subtypes based on concordant structures.

## Core Workflows

### 1. Multi-Omics Gene Set Analysis (MOGSA)

MOGSA integrates multiple data tables (e.g., list of data frames with shared columns/samples) and projects gene set annotations into the integrated space.

```R
library(mogsa)

# 1. Prepare data: x is a list of data.frames (rows=genes, cols=samples)
# sup is a list of binary annotation matrices (rows=genes, cols=gene sets)
data(NCI60_4arrays)
data(NCI60_4array_supdata)

# 2. Run MOGSA in one step
# proc.row: preprocessing (e.g., "center_ssq1")
# statis: TRUE for STATIS method, FALSE for MFA
mgsa <- mogsa(x = NCI60_4arrays, sup = NCI60_4array_supdata, nf = 3,
              proc.row = "center_ssq1", statis = TRUE)

# 3. Extract results
scores <- getmgsa(mgsa, "score") # Gene set score (GSS) matrix
p_vals <- getmgsa(mgsa, "p.val") # P-value matrix
```

### 2. Integrative Clustering (moCluster)

moCluster uses multi-block PCA (mbpca) to find latent variables representing concordant structures across datasets.

```R
# 1. Run multi-block PCA
# k: sparsity parameter ("all" for no sparsity, or a fraction like 0.1)
moa <- mbpca(NCI60_4arrays, ncomp = 10, k = "all", method = "globalScore", 
             option = "lambda1", center = TRUE, scale = FALSE, moa = TRUE)

# 2. Determine significant components via permutation
r <- bootMbpca(moa, B = 20, resample = "sample")

# 3. Extract scores for clustering
scrs <- moaScore(moa)
gap <- moGap(moa, K.max = 12, cluster = "hcl") # Evaluate cluster number
```

### 3. Result Interpretation and Visualization

*   **Decomposition**: Use `decompose.gs.group` to see which omics platform contributes most to a specific gene set's score.
*   **Influential Genes**: Use `GIS` (Gene Influential Score) to identify specific genes driving the gene set enrichment.
*   **Projection**: Use `plotGS` to visualize gene sets in the PC1/PC2 projected space.
*   **Coefficients**: Use `moaCoef` to extract non-zero coefficients from sparse mbpca results.

## Data Preparation Tips

*   **Gene Set Lists**: Convert pathway lists (e.g., from `graphite` or MSigDB `.gmt` files) into the required annotation matrix format using `prepSupMoa`.
*   **Matching**: Ensure that the list of data tables and the list of annotation matrices have identical names and that row/column orders match before running `mogsa`.
*   **Preprocessing**: `proc.row = "center_ssq1"` is a common choice to center rows and scale by sum of squares, making different platforms comparable.

## Reference documentation

- [moCluster: Integrative clustering using multiple omics data](./references/moCluster-knitr.md)
- [mogsa: gene set analysis on multiple omics data](./references/mogsa-knitr.md)