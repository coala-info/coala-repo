---
name: bioconductor-bg2
description: This tool performs Bayesian variable selection for Genome-Wide Association Studies involving non-Gaussian phenotypes like Poisson or binary data. Use when user asks to perform GWAS on count or binary traits, account for population structure using kinship matrices, or apply Bayesian two-step procedures to identify causal SNPs while controlling false discovery rates.
homepage: https://bioconductor.org/packages/release/bioc/html/BG2.html
---


# bioconductor-bg2

name: bioconductor-bg2
description: Comprehensive Bayesian variable selection for non-Gaussian GWAS data (Poisson and Binary/Bernoulli). Use when performing Genome-Wide Association Studies (GWAS) requiring: (1) Analysis of count data (Poisson) or binary traits (Bernoulli), (2) Control for population structure using kinship matrices, (3) Bayesian two-step procedures to reduce false discoveries while maintaining recall, or (4) Handling overdispersion in count data.

# bioconductor-bg2

## Overview

The `BG2` package implements a novel two-step Bayesian procedure for Genome-Wide Association Studies (GWAS) involving non-Gaussian phenotypes. It is specifically designed for Poisson (count) and Bernoulli (binary) data. Compared to single marker association testing (SMA), BG2 reduces false discovery rates while maintaining high recall of causal SNPs. It utilizes generalized linear mixed models (GLMMs) to account for population structure (kinship) and other random effects.

## Core Workflow

1.  **Prepare Data**:
    *   `Y`: Numeric vector or $n \times 1$ matrix of phenotypes (Poisson counts or 0/1 binary).
    *   `SNPs`: Numeric matrix where columns are SNPs and rows are observations.
    *   `kinship`: $n \times n$ positive semi-definite matrix representing genetic relationships.

2.  **Define Random Effects**:
    *   Create a list of covariance matrices for the `Covariance` argument.
    *   For Poisson data, typically include both a kinship matrix and an identity matrix (to account for overdispersion).

3.  **Execute BG2**:
    *   Call the `BG2()` function with the appropriate `family` ("poisson" or "bernoulli").
    *   Specify the dispersion parameter prior `Tau` ("uniform" or "IG").

4.  **Interpret Results**:
    *   The function returns a vector of column indices from the `SNPs` matrix identified as causal or perfectly correlated with causal SNPs.

## Main Function: BG2()

The primary interface is the `BG2()` function:

```r
BG2(Y, SNPs, Fixed = NULL, Covariance, Z = NULL, family, 
    replicates = NULL, Tau = "uniform", FDR_Nominal = 0.05, 
    maxiterations = 4000, runs_til_stop = 400)
```

### Key Arguments:
*   `Y`: Phenotype vector.
*   `SNPs`: Genotype matrix.
*   `Fixed`: Matrix of fixed covariates (optional).
*   `Covariance`: List of covariance matrices for random effects.
*   `Z`: List of design matrices for random effects (defaults to Identity if NULL).
*   `family`: Either `"poisson"` or `"bernoulli"`.
*   `replicates`: Number of replicates per individual (useful for Poisson speedup).
*   `Tau`: Prior for the nonlocal prior dispersion parameter (`"uniform"` or `"IG"` for Inverse Gamma).
*   `FDR_Nominal`: Target False Discovery Rate (default 0.05).

## Usage Examples

### Poisson GWAS with Overdispersion
Use this pattern for count data where you need to account for both kinship and extra-Poisson variation.

```r
library(BG2)
data("Y_poisson")
data("SNPs")
data("kinship")

# Define random effects: 1. Kinship, 2. Overdispersion (Identity)
n <- length(Y_poisson)
covariance <- list(kinship, diag(1, n))

set.seed(1330)
results <- BG2(Y = Y_poisson, 
               SNPs = SNPs, 
               Covariance = covariance, 
               family = "poisson", 
               replicates = 4, 
               Tau = "uniform")
# 'results' contains indices of identified SNPs
```

### Binary (Bernoulli) GWAS
Use this pattern for case-control or binary trait studies.

```r
library(BG2)
data("Y_binary")
data("SNPs")
data("kinship")

# Define random effect: Kinship
covariance <- list(kinship)

set.seed(1330)
results <- BG2(Y = Y_binary, 
               SNPs = SNPs, 
               Covariance = covariance, 
               family = "bernoulli", 
               Tau = "IG")
```

## Implementation Tips
*   **Computational Speed**: BG2 uses spectral decomposition and population parameters (P3D) to optimize performance.
*   **Convergence**: If the model selection does not converge, increase `maxiterations` (default 4000) or `runs_til_stop` (default 400).
*   **Design Matrices**: If your observations have a specific grouping structure (e.g., multiple observations per ecotype), provide the appropriate incidence matrices in the `Z` argument. If `Z` is NULL, an identity matrix is assumed for all random effects.

## Reference documentation
- [BG2 Vignette](./references/BG2.md)