---
name: r-prabclus
description: The r-prabclus package provides functions for clustering and testing presence-absence, abundance, and multilocus genetic data. Use when user asks to perform species delimitation, detect spatial noise using nearest neighbors, calculate ecological distance measures, or conduct parametric bootstrap tests for clustering.
homepage: https://cloud.r-project.org/web/packages/prabclus/index.html
---

# r-prabclus

name: r-prabclus
description: Functions for clustering and testing of presence-absence, abundance, and multilocus genetic data. Use this skill when performing species delimitation, distance-based parametric bootstrap tests for clustering, nearest neighbor-based noise detection (NNclean), or calculating genetic distances between communities.

# r-prabclus

## Overview
The `prabclus` package provides specialized tools for analyzing biodiversity and genetic data. It is particularly strong in distance-based clustering, testing for the presence of clusters against a null model (parametric bootstrap), and handling "noise" or outliers in spatial/abundance data. It supports presence-absence (PRAB) matrices, abundance data, and multilocus genetic markers.

## Installation
To install the package from CRAN:
```R
install.packages("prabclus")
library(prabclus)
```

## Main Functions and Workflows

### 1. Data Preparation
The package uses a `prab` object as a standard input for many functions.
- `prabinit()`: Initializes a presence-absence or abundance data object. You can specify neighborhood structures and distance measures (e.g., Jaccard, Kulczynski).
- `read.pab()`: Reads presence-absence data from a file.

### 2. Clustering and Noise Detection
- `prabclust()`: Performs clustering of the data. It can automatically account for spatial autocorrelation if a neighborhood matrix is provided.
- `NNclean()`: A powerful tool for spatial noise detection. It uses nearest neighbor distances to identify and strip "noise" points from a dataset before clustering.
- `specgroups()`: Specifically designed for species delimitation based on multilocus genetic data.

### 3. Testing for Clustering
- `prabtest()`: Performs a parametric bootstrap test for clustering. It compares the observed clustering strength against a null model (e.g., a strategic simulation of independent species distributions).
- `popdist()`: Calculates genetic distances between populations or communities.

### 4. Distance Measures
The package includes several distance functions optimized for ecological data:
- `jaccard()`: Jaccard distance.
- `kulczynski()`: Kulczynski distance.
- `qprob()`: Calculates the probability of shared species under a null model.

## Example Workflow: Testing for Clusters
```R
# 1. Load and initialize data
data(kykladspe)
prabobj <- prabinit(prabmatrix = kykladspe, neighborhood = kykladneigh)

# 2. Run the clustering test (parametric bootstrap)
# nsim defines the number of bootstrap iterations
test_results <- prabtest(prabobj, times = 100)

# 3. Summary and Visualization
summary(test_results)
plot(test_results)
```

## Tips
- **Neighborhoods**: For spatial data, always provide a neighborhood matrix to `prabinit` to ensure the null models in `prabtest` account for spatial constraints.
- **Abundance Data**: While the name suggests presence-absence, `prabinit` handles abundance data by setting `abundance = TRUE`.
- **Large Datasets**: `NNclean` is computationally efficient for identifying outliers in 2D or 3D spatial point patterns before applying density-based clustering.

## Reference documentation
- [Christian Martin Hennig Home Page](./references/home_page.md)