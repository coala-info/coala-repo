---
name: bioconductor-glmgampoi
description: This tool fits Gamma-Poisson generalized linear models to large-scale count data with optimized performance for single-cell RNA-seq. Use when user asks to fit Negative Binomial GLMs, estimate gene-wise overdispersion, perform differential expression analysis, or create pseudobulk aggregations for multi-sample comparisons.
homepage: https://bioconductor.org/packages/release/bioc/html/glmGamPoi.html
---

# bioconductor-glmgampoi

name: bioconductor-glmgampoi
description: Fit Gamma-Poisson Generalized Linear Models (GLMs) to large-scale count data, specifically optimized for single-cell RNA-seq. Use this skill to estimate overdispersion, perform differential expression analysis, and create pseudobulk aggregations for statistically robust multi-sample comparisons.

# bioconductor-glmgampoi

## Overview
The `glmGamPoi` package provides an efficient implementation for fitting Gamma-Poisson (Negative Binomial) GLMs. It is significantly faster than `DESeq2` or `edgeR` for large datasets because it uses an optimized algorithm for inferring gene-wise overdispersion without sacrificing accuracy. It supports in-memory matrices, on-disk HDF5 arrays, and `SingleCellExperiment` objects.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("glmGamPoi")
```

## Core Workflow: Fitting a Model
The primary function is `glm_gp()`. It can take a matrix, a `SummarizedExperiment`, or a `SingleCellExperiment`.

```r
library(glmGamPoi)

# Basic fit on a count matrix
# design = ~ 1 fits an intercept-only model
fit <- glm_gp(count_matrix, design = ~ condition + batch)

# Access results
beta_estimates <- fit$Beta
overdispersions <- fit$overdispersions
size_factors <- fit$size_factors
```

### Key Parameters for `glm_gp()`
- `design`: A formula or model matrix.
- `on_disk`: Set to `TRUE` to handle large datasets without loading everything into RAM.
- `size_factors`: Can be a numeric vector, "estimate" (default), or "ratio" (standard DESeq2-style).
- `reference_level`: Specify the baseline category for categorical factors in the design.

## Differential Expression Analysis
Use `test_de()` to perform quasi-likelihood ratio tests.

```r
# Simple contrast
res <- test_de(fit, contrast = condition_treated - condition_control)

# Complex contrast using cond() helper
res <- test_de(fit, 
               contrast = cond(cell = "B cells", stim = "yes") - 
                          cond(cell = "B cells", stim = "no"))
```

## Pseudobulk Aggregation
For single-cell data with multiple biological replicates (e.g., patients), it is best practice to aggregate cells into "pseudobulks" before DE testing to avoid p-value inflation.

```r
# Aggregate cells by individual, condition, and cell type
reduced_sce <- pseudobulk(sce, 
                          group_by = vars(patient_id, condition, cell_type),
                          n_cells = n())

# Run the standard workflow on the reduced object
fit_bulk <- glm_gp(reduced_sce, design = ~ condition + cell_type)
de_results <- test_de(fit_bulk, contrast = condition_stim - condition_ctrl)
```

## Tips for Performance
- **Memory**: If working with `SingleCellExperiment` objects from `TENxPBMCData` or similar, use `on_disk = TRUE` if the dataset exceeds available RAM.
- **Speed**: `glmGamPoi` is optimized for many samples (columns). It avoids duplicate calculations for genes with similar count patterns.
- **Visualization**: Use `ggplot2` to plot `lfc` vs `-log10(pval)` from the `test_de()` output for volcano plots.

## Reference documentation
- [glmGamPoi Quickstart](./references/glmGamPoi.md)
- [Pseudobulk and differential expression](./references/pseudobulk.md)