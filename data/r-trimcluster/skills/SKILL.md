---
name: r-trimcluster
description: The r-trimcluster package performs robust k-means clustering by trimming a specified proportion of outlying data points. Use when user asks to perform trimmed k-means clustering, exclude outliers from cluster center calculations, or identify anomalies in a dataset using robust clustering methods.
homepage: https://cloud.r-project.org/web/packages/trimcluster/index.html
---


# r-trimcluster

## Overview
The `trimcluster` package implements trimmed k-means clustering. This robust clustering method, based on the work of Cuesta-Albertos, Gordaliza, and Matran, allows for a pre-specified fraction of the data (the most extreme outliers) to be excluded from the calculation of cluster centers. This ensures that the resulting cluster centers are representative of the underlying dense structures rather than being pulled toward noise or anomalies.

## Installation
To install the package from CRAN:
```R
install.packages("trimcluster")
```

## Main Functions and Workflows

### Trimmed K-Means with `trimkmeans`
The primary function is `trimkmeans()`. It follows a similar interface to the standard `kmeans()` function but includes a `trim` parameter.

**Basic Syntax:**
```R
library(trimcluster)
result <- trimkmeans(data, k = 3, trim = 0.1, runs = 100, iter.max = 100)
```

**Key Arguments:**
- `data`: A numeric matrix or data frame of observations.
- `k`: The number of clusters to find.
- `trim`: The proportion of points to be trimmed (0 to 1). For example, `0.1` trims the 10% most outlying points.
- `runs`: Number of random initializations (recommended to use > 1 to avoid local optima).
- `iter.max`: Maximum number of iterations for the algorithm.
- `scaled`: Logical. If `TRUE`, variables are scaled to unit variance before clustering.

### Understanding the Output
The `trimkmeans` object contains:
- `classification`: A vector of integers indicating the cluster assignment. **Note:** Trimmed points are assigned the value `k + 1`.
- `means`: A matrix of cluster centers (excluding trimmed points).
- `disttotrim`: The distance of each point to its closest cluster center.
- `ropt`: The sum of squared distances for the non-trimmed points.

### Workflow Example
```R
# Generate synthetic data with outliers
set.seed(123)
x <- rbind(matrix(rnorm(100, sd = 0.3), ncol = 2),
           matrix(rnorm(100, mean = 2, sd = 0.3), ncol = 2),
           matrix(runif(20, min = -5, max = 5), ncol = 2)) # Outliers

# Apply trimmed k-means (trimming 10% of data)
tk_res <- trimkmeans(x, k = 2, trim = 0.1)

# Plotting results
# Points in cluster k+1 are the trimmed outliers
plot(x, col = tk_res$classification, main = "Trimmed K-Means Clustering")
points(tk_res$means, pch = 8, cex = 2, col = 1:2)
```

## Tips for Usage
1. **Choosing the Trim Level**: The `trim` parameter is often chosen based on domain knowledge of expected noise. If unknown, you can monitor how the objective function (`ropt`) changes across different trim values.
2. **Initialization**: Like standard k-means, this algorithm is sensitive to initial starting points. Always use multiple `runs` (e.g., 20-100) to ensure a stable solution.
3. **Scaling**: If your variables are on different scales, set `scaled = TRUE` to prevent variables with large magnitudes from dominating the distance calculations.
4. **Comparison**: Compare results with standard `kmeans(data, k)` to see how much the outliers were influencing the original cluster centers.

## Reference documentation
- [Home of Christian Hennig](./references/home_page.md)