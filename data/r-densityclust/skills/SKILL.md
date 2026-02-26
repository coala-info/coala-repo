---
name: r-densityclust
description: This tool implements the density peaks clustering algorithm to identify clusters of arbitrary shapes and detect cluster centers. Use when user asks to calculate local density and distance thresholds, identify cluster centers via decision plots, or perform non-parametric clustering on distance matrices.
homepage: https://cloud.r-project.org/web/packages/densityClust/index.html
---


# r-densityclust

## Overview
The `densityClust` package implements the "Clustering by Fast Search and Find of Density Peaks" algorithm. It is particularly effective at discovering clusters of arbitrary shapes and automatically detecting the number of clusters via a decision plot. The process is split into two main steps: calculating density ($\rho$) and distance to higher density ($\delta$), followed by cluster assignment based on user-defined thresholds.

## Installation
Install the package from CRAN:
```r
install.packages("densityClust")
```

## Core Workflow

### 1. Calculate Density and Distance
The `densityClust()` function performs the initial calculations. It requires a distance matrix.

```r
library(densityClust)

# Create a distance matrix (e.g., using Euclidean distance)
data_dist <- dist(my_data)

# Calculate rho and delta
# gaussian=TRUE uses a soft-cutoff; gaussian=FALSE uses a hard-cutoff
clust_obj <- densityClust(data_dist, gaussian = TRUE)
```

For very large datasets, `densityClust` can utilize k-nearest neighbors to improve performance.

### 2. Inspect the Decision Plot
Before assigning clusters, you must determine the thresholds for $\rho$ (local density) and $\delta$ (distance from points of higher density). Points with high $\rho$ and high $\delta$ are potential cluster centers.

```r
# Plot the decision graph
plot(clust_obj)
```

### 3. Assign Clusters
Use `findClusters()` to finalize the assignment. You can provide specific thresholds or select them interactively.

```r
# Manual assignment with thresholds
final_clust <- findClusters(clust_obj, rho = 2, delta = 2)

# Interactive assignment (opens a plot for clicking)
# final_clust <- findClusters(clust_obj)
```

### 4. Visualization and Results
You can visualize the results using MDS and extract the cluster assignments.

```r
# Plot clusters using Multidimensional Scaling
plotMDS(final_clust)

# Get cluster assignments for each observation
assignments <- final_clust$clusters

# View observations split by cluster
split(my_data, assignments)
```

## Tips and Best Practices
- **Distance Cutoff ($d_c$):** By default, `densityClust` calculates a $d_c$ such that the average number of neighbors is 1-2% of the total points. You can override this using the `dc` parameter in `densityClust()`.
- **Cluster Centers:** In the decision plot, outliers (low $\rho$, high $\delta$) are easily distinguished from cluster centers (high $\rho$, high $\delta$).
- **Large Datasets:** If your dataset is too large for a full distance matrix, ensure you are using the kNN-optimized version of the algorithm included in recent versions of the package.
- **Non-Separated Clusters:** If clusters are not well-separated in the feature space (like the Versicolor and Virginica species in the Iris dataset), the algorithm may merge them into a single cluster.

## Reference documentation
- [Clustering by fast search and find of density peaks](./references/README.md)