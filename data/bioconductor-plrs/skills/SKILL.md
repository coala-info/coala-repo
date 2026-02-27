---
name: bioconductor-plrs
description: This tool models the association between DNA copy number and gene expression using piecewise linear regression splines. Use when user asks to model cis-relationships between genomic data, perform model selection using OSAIC, test association strength via likelihood ratio tests, or generate confidence bands for genomic regressions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/plrs.html
---


# bioconductor-plrs

name: bioconductor-plrs
description: Analysis of the association between DNA copy number and gene expression using Piecewise Linear Regression Splines (PLRS). Use this skill to model cis-relationships, perform model selection (OSAIC), test association strength via likelihood ratio tests, and generate uniform confidence bands for genomic data.

## Overview

The `plrs` package implements piecewise linear regression splines to model the relationship between DNA copy number (aCGH) and mRNA expression. It is specifically designed to handle the discrete nature of copy number states (loss, normal, gain, amplification) while allowing for continuous relationships within and across those states.

## Core Workflow

### 1. Data Preparation
The package expects gene expression data (typically an `ExpressionSet`) and copy number data (typically a `cghCall` object). Features must be matched by genomic location before analysis.

```r
library(plrs)
# Load example data
data(neveCN17)
data(neveGE17)

# Extract data for a single gene
idx <- which(fData(neveGE17)$Symbol == "PITPNA")[1]
rna <- exprs(neveGE17)[idx,]
cghseg <- segmented(neveCN17)[idx,]
cghcall <- calls(neveCN17)[idx,]

# Extract posterior probabilities for knots
probloss <- probloss(neveCN17)[idx,]
probnorm <- probnorm(neveCN17)[idx,]
probgain <- probgain(neveCN17)[idx,]
probamp <- probamp(neveCN17)[idx,]
```

### 2. Single Relationship Analysis
Use `plrs()` to fit the model. By default, it applies inequality constraints to ensure biological plausibility (e.g., non-negative slopes).

```r
# Fit the model
model <- plrs(rna, cghseg, cghcall, probloss, probnorm, probgain, probamp)

# Model Selection (using OSAIC for constrained models)
modelSelection <- plrs.select(model)
selectedModel <- modelSelection@model

# Testing Association (Likelihood Ratio Test)
# Note: Test should be performed on the full model for correct inference
modelTest <- plrs.test(model, alpha = 0.05)

# Confidence Bands
modelCB <- plrs.cb(modelTest, alpha = 0.05)

# Visualization
plot(modelCB)
```

### 3. High-Throughput Screening
For analyzing multiple genes simultaneously, use `plrs.series()`.

```r
# Screen first 200 genes
# control.select=NULL skips model selection for speed
results <- plrs.series(neveGE17[1:200,], neveCN17[1:200,])

# View summary of rejected null hypotheses
summary(results)

# Access results
head(results@test)         # P-values and statistics
head(results@coefficients) # Spline coefficients
```

## Key Parameters and Constraints

- **min.obs**: Minimum samples per state (default is 3). Use `modify.conf()` or the `min.obs` argument in `plrs()` to merge or discard states with insufficient data.
- **continuous**: If `FALSE` (default), allows state-specific intercepts (discontinuities).
- **constr.slopes**: 
    - `1`: All slopes non-negative.
    - `2` (default): Normal state slope non-negative; others $\ge$ normal slope.
- **OSAIC**: The preferred selection criterion for constrained models.

## Tips for Success

- **Identifiability**: Always check the number of observations per copy number state using `table(cghcall)`. If a state has fewer than 3 observations, the model cannot be fit without merging or discarding that state.
- **Inference**: For statistically valid p-values and confidence bands, ensure you pass the full model (or an object where `@selected` is `TRUE`) to `plrs.test()` and `plrs.cb()`.
- **Input Objects**: While `plrs.series` accepts `ExpressionSet` and `cghCall` objects directly, the single-gene `plrs()` function requires extracted vectors and probability matrices.

## Reference documentation
- [PLRS: Piecewise Linear Regression Splines for the association between DNA copy number and gene expression](./references/plrs_vignette.md)