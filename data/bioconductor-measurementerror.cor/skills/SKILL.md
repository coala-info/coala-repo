---
name: bioconductor-measurementerror.cor
description: This tool estimates correlation coefficients between random variables while accounting for measurement error to reduce bias in point estimates. Use when user asks to calculate corrected correlations between vectors or matrices of gene expression data using both mean values and standard error estimates.
homepage: https://bioconductor.org/packages/release/bioc/html/MeasurementError.cor.html
---

# bioconductor-measurementerror.cor

name: bioconductor-measurementerror.cor
description: Estimate correlation coefficients between random variables while accounting for measurement error. Use this skill when you have gene expression data (or similar bivariate normal data) where both point estimates and standard error estimates are available for each observation, and you want to reduce bias in correlation estimation.

# bioconductor-measurementerror.cor

## Overview

The `MeasurementError.cor` package implements a two-stage measurement error model to estimate the correlation between two random variables. In many biological contexts, such as microarray or RNA-seq experiments, observations are not perfectly precise. Standard Pearson correlation can be biased when measurement error is present. This package corrects for that bias by incorporating the standard errors of the measurements into the correlation calculation.

## Main Functions

The package provides two primary functions depending on whether you are comparing two specific vectors or an entire matrix.

### cor.me.vector
Calculates the corrected correlation between two specific vectors.
- **Inputs**: 
  - `exp1`, `exp2`: Vectors of point estimates (e.g., mean expression).
  - `se1`, `se2`: Vectors of standard error estimates corresponding to the point estimates.
- **Output**: A list containing:
  - `estimate`: A vector containing `corr.true` (the corrected correlation), `corr.me` (correlation between measurement errors), and estimated means (`mu1`, `mu2`) and standard deviations (`s1`, `s2`) of the underlying variables.
  - `convergence`: An integer where `0` indicates successful convergence.

### cor.me.matrix
Calculates all pairwise corrected correlations for a dataset.
- **Inputs**:
  - `exp`: A matrix of point estimates (rows are features/genes, columns are samples).
  - `se`: A matrix of standard errors corresponding to the `exp` matrix.
- **Output**: A list where the primary element is `corr.true`, a symmetric matrix of the corrected correlation coefficients.

## Typical Workflow

1.  **Prepare Data**: Ensure you have two matrices of the same dimensions: one for the values (`exp`) and one for the standard errors (`se`).
2.  **Load Package**:
    ```r
    library(MeasurementError.cor)
    ```
3.  **Estimate Correlation**:
    - For a single pair:
      ```r
      result <- cor.me.vector(exp[1,], se[1,], exp[2,], se[2,])
      true_cor <- result$estimate["corr.true"]
      ```
    - For a whole matrix:
      ```r
      result_mat <- cor.me.matrix(exp, se)
      cor_matrix <- result_mat$corr.true
      ```

## Interpreting Results

- **corr.true**: This is the parameter of interest. It represents the estimated correlation between the "true" underlying values of the variables, stripped of the noise introduced by measurement error.
- **corr.me**: This represents the correlation between the measurement errors themselves. In many experimental designs, this is expected to be near zero, but the model estimates it to improve the accuracy of `corr.true`.
- **Convergence**: Always check the `$convergence` flag in `cor.me.vector`. If it is non-zero, the optimization did not reach a stable solution, and the estimate may be unreliable.

## Reference documentation

- [MeasurementError.cor](./references/MeasurementError.cor.md)