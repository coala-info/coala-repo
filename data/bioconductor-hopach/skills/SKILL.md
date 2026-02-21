---
name: bioconductor-hopach
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/hopach.html
---

# bioconductor-hopach

name: bioconductor-hopach
description: Hierarchical Ordered Partitioning And Collapsing Hybrid (HOPACH) clustering for genomic data. Use this skill to perform automated hierarchical clustering of genes or arrays, determine optimal cluster numbers using Median Split Silhouette (MSS), perform bootstrap resampling for fuzzy clustering memberships, and generate visualization-ready output files for MapleTree or TreeView.

# bioconductor-hopach

## Overview

The `hopach` package implements a hybrid clustering method that combines the strengths of partitioning and agglomerative algorithms. It builds an ordered hierarchical tree by partitioning clusters into two or more children at each node, while using "collapsing" steps to unite close clusters and correct partitioning errors. A key feature is the automatic determination of the number of clusters and the "pruning" of the tree using the Median Split Silhouette (MSS) criterion.

## Core Workflow

### 1. Data Preparation and Distance Matrices
Before clustering, it is computationally efficient to compute the distance matrix separately.
- For **genes**: `cosangle` (cosine angle) is typically preferred.
- For **arrays**: `euclid` (Euclidean distance) is often used.

```r
library(hopach)
data(golub) # Example dataset

# Subset genes (e.g., top 200 by variance)
vars <- apply(golub, 1, var)
subset_idx <- vars > quantile(vars, (nrow(golub) - 200) / nrow(golub))
golub.subset <- golub[subset_idx, ]

# Compute distance matrix
gene.dist <- distancematrix(golub.subset, "cosangle")
```

### 2. Running HOPACH
The `hopach` function performs the main clustering. It returns a list containing the cluster labels, sizes, and the hierarchical tree structure.

```r
# Cluster genes
gene.hobj <- hopach(golub.subset, dmat = gene.dist)

# View number of clusters identified
gene.hobj$clust$k

# View cluster sizes
gene.hobj$clust$sizes
```

### 3. Bootstrap Resampling (Fuzzy Clustering)
To assess cluster stability and gene membership, use `boothopach`. This estimates the probability of a gene belonging to each cluster.

```r
# B=100 for speed; B=1000 recommended for publication
bobj <- boothopach(golub.subset, gene.hobj, B = 100)

# Visualize bootstrap results
bootplot(bobj, gene.hobj, ord = "bootp", main = "Bootstrap Memberships")
```

### 4. Visualization and Output
`hopach` provides internal plotting and exporters for external tree viewers.

- **Distance Matrix Plot**: Visualizes the clustering structure.
  ```r
  dplot(gene.dist, gene.hobj, ord = "final", showclusters = FALSE)
  ```

- **Text Output**: Create a tab-delimited file with clustering and bootstrap results.
  ```r
  makeoutput(golub.subset, gene.hobj, bobj, file = "results.out")
  ```

- **External Viewers**: Export files for MapleTree, TreeView, or Java TreeView.
  ```r
  # For Hierarchical Tree Viewers (.cdt, .gtr, .atr)
  hopach2tree(golub.subset, file = "GolubTree", hopach.genes = gene.hobj, dist.genes = gene.dist)

  # For Fuzzy Clustering Viewers (.cdt, .fct, .mb)
  boot2fuzzy(golub.subset, bobj, gene.hobj, file = "GolubFuzzy")
  ```

## Key Functions
- `distancematrix(data, metric)`: Supports "cosangle", "abscosangle", "euclid", "cor", and "abscor".
- `hopach(data, dmat, d)`: Main clustering function. If `dmat` is NULL, it computes distance using metric `d`.
- `boothopach(data, hopachobj, B)`: Performs non-parametric bootstrap.
- `makeoutput(...)`: Summarizes results into a spreadsheet-ready format.

## Reference documentation
- [Bioconductor’s hopach package](./references/hopach.md)