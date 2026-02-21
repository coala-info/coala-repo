---
name: r-raceid
description: R package raceid (documentation from project home).
homepage: https://cran.r-project.org/web/packages/raceid/index.html
---

# r-raceid

## Overview
The `raceid` package provides a robust framework for single-cell RNA-seq analysis. It is composed of three primary modules:
1. **RaceID3**: A clustering algorithm optimized for identifying rare cell types by treating them as outliers.
2. **StemID2**: A method for reconstructing lineage trees and differentiation trajectories based on RaceID3 clusters.
3. **VarID**: A tool for quantifying local gene expression variability and identifying cell states using pruned k-nearest neighbor (kNN) networks.

## Installation
To install the package from CRAN:
```R
install.packages("RaceID")
```

## Core Workflow

### 1. Data Initialization and RaceID3 Clustering
The workflow begins with a gene-by-cell expression matrix (preferably UMI counts).

```R
library(RaceID)

# Initialize SCseq object
sc <- SCseq(expdata)

# Filtering and normalization
sc <- filterdata(sc, mintotal=2000, minexpr=5, minnumber=1)

# Compute distance matrix and clustering
sc <- compdist(sc, metric="pearson")
sc <- clustexp(sc)

# Outlier detection (RaceID's core strength)
sc <- findoutliers(sc)
```

### 2. Lineage Inference with StemID2
Once clusters are defined, StemID2 assembles them into a graph representing differentiation pathways.

```R
# Initialize Lineage object
ltr <- Ltree(sc)

# Compute entropy and projections
ltr <- compentropy(ltr)
ltr <- projcells(ltr)

# Detect significant links between clusters
ltr <- complink(ltr, outlg=2, pvn=0.01)

# Plot the lineage tree
plotlineage(ltr)
```

### 3. VarID Analysis
VarID is used for more granular analysis of expression noise and state transitions.

```R
# Create pruned kNN network
v <- VarID(sc)
v <- pruneKnn(v)

# Quantify local variability
v <- compVar(v)
```

## Key Functions
- `SCseq(expdata)`: Constructor for the main data object.
- `filterdata()`: Removes low-quality cells and lowly expressed genes.
- `compdist()`: Calculates the distance matrix (supports pearson, spearman, logpearson, euclidean).
- `clustexp()`: Performs k-medoids clustering.
- `findoutliers()`: Identifies rare cells based on a background model of transcript distribution.
- `Ltree(sc)`: Constructor for lineage tree inference.
- `plotlineage()`: Visualizes the inferred tree and cluster relationships.

## Tips for Success
- **Input Data**: Ensure the input is a matrix or data frame where rows are genes and columns are cells.
- **Rare Cells**: If you expect very rare populations, adjust the `probthr` parameter in `findoutliers` (default is 1e-3).
- **Visualization**: Use `plotmap(sc)` to visualize clusters in 2D space (t-SNE or UMAP) and `plotoutlierprobs(sc)` to inspect the statistical support for rare cell types.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)