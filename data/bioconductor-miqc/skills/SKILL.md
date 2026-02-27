---
name: bioconductor-miqc
description: This tool performs probabilistic quality control for single-cell RNA-seq data by jointly modeling mitochondrial read fractions and detected gene counts. Use when user asks to identify compromised cells, filter low-quality single-cell data, or fit mixture models for adaptive mitochondrial DNA thresholds.
homepage: https://bioconductor.org/packages/release/bioc/html/miQC.html
---


# bioconductor-miqc

name: bioconductor-miqc
description: Probabilistic quality control (QC) for single-cell RNA-seq data. Use this skill to identify and filter compromised cells by jointly modeling mitochondrial read fractions and the number of detected genes using mixture models. This is particularly useful for datasets (like archived tumor tissues) where fixed mitochondrial thresholds are too stringent or arbitrary.

# bioconductor-miqc

## Overview

The `miQC` package provides an adaptive, probabilistic framework for quality control in single-cell RNA-seq (scRNA-seq). Instead of using a hard cutoff for mitochondrial DNA (mtDNA) percentage, `miQC` jointly models the relationship between the proportion of mtDNA reads and the number of detected genes using a mixture model. This allows for the identification of compromised cells (high mtDNA, low complexity) versus intact cells (which may naturally have higher mtDNA in certain tissues).

## Typical Workflow

### 1. Preprocessing and Metric Calculation
`miQC` works with `SingleCellExperiment` objects and relies on metrics calculated by the `scater` package.

```r
library(miQC)
library(scater)
library(SingleCellExperiment)

# 1. Identify mitochondrial genes (example for HGNC symbols)
mt_genes <- grepl("^mt-", rownames(sce), ignore.case = TRUE)

# 2. Calculate QC metrics using scater
sce <- addPerCellQC(sce, subsets = list(mito = mt_genes))

# 3. Visualize the relationship (look for a triangular shape)
plotMetrics(sce)
```

### 2. Fitting the Mixture Model
The `mixtureModel` function fits a model to distinguish between "intact" and "compromised" cell distributions.

```r
# Fit a linear mixture model (default)
model <- mixtureModel(sce)

# View model parameters and posterior probabilities
parameters(model)
head(posterior(model))

# Visualize the fitted model
plotModel(sce, model)
```

### 3. Filtering Cells
After fitting the model, visualize the filtering boundary and apply the filter to the dataset.

```r
# Visualize which cells will be removed at a specific posterior cutoff (default 0.75)
plotFiltering(sce, model, posterior_cutoff = 0.75)

# Apply the filter to the SingleCellExperiment object
sce <- filterCells(sce, model, posterior_cutoff = 0.75)
```

## Advanced Usage and Parameters

### Alternative Model Types
If the relationship between gene count and mtDNA is non-linear, use different `model_type` arguments:
*   `model_type = "spline"`: Uses b-splines.
*   `model_type = "polynomial"`: Uses polynomial regression.
*   `model_type = "one_dimensional"`: Uses only mitochondrial percentage (1D Gaussian mixture model). Use `get1DCutoff(sce, model)` to find the resulting threshold.

### Handling Edge Cases
In complex datasets (e.g., cancer), the model might behave unexpectedly at the extremes. Use these parameters in `plotFiltering` and `filterCells`:
*   `keep_all_below_boundary = TRUE`: (Default) Ensures cells with very low mtDNA are not discarded just because they are near the "compromised" line intercept.
*   `enforce_left_cutoff = TRUE`: Prevents a "U-shaped" boundary by creating a de facto mtDNA cutoff for cells with low library complexity.

## When Not to Use miQC
`miQC` assumes a non-trivial number of compromised cells exist in the dataset. If `plotMetrics` shows a single uniform cloud of cells rather than a distribution with a high-mtDNA "tail," a mixture model may not be appropriate. The `mixtureModel` function will typically throw a warning if only one distribution is found.

## Reference documentation

- [An introduction to miQC](./references/miQC.Rmd)
- [An introduction to miQC (Markdown)](./references/miQC.md)