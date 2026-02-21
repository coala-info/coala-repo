---
name: bioconductor-biodist
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/bioDist.html
---

# bioconductor-biodist

name: bioconductor-biodist
description: Calculate specialized biological distance measures including Mutual Information (MI), Kullback-Leibler Divergence (KLD), and correlation-based distances (Kendall's tau, Spearman's rho). Use this skill when performing clustering, neighbor analysis, or proximity calculations on genomic data, particularly ExpressionSet objects or high-dimensional matrices.

# bioconductor-biodist

## Overview
The `bioDist` package provides a suite of distance metrics specifically useful for biological data analysis. It extends the standard R `dist` functionality by implementing measures like Mutual Information and KL Divergence, which capture non-linear relationships and distributional differences. Most functions return an S3 `dist` object, compatible with standard R clustering functions like `hclust`.

## Package Workflows

### Data Preparation
By default, `bioDist` functions compute pairwise distances between the **rows** of the input matrix.
- To calculate distances between **features** (genes): Pass the expression matrix directly.
- To calculate distances between **samples**: Transpose the matrix using `t()`.

```r
library(bioDist)
library(Biobase)

# Example with ExpressionSet
data(sample.ExpressionSet)
# Transpose to get sample-to-sample distances
sample_matrix <- t(exprs(sample.ExpressionSet))
```

### Mutual Information (MI) Distances
MI measures the statistical dependence between variables.
- Use `MIdist(x)` to compute a distance measure transformed to the [0, 1] interval (where 0 is highly correlated/dependent).
- Use `mutualInfo(x)` to compute the raw distance from independence.
- Note: MI calculations are computationally intensive on large datasets.

### Kullback-Leibler Divergence (KLD)
KLD measures how one probability distribution differs from a second, reference probability distribution.
- Use `KLdist.matrix(x)` for an implementation based on binning.
- Use `KLD.matrix(x, method="density", supp=range(x))` for an implementation using density estimation and numerical integration.

### Correlation-based Distances
These functions provide alternatives to standard Pearson correlation.
- Use `tau.dist(x)` for Kendall's tau distance.
- Use `spearman.dist(x)` for Spearman's rho distance.
- Use the `sample=FALSE` argument if the input is an `ExpressionSet` and you wish to calculate distances between features rather than samples.

### Finding Nearest Neighbors
Use the `closest.top` helper function to identify the most similar entities in a distance matrix.

```r
# Find the 3 nearest neighbors for a specific feature 'f1'
# sp is a distance object created by spearman.dist
neighbors <- closest.top("feature_id_here", sp, 3)
```

## Tips and Best Practices
- **Memory Management**: Distance matrices grow quadratically with the number of items. Subset your data (e.g., top 500 highly variable genes) before computing MI or KLD distances to avoid memory issues.
- **Object Conversion**: Convert `dist` objects to standard matrices using `as.matrix()` if you need to inspect specific pairwise values.
- **Integration**: Since outputs are `dist` objects, pipe them directly into `hclust(d)` for hierarchical clustering or `cmdscale(d)` for Multi-Dimensional Scaling (MDS).

## Reference documentation
- [bioDist](./references/bioDist.md)