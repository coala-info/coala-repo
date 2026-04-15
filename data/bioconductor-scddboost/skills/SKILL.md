---
name: bioconductor-scddboost
description: This tool identifies differentially distributed genes across two conditions in single-cell RNA-seq data using a boosting-based approach. Use when user asks to identify genes with complex distributional shifts, calculate posterior probabilities of differential distribution, or detect changes in cell subtype proportions between conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/scDDboost.html
---

# bioconductor-scddboost

name: bioconductor-scddboost
description: Scoring evidence of genes being differentially distributed (DD) across two conditions in single-cell RNA-seq data using a boosting-based approach. Use this skill when analyzing scRNA-seq data to identify genes where the distribution of expression (not just the mean) changes between conditions, particularly when dealing with high zero-inflation and multi-modal distributions.

## Overview

The `scDDboost` package identifies differentially distributed (DD) genes by viewing expression values as samples from a mixture of cellular subtypes. It assumes that distributional changes are driven by shifts in subtype proportions between conditions. This approach is particularly effective for single-cell data where traditional differential expression (DE) methods might miss complex distributional shifts.

## Core Workflow

### 1. Data Preparation
The package typically works with `SingleCellExperiment` objects or matrices of normalized counts.

```r
library(scDDboost)
library(SummarizedExperiment)
library(BiocParallel)

# Load data (example using sim_dat)
data(sim_dat)
data_counts <- assays(sim_dat)$counts
conditions <- colData(sim_dat)$conditions

# Ensure genes have names/IDs
rownames(data_counts) <- seq_len(nrow(data_counts))
```

### 2. Distance Matrix Calculation
A distance matrix of cells is required for the clustering mechanism.

```r
# Set up parallel processing
bp <- MulticoreParam(workers = 2)

# Calculate distance matrix
D_c <- calD(data_counts, bp = bp)
```

### 3. Estimating Posterior Probabilities
The `pdd` function is the core engine that calculates the posterior probability of a gene being DD.

```r
# Calculate probabilities
# D can be a distance matrix or cluster labels
ProbDD <- pdd(data = data_counts, cd = conditions, bp = bp, D = D_c)
```

### 4. Identifying DD Genes
The output of `pdd` represents the local False Discovery Rate (lFDR). You can identify significant genes using a simple threshold or the `getDD` function for FDR control.

```r
# Method 1: Simple threshold (e.g., > 0.95)
significant_genes <- which(ProbDD > 0.95)

# Method 2: Controlled FDR (e.g., 5%)
EDD <- getDD(ProbDD, alpha = 0.05)
```

## Key Functions

- `calD()`: Computes the distance matrix between cells.
- `detK()`: Estimates the optimal number of subtypes (K) based on the distance matrix.
- `pdd()`: Main function to calculate posterior probabilities of differential distribution.
- `getDD()`: Extracts the set of DD genes while controlling for FDR.

## Usage Tips

- **Subtype Estimation**: If you have prior knowledge of the number of cell subtypes, you can specify `K` directly in the `pdd` function. Otherwise, use `detK(D_c)` to estimate it.
- **Cluster Labels**: If you already have cell cluster assignments (e.g., from Seurat or Scran), you can pass these labels to the `D` argument in `pdd` instead of a distance matrix. In this case, set `random = FALSE`.
- **Parallelization**: Always use `BiocParallel` parameters (`bp`) for `calD` and `pdd` to handle large single-cell datasets efficiently.

## Reference documentation

- [scDDboost Tutorial](./references/scDDboost.Rmd)
- [scDDboost Manual](./references/scDDboost.md)