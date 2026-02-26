---
name: bioconductor-hireewas
description: HIREewas deconvolutes bulk methylation data into cell-type-specific signals to identify associations between phenotypes and specific cell types. Use when user asks to perform cell-type-specific epigenome-wide association studies, estimate cell type proportions, or identify which cell types drive differential methylation.
homepage: https://bioconductor.org/packages/release/bioc/html/HIREewas.html
---


# bioconductor-hireewas

## Overview

The `HIREewas` package implements the HIRE (HIgh REsolution) hierarchical model for EWAS. Unlike standard methods that detect associations at the aggregate (bulk) level, HIRE deconvolutes bulk methylation signals into cell-type-specific signals. This allows researchers to identify which specific cell types are driving an association with a phenotype, such as disease status or age.

## Data Preparation

The package requires two primary input matrices:

1.  **Methylation Matrix (`Ometh`)**: A numeric matrix where rows are CpG sites and columns are samples. Values should typically be Beta values (between 0 and 1).
2.  **Covariate Matrix (`X`)**: A numeric matrix where rows are covariates (e.g., disease status, age, sex) and columns are samples.

```r
# Example structure
# Ometh: [m CpG sites] x [n samples]
# X: [p covariates] x [n samples]
```

## Core Workflow

### 1. Model Fitting
The primary function is `HIRE()`. It performs deconvolution and association testing simultaneously using an EM algorithm.

```r
library(HIREewas)

# K is the number of cell types
# alpha is the significance threshold for Bonferroni correction
ret_list <- HIRE(Ometh, X, num_celltype=K, tol=10^-5, num_iter=1000, alpha=0.01)
```

**Key Arguments:**
*   `num_celltype`: The number of underlying cell types (K). Can be determined via prior knowledge or by comparing `pBIC` values across different K values.
*   `alpha`: Threshold for significance and penalized BIC calculation (default 0.01).
*   `tol` / `num_iter`: Convergence criteria for the EM algorithm.

### 2. Interpreting Results
The function returns a list containing:
*   `P_t`: Estimated cell type proportions (K x n).
*   `mu_t`: Estimated baseline methylation profiles for each cell type (m x K).
*   `beta_t`: A 3D array (m x K x p) containing the effect sizes of each phenotype on each CpG site within each cell type.
*   `pvalues`: A matrix (m x (K*p)) of p-values. The first K columns are for covariate 1, the next K for covariate 2, etc.
*   `pBIC`: The penalized Bayesian Information Criterion score for model selection.

### 3. Visualization
Use `riskCpGpattern` to generate heatmaps of the -log10 p-values, allowing for visual identification of cell-type-specific association patterns.

```r
# Visualize associations for the first 100 sites for a specific covariate
# If K=3 and looking at the second covariate, indices would be K + c(1,2,3)
riskCpGpattern(ret_list$pvalues[1:100, 4:6], 
               main_title="Cell-Type-Specific Associations", 
               hc_row_ind = FALSE)
```

## Usage Tips

*   **Label Switching**: Because deconvolution is unsupervised, the order of cell types in `ret_list` may not match your expectations. Compare `mu_t` or `P_t` against reference profiles or known cell counts to assign identities to the estimated cell types.
*   **Model Selection**: To find the optimal number of cell types (K), run `HIRE` over a range of K values (e.g., 2 to 10) and select the one that minimizes the `pBIC`.
*   **Scale**: For large datasets, consider filtering CpG sites (e.g., by most variable) before running HIRE to reduce computational time.

## Reference documentation

- [HIREewas: Detection of Cell-Type-Specific Risk-CpG Sites in EWAS](./references/HIREewas.md)