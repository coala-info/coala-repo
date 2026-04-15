---
name: bioconductor-screcover
description: scRecover imputes dropout values in single-cell RNA-seq data by distinguishing between technical noise and biological zeros using a Zero-Inflated Negative Binomial model. Use when user asks to impute missing values in scRNA-seq counts, estimate the number of dropout genes, or improve cell clustering and visualization by recovering expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/scRecover.html
---

# bioconductor-screcover

## Overview

`scRecover` is a Bioconductor package designed to address the "dropout" phenomenon in single-cell RNA-seq data. Unlike standard imputation methods that may smooth over all zeros, `scRecover` distinguishes between "dropout zeros" (technical noise) and "real zeros" (biological absence) using a Zero-Inflated Negative Binomial (ZINB) model and accumulation curves. It is often used in combination with other methods like scImpute, SAVER, or MAGIC to enhance their accuracy and improve downstream analysis such as t-SNE visualization and cell clustering.

## Core Workflow

### 1. Data Preparation
The package accepts either a raw read counts matrix (genes as rows, cells as columns) or a `SingleCellExperiment` object.

```r
library(scRecover)
library(SingleCellExperiment)

# Load example data
data(scRecoverTest)

# Option A: Use raw matrix 'counts'
# Option B: Use SingleCellExperiment
sce <- SingleCellExperiment(assays = list(counts = as.matrix(counts)))
```

### 2. Running Imputation
The primary function is `scRecover()`. It requires either `Kcluster` (estimated number of cell types) or `labels` (known cell type assignments).

```r
# Imputation with Kcluster (number of subpopulations)
scRecover(counts = counts, 
          Kcluster = 2, 
          outputDir = "./output_folder/", 
          parallel = TRUE)

# Imputation with known labels
scRecover(counts = sce, 
          labels = labels, 
          outputDir = "./output_folder/")
```

### 3. Estimating Dropout Numbers
You can estimate the number of dropout genes in a specific cell using `estDropoutNum()`. This is useful for quality control and understanding the extent of technical noise.

```r
# sample: a vector of raw counts for one cell
# depth: the relative sequencing depth (e.g., 10 if the sample is 10% of total)
dropout_est <- estDropoutNum(sample = oneCell, depth = 1, return = "dropoutNum")
```

## Parallel Computing
`scRecover` uses `BiocParallel` for acceleration. By default, `parallel = TRUE` uses the system's default back-end.

*   **Unix/Mac:** Uses `MulticoreParam`.
*   **Windows:** Uses `SnowParam`.

```r
library(BiocParallel)
# Custom configuration for Windows
param <- SnowParam(workers = 4, type = "SOCK")
scRecover(counts = counts, Kcluster = 2, parallel = TRUE, BPPARAM = param)
```

## Key Functions and Parameters
*   `scRecover()`: Main interface for imputation.
    *   `counts`: Matrix or SingleCellExperiment.
    *   `Kcluster`: Integer, number of cell clusters.
    *   `labels`: Vector, cell type labels (alternative to Kcluster).
    *   `outputDir`: Path to save results.
*   `estDropoutNum()`: Predicts the number of expressed genes or dropout genes.
*   `countsSampling()`: Downsamples a count vector (useful for testing/validation).

## Tips for Success
*   **Input Type:** Ensure the input is **raw read counts**, not normalized or log-transformed data.
*   **Cell Labels:** If cell types are known, providing `labels` is generally more accurate than letting the tool estimate clusters via `Kcluster`.
*   **Output:** The function writes files to the disk. Check the `outputDir` for the final imputed matrix.
*   **Memory:** For very large datasets, ensure you have sufficient RAM when using high `workers` counts in parallel mode.

## Reference documentation
- [scRecover Vignette (Rmd)](./references/scRecover.Rmd)
- [scRecover Vignette (Markdown)](./references/scRecover.md)