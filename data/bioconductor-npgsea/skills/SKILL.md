---
name: bioconductor-npgsea
description: This tool performs gene set enrichment analysis using moment-based approximations as a fast alternative to permutation testing. Use when user asks to calculate GSEA p-values, account for gene-gene correlations, adjust for covariates, or apply gene-specific weights in R.
homepage: https://bioconductor.org/packages/release/bioc/html/npGSEA.html
---

# bioconductor-npgsea

name: bioconductor-npgsea
description: Perform gene set enrichment analysis (GSEA) using moment-based approximations (Normal, Beta, or Chi-square) instead of computationally expensive permutations. Use this skill when you need to calculate GSEA p-values that account for gene-gene correlations, adjust for covariates, or apply gene-specific weights in R.

## Overview

The `npGSEA` package provides a fast, deterministic alternative to permutation-based gene set enrichment analysis. By calculating the exact moments of test statistics under permutation, it approximates the distribution using standard statistical distributions. This avoids the "granularity" problem of permutations (where p-values are limited by the number of iterations) and significantly reduces computation time.

## Core Workflow

### 1. Data Preparation
The package requires an `ExpressionSet` or a numeric matrix of expression data, along with a target variable (factor or numeric).

```R
library(npGSEA)
library(GSEABase)

# x: ExpressionSet or matrix (genes in rows, samples in columns)
# y: Factor or numeric vector of the phenotype/target variable
# set: A GeneSet or GeneSetCollection object
```

### 2. Running the Analysis
The primary function is `npGSEA`. You can choose between three approximation methods:
*   `approx = "norm"`: (Default) Gaussian approximation for linear statistics.
*   `approx = "beta"`: Sharper approximation for linear statistics using a scaled Beta distribution.
*   `approx = "chiSq"`: Approximation for quadratic statistics (two-sided tests only).

```R
# Single gene set analysis
res <- npGSEA(x = ALL, y = yFactor, set = set1, approx = "norm")

# Multiple gene sets (GeneSetCollection)
res_coll <- npGSEA(x = ALL, y = yFactor, set = gsc)
```

### 3. Advanced Modeling
*   **Weights:** Assign importance to specific genes using the `w` argument.
*   **Covariates:** Adjust for confounders (e.g., age, sex) using the `covars` argument.

```R
# Adding weights (e.g., 1/variance)
res_wts <- npGSEA(x = ALL, y = yFactor, set = set7, w = gene_weights)

# Adjusting for covariates
res_cov <- npGSEA(x = ALL, y = yFactor, set = set3, covars = ALL$age)
```

### 4. Interpreting Results
Use accessor functions to extract statistics and p-values from the result object:

*   `pTwoSided(res)`: Get the two-sided p-value.
*   `pLeft(res)` / `pRight(res)`: Get one-sided p-values.
*   `zStat(res)`: Get the Z-statistic (for normal/beta approx).
*   `stat(res)`: Get the observed statistic ($T_{G,w}$ or $C_{G,w}$).
*   `npGSEAPlot(res)`: Visualize the observed statistic against the approximated reference distribution.

## Tips for Success
*   **Gene Identifiers:** Ensure the `geneIds` in your `GeneSet` match the `featureNames` (rownames) of your expression data.
*   **Two-Sided Tests:** If using `approx = "chiSq"`, only two-sided p-values are relevant as it measures the magnitude of deviation regardless of direction.
*   **Reporting:** For large collections, use `unlist(pTwoSided(res_coll))` to get a vector of p-values for multiple testing correction (e.g., `p.adjust(..., method="BH")`).

## Reference documentation

- [npGSEA](./references/npGSEA.md)