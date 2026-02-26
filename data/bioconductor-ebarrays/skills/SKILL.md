---
name: bioconductor-ebarrays
description: This tool uses parametric empirical Bayes methods to analyze microarray gene expression data across multiple experimental conditions. Use when user asks to identify differentially expressed genes, calculate posterior probabilities of expression patterns, or perform model diagnostics using Gamma-Gamma or Lognormal-Normal models.
homepage: https://bioconductor.org/packages/release/bioc/html/EBarrays.html
---


# bioconductor-ebarrays

name: bioconductor-ebarrays
description: Parametric empirical Bayes methods for analyzing microarray gene expression data. Use this skill to identify differentially expressed (DE) genes across two or more conditions, calculate posterior probabilities of expression patterns, and perform model diagnostics using Gamma-Gamma (GG), Lognormal-Normal (LNN), or Lognormal-Normal with Modified Variance (LNNMV) models.

## Overview

The `EBarrays` package implements empirical Bayes methodology to account for replicate arrays and multiple experimental conditions. It treats gene-specific means as random effects arising from a system-wide distribution, allowing for information sharing across genes. The primary goal is to calculate the posterior probability that a gene fits a specific expression pattern (e.g., Equivalent Expression vs. Differential Expression).

## Core Workflow

### 1. Data Preparation
Data should be a matrix or `ExpressionSet` of normalized intensity values on the **raw scale** (not log-transformed).
```R
library(EBarrays)
data(gould) # Example dataset
# Ensure no negative values; rows with negatives are typically omitted
```

### 2. Defining Expression Patterns
Patterns define how experimental conditions are grouped. Use `ebPatterns` to create these hypotheses.
*   `1, 1, 1, 1`: All four samples are in the same group (Equivalent Expression).
*   `1, 1, 2, 2`: First two samples are Group 1, last two are Group 2 (Differential Expression).
*   `0`: Use zero to ignore specific columns/arrays.

```R
# Two-condition comparison (3 arrays total: 1 in Cond A, 2 in Cond B)
patterns <- ebPatterns(c("1, 1, 1", "1, 2, 2"))
```

### 3. Model Fitting
Use `emfit` to estimate model parameters using an EM algorithm. Choose a family: `"GG"`, `"LNN"`, or `"LNNMV"`.
*   **GG**: Gamma-Gamma (constant CV).
*   **LNN**: Lognormal-Normal (constant CV).
*   **LNNMV**: Lognormal-Normal with Modified Variance (gene-specific variance; generally recommended).

```R
# For LNNMV, groupid is required to estimate gene-specific variances
fit <- emfit(gould, family = "LNNMV", hypotheses = patterns, 
             groupid = c(1, 2, 2, 0, 0, 0, 0, 0, 0, 0))
```

### 4. Posterior Probabilities and FDR
Calculate the posterior probability for each pattern and determine a threshold to control the False Discovery Rate (FDR).

```R
prob <- postprob(fit, gould)$pattern
# Find threshold for 5% FDR (using the probability of the null pattern)
threshold <- crit.fun(prob[, 1], 0.05)
# Identify DE genes (Pattern 2)
de_genes <- which(prob[, 2] > threshold)
```

## Model Diagnostics

It is critical to check if the chosen parametric model fits the data.

*   **checkCCV(data)**: Checks the constant coefficient of variation assumption (for GG and LNN).
*   **checkModel(data, fit, model="gamma"|"lognormal")**: Generates QQ plots for subsets of genes to check observation component assumptions.
*   **plotMarginal(fit, data)**: Compares the theoretical marginal density of the fitted model against the empirical kernel density of the data.
*   **checkVarsQQ(data, groupid)**: For LNNMV, checks the scaled inverse chi-square prior assumption for variances.

## Tips
*   **LNNMV Recommendation**: The LNNMV model is often preferred as it relaxes the constant CV assumption by allowing gene-specific variances.
*   **Multiple Conditions**: For $K$ conditions, there are many possible patterns. You can restrict the analysis to a subset of biologically relevant patterns to increase power.
*   **Ordered Patterns**: `ebPatterns` can handle ordered hypotheses (e.g., $\mu_1 < \mu_2$) for specific study designs.

## Reference documentation
- [Parametric Empirical Bayes Methods for Microarrays](./references/vignette.md)