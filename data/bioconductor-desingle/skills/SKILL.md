---
name: bioconductor-desingle
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DEsingle.html
---

# bioconductor-desingle

name: bioconductor-desingle
description: Comprehensive differential expression analysis for single-cell RNA-seq data using the DEsingle R package. Use when Claude needs to: (1) Detect differentially expressed genes between two cell groups in scRNA-seq data, (2) Classify DE genes into three types (DEs, DEa, DEg) based on zero-inflation and abundance, (3) Process raw read counts or SingleCellExperiment objects, or (4) Perform parallelized DE analysis on large scRNA-seq datasets.

# bioconductor-desingle

## Overview

**DEsingle** is a Bioconductor package for differential expression (DE) analysis of single-cell RNA-seq (scRNA-seq) data. It utilizes a Zero-Inflated Negative Binomial (ZINB) model to distinguish between "real" zeros (biological non-expression) and "dropout" zeros (technical artifacts). This approach allows the package to not only identify DE genes with high accuracy but also classify them into three distinct regulatory types based on expression status and abundance.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DEsingle")
```

## Core Workflow

### 1. Prepare Input Data
DEsingle requires two primary inputs:
- **counts**: A raw read counts matrix (genes as rows, cells as columns) or a `SingleCellExperiment` object.
- **group**: A factor vector specifying the two groups to be compared, corresponding to the columns in the counts matrix.

### 2. Run Differential Expression Analysis
The `DEsingle` function performs the core statistical testing.

```r
library(DEsingle)

# Using a counts matrix
results <- DEsingle(counts = counts_matrix, group = group_factor)

# Using a SingleCellExperiment object
results <- DEsingle(counts = sce_object, group = group_factor)
```

### 3. Classify DE Types
Use `DEtype` to categorize the results. This function calculates the specific type of differential expression for each gene.

```r
# threshold specifies the FDR limit for classification
results.classified <- DEtype(results = results, threshold = 0.05)
```

### 4. Filter and Extract Results
Filter the output to identify significant genes and separate them by type.

```r
# Extract significant DE genes (FDR < 0.05)
results.sig <- results.classified[results.classified$pvalue.adj.FDR < 0.05, ]

# Separate by type
results.DEs <- results.sig[results.sig$Type == "DEs", ] # Status
results.DEa <- results.sig[results.sig$Type == "DEa", ] # Abundance
results.DEg <- results.sig[results.sig$Type == "DEg", ] # General
```

## Interpreting DE Types

DEsingle classifies genes into three categories:
- **DEs (Differential Expression Status)**: Genes showing a significant difference in the proportion of "real" zeros between groups, but no significant difference in expression levels in the remaining cells.
- **DEa (Differential Expression Abundance)**: Genes showing significant differences in expression levels between groups without a significant difference in the proportion of real zeros.
- **DEg (General Differential Expression)**: Genes showing significant differences in both the proportion of real zeros and the expression abundance.

## Parallelization

For large datasets, enable parallel computing using the `BiocParallel` framework.

```r
# Simple parallelization
results <- DEsingle(counts = counts, group = group, parallel = TRUE)

# Advanced configuration (e.g., Multicore for Unix/Mac)
library(BiocParallel)
param <- MulticoreParam(workers = 4, progressbar = TRUE)
results <- DEsingle(counts = counts, group = group, parallel = TRUE, BPPARAM = param)
```

## Tips and Best Practices
- **Input Scale**: Always use **raw read counts**. Do not use normalized or log-transformed data as input, as the ZINB model is designed for count data.
- **Normalization**: While the input is raw counts, DEsingle performs internal normalization. The output includes `norm_foldChange` for interpretation.
- **Memory**: Parallelization increases memory usage. Ensure the system has sufficient RAM for the number of workers specified.
- **Visualization**: Use standard R visualization tools like `heatmap()` or `ggplot2` on the filtered `results.sig` matrix to visualize expression patterns.

## Reference documentation

- [DEsingle](./references/DEsingle.md)