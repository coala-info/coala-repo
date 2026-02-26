---
name: bioconductor-hem
description: This tool fits the Heterogeneous Error Model to identify differentially expressed genes in microarray data while accounting for biological and experimental error variances. Use when user asks to identify differentially expressed genes, analyze microarray data with multiple error layers, or estimate false discovery rates using Bayesian hierarchical models.
homepage: https://bioconductor.org/packages/release/bioc/html/HEM.html
---


# bioconductor-hem

name: bioconductor-hem
description: Fits the Heterogeneous Error Model (HEM) to identify differentially expressed genes in microarray data. Use this skill when analyzing gene expression data with multiple biological conditions and either one layer (biological/experimental confounded) or two layers (separate biological and experimental replicates) of error.

# bioconductor-hem

## Overview

The `HEM` package implements a Bayesian hierarchical error model designed to identify differentially expressed genes while accounting for heterogeneous error variances across genes and conditions. It is particularly effective for microarray datasets with a small number of replicates. The package decomposes error into experimental and biological components (two-layer) or a single total error term (one-layer) and uses Markov Chain Monte Carlo (MCMC) for parameter estimation.

## Core Workflow

### 1. Data Preparation and Preprocessing
Data should be a matrix or data frame where rows are genes and columns are replicates.

```r
library(HEM)
data(pbrain) # Example dataset

# Preprocess: IQR normalization and log2-transformation
pbrain.nor <- hem.preproc(pbrain[, 2:13])
```

### 2. Defining the Design Matrix
The design matrix is critical for mapping columns to conditions and replicates.

- **Two-layer HEM:** Requires 3 columns: `[Condition, Biological Replicate, Experimental Replicate]`.
- **One-layer HEM:** Requires 2 columns: `[Condition, Replicate]`.

```r
# Example for Two-layer
cond <- c(1,1,1,1,1,1,2,2,2,2,2,2)
ind  <- c(1,1,2,2,3,3,1,1,2,2,3,3)
rep  <- c(1,2,1,2,1,2,1,2,1,2,1,2)
design <- data.frame(cond, ind, rep)
```

### 3. Empirical Bayes (EB) Prior Specification (Optional)
For datasets with few replicates, use EB priors to improve variance estimation.

```r
# Calculate EB priors
# method.var.e: "neb" (nonparametric), "peb" (parametric), or "gam" (gamma)
pbrain.eb <- hem.eb.prior(pbrain.nor, n.layer=2, design=design,
                          method.var.e="neb", method.var.b="peb")
```

### 4. Fitting the Model
The `hem` function performs the MCMC sampling and calculates H-scores (the statistic for differential expression).

```r
# Fit model using EB priors calculated above
pbrain.hem <- hem(pbrain.nor, n.layer=2, design=design,
                  method.var.e="neb", method.var.b="peb",
                  var.e=pbrain.eb$var.e, var.b=pbrain.eb$var.b)

# Access H-scores
h_scores <- pbrain.hem$H
```

### 5. False Discovery Rate (FDR) Evaluation
Determine significance thresholds using resampling-based FDR estimates.

```r
pbrain.fdr <- hem.fdr(pbrain.nor, n.layer=2, design=design,
                      hem.out=pbrain.hem, eb.out=pbrain.eb)

# View critical values for target FDRs
print(pbrain.fdr$targets)

# Plot FDR curve
plot(pbrain.fdr$fdr)
```

## Function Reference

- `hem()`: Main fitting function. Parameters include `burn.ins` (default 1000) and `n.samples` (default 3000).
- `hem.eb.prior()`: Estimates prior variances. `q` (default 0.01) sets the gene bin size for pooling.
- `hem.fdr()`: Calculates FDR by generating null data via resampling.
- `hem.preproc()`: Utility for normalization and log-transformation.

## Key Parameters for `hem()`
- `n.layer`: `1` for confounded error, `2` for separate biological/experimental error.
- `method.var.*`: Set to `"gam"` for standard Gamma priors, `"peb"` for parametric EB, or `"neb"` for nonparametric EB.
- `var.g`, `var.c`, `var.r`: Variance priors for gene, condition, and interaction effects (default is 1).

## Reference documentation
- [HEM](./references/HEM.md)