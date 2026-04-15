---
name: bioconductor-asgsca
description: This tool models associations between multiple genotypes and traits using Generalized Structured Component Analysis within a structural equation modeling framework. Use when user asks to perform pathway-based association studies, estimate relationships between latent variables, or test path coefficients using permutation tests.
homepage: https://bioconductor.org/packages/release/bioc/html/ASGSCA.html
---

# bioconductor-asgsca

name: bioconductor-asgsca
description: Tools for modeling and testing associations between multiple genotypes (SNPs/genes) and multiple traits (clinical pathways) using Generalized Structured Component Analysis (GSCA). Use this skill when performing pathway-based association studies where genes and clinical pathways are treated as latent variables in a structural equation model (SEM).

## Overview

The `ASGSCA` package implements a structural equation modeling approach to association studies. It allows researchers to incorporate prior biological knowledge by grouping observed SNPs into latent "Gene" variables and observed traits into latent "Clinical Pathway" variables. The core method uses an Alternating Least-Squares (ALS) algorithm to estimate weights (observed to latent) and path coefficients (latent to latent) and employs permutation tests for significance.

## Core Workflow

### 1. Data Preparation
The input data must be a data frame where rows are individuals and columns are observed variables (genotypes followed by traits). Genotypes are typically coded additively (0, 1, 2) or via indicator variables for multi-allelic variants.

### 2. Model Specification
You must define two matrices, `W0` and `B0`, to specify the model architecture:
- **W0 (Measurement Model):** An $I \times L$ matrix (Observed Variables $\times$ Latent Variables). A `1` indicates that an observed variable (SNP or trait) maps to a specific latent variable (Gene or Pathway).
- **B0 (Structural Model):** An $L \times L$ matrix (Latent Variables $\times$ Latent Variables). A `1` indicates a directed path from one latent variable to another (e.g., Gene $\to$ Pathway).

### 3. Running GSCA
The main function is `GSCA()`.

```r
library(ASGSCA)

# Basic estimation and testing
results <- GSCA(data = my_dataframe, 
                W0 = W0_matrix, 
                B0 = B0_matrix, 
                latent.names = c("Gene1", "Gene2", "Pathway1"), 
                estim = TRUE, 
                path.test = TRUE, 
                nperm = 1000)
```

### 4. Interpreting Results
The function returns a list containing:
- `$Weight`: Estimates of the relationship between observed variables and their latent constructs.
- `$Path`: Estimates of the effects between latent variables (e.g., the joint effect of a gene's SNPs on a pathway's traits).
- `$pvalues`: Permutation-based p-values for the path coefficients (only if `path.test = TRUE`).

## Key Parameters for GSCA()

- `estim`: Logical. If `TRUE`, returns weight and path coefficient estimates.
- `path.test`: Logical. If `TRUE`, performs permutation tests for path coefficients.
- `path`: Optional matrix of two columns specifying a subset of paths to test (indices of latent variables). If `NULL`, all paths defined in `B0` are tested.
- `nperm`: Number of permutations for the test (e.g., 1000 for exploratory, higher for publication).

## Tips and Best Practices

- **Sign Invariance:** If you run `GSCA` multiple times, the signs of estimates might flip. This is normal in GSCA; the relationship remains the same as long as the signs of weights and paths change consistently.
- **Scaling:** The package internally handles the scaling of variables.
- **Reproducibility:** Always use `set.seed()` before calling `GSCA` if `path.test = TRUE`, as the p-values are based on random permutations.
- **Performance:** For large models (e.g., 50+ variables and 20,000+ permutations), execution can take several hours. Consider testing with a low `nperm` (e.g., 100) first to verify model specification.

## Reference documentation

- [Using ASGSCA](./references/ASGSCA.md)