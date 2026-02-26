---
name: bioconductor-flowmeans
description: This tool performs non-parametric clustering for automated gating of cell populations in multidimensional flow cytometry data. Use when user asks to identify cell populations, perform automated gating, or cluster flow cytometry data using the flowMeans algorithm.
homepage: https://bioconductor.org/packages/release/bioc/html/flowMeans.html
---


# bioconductor-flowmeans

name: bioconductor-flowmeans
description: Non-parametric clustering for flow cytometry data gating. Use this skill to identify cell populations in multidimensional flow data using the flowMeans algorithm, which combines mode-counting, k-means clustering, and change-point detection to find non-spherical populations without complex statistical models.

## Overview

`flowMeans` is an R package designed for automated gating of cell populations. It uses a robust approach that:
1. Counts modes in every single dimension.
2. Performs multidimensional clustering.
3. Merges adjacent clusters based on Euclidean or Mahalanobis distance.
4. Automatically determines the optimal number of clusters using a change-point detection algorithm based on piecewise linear regression.

This method is particularly efficient for high-throughput flow cytometry as it avoids the computational overhead of model-based identification methods while maintaining high accuracy.

## Core Workflow

### 1. Data Preparation
The input should be a matrix or data frame of flow cytometry intensities. Ensure that non-biological parameters (like `Time` or `ID`) are removed before analysis.

```r
library(flowMeans)
data(x) # Example dataset
# Define the channels to be used for clustering
channels <- c("FL1.H", "FL2.H", "FL3.H", "FL4.H")
```

### 2. Running flowMeans
The primary function is `flowMeans()`. You must specify the variables to analyze and the maximum number of clusters (`MaxN`) to consider.

```r
res <- flowMeans(x, varNames = channels, MaxN = 10)
```

### 3. Determining Optimal Clusters
The package uses a change-point detection algorithm on the minimum distances between merged clusters to find the "elbow" or optimal cluster count.

```r
# Find the change point
ft <- changepointDetection(res@Mins)

# Visualize the change point (the red dot indicates the selected iteration)
plot(res@Mins, xlab = 'Iteration', ylab = 'Distance')
abline(ft$l1)
abline(ft$l2)
points(ft$MinIndex + 1, res@Mins[ft$MinIndex + 1], col = 'red', pch = 19)
```

### 4. Visualizing Results
You can visualize the final clustering results in 2D or across all analyzed dimensions.

```r
# 2D Plot of specific channels
plot(x, res, c("FL1.H", "FL2.H"))

# Multi-dimensional scatter plot matrix
plot(x, res, channels, pch = '.')
```

## Key Objects and Slots

The `flowMeans` function returns an S4 object with the following important slots:
- `@Labels`: A list containing cluster membership labels for every iteration of the merging process.
- `@Label`: A vector of the final cluster membership labels for the optimal number of clusters.
- `@Mins`: A vector containing the minimum distances between merged clusters at each iteration.
- `@MaxN`: The maximum number of clusters requested.

## Tips and Best Practices
- **Parameter Selection**: Always filter your input matrix to include only the fluorescent channels of interest. Including `Time` or `Event ID` will distort the distance calculations.
- **Distance Metrics**: By default, the algorithm uses Euclidean distance. For populations with significant covariance, consider if Mahalanobis distance is more appropriate (though Euclidean is the standard for the `flowMeans` implementation).
- **Iteration Inspection**: If the automated change-point detection fails to pick a biologically relevant number of clusters, you can manually inspect `res@Labels[[i]]` where `i` is your preferred iteration.

## Reference documentation
- [flowMeans](./references/flowMeans.md)