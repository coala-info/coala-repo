---
name: bioconductor-swfdr
description: This package performs multiple hypothesis testing by incorporating covariates to estimate the proportion of null hypotheses and q-values. Use when user asks to estimate q-values conditioned on covariates, calculate the science-wise false discovery rate from reported p-values, or account for rounding and truncation in published results.
homepage: https://bioconductor.org/packages/release/bioc/html/swfdr.html
---

# bioconductor-swfdr

## Overview

The `swfdr` package provides advanced tools for multiple hypothesis testing. Unlike standard FDR methods that treat all tests equally, `swfdr` allows for the inclusion of covariates (metadata) that might influence the likelihood of a null hypothesis being true. It also implements an EM algorithm to estimate the "science-wise" false discovery rate from reported p-values, accounting for common issues like rounding and truncation in published literature.

## Core Workflows

### 1. Estimating pi0 and q-values with Covariates

This is the primary workflow for modern genomic or large-scale data analysis where metadata (e.g., sample size, minor allele frequency, conservation scores) is available for each test.

```R
library(swfdr)

# X is a design matrix of covariates (numeric)
# p is a vector of p-values
# 1. Estimate pi0 (proportion of nulls) conditioned on X
pi0_results <- lm_pi0(p, X = X, type = "logistic")

# 2. Estimate q-values conditioned on X
q_results <- lm_qvalue(p, X = X)

# Access results
head(q_results$qvalues)
head(q_results$pi0)
```

**Key Arguments for `lm_qvalue`:**
* `X`: A numeric matrix or data frame of covariates. Factors should be converted to dummy variables via `model.matrix`.
* `type`: "logistic" (default) or "linear". Logistic is preferred as it constrains probabilities to [0, 1].
* `smoothing`: "unit.spline" (default, fast) or "smooth.spline" (matches the `qvalue` package behavior).

### 2. Science-Wise False Discovery Rate (swfdr)

Use this workflow to estimate the rate of false positives in a collection of results, typically from literature scraping.

```R
# pValues: vector of p-values
# truncated: 1 if p-value is reported as < (e.g., p < 0.01), 0 otherwise
# rounded: 1 if p-value is rounded (e.g., 0.02), 0 otherwise

resSwfdr <- calculateSwfdr(pValues = pvals, 
                           truncated = trunc_vec, 
                           rounded = round_vec, 
                           numEmIterations = 100)

# The estimated swfdr (pi0)
print(resSwfdr$pi0)
```

## Implementation Tips

* **Covariate Preparation:** `swfdr` requires numeric covariates. If using categorical metadata, use `model.matrix(~ covariate - 1, data = df)` to create a design matrix.
* **Non-linear effects:** For continuous covariates like sample size, use splines (e.g., `splines::ns(N, df=5)`) within the design matrix to capture non-linear relationships with the null proportion.
* **Missing Data:** The package does not support `NA` or `Inf` values in the covariate matrix. Impute or remove these instances before analysis.
* **Comparison with `qvalue` package:** If `X` is omitted, `lm_qvalue` is conceptually equivalent to the standard Storey q-value. To get exact parity with the `qvalue` package, set `smoothing = "smooth.spline"`.

## Reference documentation

- [Computing q-values conditioned on covariates using swfdr](./references/swfdrQ.md)
- [Tutorial for swfdr package](./references/swfdrTutorial.md)