---
name: bioconductor-tpsvg
description: This tool identifies spatially variable genes in spatially-resolved transcriptomics data using Poisson or Gaussian modeling. Use when user asks to identify genes with spatial expression patterns, model raw counts with a Poisson distribution, or account for biological covariates in spatial transcriptomics analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/tpSVG.html
---

# bioconductor-tpsvg

name: bioconductor-tpsvg
description: Detect spatially variable genes (SVG) in spatially-resolved transcriptomics (SRT) data using the tpSVG R package. Use this skill when analyzing SRT data (e.g., 10x Visium, seqFISH) to identify genes with spatial expression patterns. It is particularly useful for modeling raw counts with a Poisson distribution to avoid the mean-rank bias often found in Gaussian models of log-transformed data.

# bioconductor-tpsvg

## Overview

`tpSVG` is an R package for identifying Spatially Variable Genes (SVG) in spatially-resolved transcriptomics (SRT) datasets. It provides a scalable solution that can model gene expression using either Poisson distributions (for raw counts) or Gaussian distributions (for log-transformed data). A key advantage of `tpSVG` is its ability to account for technical variation via offsets and biological covariates (like tissue anatomy or cell type composition) via design matrices.

## Installation

Install the package from Bioconductor:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("tpSVG")
```

## Core Workflow

### 1. Data Preparation
`tpSVG` typically operates on `SpatialExperiment` (SPE) objects. Ensure your data includes spatial coordinates and a count matrix.

```r
library(tpSVG)
library(SpatialExperiment)
library(scuttle)

# Example: Calculate library size/size factors for the offset
spe$total <- colSums(counts(spe))
# Or use scuttle to get size factors
spe <- logNormCounts(spe)
```

### 2. Modeling Raw Counts (Poisson)
Modeling raw counts is recommended to avoid distorting low-expressed genes. Use the `offset` argument to account for technical variation (library size).

```r
spe_poisson <- tpSVG(
  input = spe,
  family = poisson(),
  assay_name = "counts",
  offset = log(spe$total) # Use natural log of library size
)
```

### 3. Modeling Log-transformed Data (Gaussian)
If working with normalized, log-transformed data, use the Gaussian family.

```r
spe_gauss <- tpSVG(
  input = spe,
  family = gaussian(),
  assay_name = "logcounts",
  offset = NULL
)
```

### 4. Covariate-adjusted Modeling
To find spatial variation that exists *beyond* known biological structures (e.g., tissue layers), provide a covariate matrix or vector to the `X` argument.

```r
# Ensure no missing values in the covariate
spe <- spe[, !is.na(spe$ground_truth)]

spe_cov <- tpSVG(
  input = spe,
  X = spe$ground_truth,
  family = poisson(),
  assay_name = "counts",
  offset = log(spe$total)
)
```

## Function Reference: `tpSVG()`

The primary function for SVG detection.

- `input`: A `SpatialExperiment` object or a gene expression matrix.
- `family`: The distribution family (e.g., `poisson()`, `gaussian()`).
- `assay_name`: The name of the assay in the SPE object to use (e.g., "counts", "logcounts").
- `offset`: A numeric vector used as an offset in the model (essential for Poisson models to account for library size).
- `X`: A vector or matrix of covariates for adjustment.
- `...`: Additional arguments passed to the underlying modeling functions.

## Interpreting Results

The results are stored in the `rowData` of the returned `SpatialExperiment` object. Key columns include:

- `test_stat`: The calculated test statistic for spatial variability.
- `raw_p`: The raw p-value.
- `runtime`: Time taken to process the specific gene.

To identify top SVGs, rank genes by their test statistic or p-value:

```r
results <- as.data.frame(rowData(spe_poisson))
top_genes <- results[order(results$raw_p), ]
head(top_genes)
```

## Tips for Performance
- **Gene Filtering**: For large datasets, filter out lowly expressed genes before running `tpSVG` to reduce computation time.
- **Parallelization**: `tpSVG` is designed to be scalable, but for very large image-based SRT data (e.g., seqFISH with >10k cells), consider processing genes in batches if memory is limited.

## Reference documentation
- [Introduction to tpSVG](./references/intro_to_tpSVG.md)