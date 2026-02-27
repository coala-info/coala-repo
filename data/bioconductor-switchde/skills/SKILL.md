---
name: bioconductor-switchde
description: Bioconductor-switchde identifies genes that follow a sigmoidal expression pattern along single-cell trajectories or pseudotime. Use when user asks to detect switch-like differential expression, fit sigmoidal models to gene expression data, identify genes regulated along a trajectory, or visualize activation strengths and times.
homepage: https://bioconductor.org/packages/release/bioc/html/switchde.html
---


# bioconductor-switchde

name: bioconductor-switchde
description: Detect switch-like differential expression in single-cell RNA-seq data along trajectories. Use this skill to fit sigmoidal models to gene expression data indexed by pseudotime, identify significantly regulated genes, and visualize activation strengths (k) and activation times (t0).

# bioconductor-switchde

## Overview

The `switchde` package identifies genes that follow a sigmoidal (switch-like) expression pattern along a single-cell trajectory or pseudotime. It uses a likelihood ratio test to determine if a sigmoidal model fits significantly better than a constant model. The model provides three key parameters:
- **mu0**: The half-peak expression level.
- **k**: Activation strength (positive for upregulation, negative for downregulation).
- **t0**: Activation time (where along the pseudotime the switch occurs).

## Core Workflow

### 1. Data Preparation and Filtering
Strict pre-filtering is essential to avoid convergence errors in the Maximum Likelihood Estimation (MLE) process.

```r
library(switchde)
library(SingleCellExperiment)

# Example: Filter for genes expressed in >20% of cells with mean log-expression > 0.1
X_filtered <- X[rowMeans(X) > 0.1 & rowMeans(X > 0) > 0.2, ]
```

### 2. Running Differential Expression Tests
You can pass a gene-by-cell matrix or a `SingleCellExperiment` object.

```r
# Using a matrix (genes as rows, cells as columns)
# ex_pseudotime is a numeric vector of pseudotimes for each cell
sde <- switchde(X_filtered, ex_pseudotime)

# Using SingleCellExperiment
sce <- SingleCellExperiment(assays = list(exprs = X_filtered))
sde <- switchde(sce, ex_pseudotime)
```

### 3. Modeling Zero-Inflation
For single-cell data with high dropout rates, use the zero-inflated model. Note: This uses an EM algorithm and is significantly slower.

```r
zde <- switchde(X_filtered, ex_pseudotime, zero_inflated = TRUE)
```

### 4. Interpreting and Filtering Results
The output is a `data.frame` containing p-values, q-values (FDR), and MLE parameters.

```r
library(dplyr)

# Sort by significance
top_genes <- arrange(sde, qval)

# Filter for genes with strong "switch" behavior (high magnitude of k)
# and that activate in the first half of the trajectory
interesting_genes <- filter(sde, qval < 0.01, abs(k) > 5, t0 < 0.5)
```

### 5. Visualization
Use `switchplot` to visualize the fitted sigmoid curve against the raw data.

```r
# Extract parameters for a specific gene
gene_name <- "Gene8"
pars <- extract_pars(sde, gene_name)

# Plot
switchplot(X_filtered[gene_name, ], ex_pseudotime, pars)
```

## Parameters and Tuning

- **lower_threshold**: `switchde` sets expression values below 0.01 to 0 by default. Adjust this if your data scale is different.
- **zero_inflated**: Set to `TRUE` to account for dropouts. Adds a `lambda` parameter (dropout probability) and an `EM_converged` flag.
- **maxiter** and **log_lik_tol**: Control the EM algorithm convergence for zero-inflated models. If `EM_converged` is `FALSE`, increase `maxiter`.

## Reference documentation

- [switchde: inference of switch-like gene behaviour along single-cell trajectories](./references/switchde_vignette.md)
- [switchde: inference of switch-like gene behaviour along single-cell trajectories (Rmd)](./references/switchde_vignette.Rmd)