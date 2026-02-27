---
name: bioconductor-scdesign3
description: scDesign3 fits probabilistic models to single-cell data to generate realistic synthetic datasets across various biological states and modalities. Use when user asks to generate synthetic single-cell data, fit models to single-cell experiments, or simulate datasets for clusters, lineages, and spatial patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/scDesign3.html
---


# bioconductor-scdesign3

## Overview

`scDesign3` is an R package that fits probabilistic models to single-cell data to generate realistic synthetic datasets. It handles various biological states (clusters, lineages, spatial patterns) and data modalities. The core workflow involves taking a `SingleCellExperiment` (SCE) object, fitting marginal distributions for genes using Generalized Additive Models (GAMs), and capturing gene-gene correlations via copulas.

## Core Workflow

### 1. Data Preparation
The input must be a `SingleCellExperiment` object. Covariates like cell types, pseudotime, or spatial coordinates must be present in the `colData`.

```r
library(scDesign3)
library(SingleCellExperiment)

# Example: Creating an SCE from counts and pseudotime
example_sce <- SingleCellExperiment(
  assays = list(counts = count_matrix),
  colData = DataFrame(pseudotime = pseudotime_vector)
)
```

### 2. Simulation with `scdesign3()`
The `scdesign3()` function is the primary interface. It performs model fitting and data generation in one step.

```r
set.seed(123)
sim_results <- scdesign3(
    sce = example_sce,
    assay_use = "counts",
    celltype = NULL,               # Set if simulating discrete clusters
    pseudotime = "pseudotime",     # Set if simulating a trajectory
    spatial = NULL,                # Set for spatial data (e.g., c("x", "y"))
    mu_formula = "s(pseudotime, k = 10, bs = 'cr')", # GAM formula for mean
    sigma_formula = "1",           # Formula for dispersion
    family_use = "nb",             # Distribution (e.g., 'nb', 'poisson', 'zip')
    n_cores = 2,
    copula = "gaussian"            # 'gaussian' or 'vine' for correlations
)
```

**Key Parameters:**
- `mu_formula`: Uses `mgcv::gam` syntax. `s(x)` denotes a smoothing spline.
- `family_use`: Common choices are `"nb"` (Negative Binomial), `"poisson"`, `"zip"` (Zero-inflated Poisson), or `"zinb"`.
- `ncell`: Number of cells to simulate. Defaults to the same number as the input SCE.
- `return_model`: Set to `TRUE` to inspect the fitted GAM/GAMLSS models.

### 3. Processing Results
The output is a list containing the synthetic matrix and model metadata.

```r
# Extract synthetic counts
new_counts <- sim_results$new_count

# Create a new SCE for the simulated data
sim_sce <- SingleCellExperiment(
  assays = list(counts = new_counts),
  colData = sim_results$new_covariate
)
logcounts(sim_sce) <- log1p(counts(sim_sce))
```

### 4. Evaluation and Visualization
Use `plot_reduceddim` to compare the reference data against the synthetic data in a low-dimensional space (PCA/UMAP).

```r
compare_figure <- plot_reduceddim(
  ref_sce = example_sce, 
  sce_list = list(sim_sce), 
  name_vec = c("Reference", "scDesign3"),
  assay_use = "logcounts", 
  if_plot = TRUE, 
  color_by = "pseudotime"
)
plot(compare_figure$p_umap)
```

## Tips for Success
- **Formula Selection**: For discrete cell types, use `mu_formula = "celltype"`. For trajectories, use splines like `s(pseudotime)`.
- **Computational Cost**: Using `copula = "vine"` or complex `sigma_formula` significantly increases runtime. Start with `gaussian` copulas and constant dispersion (`sigma_formula = "1"`) for initial testing.
- **Parallelization**: Always set `n_cores` to speed up gene-wise marginal model fitting.
- **Model Selection**: Check `sim_results$model_aic` or `model_bic` to evaluate how well the chosen distribution and formula fit the reference data.

## Reference documentation
- [scDesign3 Quickstart](./references/scDesign3.md)
- [scDesign3 RMarkdown Source](./references/scDesign3.Rmd)