---
name: bioconductor-xde
description: This tool performs Bayesian hierarchical modeling for cross-study differential expression analysis of gene expression datasets. Use when user asks to integrate multiple gene expression datasets, identify concordant or discordant differential expression patterns, or account for study-specific technological effects in meta-analyses.
homepage: https://bioconductor.org/packages/release/bioc/html/XDE.html
---

# bioconductor-xde

name: bioconductor-xde
description: Bayesian hierarchical modeling for cross-study differential expression analysis. Use this skill to integrate multiple gene expression datasets (ExpressionSets) to identify concordant or discordant differential expression patterns while accounting for study-specific technological effects.

# bioconductor-xde

## Overview
The `XDE` package fits a Bayesian hierarchical model to gene expression data from two or more studies. It is designed to improve statistical power by combining data while filtering out technological variation between platforms. It identifies genes that are differentially expressed (DE) across all studies (concordant) or in a subset of studies (discordant).

## Core Workflow

### 1. Data Preparation
Data must be organized into an `ExpressionSetList`. All `ExpressionSet` objects in the list must have identical `featureNames` (e.g., mapped to common Entrez or Unigene IDs) and a common binary phenotype variable.

```r
library(XDE)
# xlist is an ExpressionSetList
# Ensure a common binary covariate exists in all studies
label <- "adenoVsquamous"
stopifnot(all(sapply(xlist, function(x) label %in% varLabels(x))))
```

### 2. Initializing Parameters
The `XdeParameter` class manages MCMC hyperparameters, starting values, and tuning.

```r
# one.delta=TRUE assumes a gene is DE in all studies or none
# one.delta=FALSE allows study-specific DE (delta_gp model)
params <- new("XdeParameter", esetList=xlist, phenotypeLabel=label, one.delta=FALSE)
```

### 3. Fitting the Model
The `xde` function performs the MCMC sampling. It is recommended to run a burn-in period first.

```r
# Run burn-in (output not saved to disk)
iterations(params) <- 1000
burnin(params) <- TRUE
fit_burn <- xde(params, xlist)

# Run production MCMC starting from the last state of burn-in
iterations(params) <- 2000
burnin(params) <- FALSE
directory(params) <- "mcmc_logs" # Directory for log files
fit_final <- xde(params, xlist, fit_burn)
```

### 4. MCMC Diagnostics
Assess convergence by plotting trace plots of hyperparameters that are not gene-indexed.

```r
# Load a chain from the log directory
c2_chain <- fit_final$c2
plot.ts(c2_chain, ylab="c2", xlab="iterations")
```

### 5. Posterior Summaries
Calculate the Bayesian Effect Size (BES) and posterior probabilities of differential expression.

```r
# Calculate BES (requires delta, Delta, and sigma2 chains to be saved)
# bayesianEffectSize(fit_final) <- calculateBayesianEffectSize(fit_final)

# Access posterior averages for concordant/discordant DE
# These are typically stored in a postAvg object after processing
# postAvg[, "concordant"]  # Prob of same-direction DE across studies
# postAvg[, "discordant"]  # Prob of different-direction DE across studies
```

## Key Tips
- **Memory Management**: MCMC chains for gene-indexed parameters (nu, Delta, delta, sigma2) are very large. Use `thin(params)` to save every $n$-th iteration or disable specific outputs using `output(params)[...] <- 0`.
- **Starting Values**: If the model struggles to converge, use `empiricalStart(xlist, phenotypeLabel)` to generate better initial values for the `firstMcmc` slot.
- **Mapping**: Successful meta-analysis depends on high-quality mapping of platform-specific probes to a common reference identifier before creating the `ExpressionSetList`.

## Reference documentation
- [XDE](./references/XDE.md)
- [XdeParameterClass](./references/XdeParameterClass.md)