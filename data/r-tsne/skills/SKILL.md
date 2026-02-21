---
name: r-tsne
description: A "pure R" implementation of the t-SNE algorithm.</p>
homepage: https://cloud.r-project.org/web/packages/tsne/index.html
---

# r-tsne

name: r-tsne
description: Use this skill to perform T-Distributed Stochastic Neighbor Embedding (t-SNE) in R using the 'tsne' package. This skill is appropriate for dimensionality reduction, visualizing high-dimensional datasets, and non-linear cluster analysis within an R environment.

# r-tsne

## Overview
The `tsne` package provides a pure R implementation of the t-Distributed Stochastic Neighbor Embedding algorithm. It is used to project high-dimensional data into a low-dimensional space (typically 2D or 3D) while preserving local structures, making it ideal for visualizing clusters in complex datasets.

## Installation
Install the package from CRAN:
```R
install.packages("tsne")
```

## Main Functions
The package primarily revolves around a single function:

- `tsne(X, initial_config = NULL, k = 2, initial_dims = 30, perplexity = 30, max_iter = 1000, min_cost = 0, epoch_callback = NULL, whiten = TRUE, epoch = 100)`
  - `X`: The data matrix or distance object.
  - `k`: The number of dimensions for the resulting embedding (default is 2).
  - `initial_dims`: The number of dimensions to retain in the initial PCA step.
  - `perplexity`: Target neighbor density (usually between 5 and 50).
  - `max_iter`: Maximum number of iterations.
  - `epoch_callback`: A function to be called at each epoch (useful for plotting progress).
  - `whiten`: Boolean indicating whether to perform PCA whitening on the input data.

## Standard Workflow

### 1. Basic 2D Projection
```R
library(tsne)

# Load data (e.g., iris)
data(iris)
x <- as.matrix(iris[,1:4])

# Run t-SNE
set.seed(42) # For reproducibility
tsne_results <- tsne(x, k = 2, perplexity = 30)

# Plot results
plot(tsne_results, col = iris$Species, pch = 19, main = "t-SNE of Iris Dataset")
```

### 2. Using a Callback for Visualization
To monitor the embedding process as it optimizes:
```R
colors <- rainbow(length(unique(iris$Species)))
names(colors) <- unique(iris$Species)

ecb <- function(x, y){
  plot(x, t='n', main="t-SNE Progress")
  text(x, labels=iris$Species, col=colors[iris$Species])
}

tsne_res <- tsne(iris[,1:4], epoch_callback = ecb, epoch = 50)
```

## Tips and Best Practices
- **Data Scaling**: While the package can perform whitening, it is often beneficial to scale your data (`scale(x)`) before passing it to the function if variables are on different scales.
- **Perplexity**: This is the most critical hyperparameter. Larger datasets usually require higher perplexity. If the output looks like a uniform "ball," try decreasing perplexity; if points are too compressed, try increasing it.
- **Computational Cost**: As a "pure R" implementation, this package may be slower on very large datasets (e.g., >10,000 rows) compared to C++ accelerated versions like `Rtsne`.
- **Distance Matrices**: You can pass a distance matrix (created via `dist()`) directly to the `tsne` function instead of a raw data matrix.

## Reference documentation
- [README.md](./references/README.md)