---
name: r-fnn
description: R package fnn (documentation from project home).
homepage: https://cran.r-project.org/web/packages/fnn/index.html
---

# r-fnn

## Overview
The `fnn` package provides fast implementations of k-nearest neighbor (KNN) algorithms. It is significantly faster than the standard `class::knn` implementation, especially for large datasets, by utilizing specialized data structures like KD-trees and Cover-trees.

## Installation
```R
install.packages("FNN")
```

## Core Functions

### Nearest Neighbor Search
- `get.knn(data, k=1, algorithm=c("kd_tree", "cover_tree", "brute"))`: Finds the k-nearest neighbors for each point in a single dataset.
- `get.knnx(data, query, k=1, ...)`: Finds the k-nearest neighbors in `data` for each point in a separate `query` dataset.

### Classification and Regression
- `knn(train, test, cl, k=1, prob=FALSE, algorithm="kd_tree")`: KNN classification. Returns factor levels of the nearest neighbors.
- `knn.reg(train, test, y, k=3, algorithm="kd_tree")`: KNN regression. Returns predicted continuous values.
- `knn.cv(train, cl, k=1, ...)`: Leave-one-out cross-validation for KNN classification.

### Information Measures
- `entropy(data, k=10, ...)`: Shannon entropy estimation based on the k-nearest neighbor distances.
- `mutinfo(X, Y, k=10, ...)`: Mutual information estimation between two variables.
- `KL.dist(X, Y, k=10, ...)`: Kullback-Leibler divergence estimation.

## Workflows

### Fast KNN Classification
```R
library(FNN)
# Split data
train_idx <- sample(1:nrow(iris), 100)
train <- iris[train_idx, 1:4]
test <- iris[-train_idx, 1:4]
cl <- iris$Species[train_idx]

# Predict
preds <- knn(train = train, test = test, cl = cl, k = 3)
table(preds, iris$Species[-train_idx])
```

### Finding Neighbors for New Data
```R
# Find indices and distances of 5 nearest neighbors in 'train' for each point in 'test'
nn_results <- get.knnx(train, test, k = 5)

# Access results
neighbor_indices <- nn_results$nn.index
neighbor_dists <- nn_results$nn.dist
```

## Tips
- **Algorithm Selection**: `kd_tree` is generally fast for low-dimensional data (d < 20). `cover_tree` is often more efficient for higher-dimensional data.
- **Scaling**: Like all KNN methods, `fnn` is sensitive to the scale of features. Always scale your data (e.g., using `scale()`) before processing if features have different units.
- **Memory**: While fast, building trees for extremely large datasets can be memory-intensive.

## Reference documentation
- [FNN: Fast Nearest Neighbor Search Algorithms and Applications](./references/home_page.md)