---
name: r-flexclust
description: "The main function kcca implements a general framework for   k-centroids cluster analysis supporting arbitrary distance measures   and centroid computation. Further cluster methods include hard   competitive learning, neural gas, and QT clustering. There are   numerous visualization methods for cluster results (neighborhood   graphs, convex cluster hulls, barcharts of centroids, ...), and   bootstrap methods for the analysis of cluster stability.</p>"
homepage: https://cloud.r-project.org/web/packages/flexclust/index.html
---

# r-flexclust

## Overview
The `flexclust` package provides a flexible framework for k-centroids clustering. Unlike standard `kmeans`, it allows for arbitrary distance measures and centroid computation functions. It includes implementations for hard competitive learning, neural gas, and QT clustering, along with extensive tools for validating cluster stability and visualizing high-dimensional cluster structures.

## Installation
```R
install.packages("flexclust")
```

## Main Functions

### K-Centroids Clustering
- `kcca(x, k, family, ...)`: The main engine for k-centroids cluster analysis.
- `kccaFamily(dist, cent, ...)`: Defines a cluster family (distance and centroid functions). Predefined families include `kccaFamily("kmeans")`, `"kmedians"`, `"angle"`, and `"jaccard"`.
- `predict(object, newdata)`: Assigns new data points to the closest cluster centers of a fitted model.

### Alternative Clustering Algorithms
- `cclust(x, k, method="hardcl")`: Stochastic gradient descent clustering (hard competitive learning or neural gas).
- `qtclust(x, radius)`: Quality threshold clustering (finds clusters with a maximum diameter).

### Validation and Stability
- `bootFlexclust(x, k, nboot=100)`: Performs bootstrap resampling to assess cluster stability.
- `randIndex(x, y)`: Computes the (Adjusted) Rand Index to compare two partitionings.

## Workflows

### Basic K-Centroids Workflow
```R
library(flexclust)
data("iris")
x <- iris[,1:4]

# Fit k-medians (Manhattan distance)
cl1 <- kcca(x, k=3, family=kccaFamily("kmedians"))

# Summary and cluster assignments
summary(cl1)
clusters <- clusters(cl1)

# Predict on new data
new_data <- x[1:5, ] + 0.1
predict(cl1, newdata=new_data)
```

### Visualizing Clusters
- `barchart(cl1)`: Shows the variables' influence on each cluster relative to the global mean.
- `shadow(cl1)`: Creates a shadow plot to visualize cluster separation.
- `image(cl1)`: Displays a neighborhood graph showing distances between clusters.
- `plot(cl1, data=x)`: Standard scatterplot with cluster hulls (if 2D).

### Stability Analysis
```R
# Assess stability for k=2 to k=5
bf <- bootFlexclust(x, k=2:5, nboot=50)
plot(bf) # Look for the k with the highest/most stable Rand Index
```

## Tips
- **Distance Measures**: Use `distEx(x, y, method)` for additional distance measures like "tanimoto" or "cosine".
- **Model Selection**: Use `stepFlexclust` to run `kcca` multiple times with different seeds and select the best result based on within-cluster sum of squares.
- **Conversion**: Use `as.kcca(object)` to convert objects from `kmeans` (stats) or `pam` (cluster) into `kcca` objects to use `flexclust` visualization tools.

## Reference documentation
- [flexclust: Flexible Cluster Algorithms](./references/home_page.md)