---
name: bioconductor-correp
description: This tool estimates multivariate correlations and performs statistical inference for replicated OMICS data without averaging replicates. Use when user asks to estimate correlations between genes or proteins with biological replicates, perform likelihood ratio tests on multivariate correlations, or cluster variables based on replicate-aware correlation matrices.
homepage: https://bioconductor.org/packages/3.6/bioc/html/CORREP.html
---


# bioconductor-correp

name: bioconductor-correp
description: Multivariate correlation estimation for replicated OMICS data. Use this skill when you need to estimate correlations between genes or proteins where biological replicates are available, or when you need to perform statistical inference (Likelihood Ratio Tests) on such correlations without simply averaging replicates.

# bioconductor-correp

## Overview

The `CORREP` package provides a multivariate correlation estimator designed specifically for replicated OMICS data (e.g., microarray or proteomics). Unlike standard Pearson correlation, which often requires averaging replicates and thus losing variance information, `CORREP` explicitly models within-replicate and between-replicate correlation using a multivariate normal distribution. This approach is particularly beneficial for "noisy" data where within-replicate concordance is poor.

## Core Functions

- `cor.balance(data, m, G)`: Estimates the correlation matrix for balanced data (where every variable has the same number of replicates `m`).
- `cor.unbalance(data, m1, m2, G)`: Estimates correlation for unbalanced data (different number of replicates for the two variables being compared).
- `cor.test(data, m1, m2, ...)`: Performs a Likelihood Ratio Test (LRT) to determine if the multivariate correlation is significantly different from zero.
- `permutational.test(data, m1, m2, ...)`: An alternative to LRT for very small sample sizes (e.g., n < 4) using permutations to approximate the null distribution.

## Typical Workflow

### 1. Data Preparation
Data must be standardized such that the variance of each row (gene/protein) equals 1. The input matrix should have rows representing variables and columns representing conditions/replicates.

```R
# Example: 205 genes, 20 conditions, 4 replicates each (80 columns total)
# Standardize rows
stddata <- t(apply(rawdata, 1, function(x) x/sd(x)))
```

### 2. Estimating Correlation (Balanced Data)
Use `cor.balance` when all genes have the same number of replicates.

```R
# m = number of replicates per condition
# G = total number of genes/variables
M <- cor.balance(stddata, m = 4, G = 205)
```

### 3. Clustering with Multivariate Correlation
The resulting correlation matrix can be converted into a distance matrix (1 - correlation) for use in hierarchical clustering.

```R
dist_matrix <- as.dist(1 - M)
# Top-down clustering (recommended for identifying a few large clusters)
library(cluster)
fit <- diana(dist_matrix)
clusters <- cutree(fit, k = 4)
```

### 4. Statistical Inference
To test if the correlation between two specific replicated profiles is significant:

```R
# Assuming x and y are matrices of replicates
# G2 is the Likelihood Ratio statistic, asymptotically chi-square distributed
result <- cor.test(x, y, m1 = 4, m2 = 4)
```

## Tips and Constraints

- **Standardization is Mandatory**: You must ensure row-wise variance is 1 before calling `cor.balance` or `cor.unbalance`.
- **Data Reshaping**: Ensure your data is formatted such that replicates for the same condition are grouped together or correctly indexed.
- **Small Samples**: If the number of conditions (n) is less than 4, use `permutational.test` instead of the asymptotic LRT provided by `cor.test`.
- **Top-Down Clustering**: For functional genomics, divisive hierarchical clustering (`diana`) often performs better with `CORREP` distances when looking for broad functional groups.

## Reference documentation

- [CORREP](./references/CORREP.md)