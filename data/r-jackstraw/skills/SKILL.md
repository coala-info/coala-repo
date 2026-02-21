---
name: r-jackstraw
description: Test for association between the observed data and their estimated latent variables. The jackstraw package provides a resampling strategy and testing scheme to estimate statistical significance of association between the observed data and their latent variables. Depending on the data type and the analysis aim, the latent variables may be estimated by principal component analysis (PCA), factor analysis (FA), K-means clustering, and related unsupervised learning algorithms. The jackstraw methods learn over-fitting characteristics inherent in this circular analysis, where the observed data are used to estimate the latent variables and used again to test against that estimated latent variables. When latent variables are estimated by PCA, the jackstraw enables statistical testing for association between observed variables and latent variables, as estimated by low-dimensional principal components (PCs). This essentially leads to identifying variables that are significantly associated with PCs. Similarly, unsupervised clustering, such as K-means clustering, partition around medoids (PAM), and others, finds coherent groups in high-dimensional data. The jackstraw estimates statistical significance of cluster membership, by testing association between data and cluster centers. Clustering membership can be improved by using the resulting jackstraw p-values and posterior inclusion probabilities (PIPs), with an application to unsupervised evaluation of cell identities in single cell RNA-seq (scRNA-seq).</p>
homepage: https://cran.r-project.org/web/packages/jackstraw/index.html
---

# r-jackstraw

name: r-jackstraw
description: Statistical inference for unsupervised learning using the jackstraw resampling strategy. Use this skill to test for associations between observed data and estimated latent variables (PCA, K-means, Factor Analysis, LFA). It is specifically designed to address "circular analysis" or over-fitting where the same data is used to both estimate and test latent structures.

## Overview

The `jackstraw` package provides methods to estimate the statistical significance of variables driving systematic variation in high-dimensional data. It allows users to identify which variables (e.g., genes, SNPs, or features) are significantly associated with principal components (PCs) or cluster memberships.

Key capabilities:
- **PCA/SVD Inference**: Identify variables significantly associated with specific PCs.
- **Clustering Inference**: Test the significance of cluster membership for individual data points.
- **Latent Variable Modeling**: Support for Factor Analysis (FA) and Logistic Factor Analysis (LFA).
- **PIP Estimation**: Calculate Posterior Inclusion Probabilities (PIPs) based on p-values.

## Installation

The package requires several Bioconductor dependencies for full functionality (specifically for LFA and PIP estimation).

```r
# Install Bioconductor dependencies first
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c('qvalue', 'lfa', 'gcatest'))

# Install jackstraw from CRAN
install.packages("jackstraw")
```

## Core Workflows

### 1. Principal Component Analysis (PCA)
To find variables significantly associated with the top `r` principal components:

```r
library(jackstraw)

# Example: Test association with the first 3 PCs
# s: number of "synthetic" null variables to create
# B: number of resampling iterations
out <- jackstraw_pca(dat, r = 3, s = 10, B = 1000)

# View p-values for each variable
head(out$p.value)
```

To test against a specific subset of PCs (e.g., only PC 2 and 3) while accounting for the fact that 5 PCs are significant:
```r
out <- jackstraw_pca(dat, r = 5, r1 = c(2, 3), s = 10, B = 1000)
```

For large datasets, use the IRLBA or Randomized SVD versions:
- `jackstraw_irlba(dat, r = 3)`
- `jackstraw_rpca(dat, r = 3)`

### 2. K-means Clustering
To evaluate if data points are significant members of their assigned clusters:

```r
# 1. Perform clustering first
set.seed(123)
km_out <- kmeans(dat, centers = 3)

# 2. Run jackstraw for clustering
# Requires the original data and the kmeans object
jk_out <- jackstraw_kmeans(dat, kmeans.dat = km_out, s = 10, B = 1000)

# Results include p-values for cluster membership
head(jk_out$p.value)
```

### 3. Logistic Factor Analysis (LFA)
Used primarily for genetic data (SNPs) to test association with population structure:

```r
# Requires 'lfa' package from Bioconductor
out <- jackstraw_lfa(dat, r = 3, s = 10, B = 1000)
```

### 4. Posterior Inclusion Probabilities (PIP)
After obtaining p-values, use `pip` to estimate the probability that a variable is truly associated with the latent variables:

```r
# Requires 'qvalue' package from Bioconductor
pips <- pip(out$p.value)
```

## Tips and Best Practices

- **Resampling Parameters**: The number of iterations `B` should be sufficiently large (e.g., 1000+) for stable p-values. The number of synthetic variables `s` should be small enough not to disrupt the global structure but large enough to provide a good null distribution.
- **Circular Analysis**: Always use `jackstraw` when you are testing variables against patterns (PCs/Clusters) that were derived from those same variables. Standard tests (like t-tests or correlation) will yield inflated significance in this context.
- **Data Types**: While widely used in genomics (scRNA-seq, SNPs), these methods apply to any high-dimensional data where unsupervised learning is used for feature selection or cluster validation.

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)