---
name: bioconductor-sspa
description: This tool performs sample size and power analysis for high-dimensional genomic data using pilot study results. Use when user asks to estimate the proportion of non-differentially expressed features, estimate effect size distributions, or predict statistical power for future microarray and RNA-seq experiments.
homepage: https://bioconductor.org/packages/3.5/bioc/html/SSPA.html
---


# bioconductor-sspa

name: bioconductor-sspa
description: General Sample Size and Power Analysis (SSPA) for high-dimensional genomic data. Use this skill to estimate the proportion of non-differentially expressed features, estimate effect size distributions from pilot data, and predict statistical power for future experiments (microarray, RNA-seq, etc.).

# bioconductor-sspa

## Overview
The `SSPA` package provides a pilot-data-based method for power and sample size determination in high-dimensional genomic experiments. It addresses the challenges of multiple testing (FDR control) and the distribution of effect sizes inherent in large-scale datasets. The workflow typically involves creating a `PilotData` object from test statistics, estimating the effect size density using a `SampleSize` object, and then predicting power for various sample sizes.

## Core Workflow

### 1. Prepare Pilot Data
Create a `PilotData` object using test statistics (e.g., t-statistics, likelihood ratio statistics) and the sample size used to generate them.

```R
library(SSPA)

# statistics: vector of test statistics from a pilot study
# samplesize: for two-group comparison (norm), use sqrt(1/(1/n1 + 1/n2))
# distribution: "norm", "t", or "chisq"
pd <- pilotData(statistics = statistics, 
                samplesize = sqrt(1/(1/10 + 1/10)), 
                distribution = "norm")

# Exploratory plots (histograms of stats/p-values, QQ-plot)
plot(pd)
```

### 2. Estimate Effect Size Distribution
The `sampleSize` function estimates $\pi_0$ (proportion of non-differentially expressed features) and the density of effect sizes.

```R
# method: "deconv" (default, for normal), "congrad" (conjugate gradient), or "tikhonov"
ss <- sampleSize(pd, method = "deconv", control = list(from = -6, to = 6))

# View estimated pi0
ss@info$pi0

# Plot estimated density of effect sizes
plot(ss)
```

### 3. Predict Power
Predict the average power for different future sample sizes based on the pilot data analysis.

```R
# Jpred: vector of proposed sample sizes per group
Jpred <- seq(10, 50, by = 10)
# For 'norm' distribution, use effective sample size
N_eff <- sqrt(Jpred / 2)

# alpha: False Discovery Rate (FDR) level
pwr <- predictpower(ss, samplesizes = N_eff, alpha = 0.05)

# Visualize power curve
plot(Jpred, pwr, type = "b", xlab = "Sample Size (per group)", ylab = "Predicted Power")
```

## Application-Specific Guidance

### RNA-seq (Count Data)
When using RNA-seq data processed with `edgeR` or `DESeq2`, use the likelihood ratio statistics or Wald statistics.
- **Distribution**: Use `distribution = "chisq"` with `df = 1`.
- **Method**: Use `method = "congrad"`.
- **Sample Size**: Use the total sample size (e.g., `samplesize = 8` for 4 vs 4).

### T-Statistics
If using standard t-tests instead of normal approximations:
- **Distribution**: Use `distribution = "t"` and specify degrees of freedom `df`.
- **Sample Size**: Use the total sample size.

## Tips and Troubleshooting
- **Effective Sample Size**: For two-group comparisons with normal distributions, `SSPA` uses the effective sample size $N = \sqrt{1/(1/n_1 + 1/n_2)}$. For other distributions, it typically uses the total sample size.
- **Pi0 Estimation**: If the default estimation fails, adjust the `pi0Method` in the control list (e.g., `control = list(pi0Method = "Storey")`).
- **Deconvolution**: The "deconv" method is specifically optimized for two-group comparisons where statistics are approximately normal. For more complex models or non-normal statistics, "congrad" is generally more robust.

## Reference documentation
- [General Sample Size and Power Analysis for high-dimensional genomic data](./references/SSPA.md)