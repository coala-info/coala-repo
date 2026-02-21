---
name: bioconductor-fusesom
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/FuseSOM.html
---

# bioconductor-fusesom

name: bioconductor-fusesom
description: Unsupervised clustering of high-dimensional single-cell and spatial data using correlation-based multiview Self Organizing Maps (SOM). Use this skill to characterize cell types in multiplexed imaging cytometry assays, integrate multiview correlation metrics, and estimate optimal cluster numbers using discriminant or distance-based statistics.

# bioconductor-fusesom

## Overview

FuseSOM is an R package designed for robust unsupervised clustering of highly multiplexed in situ imaging cytometry data. It combines a Self Organizing Map (SOM) architecture with multiview integration of correlation-based metrics. It supports standard Bioconductor objects like `SingleCellExperiment` and `SpatialExperiment`, as well as standard R `matrix` and `data.frame` structures.

Note: FuseSOM does not perform quality control (QC) or feature selection. Data should be normalized and filtered before use.

## Basic Workflow with Matrix/DataFrame

For standard tabular data where columns are markers and rows are cells/observations:

```r
library(FuseSOM)

# 1. Prepare data and markers
# data: matrix or data.frame
# markers: character vector of column names to use for clustering
markers <- c('CD45', 'SMA', 'CK7', 'VIM', 'CD3', 'CD8', 'CD4')

# 2. Run the FuseSOM pipeline
# numClusters: the desired number of clusters
results <- runFuseSOM(data = my_data, markers = markers, numClusters = 20)

# 3. Access results
clusters <- results$clusters
som_model <- results$model

# 4. Visualize marker expression across clusters
markerHeatmap(data = my_data, markers = markers, clusters = clusters, clusterMarkers = TRUE)
```

## Workflow with SingleCellExperiment or SpatialExperiment

FuseSOM integrates directly with Bioconductor containers, storing results within the object.

```r
library(SingleCellExperiment)

# Run FuseSOM on an SCE object
# assay: the assay name containing expression values (e.g., 'counts', 'logcounts')
# clusterName: name for the new column in colData (defaults to 'clusters')
sce <- runFuseSOM(sce, markers = markers, assay = 'counts', numClusters = 15)

# Results are stored in:
# - colData(sce)$clusters
# - metadata(sce)$SOM
```

## Estimating the Number of Clusters

If the optimal number of clusters is unknown, use `estimateNumCluster` which provides Discriminant-based and Distance-based (Gap, Jump, Slope, Silhouette, WCD) metrics.

```r
# Method 1: Using a previously generated SOM model
k_est <- estimateNumCluster(data = results$model, kSeq = 2:20, method = c("Discriminant", "Distance"))

# Method 2: Using an SCE object (results stored in metadata)
sce <- estimateNumCluster(data = sce, kSeq = 2:20, method = c("Discriminant", "Distance"))

# Check optimal clusters for Discriminant method
print(k_est$Discriminant)

# Visualize distance-based metrics using elbow plots
optiPlot(k_est, method = 'jump')
optiPlot(k_est, method = 'gap')
optiPlot(k_est, method = 'silhouette')
```

## Tips for Success

- **Grid Size**: `runFuseSOM` automatically calculates an optimal SOM grid size based on the data, but you can inspect this in the verbose output.
- **Method Selection**: The `Jump` statistic is often highly effective at capturing the true number of clusters in imaging data.
- **Overwriting**: When running `runFuseSOM` multiple times on the same SCE object, provide a unique `clusterName` to avoid overwriting previous results in `colData`. The `SOM` field in `metadata` will be overwritten by the most recent run.

## Reference documentation

- [Introduction](./references/Introduction.md)
- [Introduction.Rmd](./references/Introduction.Rmd)