---
name: bioconductor-gcatest
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gcatest.html
---

# bioconductor-gcatest

name: bioconductor-gcatest
description: Statistical testing for genetic association in structured populations using the Genotype Conditional Association Test (GCAT). Use this skill when performing Genome-Wide Association Studies (GWAS) where population structure is a confounding factor, specifically for calculating p-values for SNP-trait associations using Logistic Factor Analysis (LFA).

# bioconductor-gcatest

## Overview

The `gcatest` package implements the Genotype Conditional Association Test (GCAT), a method for genetic association testing that is robust to confounding from population structure. It leverages Logistic Factor Analysis (LFA) to model population structure, making it suitable for both quantitative and binary traits in arbitrarily structured populations.

## Typical Workflow

The standard workflow involves estimating logistic factors from genotype data and then testing for association with a trait.

### 1. Load Data and Libraries
The package requires genotype data (typically a matrix where rows are SNPs and columns are individuals) and a trait vector.

```r
library(lfa)
library(gcatest)

# Example data dimensions
# genotype_matrix: SNPs x Individuals
# trait_vector: length equal to number of individuals
```

### 2. Estimate Logistic Factors (LFA)
Before running GCAT, you must estimate the population structure using the `lfa` function from the `lfa` package. You must specify `d`, the number of logistic factors (dimensions).

```r
# Estimate 3 logistic factors
LF <- lfa(genotype_matrix, d = 3)
```

### 3. Run GCAT
Pass the genotype matrix, the estimated logistic factors, and the trait vector to the `gcat` function to obtain p-values.

```r
# returns a vector of p-values for each SNP
p_values <- gcat(genotype_matrix, LF, trait_vector)
```

## Data Input Handling

`gcatest` supports multiple input formats for genotype data:
- **Standard R Matrix**: Genotypes as numeric values.
- **PLINK Files**: Use the `genio` package and `read_plink` to import `.bed` files.
- **BEDMatrix**: Use the `BEDMatrix` package for memory-efficient access to large datasets without loading the entire matrix into RAM.

## Interpretation and Validation

- **P-values**: The output is a vector of p-values corresponding to the rows (SNPs) of the input matrix.
- **Null Distribution**: For unassociated SNPs, the p-values should follow a Uniform(0,1) distribution. This can be verified using a histogram or a QQ-plot.

```r
library(ggplot2)
# Plotting p-values for SNPs expected to be null
hist(p_values, main="GCAT P-value Distribution", xlab="p-value")
```

## Reference documentation

- [Genotype Conditional Association Test Vignette](./references/gcatest.md)