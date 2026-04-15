---
name: bioconductor-covrna
description: This package tests and visualizes associations between sample-level metadata and gene-level metadata through gene expression levels using fourthcorner and RLQ analysis. Use when user asks to test the significance of associations between sample and gene covariates, perform ordination on transcriptomic data, or visualize functional links between phenotypes and gene annotations.
homepage: https://bioconductor.org/packages/release/bioc/html/covRNA.html
---

# bioconductor-covrna

## Overview

The `covRNA` package provides a framework for testing and visualizing how sample-level metadata (e.g., treatment conditions, phenotypes) and gene-level metadata (e.g., GO terms, COG categories) are linked through gene expression levels. It adapts ecological methods (fourthcorner and RLQ analysis) for transcriptomics, offering parallelized implementations suitable for large-scale read count or intensity data.

## Core Workflow

### 1. Data Preparation
The package accepts either a Bioconductor `ExpressionSet` or three separate matrices:
- **L**: Gene expression data (genes in rows, samples in columns).
- **R**: Gene covariates (genes in rows, annotations in columns).
- **Q**: Sample covariates (samples in rows, conditions in columns).

```r
library(covRNA)
# Using an ExpressionSet
data(Baca) 

# Alternatively, using matrices
# L <- exprs(ExpressionSet)
# R <- fData(ExpressionSet)
# Q <- pData(ExpressionSet)
```

### 2. Statistical Testing (Fourthcorner Analysis)
Use the `stat` function to calculate the significance of associations between every combination of sample and gene covariates.

```r
# npermut: number of permutations for p-value calculation
# padjust: method for multiple testing correction (e.g., "BH")
# nrcor: number of cores for parallel processing
stat_results <- stat(ExprSet = Baca, npermut = 999, padjust = "BH", nrcor = 2)

# Access results
adjp <- stat_results$adj.pvalue
tests <- stat_results$stattest

# Visualize significant associations (Red = negative, Blue = positive)
plot(stat_results, xnames = c('cold','ctrl','etoh','salt'))
```

### 3. Ordination (RLQ Analysis)
Use the `ord` function to project sample and gene covariates into a shared reduced-dimensional space.

```r
ord_results <- ord(Baca)

# Plot explained variance (scree plot)
plot(ord_results, feature = "variance")

# Plot ordination of samples or genes
plot(ord_results, feature = "samples")
plot(ord_results, feature = "genes")
```

### 4. Combined Visualization
The `vis` function overlays the statistical significance from `stat` onto the ordination space from `ord`.

```r
# Significant associations are drawn as colored lines
vis(Stat = stat_results, Ord = ord_results, rangex = 1.5, rangey = 1.5)
```

## Tips and Best Practices
- **Input Scaling**: `covRNA` handles the underlying Correspondence Analysis (CA) for expression data and PCA/MCA for covariates automatically within the `ord` function.
- **Parallelization**: Always specify `nrcor` in the `stat` function when working with large datasets to reduce computation time for permutations.
- **Gene Annotation**: If your dataset lacks gene covariates, use `biomaRt` to fetch attributes (like GO terms or InterPro IDs) and add them to the `featureData` of your `ExpressionSet` before analysis.
- **Interpretation**: In the `vis` plot, spatial proximity indicates similar functional effects. Lines represent statistically validated relationships that survive the permutation test.

## Reference documentation
- [An Introduction to covRNA](./references/covRNA.md)