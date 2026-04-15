---
name: bioconductor-flowpeaks
description: The bioconductor-flowpeaks package implements a fast, unsupervised clustering algorithm for flow cytometry data using K-means partitioning and density peak finding. Use when user asks to cluster flow cytometry data, identify cell populations based on density peaks, or visualize irregular cluster boundaries in multidimensional flow data.
homepage: https://bioconductor.org/packages/release/bioc/html/flowPeaks.html
---

# bioconductor-flowpeaks

## Overview

The `flowPeaks` package implements a fast, unsupervised clustering algorithm designed specifically for flow cytometry. It operates in two main stages:
1. **K-means Partitioning**: It uses K-means with a large $K$ to break the data into many small, compact clusters.
2. **Density Peak Finding**: It generates a smoothed density function from these partitions and merges them by following the gradient to local density peaks.

This approach allows the algorithm to identify clusters of irregular shapes and is robust against outliers.

## Core Workflow

### 1. Data Preparation
`flowPeaks` accepts a numeric matrix where rows are cells and columns are markers/channels. If working with `flowCore` objects, extract and transform the expression matrix first.

```r
library(flowPeaks)
library(flowCore)

# Load data (example using flowCore)
fcs_file <- read.FCS("path_to_file.fcs")
# Select channels and apply transformation (e.g., asinh)
data_matrix <- asinh(exprs(fcs_file)[, c("FL1-H", "FL2-H")])
```

### 2. Running the Clustering
The primary function is `flowPeaks()`. It automatically determines the number of clusters based on density peaks.

```r
# Run clustering
fp <- flowPeaks(data_matrix)

# Summary of results
summary(fp)
```

### 3. Visualization
The package provides a specialized `plot` method to visualize clusters, K-means centers, and boundaries.

```r
# 2D Scatter plot with cluster boundaries
plot(fp, idx=c(1, 2)) 

# Pairwise plots for more than 2 dimensions
par(mfrow=c(2,2))
plot(fp)
```

### 4. Assigning New Data and Handling Outliers
You can assign new points to existing clusters or identify outliers that do not clearly belong to a peak.

```r
# Assigning data (can be used to identify outliers)
# fpc will contain cluster labels; 0 typically indicates outliers/noise
fpc <- assign.flowPeaks(fp, fp$x)

# Plotting with identified outliers in black
plot(fp, classlab=fpc, drawboundary=FALSE, drawkmeans=FALSE)
```

### 5. Evaluation
If gold-standard labels (manual gating) are available, use `evalCluster` to compare performance.

```r
# Compare results using V-measure
score <- evalCluster(gold_standard_labels, fp$peaks.cluster, method="Vmeasure")
print(score)
```

## Tips for Success
- **Transformation**: Always transform flow cytometry data (e.g., `logicle` or `asinh`) before running `flowPeaks`, as the density estimation assumes a relatively continuous space.
- **Dimensionality**: While `flowPeaks` handles high-dimensional data, clustering performance often improves by selecting only the specific markers of interest rather than using all available channels.
- **Large Datasets**: The algorithm is optimized for speed. For very large datasets, the initial K-means step significantly reduces the computational burden of the density estimation.

## Reference documentation
- [flowPeaks User Guide](./references/flowPeaks-guide.md)