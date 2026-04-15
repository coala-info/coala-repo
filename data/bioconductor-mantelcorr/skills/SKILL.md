---
name: bioconductor-mantelcorr
description: The bioconductor-mantelcorr package performs variable selection and cluster identification in microarray data by correlating local cluster distance matrices with the global data structure using the Mantel statistic. Use when user asks to over-partition gene expression data, calculate Mantel correlation coefficients for clusters, or identify significant gene clusters through permutation testing.
homepage: https://bioconductor.org/packages/release/bioc/html/MantelCorr.html
---

# bioconductor-mantelcorr

## Overview

The `MantelCorr` package provides a methodology for variable selection and cluster identification in microarray expression data. It uses an "over-partitioning" approach where the gene space is divided into $k$ non-overlapping clusters using k-means. The skill of the package lies in using the Mantel statistic to correlate the distance matrix of each subset (cluster) with the distance matrix of the full dataset. Clusters that maintain a high correlation with the global data structure are identified as significant through permutation testing.

## Typical Workflow

### 1. Data Preparation and Clustering
Load the package and your expression data (rows as genes, columns as samples). Use `GetClusters` to over-partition the gene space.

```r
library(MantelCorr)
# data should be a numeric matrix or data frame
# k: number of clusters (e.g., 500)
# iter.max: max iterations for k-means
kmeans.result <- GetClusters(data, k = 500, iter.max = 100)
```

### 2. Computing Dissimilarity Matrices
Generate the distance matrices for the full dataset ($D_{full}$) and each cluster subset ($D_{subset}$).

```r
DistMatrices.result <- DistMatrices(data, kmeans.result$clusters)
```

### 3. Calculating Mantel Correlations
Compute the Mantel correlation for each cluster by correlating its local distance matrix with the global distance matrix.

```r
MantelCorrs.result <- MantelCorrs(DistMatrices.result$Dfull, DistMatrices.result$Dsubsets)
```

### 4. Permutation Testing for Significance
Determine which clusters are statistically significant. The package permutes $D_{full}$ to create an empirical null distribution.

```r
# nperm: number of permutations (1000+ recommended for final analysis)
# n: number of samples in the original data
# alpha: significance level (e.g., 0.05)
permuted.pval <- PermutationTest(DistMatrices.result$Dfull, 
                                 DistMatrices.result$Dsubsets, 
                                 nperm = 100, 
                                 n = ncol(data), 
                                 alpha = 0.05)
```

### 5. Extracting Results
Generate lists of significant and non-significant clusters and retrieve the specific genes within them.

```r
# Get summary of clusters
ClusterLists <- ClusterList(permuted.pval, 
                            kmeans.result$cluster.sizes, 
                            MantelCorrs.result)

# Get specific gene names/IDs within the significant clusters
ClusterGenes <- ClusterGeneList(kmeans.result$clusters, 
                                ClusterLists$SignificantClusters, 
                                data)
```

## Key Functions

- `GetClusters(data, k, iter.max)`: Performs k-means clustering to partition genes.
- `DistMatrices(data, clusters)`: Computes Euclidean distance matrices for the whole set and subsets.
- `MantelCorrs(Dfull, Dsubsets)`: Calculates the Mantel correlation coefficient ($r$) for each cluster.
- `PermutationTest(Dfull, Dsubsets, nperm, n, alpha)`: Returns p-values and identifies significant clusters based on the alpha threshold.
- `ClusterList(permuted.pval, cluster.sizes, mantel.corrs)`: Summarizes cluster statistics (size, correlation, significance).
- `ClusterGeneList(clusters, significant.clusters, data)`: Maps cluster indices back to gene labels from the original data.

## Tips
- **Choosing k**: The package suggests a large $k$ (e.g., between 5 and $p/2$, where $p$ is the number of genes) to ensure the gene space is sufficiently over-partitioned.
- **Permutations**: While 100 permutations are useful for quick testing, use at least 1000 for published results to ensure stable p-values.
- **Data Input**: Ensure your input matrix has appropriate `dimnames` (gene names as rows), as `ClusterGeneList` relies on these for the final output.

## Reference documentation

- [MantelCorrVignette](./references/MantelCorrVignette.md)