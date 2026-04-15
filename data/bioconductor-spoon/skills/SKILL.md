---
name: bioconductor-spoon
description: The spoon package mitigates the mean-variance technical bias in spatial transcriptomics data by generating weights for spatially variable gene detection. Use when user asks to estimate mean-variance relationships in SRT data, generate weights for Gaussian Process Regression, or run weighted nnSVG to identify spatially variable genes.
homepage: https://bioconductor.org/packages/release/bioc/html/spoon.html
---

# bioconductor-spoon

## Overview

The `spoon` package provides a method to mitigate the "mean-variance relationship" technical bias in spatial transcriptomics. In SRT data, gene-level variance is often correlated with mean expression, which can confound the ranking of spatially variable genes (SVGs). `spoon` fits a spline curve to estimate this relationship and generates weights that can be used in Gaussian Process Regression models (like `nnSVG`) to produce a more informative and less biased set of SVGs.

## Installation

Install the package via Bioconductor:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("spoon")
```

## Typical Workflow

The standard workflow involves preprocessing a `SpatialExperiment` object, generating weights, and then running a weighted SVG detection algorithm.

### 1. Data Preparation
`spoon` works best with `SpatialExperiment` objects. Ensure your data is filtered and normalized (logcounts) before processing.

```r
library(spoon)
library(SpatialExperiment)
library(scuttle)

# Example: Filter genes and calculate logcounts
spe <- filter_genes(spe)
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)

# Ensure spots with zero counts are removed to avoid errors in weight generation
spe <- spe[, colSums(logcounts(spe)) > 0]
```

### 2. Generate Weights
The `generate_weights` function estimates the mean-variance relationship and produces a weight matrix.

```r
# stabilize = TRUE is recommended to handle extreme values
weights <- generate_weights(input = spe,
                            stabilize = TRUE,
                            BPPARAM = BiocParallel::MulticoreParam(workers = 1))
```

### 3. Weighted SVG Detection
You can use the built-in wrapper for `nnSVG` or manually apply weights to other tools.

**Using the built-in weighted nnSVG:**
```r
spe <- weighted_nnSVG(input = spe,
                      w = weights,
                      BPPARAM = BiocParallel::MulticoreParam(workers = 1))

# Results are stored in rowData
rowData(spe)
```

**Using weights with other SVG tools:**
If a tool does not natively support weights, rescale the logcounts matrix manually:
```r
assay_name <- "logcounts"
# Apply weights to the expression matrix
weighted_logcounts <- t(weights) * assays(spe)[[assay_name]]
assay(spe, "weighted_logcounts") <- weighted_logcounts

# Use 'weighted_logcounts' as input for your preferred SVG detection tool
```

## Key Functions

- `generate_weights()`: Calculates individual observation weights based on the mean-variance relationship.
- `weighted_nnSVG()`: A specialized implementation of the `nnSVG` algorithm that incorporates `spoon` weights to identify SVGs.
- `filter_genes()`: Utility to remove mitochondrial genes and low-expressed genes (essential for stable model fitting).

## Tips for Success

- **Filtering**: Always filter out low-quality genes and spots with zero total counts before running `generate_weights()`. Zeros can cause warnings or errors during the spline fitting process.
- **Parallelization**: Weight generation and SVG detection are computationally intensive. Use the `BPPARAM` argument to utilize multiple cores via the `BiocParallel` package.
- **Interpretation**: The `weighted_rank` in the output `rowData` provides the prioritized list of genes after accounting for the mean-variance bias.

## Reference documentation

- [spoon Tutorial](./references/spoon.Rmd)
- [spoon Tutorial (Markdown)](./references/spoon.md)