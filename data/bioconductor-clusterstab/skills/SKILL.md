---
name: bioconductor-clusterstab
description: The clusterStab package provides resampling-based tools to determine the optimal number of clusters and assess their stability in high-dimensional biological data. Use when user asks to estimate the number of clusters in a dataset, evaluate cluster reliability using Jaccard coefficients, or perform stability analysis on hierarchical clustering results.
homepage: https://bioconductor.org/packages/release/bioc/html/clusterStab.html
---


# bioconductor-clusterstab

## Overview

The `clusterStab` package provides tools to address two fundamental questions in hierarchical clustering of high-dimensional biological data (like microarrays):
1. **How many clusters are actually in the data?**
2. **How stable/reliable are those clusters?**

It uses a resampling-based approach. To find the number of clusters, it subsets samples and compares clustering results. To test the stability of a specific clustering solution, it subsets genes. Stability is quantified using the Jaccard coefficient, where values closer to 1.0 indicate higher stability.

## Workflow and Usage

### 1. Data Preparation and Filtering
Clustering is sensitive to noise. It is recommended to filter genes with low variation (e.g., using Coefficient of Variation) before analysis to avoid "self-fulfilling prophecies" where clusters are forced by arbitrary gene selection.

```r
library(clusterStab)
library(genefilter)

# Example: Filter genes with CV > 0.1
filt <- cv(0.1, Inf)
index <- genefilter(expression_matrix, filt)
filtered_data <- expression_matrix[index, ]
```

### 2. Determining the Number of Clusters (`benhur`)
The `benhur` function implements the Ben-Hur et al. (2002) algorithm. It repeatedly subsets samples and calculates the distribution of Jaccard coefficients for different values of $k$.

```r
# bh <- benhur(data, prop, maxK, seednum)
# prop: proportion of samples to sub-sample (e.g., 0.7 or 0.8)
# maxK: maximum number of clusters to test
bh <- benhur(filtered_data, prop = 0.7, maxK = 6)

# Visualize results to find the optimal K
hist(bh)  # Look for the K where the distribution is most skewed toward 1.0
ecdf(bh)  # Empirical CDF plots; look for the curve that stays lowest/rightmost
```

### 3. Assessing Cluster Stability (`clusterComp`)
Once a value for $k$ is chosen, use `clusterComp` to see how stable those specific clusters are when different sets of genes are used.

```r
# cmp <- clusterComp(data, k, counts, iter, prop)
# k: the chosen number of clusters
# iter: number of iterations (default 100)
res <- clusterComp(filtered_data, k = 2)

# View stability percentages for each cluster
print(res)
```

## Interpretation Tips

*   **Optimal K Selection**: When viewing `hist(bh)`, the "true" number of clusters is typically the largest $k$ for which the Jaccard coefficients remain concentrated near 1.0. If all histograms for $k > 1$ show significant spread away from 1.0, the data may not contain distinct clusters.
*   **Stability Score**: The output of `clusterComp` provides a percentage. A 100% stability score means that every time a subset of genes was used, the samples were assigned to the same cluster as in the original full-gene-set clustering.
*   **Algorithm**: Currently, these functions are wrappers around `hclust()`. Ensure your data is appropriately transformed (e.g., log2) before processing.

## Reference documentation

- [Using clusterStab](./references/clusterStab.md)