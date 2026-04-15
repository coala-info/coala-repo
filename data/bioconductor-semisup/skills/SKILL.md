---
name: bioconductor-semisup
description: This package implements a semi-supervised learning framework to identify subgroups and interactive effects in genetic association studies. Use when user asks to detect SNPs with interactive effects, perform model fitting for mixture distributions, or conduct hypothesis testing for homogeneity versus heterogeneity in quantitative traits.
homepage: https://bioconductor.org/packages/release/bioc/html/semisup.html
---

# bioconductor-semisup

name: bioconductor-semisup
description: Statistical framework for semi-supervised learning in genetics and genomics. Use this skill to detect SNPs with interactive effects on quantitative traits, perform model fitting for mixture distributions, and conduct hypothesis testing for homogeneity (null) vs. heterogeneity (alternative).

# bioconductor-semisup

## Overview

The `semisup` package implements a semi-supervised approach to identify subgroups within data, specifically designed for genetic association studies (e.g., GWAS, eQTL). It assumes two groups: a **labelled** group (all in class A) and an **unlabelled** group (mixture of class A and class B). The package helps estimate the mixing proportion ($\tau$) and tests if $\tau > 0$, which indicates the presence of a subgroup with different parameters (e.g., a SNP effect that only manifests in a subset of individuals).

## Installation and Setup

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("semisup")

library(semisup)
# For examples/testing:
attach(toydata)
```

## Core Workflow

### 1. Data Preparation
The package requires two main inputs:
- `y`: Quantitative trait (vector for one trait, matrix for multiple).
- `z`: Group indicators. 
    - `0`: Labelled group (Class A).
    - `NA`: Unlabelled group (Class A or B).

**Example: Binarizing a SNP**
```r
# Assign homozygous major alleles (0) to labelled group
# Assign carriers of minor alleles (1 or 2) to unlabelled group
z <- rep(NA, length(snp))
z[snp == 0] <- 0
```

### 2. Model Fitting (`mixtura`)
Use `mixtura` to estimate parameters ($\theta_a, \theta_b, \tau$) and predict class labels.

```r
fit <- mixtura(y, z)

# View parameter estimates
fit$estim1

# Predict class labels (posterior probability of being in class B)
class_assignments <- round(fit$posterior)
```

### 3. Hypothesis Testing (`scrutor`)
Use `scrutor` to test $H_0: \tau = 0$ (homogeneity) against $H_1: \tau > 0$ (heterogeneity).

```r
# Single test
test_results <- scrutor(y, z)

# The output includes a test statistic and a p-value
# Low p-value suggests a significant subgroup (interactive effect)
```

## Application Scenarios

### Genome-Wide Association Study (GWAS)
Test one quantitative trait against multiple SNPs.
```r
# y is a vector, Z is a matrix of SNPs
results <- scrutor(y, Z)
```

### Differential Expression Analysis
Test multiple quantitative traits (e.g., gene expression) against one SNP.
```r
# Y is a matrix of traits, z is a vector
results <- scrutor(Y, z)
```

### eQTL Analysis
Test multiple traits against multiple SNPs.
```r
# Y and Z are matrices
# If dimensions match, it assumes 1-to-1; otherwise, all pairwise combinations
results <- scrutor(Y, Z)
```

## Technical Options
- **Distributions**: Set `dist = "norm"` (default) for Gaussian data or `dist = "nbinom"` for count data (e.g., RNA-seq).
- **Negative Binomial**: When using `nbinom`, you can provide a dispersion estimate `phi` or an offset `gamma`.
- **Resampling**: `scrutor` uses parametric bootstrapping or permutation to calculate p-values.

## Reference documentation
- [semisup Vignette](./references/semisup.md)
- [Article: Detecting SNPs with interactive effects](./references/article.md)