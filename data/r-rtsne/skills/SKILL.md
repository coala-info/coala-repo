---
name: r-rtsne
description: The Rtsne package provides an R wrapper for the Barnes-Hut implementation of t-SNE to perform fast dimensionality reduction on large datasets. Use when user asks to visualize high-dimensional data, perform t-SNE analysis, or create low-dimensional embeddings for biological and numerical datasets.
homepage: https://cloud.r-project.org/web/packages/Rtsne/index.html
---


# r-rtsne

## Overview
The `Rtsne` package provides an R wrapper for the Barnes-Hut implementation of t-SNE. It is significantly faster than the standard t-SNE algorithm for large datasets, making it the industry standard for visualizing high-dimensional biological or numerical data (e.g., single-cell RNA-seq or iris-like datasets).

## Installation
```r
install.packages("Rtsne")
```

## Core Workflow
The primary function is `Rtsne()`. It expects a numeric matrix as input.

### Basic Example
```r
library(Rtsne)

# 1. Prepare data (remove duplicates and non-numeric columns)
data_unique <- unique(iris) 
data_matrix <- as.matrix(data_unique[, 1:4])

# 2. Run t-SNE
set.seed(42) # Essential for reproducibility
tsne_results <- Rtsne(data_matrix, 
                      dims = 2, 
                      perplexity = 30, 
                      verbose = TRUE, 
                      max_iter = 1000)

# 3. Visualize
plot(tsne_results$Y, col = data_unique$Species, pch = 19, main = "t-SNE Plot")
```

## Key Parameters
- `X`: Matrix or data frame (if `is_distance = FALSE`).
- `dims`: Output dimensionality (default is 2).
- `perplexity`: Related to the number of nearest neighbors. Usually between 5 and 50. Must be less than `(nrow(data) - 1) / 3`.
- `theta`: Speed/accuracy trade-off (0.0 is exact t-SNE, 0.5 is standard Barnes-Hut).
- `pca`: Logical; whether to perform an initial PCA step (default is `TRUE`).
- `max_iter`: Number of iterations (default is 1000).
- `check_duplicates`: Logical; `Rtsne` will error if duplicates are present. Set to `FALSE` only if you are certain data is unique.

## Advanced Usage

### Working with Distance Matrices
If you have already calculated a distance matrix (e.g., using `dist()`), set `is_distance = TRUE`.
```r
d <- dist(data_matrix)
tsne_out <- Rtsne(d, is_distance = TRUE)
```

### Partial PCA
For very large datasets, you can suppress the internal PCA and provide your own reduced-dimension matrix to speed up the initial embedding.
```r
tsne_out <- Rtsne(data_matrix, pca = FALSE)
```

## Tips for Success
1. **Duplicates**: `Rtsne` cannot handle duplicate rows. Always run `unique()` on your dataset before processing.
2. **Normalization**: t-SNE is sensitive to scale. Ensure data is centered and scaled (or log-transformed for sequencing data) before running.
3. **Perplexity**: If you get an error regarding perplexity being too large, decrease the `perplexity` value or increase your sample size.
4. **Reproducibility**: Always use `set.seed()` before calling `Rtsne()` because the initial embedding is random.

## Reference documentation
- [Rtsne README](./references/README.md)