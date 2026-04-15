---
name: bioconductor-zinbwave
description: The zinbwave package implements a general and flexible model for dimensionality reduction, normalization, and differential expression analysis of high-dimensional zero-inflated count data. Use when user asks to perform dimensionality reduction on scRNA-seq data, account for zero inflation in single-cell counts, or compute observational weights for differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/zinbwave.html
---

# bioconductor-zinbwave

## Overview

The `zinbwave` package implements a general and flexible model for the analysis of high-dimensional zero-inflated count data. It is primarily used for single-cell RNA-seq (scRNA-seq) to:
1.  **Dimensionality Reduction**: Extract low-dimensional latent factors ($W$) while accounting for zero inflation and overdispersion.
2.  **Normalization**: Produce normalized counts and deviance residuals.
3.  **Differential Expression**: Compute observational weights that allow standard bulk RNA-seq tools (like `edgeR` and `DESeq2`) to handle zero-inflated single-cell data.

## Core Workflow

### 1. Data Preparation
The package works with `SummarizedExperiment` or `SingleCellExperiment` objects. It is recommended to filter lowly expressed genes and focus on highly variable genes (HVGs) for computational efficiency.

```r
library(zinbwave)
library(SingleCellExperiment)

# Filter: genes with at least 5 reads in at least 5 samples
filter <- rowSums(assay(se) > 5) > 5
se <- se[filter,]

# Select top 1000 highly variable genes
# (Assuming log-transformed variance calculation)
se_hvg <- se[1:1000, ] 
```

### 2. Running ZINB-WaVE
The main function is `zinbwave()`. It returns a `SingleCellExperiment` object with the low-dimensional representation in the `reducedDim` slot.

```r
# K: number of latent variables
# epsilon: regularization parameter (higher values like 1000 or 1e6 often yield better representations)
sce <- zinbwave(se_hvg, K = 2, epsilon = 1000)

# Access the low-dimensional factors (W)
W <- reducedDim(sce, "zinbwave")
```

### 3. Adding Covariates
You can include sample-level ($X$) or gene-level ($V$) covariates to account for batch effects or biological factors (e.g., GC-content).

```r
# Sample-level covariate (e.g., Batch)
sce_cov <- zinbwave(se_hvg, X = "~Batch", K = 2)

# Gene-level covariate (e.g., GC-content in rowData)
sce_gene <- zinbwave(se_hvg, V = "~gccontent", K = 2)
```

### 4. Normalization and Residuals
To obtain normalized values or residuals for visualization and QC:

```r
sce <- zinbwave(se_hvg, K = 2, normalizedValues = TRUE, residuals = TRUE)
norm_counts <- assay(sce, "normalizedValues")
resids <- assay(sce, "residuals")
```

### 5. Differential Expression (DE) with Weights
ZINB-WaVE can "unlock" bulk tools by computing observational weights. For DE, use a high `epsilon` (e.g., `1e12`).

```r
# Compute weights
sce <- zinbwave(se_hvg, observationalWeights = TRUE, epsilon = 1e12)
weights <- assay(sce, "weights")

# Example with edgeR
library(edgeR)
dge <- DGEList(assay(sce, "counts"))
dge$weights <- weights
dge <- estimateDisp(dge, design)
fit <- glmFit(dge, design)
lrt <- glmWeightedF(fit, coef = 2) # Adjusted F-test
```

## Advanced Features

### Large Datasets (`zinbsurf`)
For datasets with tens of thousands of cells, use `zinbsurf` for an approximate strategy that fits the model on a subset and projects the remaining cells.

```r
# prop_fit: proportion of cells used for the initial fit (default 0.1)
sce_surf <- zinbsurf(se, K = 2, prop_fit = 0.1)
```

### Integration with Seurat
You can convert the result to a Seurat object for clustering.

```r
library(Seurat)
seu <- as.Seurat(sce, counts = "counts", data = "counts")
# The 'zinbwave' reduction is automatically transferred
seu <- FindNeighbors(seu, reduction = "zinbwave", dims = 1:2)
seu <- FindClusters(seu)
```

## Tips and Best Practices
- **Parallelization**: Use `BiocParallel::register()` or pass `BPPARAM` to `zinbwave()` to speed up computation on large matrices.
- **Epsilon**: The penalty parameter `epsilon` is crucial. For dimensionality reduction, `1000` is often sufficient. For Differential Expression weights, use `1e6` to `1e13`.
- **Assay Names**: If your input object has multiple assays, ensure the raw counts are in the first assay or named "counts".

## Reference documentation
- [An introduction to ZINB-WaVE](./references/intro.Rmd)
- [An introduction to ZINB-WaVE](./references/intro.md)