---
name: bioconductor-newwave
description: NewWave performs dimensionality reduction and batch effect removal for large-scale single-cell count data using a Negative Binomial model. Use when user asks to perform batch correction on single-cell datasets, reduce data dimensionality, or account for technical covariates in count matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/NewWave.html
---


# bioconductor-newwave

## Overview

NewWave is a Bioconductor package designed for dimensionality reduction and batch effect removal in count data, specifically optimized for large single-cell datasets. It assumes a Negative Binomial distribution and utilizes a PSOCK cluster with shared memory (via the `SharedObject` package) to minimize memory duplication during parallel processing. It is particularly effective for producing a low-dimensional latent representation of data while accounting for known technical covariates (batches) and biological variables.

## Installation

```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("NewWave")
library(NewWave)
```

## Core Workflow

### 1. Data Preparation
NewWave requires **raw, non-normalized count data**. It typically accepts a `SingleCellExperiment` object or a matrix.

**Important:** Batch variables in `colData` must be converted to factors for proper correction.

```r
# Ensure batch is a factor
sce$Batch <- as.factor(sce$Batch)

# Filter to highly variable genes (HVGs) for speed
# NewWave works best on raw counts of selected features
hvg_indices <- order(rowVars(counts(sce)), decreasing = TRUE)[1:500]
sce_sub <- sce[hvg_indices, ]
```

### 2. Dimensionality Reduction and Batch Correction
The primary function is `newWave()`. You specify the latent space dimension ($K$) and the covariates to adjust for.

```r
# Standard usage: Adjusting for Batch
# X: formula for cell-level covariates (e.g., Batch)
# V: formula for gene-level covariates (optional)
# K: number of latent dimensions
res <- newWave(sce_sub, X = "~Batch", K = 10, verbose = FALSE)
```

### 3. Accessing Results
The function returns a `SingleCellExperiment` object with the latent representation stored in `reducedDim`.

```r
# Extract latent dimensions
latent_space <- reducedDim(res)

# Use for downstream tasks like t-SNE or Clustering
library(Rtsne)
tsne_results <- Rtsne(latent_space)$Y

clusters <- kmeans(latent_space, centers = 10)
```

## Optimization Strategies

NewWave provides several parameters to handle large datasets efficiently:

### Parallelization
Use the `children` parameter to specify the number of cores.
```r
res <- newWave(sce_sub, X = "~Batch", K = 10, children = 4)
```

### Mini-batch Approaches
To speed up convergence on large datasets, use mini-batches (typically 10% of observations).
* `n_gene_disp`: Genes used for dispersion optimization.
* `n_cell_par`: Cells used for cell-related parameter optimization.
* `n_gene_par`: Genes used for gene-related parameter optimization.

```r
# Fast execution with commonwise dispersion
res <- newWave(sce_sub, X = "~Batch", K = 10, children = 2,
               n_gene_disp = 100, n_gene_par = 100, n_cell_par = 100)
```

### Genewise Dispersion
By default, NewWave uses commonwise dispersion. For genewise dispersion (more precise but slower):
```r
res <- newWave(sce_sub, X = "~Batch", K = 10, 
               commondispersion = FALSE,
               n_gene_par = 100, n_cell_par = 100)
# Note: Do NOT use n_gene_disp when commondispersion = FALSE
```

## Tips and Best Practices
- **Memory:** NewWave uses `SharedObject` to avoid memory duplication across cores. This makes it much more memory-efficient than standard `BiocParallel` setups for large matrices.
- **Verbosity:** Set `verbose = FALSE` for production runs, as printing progress can slow down computation on very large datasets.
- **Input:** Always provide raw counts. The Negative Binomial model internally handles the mean-variance relationship inherent in count data.

## Reference documentation
- [Dimensionality reduction and batch effect removal using NewWave](./references/vignette.md)
- [NewWave Rmd Source](./references/vignette.Rmd)