---
name: bioconductor-dino
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/Dino.html
---

# bioconductor-dino

## Overview

Dino (Distributional Normalization) is an R package designed to normalize high-throughput scRNA-seq data, particularly from UMI-based protocols like 10x Genomics. It addresses technical variability in sequencing depth by modeling gene expression as a mixture of Negative Binomial distributions. Unlike simple scaling, Dino reconstructs full gene-specific expression distributions, making it robust to cellular heterogeneity and the high sparsity (zeros) typical of modern single-cell datasets.

## Installation

Install the package via Bioconductor:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Dino")
```

## Core Workflow

### 1. Data Preparation
Dino accepts sparse or dense matrices with genes in rows and cells in columns. It is highly recommended to filter out lowly expressed genes before normalization.

```r
library(Dino)
# Example: Filter genes with fewer than 20 non-zero samples
counts <- counts[rowSums(counts != 0) >= 20, ]
```

### 2. Basic Normalization
The primary function `Dino` returns a sparse matrix of normalized expression values.

```r
# Standard normalization
norm_mat <- Dino(counts)

# Parallel processing (nCores = 0 uses all available cores)
norm_mat <- Dino(counts, nCores = 4)
```

### 3. Integration with Seurat
Use `SeuratFromDino` to streamline the creation of Seurat objects.

```r
# Create Seurat object directly from raw UMI counts
seurat_obj <- SeuratFromDino(counts)

# Create Seurat object from a previously normalized Dino matrix
# Set doNorm = FALSE to prevent re-normalization
seurat_obj <- SeuratFromDino(norm_mat, doNorm = FALSE)
```

### 4. Integration with SingleCellExperiment
Use `Dino_SCE` for objects following the Bioconductor SingleCellExperiment standard.

```r
library(SingleCellExperiment)
sce <- SingleCellExperiment(assays = list("counts" = counts))

# Normalize and store in normcounts assay
sce <- Dino_SCE(sce)
```

## Advanced Usage

### Custom Sequencing Depth
By default, Dino calculates depth as the column sums scaled to a median of 1. You can provide custom depth factors (e.g., from `scran`).

```r
library(scran)
size_factors <- calculateSumFactors(counts)

# Provide log-transformed custom depths
norm_mat <- Dino(counts, depth = log(size_factors))
```

### Parameter Tuning
- `nCores`: Set to 0 for maximum parallelization.
- `depth`: A vector of cell-specific sequencing depths.
- `subSample`: For very large datasets, Dino can estimate parameters on a subset of cells to increase speed.

## Reference documentation

- [Normalization by distributional resampling of high throughput single-cell RNA-sequencing data](./references/Dino.Rmd)
- [Normalization by distributional resampling of high throughput single-cell RNA-sequencing data](./references/Dino.md)