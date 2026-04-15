---
name: bioconductor-divergence
description: This package transforms high-dimensional omics data into a digital format by measuring the divergence of samples from a defined normal baseline. Use when user asks to digitize continuous omics data into ternary or binary forms, identify features deviating from a reference profile, or perform differential divergence analysis between phenotypes.
homepage: https://bioconductor.org/packages/release/bioc/html/divergence.html
---

# bioconductor-divergence

## Overview

The `divergence` package implements a framework for analyzing high-dimensional omics data by simulating a clinical test for deviation from a "normal" profile. It transforms continuous data into a simplified digital form:
- **Univariate:** Features are coded as -1 (below baseline), 0 (within baseline), or 1 (above baseline).
- **Multivariate:** Sets of features (e.g., gene sets) are coded as 0 (no deviation) or 1 (deviant).

This approach is robust to normalization differences and focuses on the stability of a reference population to define "normal" ranges.

## Data Preparation

The package works best with `SummarizedExperiment` objects. You must define a **baseline cohort** (e.g., normal samples) and an **experimental cohort** (e.g., tumor samples).

```r
library(divergence)
library(SummarizedExperiment)

# Create SummarizedExperiment objects
# Assumes mat.base and mat.data are matrices with features as rows
se.base <- SummarizedExperiment(assays = list(data = mat.base))
se.data <- SummarizedExperiment(assays = list(data = mat.data))
```

## Univariate Divergence Workflow

### 1. Quantile Transformation
Divergence analysis requires a sample-specific quantile transformation.

```r
assays(se.base)$quantile <- computeQuantileMatrix(se.base)
assays(se.data)$quantile <- computeQuantileMatrix(se.data)
```

### 2. Baseline Support Computation
You can either provide fixed parameters ($\gamma$ and $\beta$) or search for an optimal $\gamma$ that keeps the expected divergence in the baseline below a threshold $\alpha$.

```r
# Search for optimal gamma
baseline <- findUnivariateGammaWithSupport(
  seMat = se.base,
  gamma = 1:9/10, # Candidate gamma values
  beta = 0.9,     # Proportion of reference samples to include
  alpha = 0.01    # Max allowed divergence proportion in baseline
)
```

### 3. Digitization
Convert the experimental data into ternary form (-1, 0, 1).

```r
assays(se.data)$div <- computeUnivariateTernaryMatrix(
  seMat = se.data,
  Baseline = baseline
)
```

### All-in-One Wrapper
Use `computeUnivariateDigitization` to perform all steps (quantiles, gamma search, and digitization) in one call.

```r
res <- computeUnivariateDigitization(
  seMat = se.data,
  seMat.base = se.base,
  gamma = 1:9/10,
  alpha = 0.01
)
# Results available in res$Mat.div
```

## Multivariate Divergence Workflow

Multivariate analysis operates on feature sets (e.g., MSigDB Hallmarks).

```r
# FeatureSets should be a list of character vectors
baseline_multi <- findMultivariateGammaWithSupport(
  seMat = se.base,
  FeatureSets = my_gene_sets,
  gamma = 1:9/10,
  alpha = 0.01
)

# Digitize to binary matrix (0 or 1)
mat.div.multi <- computeMultivariateBinaryMatrix(
  seMat = se.data,
  Baseline = baseline_multi
)
```

## Differential Divergence Analysis

To find features that are significantly more divergent in one phenotype versus another, use the Chi-squared test on the digitized data.

```r
# groups: factor indicating sample classes (e.g., "ER+" vs "ER-")
chi_results <- computeChiSquaredTest(
  Mat = assays(se.data)$div,
  Groups = groups,
  classes = c("Positive", "Negative")
)

# Returns a data frame with statistics and p-values sorted by significance
head(chi_results)
```

## Key Parameters
- `gamma` ($\gamma$): Controls the radius around baseline samples. Larger values result in wider baseline ranges (less divergence).
- `beta` ($\beta$): The probability mass of the baseline population to be captured within the support.
- `alpha` ($\alpha$): The threshold for the expected proportion of divergent features per sample in the baseline cohort.

## Reference documentation
- [divergence](./references/divergence.md)