---
name: bioconductor-peco
description: This tool predicts the cell cycle phase of single cells as a continuous variable using single-cell RNA sequencing data. Use when user asks to predict cell cycle position, map cells onto a unit circle, or fit cyclic trends to gene expression data.
homepage: https://bioconductor.org/packages/release/bioc/html/peco.html
---


# bioconductor-peco

name: bioconductor-peco
description: Predicts cell cycle phase in a continuum using single-cell RNA sequencing (scRNA-seq) data. Use this skill when you need to build training datasets for cyclic gene expression or apply supervised models to predict continuous cell cycle position (angles 0 to 2π) for single cells using the peco R package.

# bioconductor-peco

## Overview

`peco` is a supervised learning framework designed to predict the cell cycle phase of individual cells as a continuous variable. Unlike discrete classification (e.g., G1, S, G2/M), `peco` maps cells onto a unit circle (0 to 2π). It is optimized for single-cell RNA-seq data and can function effectively with a small set of well-known cyclic marker genes (e.g., *CDK1*, *UBE2C*, *TOP2A*).

## Core Workflow

### 1. Data Preparation
`peco` operates on `SingleCellExperiment` (SCE) objects. The input expression data must be quantile-normalized counts-per-million (CPM).

```r
library(peco)
library(SingleCellExperiment)

# Transform raw counts to quantile-normalized CPM
# This adds a 'cpm_quantNormed' assay to the SCE object
sce <- data_transform_quantile(sce)
```

### 2. Predicting Cell Cycle Phase
To predict phases for a new dataset (out-sample), use `cycle_npreg_outsample`. This requires a training object (like the built-in `training_human`) which contains estimated cyclic trends (`funs_est`) and error variances (`sigma_est`).

```r
data("training_human")

# Predict phases
# Y_test: SCE object with cpm_quantNormed assay
# sigma_est: standard error from training data
# funs_est: cyclic functions from training data
results <- cycle_npreg_outsample(
    Y_test = sce,
    sigma_est = training_human$sigma[rownames(sce), ],
    funs_est = training_human$cellcycle_function[rownames(sce)],
    method.trend = "trendfilter",
    ncores = 1
)

# Access predicted angles (0 to 2pi)
predicted_phases <- colData(results$Y)$cellcycle_peco
```

### 3. Fitting Cyclic Trends
If you have predicted phases and want to visualize or analyze the cyclic behavior of specific genes, use `fit_cyclical_many`.

```r
# Extract predicted phases
theta_predict <- colData(results$Y)$cellcycle_peco
names(theta_predict) <- colnames(results$Y)

# Fit trends for a subset of genes
yy_input <- assay(results$Y, "cpm_quantNormed")[1:5, ]
fit_cyclic <- fit_cyclical_many(Y = yy_input, theta = theta_predict)

# fit_cyclic$cellcycle_function contains the fitted functions for plotting
```

## Key Functions

- `data_transform_quantile()`: Prepares SCE objects by calculating CPM and performing quantile normalization.
- `cycle_npreg_outsample()`: The primary function for predicting cell cycle phase in new samples using a reference model.
- `fit_cyclical_many()`: Fits non-parametric cyclic trends (using trend filtering) to gene expression data given a set of cell phases.
- `training_human`: A built-in dataset containing model parameters for 101 human cyclic genes.

## Tips for Success

- **Gene Matching**: Ensure the rownames of your SCE object (Gene IDs) match the IDs used in the training data (e.g., Ensembl IDs for `training_human`).
- **Marker Genes**: While the package supports 101 genes, accurate prediction is often possible with just the top 5-10 markers like *CDK1* and *TOP2A*.
- **Visualization**: Always perform a "sanity check" by plotting a known marker like *CDK1* against the predicted phase (`cellcycle_peco`). It should show a clear, smooth cyclic peak.

## Reference documentation

- [Predicting cell cycle phase using peco](./references/peco.Rmd)
- [peco Vignette](./references/vignette.md)