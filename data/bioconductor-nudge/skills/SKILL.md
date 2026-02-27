---
name: bioconductor-nudge
description: The nudge package identifies differentially expressed genes in microarray data using a two-component mixture model of Normal and Uniform distributions. Use when user asks to identify differentially expressed genes, analyze single or multiple replicate microarray experiments, or compare treatment and control groups against a common reference.
homepage: https://bioconductor.org/packages/3.5/bioc/html/nudge.html
---


# bioconductor-nudge

## Overview

The `nudge` (Normal Uniform Differential Gene Expression) package provides a statistical framework for identifying differentially expressed genes in microarray experiments. It models normalized log-ratio data as a two-component mixture: a **Normal distribution** for non-differentially expressed genes and a **Uniform distribution** for differentially expressed genes. The package outputs posterior probabilities for each gene, where a threshold (typically 0.5) is used to classify genes as differentially expressed.

## Core Workflows

### 1. Data Preparation
The package requires log2 ratios ($lR$) and log2 intensities ($lI$).
*   **Log Ratio ($lR$):** `log2(Sample1) - log2(Sample2)`
*   **Log Intensity ($lI$):** `log2(Sample1) + log2(Sample2)`

### 2. Single Replicate Analysis
Use `nudge1` for single-slide experiments. The function automatically adjusts normalization for single replicates.

```r
library(nudge)
data(like)

# Prepare log2 data
lR <- log(like[,1], 2) - log(like[,2], 2)
lI <- log(like[,1], 2) + log(like[,2], 2)

# Run analysis
result <- nudge1(logratio = lR, logintensity = lI)

# Identify significant genes (Prob >= 0.5)
sig_genes <- which(result$pdiff >= 0.5)
```

### 3. Multiple Replicate Analysis
Use `nudge1` for experiments with multiple replicates. If a balanced dye swap was used, set `dye.swap = TRUE`.

```r
data(hiv)
# Calculate matrices for lR and lI (rows = genes, cols = replicates)
lR <- log(hiv[,1:4], 2) - log(hiv[,5:8], 2)
lI <- log(hiv[,1:4], 2) + log(hiv[,5:8], 2)

# Run analysis with dye swap
result <- nudge1(logratio = lR, logintensity = lI, dye.swap = TRUE)
```

### 4. Reference Sample Comparison
Use `nudge2` when comparing two different groups (e.g., Treatment vs. Control) where both were hybridized against a common reference sample.

```r
# Requires log ratios and intensities for both groups
result <- nudge2(control.logratio = lRctl, 
                 txt.logratio = lRtxt, 
                 control.logintensity = lIctl, 
                 txt.logintensity = lItxt)
```

## Advanced Configuration

### Starting Estimates (EM Algorithm)
The EM algorithm can be sensitive to starting values. You can provide a custom starting label matrix `z` (a matrix with 2 columns: [Non-Diff, Diff]).

```r
# Example: Setting a prior probability 'p' for differential expression
p <- 0.01
temp <- rbinom(nrow(data), 1, p)
z_start <- matrix(c(1-temp, temp), nrow(data), 2)

result <- nudge1(logratio = lR, logintensity = lI, z = z_start)
```

### Normalization Parameters
*   `span1`: Proportion of data for loess mean normalization (default 0.6).
*   `span2`: Proportion of data for loess variance normalization (default 0.2).
*   `tol`: Convergence tolerance for the EM algorithm (default 0.00001).

## Interpreting Results
The functions return a list containing:
*   `pdiff`: Vector of posterior probabilities of differential expression.
*   `lRnorm`: Normalized log ratios (or differences).
*   `mu`, `sigma`: Parameters of the Normal component (non-diff genes).
*   `a`, `b`: Range of the Uniform component (diff genes).
*   `mixprob`: Prior probability of a gene being **not** differentially expressed.

## Reference documentation

- [The Normal Uniform Differential Gene Expression (nudge) detection package](./references/nudge.vignette.md)