---
name: bioconductor-mbkmeans
description: The mbkmeans package implements a memory-efficient mini-batch k-means algorithm for clustering large-scale genomic data, specifically optimized for single-cell RNA-sequencing datasets. Use when user asks to perform fast clustering on large datasets, run k-means on SingleCellExperiment objects, or use on-disk data representations to minimize memory overhead.
homepage: https://bioconductor.org/packages/release/bioc/html/mbkmeans.html
---


# bioconductor-mbkmeans

## Overview

The `mbkmeans` package implements the mini-batch k-means algorithm for large-scale data, with a specific focus on single-cell RNA-sequencing (scRNA-seq). Unlike standard k-means, this algorithm uses small, random subsamples ("mini-batches") in each iteration, significantly reducing memory overhead and increasing speed without substantial loss in accuracy. It is designed to interface seamlessly with `DelayedArray` and `HDF5Array`, allowing for "on-disk" computations where data is only loaded into memory as needed.

## Main Functions

- `mbkmeans()`: The primary S4 generic function for performing mini-batch k-means.
- `blocksize()`: Helper to determine an optimal `batch_size` based on available system RAM.
- `mini_batch()`: A lower-level function (observations in rows) intended as a replacement for `ClusterR::MiniBatchKmeans`.

## Typical Workflow

### 1. Data Preparation
`mbkmeans` expects genomic data orientation (genes in rows, cells in columns) for `SummarizedExperiment` or `SingleCellExperiment` objects.

```r
library(mbkmeans)
library(SingleCellExperiment)

# Example: Using a SingleCellExperiment object 'sce'
# Ensure data is normalized (e.g., logcounts)
```

### 2. Determining Batch Size
For large datasets, use `blocksize()` to calculate a batch size that fits your available memory.

```r
# Calculate reasonable batch size for the current machine
b_size <- blocksize(sce)
```

### 3. Running Clustering
You can run clustering on specific assays or reduced dimensions (like PCA).

```r
# Clustering on PCA results (default for SCE objects)
res <- mbkmeans(sce, clusters = 10, reduceMethod = "PCA")

# Clustering on a specific assay (e.g., logcounts)
res <- mbkmeans(sce, clusters = 5, reduceMethod = NA, whichAssay = "logcounts")

# Access results
clusters <- res$Clusters
centroids <- res$centroids
```

### 4. Selecting k (Elbow Method)
Because `mbkmeans` is fast, you can iterate over multiple values of $k$ to find the inflection point of the Within-Cluster Sum of Squares (WCSS).

```r
ks <- 5:15
results <- lapply(ks, function(k) {
    mbkmeans(sce, clusters = k, reduceMethod = "PCA", calc_wcss = TRUE)
})
wcss <- sapply(results, function(x) sum(x$WCSS_per_cluster))
plot(ks, wcss, type = "b")
```

## Integration with bluster

The `bluster` framework can dispatch to `mbkmeans` using `MbkmeansParam`. Note that `bluster` expects observations in rows, so transpose your matrix if passing a `DelayedMatrix` directly.

```r
library(bluster)
# Using PCA matrix (cells in rows)
mat <- reducedDim(sce, "PCA")
clusterRows(mat, MbkmeansParam(centers = 5, batch_size = 100))
```

## Usage Tips

- **Memory Efficiency**: For massive datasets (e.g., 1 million+ cells), keep `batch_size` between 1,000 and 10,000. Larger batches do not necessarily improve accuracy but will increase memory usage.
- **Initialization**: The default `initializer = "kmeans++"` is generally superior to random initialization.
- **Initialization Fraction**: Avoid setting `init_fraction` too high on large datasets, as the initialization step itself could then exceed memory limits. The default is automatically scaled to the `batch_size`.
- **Classic K-means**: You can recover classic k-means behavior by setting `batch_size` to the total number of columns, `init_fraction = 1`, and `initializer = "random"`.

## Reference documentation

- [An introduction to mbkmeans](./references/Vignette.md)
- [An introduction to mbkmeans (RMarkdown)](./references/Vignette.Rmd)