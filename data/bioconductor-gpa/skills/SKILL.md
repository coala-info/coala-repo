---
name: bioconductor-gpa
description: GPA implements a statistical framework for the joint analysis of multiple GWAS datasets and the integration of functional annotations. Use when user asks to analyze pleiotropy between traits, perform association mapping with FDR control, or test for enrichment of genomic annotations in GWAS signals.
homepage: https://bioconductor.org/packages/release/bioc/html/GPA.html
---

# bioconductor-gpa

name: bioconductor-gpa
description: Statistical framework for joint analysis of multiple GWAS data and integration with functional annotations. Use when analyzing pleiotropy between traits, performing association mapping with FDR control, or testing for enrichment of genomic annotations in GWAS signals.

# bioconductor-gpa

## Overview

The `GPA` package implements a flexible parametric mixture modeling approach for the joint analysis of multiple genome-wide association studies (GWAS). It integrates p-values from multiple traits with functional annotation data to improve the power of association mapping and provides formal hypothesis testing for pleiotropy and annotation enrichment.

## Core Workflow

### 1. Data Preparation
GPA requires two primary inputs:
- **p-values**: A matrix where rows are SNPs and columns are different GWAS traits.
- **Annotations** (Optional): A binary matrix (0 or 1) where rows are SNPs and columns are functional categories (e.g., CNS-expressed genes).

### 2. Fitting the GPA Model
Use the `GPA` function to fit the model. While it supports multiple GWAS, it is most extensively tested for pairs.

```r
library(GPA)

# Fit model with two GWAS traits and no annotation
fit.noAnn <- GPA(pval_matrix[, c(1, 2)])

# Fit model with annotation data
fit.wAnn <- GPA(pval_matrix[, c(1, 2)], ann_matrix)

# Extract parameters and standard errors
estimates(fit.wAnn)
se(fit.wAnn)
```

### 3. Association Mapping
Identify SNPs associated with traits using global or local FDR control.

```r
# Global FDR control at 0.05
assoc.results <- assoc(fit.wAnn, FDR = 0.05, fdrControl = "global")

# Get local FDR values for each SNP/trait
fdr.values <- fdr(fit.wAnn)

# Find SNPs associated with BOTH traits (pattern "11")
assoc.both <- assoc(fit.wAnn, FDR = 0.05, fdrControl = "global", pattern = "11")
```

### 4. Hypothesis Testing

#### Pleiotropy Test
Tests if signals from two GWAS are related. Requires fitting a null model where `pleiotropyH0 = TRUE`.

```r
# Fit null model (independence)
fit.H0 <- GPA(pval_matrix[, c(1, 2)], pleiotropyH0 = TRUE)

# Likelihood Ratio Test for pleiotropy
pTest(fit.noAnn, fit.H0)
```

#### Annotation Enrichment Test
Tests if GWAS signals are enriched in the provided annotation.

```r
# Compare model with annotation vs model without annotation
aTest(fit.noAnn, fit.wAnn)
```

## Advanced Usage
- **Posterior Probabilities**: Use `print(fit)` to get the matrix of posterior probabilities for each SNP belonging to specific association patterns (e.g., 00, 10, 01, 11).
- **Covariance Matrix**: Use `cov(fit)` to get the covariance matrix of model parameters, useful for the Delta method.
- **EM Iterations**: For real data, ensure a sufficient number of EM iterations (default is often low for testing; 10,000 is recommended in literature).

## Reference documentation
- [GPA-example](./references/GPA-example.md)