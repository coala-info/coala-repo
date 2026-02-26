---
name: bioconductor-dks
description: This tool evaluates the distribution of multiple testing p-values using Frequentist and Bayesian diagnostics to ensure they follow the expected uniform distribution. Use when user asks to validate multiple testing procedures, calculate Double Kolmogorov-Smirnov p-values, or assess the uniformity of simulated null p-values.
homepage: https://bioconductor.org/packages/release/bioc/html/dks.html
---


# bioconductor-dks

name: bioconductor-dks
description: Diagnostic tests for multiple testing p-values using the Joint Null Criterion (JNC). Use this skill to evaluate whether a multiple testing procedure produces "correct" null p-values by calculating Frequentist (Double Kolmogorov-Smirnov) and Bayesian diagnostics. It is specifically used for analyzing matrices of simulated null p-values to ensure they follow the expected uniform distribution.

## Overview

The `dks` package implements the Joint Null Criterion (JNC) to validate multiple testing procedures. It evaluates whether null p-values from multiple simulated studies behave like independent samples from a $U(0,1)$ distribution. This is critical because error estimates (like FDR) depend on the correct specification of null p-values.

The package provides:
1. **Frequentist Diagnostic**: A "Double" Kolmogorov-Smirnov (DKS) test.
2. **Bayesian Diagnostic**: Posterior probabilities and credible sets for Beta distribution hyperparameters ($\alpha, \beta$) representing the p-value distribution.

## Typical Workflow

### 1. Data Preparation
Input data must be a matrix of **null p-values only**. Each column represents a single simulated study, and each row represents a null hypothesis test within that study.

```r
library(dks)
data(dksdata) # Loads example matrix 'P' (200 rows x 100 columns)
```

### 2. Running the Main Diagnostic
The `dks()` function performs both Frequentist and Bayesian tests simultaneously.

```r
# Run diagnostics and generate plots
results <- dks(P, plot=TRUE)

# Access the Double KS p-value
results$dks.pvalue

# Access posterior probabilities of uniformity for each study
results$post.prob.uniform
```

**Interpreting the Plots:**
*   **QQ-Plot**: Lines for each study should follow the 45-degree diagonal.
*   **Empirical CDF**: The distribution of first-level KS p-values should be uniform (diagonal line).
*   **Histogram**: Posterior probabilities of uniformity should cluster near 1.0.

### 3. Detailed Bayesian Analysis
To analyze a specific study (e.g., the first column of matrix `P`) and see how it deviates from uniformity:

```r
# 1. Calculate posterior distribution of Beta hyperparameters
# alpha=1, beta=1 corresponds to Uniform(0,1)
dist1 <- pprob.dist(P[,1])

# 2. Calculate an 80% credible set
cred1 <- cred.set(dist1, delta=0.1, level=0.80)

# 3. Visualize the posterior distribution
delta <- 0.1
alpha <- seq(0.1, 10, by=delta)
beta <- seq(0.1, 10, by=delta)
image(log10(alpha), log10(beta), dist1, xlab="Alpha", ylab="Beta")
points(0, 0, col="blue", pch=19) # Mark the (1,1) uniform point
```

### 4. Interpreting Hyperparameters
*   **$\beta > 1, \alpha < 1$**: P-values are stochastically smaller than uniform (conservative/anti-conservative bias).
*   **$\beta < 1, \alpha > 1$**: P-values are stochastically larger than uniform.
*   **$\alpha = 1, \beta = 1$**: P-values are Uniform (Correct).

## Tips for Simulation
*   Simulate studies with both null and alternative p-values to mimic real data.
*   **Crucial**: Extract and pass *only* the p-values known to be null to the `dks` functions.
*   If p-values show extreme behavior, extend the range of `alpha` and `beta` in `pprob.dist`.

## Reference documentation
- [The dks package](./references/dks.md)