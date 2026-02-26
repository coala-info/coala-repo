---
name: bioconductor-ccfindr
description: bioconductor-ccfindr performs single-cell RNA-seq data analysis using Non-negative Matrix Factorization to identify cell clusters and gene signatures. Use when user asks to decompose count matrices, determine the optimal number of clusters using Variational Bayesian inference, or visualize cell-gene relationships through heatmaps and trees.
homepage: https://bioconductor.org/packages/release/bioc/html/ccfindR.html
---


# bioconductor-ccfindr

## Overview

The `ccfindR` package is designed for the analysis of single-cell RNA-seq (scRNA-seq) data, particularly UMI count data. It utilizes Non-negative Matrix Factorization (NMF) to decompose a gene-by-cell count matrix into basis (meta-genes) and coefficient (cell weights) matrices. Its primary strength is a Variational Bayesian inference framework that provides a statistically rigorous method for determining the optimal number of clusters (rank).

## Core Workflow

### 1. Data Initialization
The package uses the `scNMFSet` class, which extends `SingleCellExperiment`.

```r
library(ccfindR)

# From a matrix
sc <- scNMFSet(count = count_matrix)

# From 10x Genomics output directory
sc <- read_10x(dir = "path/to/data", count = 'matrix.mtx', genes = 'genes.tsv', barcodes = 'barcodes.tsv')
```

### 2. Quality Control and Filtering
Filtering is performed on both cells (UMI counts) and genes (variance-to-mean ratio).

```r
# Filter cells by UMI range
sc <- filter_cells(sc, umi.min = 10^2.6, umi.max = 10^3.4)

# Filter genes by VMR and expression frequency
# rescue.genes = TRUE identifies genes with non-trivial count distributions (modes)
sc <- filter_genes(sc, vmr.min = 1.5, min.cells.expressed = 50, rescue.genes = TRUE)
```

### 3. Factorization and Rank Determination
You can use either Maximum Likelihood (ML) or Variational Bayesian (VB) NMF. VB is preferred for rank selection.

**Maximum Likelihood NMF:**
```r
# Run for a range of ranks to evaluate quality measures (dispersion, cophenetic)
sc <- factorize(sc, ranks = seq(3, 7), nrun = 5)
plot(sc) # Visualize quality measures
```

**Variational Bayesian NMF:**
```r
# VB provides "evidence" (log marginal likelihood) to find the optimal rank
sb <- vb_factorize(sc, ranks = seq(2, 7), nrun = 5, Tol = 1e-4)
plot(sb) # Visualize log ML vs rank

# Identify the optimal rank
opt <- optimal_rank(sb)
print(opt$ropt)
```

### 4. Visualization and Interpretation
Once the optimal rank is determined, visualize the results.

```r
# Heatmap of basis matrix (meta-genes)
feature_map(sb, rank = 5, max.per.cluster = 4)

# Heatmap of coefficient matrix (cell assignments)
cell_map(sb, rank = 5)

# t-SNE visualization of clusters
visualize_clusters(sb, rank = 5)
```

### 5. Hierarchical Relationships
Construct a tree to see how clusters relate across different rank resolutions.

```r
tree <- build_tree(sb, rmax = 5)
plot_tree(tree)
```

## Key Functions

- `scNMFSet()`: Constructor for the main data object.
- `filter_cells()` / `filter_genes()`: QC functions with built-in plotting.
- `factorize()`: Standard NMF using iterative updates.
- `vb_factorize()`: Bayesian NMF for robust model selection.
- `optimal_rank()`: Extracts the suggested rank from VB results.
- `feature_map()`: Displays top genes associated with each NMF cluster.
- `visualize_clusters()`: Dimensionality reduction (t-SNE) based on NMF coefficients.

## Reference documentation
- [ccfindR](./references/ccfindR.md)