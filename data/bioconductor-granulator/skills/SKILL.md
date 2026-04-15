---
name: bioconductor-granulator
description: The granulator package provides a unified interface for estimating cell type abundances from bulk transcriptomics data using multiple deconvolution algorithms and signature matrices. Use when user asks to estimate cell type proportions, benchmark deconvolution methods, or compare results across different reference profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/granulator.html
---

# bioconductor-granulator

## Overview

The `granulator` package provides a unified interface for estimating cell type abundances from bulk transcriptomics data. It allows users to run several state-of-the-art deconvolution algorithms in parallel using one or more signature matrices (reference profiles). It is particularly useful for benchmarking different methods and signatures to find the most stable and accurate cell type estimates for a given dataset.

## Core Workflow

### 1. Data Preparation
Deconvolution requires two main inputs: a bulk expression matrix and a signature matrix (reference profile). Both should be normalized (e.g., TPM).

```r
library(granulator)

# Load example PBMC data
load_ABIS()

# bulkRNAseq_ABIS: Gene x Sample matrix (TPM)
# sigMatrix_ABIS_S0: Gene x CellType matrix (TPM)
```

### 2. Running Deconvolution
The `deconvolute()` function is the primary entry point. It can handle multiple signature matrices and multiple methods at once.

```r
# Define signatures to test
sigList <- list(
  S0 = sigMatrix_ABIS_S0,
  S1 = sigMatrix_ABIS_S1
)

# Run deconvolution (defaults to all available methods)
# Methods include: 'ols', 'nnls', 'qprogwc', 'qprog', 'rls', 'svr', 'dtangle'
decon <- deconvolute(m = bulkRNAseq_ABIS, sigMatrix = sigList, methods = c('nnls', 'svr'))

# Access results
# Proportions are in percentages
head(decon$proportions$svr_S0)
```

### 3. Benchmarking (Optional)
If ground truth proportions (e.g., from FACS) are available, use `benchmark()` to calculate performance metrics like Pearson Correlation Coefficient (pcc) and Root Mean Square Error (rmse).

```r
# groundTruth_ABIS: Sample x CellType matrix
bench <- benchmark(deconvoluted = decon, ground_truth = groundTruth_ABIS)

# View summary metrics
print(bench$summary)
print(bench$rank)
```

### 4. Correlation Analysis
When ground truth is unavailable, use `correlate()` to see how well different deconvolution methods agree with each other.

```r
correl <- correlate(deconvoluted = decon)
# View average correlation across methods by cell type
head(correl$summary)
```

## Visualization Functions

`granulator` provides several plotting functions to inspect signatures and results:

*   `plot_similarity(sigMatrix = sigList)`: Visualizes the similarity between cell types in the reference profiles.
*   `plot_proportions(deconvoluted = decon, method = 'svr', signature = 'S0')`: Bar plot of estimated cell type percentages per sample.
*   `plot_deconvolute(deconvoluted = decon, scale = TRUE)`: Heatmap comparing results across methods and cell types.
*   `plot_regress(benchmarked = bench, method = 'svr', signature = 'S0')`: Scatter plots of estimated vs. measured proportions.
*   `plot_benchmark(benchmarked = bench, metric = 'pcc')`: Heatmap of performance metrics across methods and signatures.
*   `plot_correlate(correlated = correl, method = "heatmap")`: Heatmap showing collinearity between different deconvolution models.

## Tips for Success

*   **Normalization**: Ensure both bulk and signature data are on the same scale (TPM is recommended). Use `get_TPM()` if starting from raw counts.
*   **Signature Resolution**: Deconvolution performance often improves when collapsing highly similar cell types (e.g., grouping T-cell subsets) into broader categories.
*   **Condition Number**: A low condition number for a signature matrix indicates a more stable deconvolution.
*   **Negative Values**: While some methods allow small negative coefficients, large negative values usually indicate a poor fit between the bulk data and the reference signature.

## Reference documentation

- [Deconvolution of bulk RNA-seq data with granulator](./references/granulator.Rmd)