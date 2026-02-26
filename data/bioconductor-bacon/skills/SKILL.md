---
name: bioconductor-bacon
description: bioconductor-bacon controls for bias and inflation in large-scale association studies by estimating the empirical null distribution using a Gibbs sampling algorithm. Use when user asks to estimate empirical null distributions from z-scores, correct for genomic inflation in EWAS or TWAS, perform bias-corrected meta-analysis, or visualize Gibbs sampling diagnostics and corrected QQ-plots.
homepage: https://bioconductor.org/packages/release/bioc/html/bacon.html
---


# bioconductor-bacon

name: bioconductor-bacon
description: Controlling bias and inflation in association studies (EWAS/TWAS) using the empirical null distribution. Use when Claude needs to: (1) Estimate empirical null distributions from z-scores or effect sizes, (2) Correct for genomic inflation and bias in association statistics, (3) Perform fixed-effect meta-analysis with bias correction, or (4) Visualize Gibbs sampling diagnostics and corrected QQ-plots.

# bioconductor-bacon

## Overview

The `bacon` package addresses the common issue of inflation and bias in large-scale association studies (like EWAS or TWAS). It uses a Gibbs Sampling algorithm to fit a three-component normal mixture to z-scores. One component represents the empirical null distribution (capturing bias and inflation), while the other two capture true associations. This allows for the extraction of corrected test statistics, p-values, and effect sizes.

## Core Workflow

### 1. Input Data Preparation
`bacon` accepts either a vector/matrix of z-scores or a combination of effect sizes and standard errors.

```r
library(bacon)

# Option A: Using z-scores
y <- rnormmix(5000, c(0.9, 0.2, 1.3, 1, 4, 1)) # Simulated data
bc <- bacon(teststatistics = y)

# Option B: Using effect sizes and standard errors
# es and se should be matrices for multiple sets/studies
bc <- bacon(teststatistics = NULL, effectsizes = es, standarderrors = se)
```

### 2. Extracting Estimates
Once the `Bacon` object is created, use accessor functions to retrieve the estimated bias ($\mu_0$) and inflation ($\sigma_0$).

```r
# Get all mixture parameters
estimates(bc)

# Get specific metrics
inflation(bc) # sigma.0
bias(bc)      # mu.0
```

### 3. Retrieving Corrected Statistics
Extract corrected values for downstream analysis.

```r
corrected_pvals <- pval(bc)
corrected_tstats <- tstat(bc)
corrected_es <- es(bc)
corrected_se <- se(bc)
```

## Diagnostics and Visualization

It is critical to inspect the Gibbs Sampler performance and the resulting fit.

*   **Traces**: Check for convergence of the sampler.
    `traces(bc)`
*   **Posteriors**: View posterior distributions of parameters.
    `posteriors(bc)`
*   **Fit**: Visualize the three-component mixture against the data histogram.
    `fit(bc)`
*   **QQ-Plots**: Compare uncorrected vs. corrected p-values.
    `plot(bc, type="qq")`
*   **Histogram**: Compare the empirical null to the standard normal.
    `plot(bc, type="hist")`

## Meta-analysis

`bacon` provides a robust way to perform fixed-effect meta-analysis using corrected statistics from multiple cohorts.

```r
# Perform meta-analysis on a Bacon object containing multiple sets
bcm <- meta(bc)

# View top results
topTable(bcm)

# Plot meta-analysis QQ-plot
plot(bcm, type="qq")
```

## Advanced Usage

### Parallelization
For large datasets or multiple sets, use `BiocParallel` to speed up the Gibbs Sampling.

```r
library(BiocParallel)
register(MulticoreParam(workers = 4))
bc <- bacon(teststatistics = zs)
```

### 95% Confidence Intervals
To obtain a sampling distribution for bias and inflation (e.g., for 95% CI), provide a matrix where the same z-scores are replicated across columns.

```r
# Replicate z-scores 10 times
zs_matrix <- matrix(y, nrow=length(y), ncol=10)
bc_reps <- bacon(teststatistics = zs_matrix, globalSeed = NULL)

# Calculate CI
quantile(bias(bc_reps), c(0.025, 0.975))
```

## Tips
*   **Z-score calculation**: If you only have p-values, convert them to z-scores using `qnorm(p/2)` before using `bacon`, though providing effect sizes and standard errors is preferred.
*   **Burn-in**: The default burn-in is 2000 iterations with 5000 total iterations. If traces show poor convergence, increase these via the `nafter` and `nburn` arguments in `bacon()`.

## Reference documentation
- [Controlling bias and inflation in association studies using the empirical null distribution](./references/bacon.md)