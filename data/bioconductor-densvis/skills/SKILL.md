---
name: bioconductor-densvis
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/densvis.html
---

# bioconductor-densvis

## Overview

The `densvis` package implements density-preserving versions of t-SNE and UMAP. Standard dimensionality reduction techniques often fail to represent the local density of the original high-dimensional space, leading to visualizations where cluster sizes do not reflect their actual data density. `densvis` addresses this by adding a density-preserving term to the optimization objective, ensuring that the "spread" of clusters in the embedding is proportional to their original heterogeneity.

## Typical Workflow

### 1. Load Libraries and Data
Prepare your high-dimensional matrix or data frame. It is recommended to set a seed for reproducibility.

```r
library(densvis)
library(ggplot2)

# Example: matrix with 2000 rows (cells) and 50 columns (features/PCs)
set.seed(42)
data_matrix <- matrix(rnorm(100000), ncol = 50)
```

### 2. Density-Preserving t-SNE (densne)
Use `densne` to generate coordinates that preserve local density.

```r
# Run densne
# dens_frac: fraction of optimization steps considering density (0 to 1)
# dens_lambda: weight of density preservation relative to t-SNE objective
tsne_coords <- densne(data_matrix, 
                      dens_frac = 0.5, 
                      dens_lambda = 0.5,
                      perplexity = 30)

# Visualize
df_tsne <- as.data.frame(tsne_coords)
ggplot(df_tsne, aes(V1, V2)) + geom_point() + labs(title = "densne Embedding")
```

### 3. Density-Preserving UMAP (densmap)
Use `densmap` for a UMAP-based density-preserving embedding. Note: This function utilizes `basilisk` to manage a Python environment for the underlying `densmap-learn` implementation.

```r
# Run densmap
umap_coords <- densmap(data_matrix, 
                       dens_frac = 0.5, 
                       dens_lambda = 0.5,
                       n_neighbors = 15)

# Visualize
df_umap <- as.data.frame(umap_coords)
ggplot(df_umap, aes(V1, V2)) + geom_point() + labs(title = "densmap Embedding")
```

## Key Parameters

*   `dens_frac`: Controls how long the density-preserving term is active during optimization. A value of 0.5 means it is active for the first half of the iterations.
*   `dens_lambda`: Controls the strength of the density preservation. Higher values force the embedding to prioritize original local density more strictly.
*   `n_components`: The dimensionality of the output embedding (default is 2).

## Tips for Success

*   **Comparison**: Always compare `densne`/`densmap` results with standard `Rtsne` or `uwot::umap` to see how density preservation changes the interpretation of cluster sizes.
*   **Input Scaling**: Like standard t-SNE/UMAP, it is often beneficial to run these functions on PCA-reduced data (e.g., the top 30-50 PCs) rather than raw gene expression counts.
*   **Python Environment**: The first time you run `densmap`, `basilisk` will download and configure a Python environment. This may take several minutes.

## Reference documentation

- [Introduction to densvis](./references/densvis.Rmd)
- [Introduction to densvis (Markdown)](./references/densvis.md)