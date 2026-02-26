---
name: bioconductor-fastliquidassociation
description: This tool performs genome-wide liquid association analysis to identify gene triplets where the co-expression of two genes is mediated by a third gene. Use when user asks to identify mediated co-expression dynamics, pre-screen gene triplets with fastMLA, perform significance testing using conditional normal models, or run robust bootstrapping for liquid association values.
homepage: https://bioconductor.org/packages/release/bioc/html/fastLiquidAssociation.html
---


# bioconductor-fastliquidassociation

name: bioconductor-fastliquidassociation
description: Expert guidance for using the fastLiquidAssociation R package to perform genome-wide liquid association (LA) analysis. Use this skill when analyzing co-expression dynamics where the correlation between two genes (X1, X2) is mediated by a third gene (X3). It includes workflows for pre-screening triplets with fastMLA, significance testing with Conditional Normal Models (mass.CNM), and robust bootstrapping (fastboots.GLA).

## Overview

The `fastLiquidAssociation` package provides efficient tools for genome-wide liquid association (LA) analysis. It identifies triplets of genes (X1, X2, X3) where the co-expression of X1 and X2 changes based on the expression level of X3. The package optimizes the computationally expensive process of testing all possible triplets by using a pre-screening method ($\rho_{diff}$) to identify candidates likely to have high Modified Liquid Association (MLA) values.

## Core Workflow

### 1. Data Preparation
Data should be a numerical matrix with genes as columns and samples as rows. It is recommended to remove genes with high percentages of missing values (e.g., >30% NA).

```r
library(fastLiquidAssociation)
# data: matrix with samples as rows, genes as columns
# Example: data <- t(exprs(yeast_data))
```

### 2. Pre-screening with fastMLA
Use `fastMLA` to identify candidate triplets. This function uses matrix algebra to approximate MLA values, significantly reducing the search space.

```r
# topn: number of results to return
# nvec: column indices of genes to test as X1/X2
# rvalue: rho-diff cutoff (default 0.5; max 2.0)
# cut: bins + 1 (usually 4 for ~70 samples, aiming for 15-30 observations per bin)
results <- fastMLA(data = data, topn = 50, nvec = 1:100, rvalue = 0.5, cut = 4, threads = detectCores())
```

### 3. Significance Testing (mass.CNM)
Test the candidates from `fastMLA` using the Conditional Normal Model (CNM). This function attempts to fit a full model first, then falls back to a simple model if the full one fails to converge.

```r
# GLA.mat: output from fastMLA
# nback: number of top significant triplets to return
cnm_results <- mass.CNM(data = data, GLA.mat = results, nback = 10)

# Access results
significant_triplets <- cnm_results$`top p-values`
failed_triplets <- cnm_results$`bootstrap triplets`
```

### 4. Robust Estimation (fastboots.GLA)
For triplets that do not return sensible values in `mass.CNM` (e.g., SE > 10 or p-value = 0), use the parallelized bootstrapping method.

```r
library(parallel)
library(doParallel)

# Setup parallel backend
clust <- makeCluster(detectCores())
registerDoParallel(clust)

# Run bootstrapping on failed triplets
boot_results <- fastboots.GLA(tripmat = failed_triplets, 
                              data = data, 
                              clust = clust, 
                              boots = 30, 
                              perm = 500, 
                              cut = 4)

stopCluster(clust)
```

## Key Parameters and Interpretation

- **MLA value**: Represents the change in correlation between X1 and X2 mediated by X3.
- **rho-diff ($\rho_{diff}$)**: The difference in correlation ($\rho_{high} - \rho_{low}$) used for fast screening.
- **cut**: Critical for binning. Ensure `(number of samples / (cut - 1))` is between 15 and 30 for optimal specificity.
- **Model 'F' vs 'S'**: In `mass.CNM` output, 'F' indicates the Full CNM model was used, while 'S' indicates the Simple model.

## Reference documentation

- [The fastLiquidAssociation Package](./references/fastLiquidAssociation.md)