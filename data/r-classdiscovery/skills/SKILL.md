---
name: r-classdiscovery
description: The r-classdiscovery tool provides R-based methods for clustering, dimensionality reduction, and pattern identification in high-throughput biological datasets. Use when user asks to perform principal component analysis, conduct hierarchical clustering, evaluate cluster stability, or generate heatmaps for microarray and proteomics data.
homepage: https://cran.r-project.org/web/packages/classdiscovery/index.html
---

# r-classdiscovery

name: r-classdiscovery
description: Expert guidance for using the 'classdiscovery' R package to perform clustering, classification, and dimensionality reduction on high-throughput biological data (microarrays, proteomics). Use this skill when performing unsupervised learning tasks, including hierarchical clustering, principal component analysis (PCA), and determining the number of clusters in a dataset.

# r-classdiscovery

## Overview
The `classdiscovery' package is part of the OOMPA (Object-Oriented Microarray and Proteomics Analysis) suite. It provides specialized S4 classes and methods for "class discovery" in high-dimensional biological datasets. Its primary focus is on identifying patterns, clusters, and structure in data through robust implementations of clustering algorithms and visualization tools.

## Installation
To install the package from CRAN:
```R
install.packages("classdiscovery")
```

## Core Workflows and Functions

### 1. Principal Component Analysis (PCA)
Use the `SamplePCA` class to perform PCA and visualize sample relationships.
- `SamplePCA(data, center=TRUE, scale=FALSE)`: Creates a PCA object.
- `plot(pcaObject)`: Generates a 2D scree plot or scatter plot of components.
- `identify(pcaObject)`: Interactively identify points in the plot.

### 2. Hierarchical Clustering
The package provides the `ClusterDiagram` class to wrap and extend standard R clustering.
- `ClusterDiagram(data, method="average", distance="pearson")`: Performs clustering.
- `plot(clusterObj)`: Plots the dendrogram with enhanced labeling options.

### 3. Determining Cluster Stability (ClusterTest)
Use `ClusterTest` to evaluate the stability of clusters via bootstrap resampling.
- `ClusterTest(data, clusterer, nTimes=100)`: Runs the stability test.
- `summary(testObj)`: Provides statistics on cluster consistency.

### 4. Mosaic Plots and Heatmaps
The `Mosaic` class provides a high-level interface for creating heatmaps.
- `Mosaic(data, samplePCA, genePCA)`: Creates a mosaic object using PCA-based ordering.
- `plot(mosaicObj)`: Displays the heatmap.

### 5. Distance Metrics
The package includes specialized distance functions for biological data:
- `distanceMatrix(data, metric)`: Supports "pearson", "uncentered correlation", "spearman", and "euclidean".

## Usage Tips
- **Data Input**: Most functions expect a matrix where rows are features (genes/proteins) and columns are samples.
- **OOMPA Integration**: This package works seamlessly with other OOMPA packages like `PreProcess`.
- **S4 Methods**: Use `slotNames()` or `show()` to inspect the contents of the objects created by this package.

## Reference documentation
- [OOMPA Project Home](./references/home_page.md)