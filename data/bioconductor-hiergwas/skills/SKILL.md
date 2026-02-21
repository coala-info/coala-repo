---
name: bioconductor-hiergwas
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/hierGWAS.html
---

# bioconductor-hiergwas

name: bioconductor-hiergwas
description: Statistical significance testing in Genome-Wide Association Studies (GWAS) using hierarchical inference and joint models. Use this skill when performing GWAS analysis to control Family Wise Error Rate (FWER) while identifying single SNPs or clusters of SNPs associated with continuous or binary phenotypes.

## Overview

The `hierGWAS` package provides a multivariate approach to GWAS, moving beyond marginal testing to a joint model of all SNPs. It uses a three-stage procedure: hierarchical clustering of SNPs, multiple sample splitting with LASSO selection, and hierarchical testing. This method is suitable for case-control (logistic regression) and continuous trait (linear regression) studies, with support for covariates.

## Core Workflow

### 1. Data Preparation
Genotype data must be a matrix (samples x SNPs) with SNPs coded as 0, 1, 2. Phenotypes must be a vector (binary 0/1 or continuous). Missing values must be imputed (e.g., using `mice` or `SHAPEIT`) before analysis.

```r
library(hierGWAS)
# x: genotype matrix (n x p)
# y: phenotype vector (n)
# covar: optional matrix of covariates (n x c)
```

### 2. Hierarchical Clustering
Cluster SNPs based on Linkage Disequilibrium (LD). For large datasets, cluster chromosomes separately to maintain computational feasibility.

```r
# Cluster a specific chromosome or subset
snp_idx <- 1:500 
dendr_chrom1 <- cluster.snp(x, SNP_index = snp_idx)
```

### 3. Multiple Sample Splitting & LASSO
Perform repeated LASSO regressions on random sample splits to identify potential predictors.

```r
# B = number of splits (default 50)
res_multisplit <- multisplit(x, y, covar = covar, B = 50)
```

### 4. Hierarchical Testing
Test hypotheses starting from the global null down to individual SNPs or small clusters.

```r
# Test the hierarchy for a specific cluster/chromosome
results <- test.hierarchy(x, y, dendr_chrom1, res_multisplit, 
                          covar = covar, 
                          SNP_index = snp_idx,
                          global.test = TRUE)

# Access significant groups and p-values
# results is a list of significant clusters/SNPs
```

### 5. Explained Variance
Calculate the variance explained ($R^2$) for a specific group of SNPs.

```r
target_snps <- c(10, 15, 20)
r2_val <- compute.r2(x, y, res_multisplit, covar = covar, SNP_index = target_snps)
```

## Usage Tips

- **Parallelization**: Clustering and sample splitting are independent. Run `cluster.snp` for different chromosomes in parallel to save time.
- **Global Test Optimization**: When testing multiple chromosomes, set `global.test = TRUE` for the first one. If the global null is rejected, set `global.test = FALSE` for subsequent chromosomes to avoid redundant computation.
- **LD Measure**: The default dissimilarity is $1 - r^2$ (Pearson correlation squared). You can provide a custom dissimilarity matrix to `cluster.snp` if needed.
- **Interpretation**: The output `label` contains the indices of SNPs in a significant cluster. Use these to map back to rsIDs in your original annotation file.

## Reference documentation

- [A tutorial for the Bioconductor package hierGWAS](./references/hierGWAS.md)