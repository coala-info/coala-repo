---
name: bioconductor-consensusclusterplus
description: ConsensusClusterPlus performs unsupervised class discovery and consensus clustering to identify stable clusters in genomic data. Use when user asks to determine the optimal number of clusters, assess cluster stability via resampling, or generate consensus matrices and tracking plots for sample classification.
homepage: https://bioconductor.org/packages/release/bioc/html/ConsensusClusterPlus.html
---

# bioconductor-consensusclusterplus

name: bioconductor-consensusclusterplus
description: Unsupervised class discovery and consensus clustering for genomic data. Use this skill when you need to determine the optimal number of clusters (k) in a dataset, assess cluster stability via resampling, or generate consensus matrices and tracking plots for sample classification.

## Overview
ConsensusClusterPlus is a Bioconductor package used for unsupervised class discovery. It implements the consensus clustering method, which uses subsampling (bootstrapping) to provide quantitative evidence for the number and membership of clusters. It is particularly effective for high-dimensional data like gene expression microarrays or RNA-seq.

## Typical Workflow

### 1. Data Preparation
Input data should be a matrix where columns are samples (items) and rows are features (e.g., genes).
- **Filtering**: It is common practice to filter for the most variable features (e.g., top 5,000 genes by Median Absolute Deviation).
- **Normalization**: Data should be centered or normalized if using correlation-based distances.

```r
# Example: Top 5000 MAD genes
mads = apply(d, 1, mad)
d = d[rev(order(mads))[1:5000], ]
# Median center rows
d = sweep(d, 1, apply(d, 1, median, na.rm=TRUE))
```

### 2. Running ConsensusClusterPlus
The main function executes the resampling and clustering iterations.

```r
library(ConsensusClusterPlus)
results = ConsensusClusterPlus(d,
                               maxK = 6,
                               reps = 50,
                               pItem = 0.8,
                               pFeature = 1,
                               title = "my_cluster_output",
                               clusterAlg = "hc",
                               distance = "pearson",
                               seed = 12345,
                               plot = "pdf")
```

**Key Parameters:**
- `maxK`: Maximum number of clusters to evaluate (e.g., 2 to 6).
- `reps`: Number of subsampling iterations (1,000 is recommended for publication).
- `pItem`: Proportion of items (samples) to sample in each iteration.
- `pFeature`: Proportion of features (genes) to sample.
- `clusterAlg`: Clustering algorithm ("hc" for hierarchical, "pam" for partitioning around medoids, "km" for kmeans).
- `distance`: Distance metric ("pearson", "spearman", "euclidean", "binary", etc.).

### 3. Calculating Consensus Statistics
Use `calcICL` to calculate the Cluster-Consensus and Item-Consensus.

```r
icl = calcICL(results, title="my_cluster_output", plot="pdf")
```

## Interpreting Results

### Output Objects
- `results[[k]][["consensusMatrix"]]`: Symmetrical matrix of pairwise consensus values.
- `results[[k]][["consensusClass"]]`: Cluster assignments for the samples at a specific k.
- `icl[["clusterConsensus"]]`: Mean pairwise consensus values between members of the same cluster (higher = more stable).
- `icl[["itemConsensus"]]`: Mean consensus of an item with all items in a specific cluster.

### Graphical Outputs
- **Consensus Matrix Heatmap**: Look for "clean" blocks of blue on the diagonal with minimal off-diagonal signal.
- **CDF Plot**: Identifies the k where the Cumulative Distribution Function reaches an approximate maximum.
- **Delta Area Plot**: Shows the relative change in the area under the CDF curve. A sharp drop-off often suggests the optimal k.
- **Tracking Plot**: Visualizes how samples move between clusters as k increases. Frequent color changes indicate unstable membership.

## Advanced Options
- **Custom Distance**: You can provide a custom distance function that returns a `dist` object.
- **Custom Algorithm**: You can provide a custom clustering function that accepts a distance matrix and k.
- **Large Datasets**: If `pFeature=1`, you can pass a pre-computed distance matrix as `d` to save time. For very large matrices, use `plot="pngBMP"` to avoid memory issues with dendrogram rendering.

## Reference documentation
- [ConsensusClusterPlus](./references/ConsensusClusterPlus.md)