---
name: bioconductor-randrotation
description: This package generates randomly rotated data to resample null distributions of linear model-based test statistics in high-dimensional biological datasets. Use when user asks to perform valid resampling-based p-value or FDR estimation, account for dependencies introduced by batch effect correction, or generate random orthogonal matrices for linear models.
homepage: https://bioconductor.org/packages/release/bioc/html/randRotation.html
---


# bioconductor-randrotation

## Overview

The `randRotation` package provides a methodology for generating randomly rotated data to resample null distributions of linear model-based test statistics. Its primary application is in high-dimensional biology (e.g., transcriptomics) where batch effect correction methods (like ComBat) can skew p-value distributions by introducing dependencies between samples. By using random orthogonal matrices, the package allows for valid resampling-based p-values and False Discovery Rate (FDR) estimation even after complex data preprocessing.

## Core Workflow

### 1. Initialization
Prepare the random rotation object by specifying the data, the design matrix, and the coefficient(s) associated with the null hypothesis ($H_0$).

```r
library(randRotation)

# mod1: full model matrix
# coef.h: index of the coefficient to test (e.g., 2 for 'phenotype')
# batch: vector indicating batch membership
rr <- initBatchRandrot(Y = edata, X = mod1, coef.h = 2, batch = pdata$batch)
```

### 2. Defining the Statistic Function
Create a function that encapsulates the entire data analysis pipeline (preprocessing + testing). This function must return a scale-independent statistic (e.g., t-values).

```r
statistic <- function(Y, batch, mod) {
  # 1. Batch effect correction
  Y_corr <- sva::ComBat(dat = Y, batch = batch, mod = mod)
  
  # 2. Linear model fit (e.g., using limma)
  fit <- limma::lmFit(Y_corr, design = mod)
  fit <- limma::eBayes(fit)
  
  # Return absolute t-values for two-sided testing in pFdr
  abs(fit$t[, 2])
}
```

### 3. Rotating and Calculating Statistics
Use `rotateStat` to apply the statistic function to the original data and $R$ rotated versions.

```r
# R = 10 is often sufficient when using pooling
rs <- rotateStat(initialised.obj = rr, R = 10, statistic = statistic,
                 batch = pdata$batch, mod = mod1)
```

### 4. P-value and FDR Estimation
Calculate resampling-based p-values or FDR using `pFdr`.

```r
# Resampling-based p-values
p_vals <- pFdr(rs)

# Resampling-based FDR (options: "fdr.q", "fdr.qu", "BH")
fdr_q <- pFdr(rs, "fdr.q")
```

## Advanced Usage

### Working with Contrasts
To test specific contrasts, use `contrastModel` to transform the design matrix before initialization.

```r
contrasts1 <- limma::makeContrasts("GroupA-GroupB", levels = mod_groups)
mod_cont <- contrastModel(X = mod_groups, C = contrasts1)
rr_cont <- initBatchRandrot(Y = edata, X = mod_cont, batch = pdata$batch)
```

### Linear Mixed Models
For repeated measures or nested designs, provide a correlation matrix (`cormat`) to `initBatchRandrot`.

```r
# Example for a block-design correlation matrix
rr_mixed <- initBatchRandrot(Y = edata, X = mod1, coef.h = 2, 
                             batch = pdata$batch, cormat = list_of_cormats)
```

## Implementation Tips

- **Pivotal Quantities**: Always use t-statistics or similar scale-independent values in the `statistic` function rather than raw coefficients.
- **Pooling**: `pFdr` defaults to pooling statistics across all features. This significantly reduces the number of rotations ($R$) required to achieve stable p-values.
- **Parallelization**: For large datasets or complex pipelines, set `parallel = TRUE` in `rotateStat`. Ensure functions are called with their namespace (e.g., `sva::ComBat`) within the statistic function.
- **Two-tailed Tests**: Ensure the statistic function returns absolute values if a two-tailed test is intended, as `pFdr` considers larger values more significant.

## Reference documentation

- [Random Rotation Package Introduction](./references/randRotationIntro.md)