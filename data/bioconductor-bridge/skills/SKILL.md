---
name: bioconductor-bridge
description: This tool performs robust Bayesian testing for differential gene expression in microarray data using a t-distribution based hierarchical model. Use when user asks to perform robust differential expression analysis, identify differentially expressed genes in microarray data, or compare two or three biological samples while accounting for outliers.
homepage: https://bioconductor.org/packages/3.6/bioc/html/bridge.html
---

# bioconductor-bridge

name: bioconductor-bridge
description: Bayesian Robust Inference of Differential Gene Expression (BRIDGE). Use this skill to perform robust testing for differential expression between two or three biological samples in microarray data. It is particularly useful when data contains outliers, as it employs a t-distribution based hierarchical Bayesian model and MCMC for parameter estimation.

## Overview

The `bridge` package provides a robust Bayesian framework for identifying differentially expressed genes. Unlike standard methods that might be sensitive to outliers, `bridge` models noise using a t-distribution and uses Markov Chain Monte Carlo (MCMC) to estimate posterior probabilities of differential expression. It currently supports comparisons between two samples (`bridge.2samples`) or among three samples (`bridge.3samples`).

## Typical Workflow

### 1. Data Preparation
Data must be on the **raw scale** (not log-transformed) before being passed to the functions. The package expects separate matrices for each sample group, where rows are genes and columns are replicates.

```r
library(bridge)

# Example: Two samples (Control vs Treatment)
# control_data: matrix of raw intensities (genes x replicates)
# treatment_data: matrix of raw intensities (genes x replicates)
```

### 2. Testing Two Samples
Use `bridge.2samples` for two-group comparisons. The function internally performs a log2 transformation.

```r
# B: number of MCMC iterations (50,000 recommended for final analysis)
result2 <- bridge.2samples(control_data, treatment_data, B=2000, verbose=FALSE)

# Extract posterior probabilities of differential expression
post_probs <- result2$post.p

# Extract gene effects (gamma)
gamma1 <- mat.mean(result2$gamma1)[,1]
gamma2 <- mat.mean(result2$gamma2)[,1]
log_ratio <- gamma1 - gamma2
```

### 3. Testing Three Samples
Use `bridge.3samples` for three-group comparisons.

```r
result3 <- bridge.3samples(sample1, sample2, sample3, B=2000, verbose=FALSE)
post_probs3 <- result3$post.p
```

### 4. Visualization and Diagnostics
You can visualize the relationship between the log ratio and the posterior probability to identify significant genes.

```r
# Plot Posterior Probability vs Log Ratio
plot(gamma1 - gamma2, result2$post.p, 
     xlab="Log Ratio", ylab="Posterior Probability",
     main="BRIDGE Differential Expression")

# Check convergence/outliers via degrees of freedom (nu)
# Low nu values indicate the presence of outliers in that array
hist(result2$nu1[1,], main="Posterior Degrees of Freedom (Array 1)", xlab="nu")
```

## Key Parameters

- `B`: The number of MCMC iterations. While 2,000 is fine for testing, 50,000 is recommended for stable estimates.
- `batch`: Set to 1 for standard operation.
- `mcmc.obj`: Can be used to restart a chain from a previous `bridge` object.
- `all.out`: If TRUE, returns all MCMC samples (can be memory intensive).

## Tips for Performance

- **Batch Mode**: Because MCMC on thousands of genes is computationally expensive, it is recommended to run long simulations in batch mode using `R CMD BATCH`.
- **Memory**: For large datasets, avoid setting `all.out=TRUE` unless you specifically need the full posterior distribution for every parameter.
- **Robustness**: The model's strength is its handling of outliers via the t-distribution. If `nu` (degrees of freedom) estimates are consistently high, the data is relatively clean; low `nu` values justify the use of this robust model over standard normal-based methods.

## Reference documentation

- [Bayesian Robust Inference of Differential Gene Expression](./references/bridge.md)