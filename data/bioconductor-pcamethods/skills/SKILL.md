---
name: bioconductor-pcamethods
description: This package provides Principal Component Analysis methods specifically designed to handle incomplete datasets and perform missing value imputation. Use when user asks to perform PCA on data with missing values, impute missing data using probabilistic or Bayesian algorithms, or estimate the optimal number of principal components for high-dimensional biological data.
homepage: https://bioconductor.org/packages/release/bioc/html/pcaMethods.html
---


# bioconductor-pcamethods

name: bioconductor-pcamethods
description: Principal Component Analysis (PCA) methods for incomplete data and missing value imputation. Use when Claude needs to perform PCA on datasets with missing values (NAs), impute missing data using algorithms like PPCA, BPCA, or Nipals, or handle outliers in high-dimensional biological data (e.g., metabolomics, transcriptomics).

# bioconductor-pcamethods

## Overview

The `pcaMethods` package provides a collection of PCA implementations specifically designed to handle incomplete datasets. While standard SVD requires complete matrices, this package allows for PCA estimation and missing value imputation using various probabilistic, Bayesian, and iterative regression-based approaches.

## Core Workflow

### 1. Data Preparation
Data should be centered and/or scaled before PCA. The `prep()` function handles this, especially for data with missing values.

```r
library(pcaMethods)
data(metaboliteData)
# Center data without scaling
md <- prep(metaboliteData, scale="none", center=TRUE)
```

### 2. Performing PCA
The `pca()` wrapper function is the primary interface. Specify the method based on data characteristics.

```r
# Probabilistic PCA (good for 10-15% missing data)
resPPCA <- pca(md, method="ppca", nPcs=5)

# Bayesian PCA (robust for missing value estimation)
resBPCA <- pca(md, method="bpca", nPcs=5)

# Nipals PCA (iterative, handles small amounts of missing data)
resNipals <- pca(md, method="nipals", nPcs=5)

# SVDimpute (iterative regression)
resSVDI <- pca(md, method="svdImpute", nPcs=5)
```

### 3. Missing Value Imputation
To obtain a complete dataset from a PCA model, use `completeObs()`.

```r
# Impute missing values using the PPCA model
imputedData <- completeObs(resPPCA)

# For ExpressionSet objects
# impExSet <- asExprSet(resPPCA, originalExSet)
```

### 4. Evaluating Results
Use cross-validation to determine the optimal number of principal components (PCs) or to measure imputation accuracy.

```r
# Q2 goodness of prediction
q2 <- Q2(resPPCA, md, fold=10)

# Estimate optimal number of PCs using NRMSEP
errEst <- kEstimate(md, method="ppca", evalPcs=1:5, nruncv=1, em="nrmsep")
```

### 5. Visualization
The package provides built-in plotting for scores and loadings.

```r
# Quick scores and loadings plot
slplot(resPPCA)

# Plot multiple PCs against each other
plotPcs(resPPCA, pcs=1:3)
```

## Handling Outliers
Standard PCA is sensitive to outliers. Use `robustPca` or manually set outliers to `NA` and use a missing-value robust method like `ppca`.

```r
# Use robust SVD-based PCA
resRob <- pca(md, method="robustPca", nPcs=5)
```

## Method Selection Guide
- **ppca**: Best for general probabilistic modeling; handles 10-15% missingness.
- **bpca**: Best for missing value estimation; uses a Bayesian framework.
- **svdImpute**: Good for high amounts of missing data (>10%).
- **nipals**: Fast, but only handles small amounts of missing data (<5%).
- **nlpca**: Use for non-linear responses (e.g., enzyme kinetics).
- **llsImpute**: Local Least Squares; a cluster-based alternative to PCA methods.

## Reference documentation
- [Imputing missing values using the pcaMethods package](./references/missingValues.md)
- [Handling of data containing outliers](./references/outliers.md)
- [The pcaMethods Package Overview](./references/pcaMethods.md)