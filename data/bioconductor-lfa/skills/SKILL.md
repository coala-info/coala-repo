---
name: bioconductor-lfa
description: The lfa package implements Logistic Factor Analysis to model population structure and estimate individual-specific allele frequencies in genomic datasets. Use when user asks to estimate logistic factors, calculate individual-specific allele frequencies, or model population structure in genotype data.
homepage: https://bioconductor.org/packages/release/bioc/html/lfa.html
---

# bioconductor-lfa

## Overview

The `lfa` package implements Logistic Factor Analysis, a method for modeling population structure in genomic datasets. Unlike Principal Component Analysis (PCA) which assumes a linear relationship, LFA models the logit-transformed binomial parameters of genotype data. This provides a likelihood-based framework for estimating individual-specific allele frequencies and latent "logistic factors" that represent population structure.

## Core Workflow

### 1. Data Preparation
Genotype data should be formatted as a matrix where rows are SNPs and columns are individuals, with genotypes coded as 0, 1, and 2 (representing the count of the effector allele).

```r
library(lfa)
# Example using internal dataset
data(hgdp_subset)
# Rows: 5000 SNPs, Columns: 159 individuals
```

For large datasets, use the `genio` package to read PLINK files or the `BEDMatrix` package to handle data without loading the entire matrix into memory.

### 2. Estimating Logistic Factors
The `lfa()` function requires the genotype matrix and the number of factors (`d`) to estimate. Note that `d` includes the intercept term.

```r
# Estimate 4 logistic factors (including intercept)
LF <- lfa(hgdp_subset, 4)

# The result is a matrix of dimensions: individuals x d
head(LF)
```

### 3. Calculating Individual-Specific Allele Frequencies
Once factors are estimated, use `af()` to calculate the allele frequencies for each individual at each locus.

```r
# Calculate frequencies for all SNPs
allele_freqs <- af(hgdp_subset, LF)

# Calculate frequencies for a subset of SNPs (more efficient)
subset_freqs <- af(hgdp_subset[1:10, ], LF)
```

### 4. Downstream Analysis
The allele frequencies can be used for likelihood calculations or other population genetic statistics.

```r
# Example: Calculate log-likelihood for a specific SNP
# snp: vector of genotypes (0,1,2); af: vector of estimated frequencies
calc_log_lik <- function(snp, af) {
  -sum(snp * log(af) + (2 - snp) * log(1 - af))
}

# Apply across the dataset
log_liks <- sapply(1:nrow(hgdp_subset), function(i) {
  calc_log_lik(hgdp_subset[i,], allele_freqs[i,])
})
```

## Tips and Best Practices
- **Intercept**: Always remember that the number of factors `d` passed to `lfa()` includes the intercept. If you want 3 latent variables representing structure, set `d = 4`.
- **Memory Management**: For very large SNP sets, use `BEDMatrix`. The `af()` function is locus-independent, so you can process the genotype matrix in chunks to save memory.
- **Visualization**: Logistic factors can be plotted similarly to PCA components to visualize population clusters.

## Reference documentation
- [Logistic Factor Analysis Vignette](./references/lfa.md)