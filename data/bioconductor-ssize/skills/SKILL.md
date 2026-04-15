---
name: bioconductor-ssize
description: This tool performs sample size estimation and power analysis for microarray experiments while accounting for multiple testing. Use when user asks to calculate required sample sizes, estimate statistical power, or determine minimum detectable fold-changes for two-group comparisons.
homepage: https://bioconductor.org/packages/release/bioc/html/ssize.html
---

# bioconductor-ssize

name: bioconductor-ssize
description: Sample size estimation and power analysis for microarray experiments. Use this skill to calculate required sample sizes, power, or minimum detectable fold-changes (delta) for two-group comparisons while accounting for multiple testing (Bonferroni correction) across thousands of genes.

## Overview

The `ssize` package provides a method for sample size estimation specifically tailored for high-throughput microarray data. Instead of a single value, it produces cumulative plots showing the proportion of genes that achieve a specific power at various sample sizes or effect sizes. This allows researchers to make informed trade-offs between experimental cost and statistical sensitivity.

## Core Workflow

The package assumes data has been normalized and log-transformed, and that a two-sample pooled-variance t-test is appropriate for comparing a treatment group vs. a control group.

1.  **Estimate Variability**: Obtain standard deviation ($\sigma$) estimates for each gene from a pilot study or existing control data.
2.  **Define Parameters**: Set the desired power (e.g., 0.8), family-wise error rate (e.g., 0.05), and minimum effect size (fold-change).
3.  **Compute and Plot**: Use the specific function pair (`ssize`, `pow`, or `delta`) to generate calculations and their corresponding cumulative distribution plots.

## Key Functions

### 1. Sample Size Estimation
Calculates the sample size needed per group to achieve a target power for a specific fold change.
```r
library(ssize)
data(exp.sd) # Example standard deviations

# Calculate sizes
all.size <- ssize(sd = exp.sd, 
                  delta = log2(2.0), # 2-fold change on log2 scale
                  sig.level = 0.05, 
                  power = 0.8)

# Plot results
ssize.plot(all.size, xlim = c(1, 20))
```

### 2. Power Calculation
Calculates the power achieved by a fixed sample size and fold change.
```r
all.power <- pow(sd = exp.sd, 
                 n = 6, 
                 delta = log2(2.0), 
                 sig.level = 0.05)

power.plot(all.power)
```

### 3. Minimum Detectable Fold-Change (Delta)
Calculates the fold-change detectable at a fixed sample size and power.
```r
all.delta <- delta(sd = exp.sd, 
                   n = 6, 
                   power = 0.8, 
                   sig.level = 0.05)

delta.plot(all.delta, xlim = c(1, 10))
```

## Usage Tips

*   **Log Scale**: The `delta` parameter and the input `sd` vector must be on the same scale (usually log2). If your effect size is a "2-fold change", use `delta = log2(2)`.
*   **Multiple Testing**: By default, functions use `alpha.correct = "Bonferonni"`. The per-test alpha is calculated as $\alpha / G$, where $G$ is the number of genes (length of the `sd` vector).
*   **Interpreting Plots**: 
    *   In `ssize.plot`, the y-axis represents the proportion of genes. If the curve hits 0.80 at $n=10$, it means 80% of your genes will have at least the specified power if you use 10 samples per group.
    *   The `marks` argument in plotting functions highlights specific points of interest on the curve.
*   **Performance**: For very large gene sets, you may want to subset the standard deviation vector (e.g., `exp.sd[1:1000]`) for quick exploratory plotting before running the full analysis.

## Reference documentation

- [Sample Size Estimation for Microarray Experiments](./references/ssize.md)