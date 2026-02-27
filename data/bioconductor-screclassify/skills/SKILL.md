---
name: bioconductor-screclassify
description: This tool performs post hoc cell type classification to refine and correct potentially mislabeled cells in single-cell RNA-sequencing data. Use when user asks to refine cell type annotations, identify mislabeled cells using the adaSampling algorithm, or perform semi-supervised reclassification of scRNA-seq datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/scReClassify.html
---


# bioconductor-screclassify

name: bioconductor-screclassify
description: Post hoc cell type classification for single-cell RNA-sequencing (scRNA-seq) data. Use this skill to fine-tune and correct cell type annotations that may contain mislabeled cells using the semi-supervised learning algorithm adaSampling.

# bioconductor-screclassify

## Overview

`scReClassify` is an R package designed to refine cell type annotations in scRNA-seq datasets. It addresses the issue of "noisy" or subjective initial labels by using a semi-supervised learning approach (adaSampling). It is particularly useful after an initial clustering or automated annotation step to identify and correct potentially mislabeled cells based on their gene expression profiles.

## Core Workflow

### 1. Data Preparation
The package works with `SingleCellExperiment` objects or standard matrices. Data should be log-normalized before processing.

```r
library(scReClassify)
library(SingleCellExperiment)

# Load your SingleCellExperiment object
# dat <- your_sce_object
# initial_labels <- colData(dat)$cell_type
```

### 2. Dimension Reduction
Before reclassification, reduce the dimensionality of the data. The `matPCs` function selects the number of principal components required to explain a specific percentage of variance (default is 0.7 or 70%).

```r
# For SingleCellExperiment:
reducedDim(dat, "matPCs") <- matPCs(dat, assay = "logNorm", percent = 0.7)

# For a matrix:
# pcs <- matPCs(matrix_data, percent = 0.7)
```

### 3. Cell Type Reclassification
The primary function is `multiAdaSampling`. It runs the adaSampling algorithm using a base classifier (typically Support Vector Machine) to generate refined labels.

```r
set.seed(1) # For reproducibility
reclass_results <- multiAdaSampling(
  dat, 
  label = initial_labels, 
  reducedDimName = "matPCs", 
  classifier = "svm", 
  percent = 1, 
  L = 10
)

# Extract the refined labels
final_labels <- reclass_results$final
```

### 4. Identifying Mislabeled Cells
Compare the original labels with the reclassified labels to find cells that were likely mislabeled.

```r
# Find indices where labels changed
idx <- which(final_labels != initial_labels)

# View changes
data.frame(
  CellID = colnames(dat)[idx],
  Original = initial_labels[idx],
  Reclassified = final_labels[idx]
)
```

## Key Functions

- `matPCs(data, assay, percent)`: Performs PCA and returns a matrix with the number of PCs explaining the target variance percentage.
- `multiAdaSampling(data, label, reducedDimName, classifier, percent, L)`: The main reclassification engine.
    - `classifier`: Supports "svm" (recommended) or "rf" (Random Forest).
    - `percent`: The proportion of the data to sample.
    - `L`: The number of iterations for the adaSampling process.
- `bAccuracy(truth, predicted)`: Calculates balanced accuracy, useful for benchmarking against known ground truths.

## Tips for Success

- **Input Quality**: Ensure the input `assay` (e.g., "logNorm") is correctly specified when using `SingleCellExperiment`.
- **Stability**: Because the algorithm involves sampling, setting a seed with `set.seed()` is critical for reproducible results.
- **Validation**: Always validate reclassified cells by checking the expression of known marker genes for the "new" assigned cell type versus the "old" one. If a cell is reclassified to "Macrophage," it should show higher expression of macrophage markers than its original label group.

## Reference documentation

- [An introduction to scReClassify package](./references/scReClassify.Rmd)
- [scReClassify Vignette](./references/scReClassify.md)