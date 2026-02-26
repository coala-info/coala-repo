---
name: bioconductor-hdtd
description: This tool provides statistical methods for hypothesis testing and estimation of mean matrices and covariance structures in high-dimensional transposable data. Use when user asks to test for constant mean matrices, estimate mean matrices, or perform shrinkage estimation and hypothesis testing for row and column covariance structures.
homepage: https://bioconductor.org/packages/release/bioc/html/HDTD.html
---


# bioconductor-hdtd

name: bioconductor-hdtd
description: Statistical analysis of high-dimensional transposable data (matrix-valued data per subject). Use this skill to perform hypothesis testing and estimation for mean matrices and covariance structures in datasets where rows and columns represent distinct sets of variables (e.g., genes across multiple tissues).

# bioconductor-hdtd

## Overview
The `HDTD` package provides specialized statistical methods for "transposable data"—datasets where each sampling unit (e.g., a patient or mouse) is represented by a matrix rather than a vector. It is specifically designed for high-dimensional settings where the number of variables (rows $\times$ columns) greatly exceeds the sample size. Key capabilities include testing for constant mean vectors across groups, estimating mean matrices, and shrinking covariance matrices for both row and column variables.

## Data Preparation
Data must be formatted as a single large matrix where:
- **Rows**: Represent the first set of variables (e.g., genes).
- **Columns**: Represent the second set of variables (e.g., tissues) stacked for all subjects.
- **Structure**: If you have $N$ subjects and $K$ column variables, the input matrix should have $K \times N$ columns. Every $K$ consecutive columns must belong to the same subject, and the order of variables within those $K$ columns must be identical for every subject.

## Core Workflows

### 1. Mean Matrix Analysis
Use these functions to analyze the average relationship between row and column variables.

- **Testing for constant means**: `meanmat.ts(datamat, N, group.sizes)`
  - `N`: Number of subjects.
  - `group.sizes`: An integer or vector indicating how columns are grouped to test for mean conservation.
- **Estimation**: `meanmat.hat(datamat, N)`
  - Returns the sample mean matrix across all subjects.

### 2. Covariance Structure Analysis
Analyze the dependencies among rows (e.g., gene-gene correlations) and columns (e.g., tissue-tissue correlations).

- **Estimation with Shrinkage**: `covmat.hat(datamat, N, shrink = "both")`
  - Recommended to use `shrink = "both"` to ensure invertible and well-defined estimators.
  - Access results via `$rows.covmat` and `$cols.covmat`.
- **Hypothesis Testing**: `covmat.ts(datamat, N, voi)`
  - `voi`: "rows" or "columns".
  - Performs tests for Diagonality, Sphericity, and Identity.

### 3. Data Manipulation
- **Reordering**: `orderdata(datamat, N, order.cols)`
  - Use this to rearrange column variables into successive groups before performing group-specific mean tests.

## Example Usage

```r
library(HDTD)
data("VEGFmouse")

# 1. Test if mean gene expression is constant across 9 tissues for 40 mice
mean_test <- meanmat.ts(VEGFmouse, N = 40, group.sizes = 9)

# 2. Estimate the mean matrix
mean_est <- meanmat.hat(VEGFmouse, N = 40)

# 3. Estimate row (gene) and column (tissue) covariance matrices with shrinkage
cov_est <- covmat.hat(VEGFmouse, N = 40)
# View tissue-wise covariance
round(cov_est$cols.covmat, 3)

# 4. Test for independence (diagonality) among tissues
cov_test <- covmat.ts(VEGFmouse, N = 40, voi = "columns")
```

## Reference documentation
- [Using HDTD to Analyze High-Dimensional Transposable Data: An Application in Genetics](./references/HDTD.md)
- [HDTD R Markdown Vignette](./references/HDTD.Rmd)