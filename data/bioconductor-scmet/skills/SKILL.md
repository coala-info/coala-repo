---
name: bioconductor-scmet
description: This tool uses Bayesian modeling to quantify mean methylation and biological overdispersion in single-cell DNA methylation data. Use when user asks to identify highly variable features, perform differential methylation testing, perform differential variability testing, or model sparse single-cell DNA methylation data.
homepage: https://bioconductor.org/packages/release/bioc/html/scMET.html
---


# bioconductor-scmet

name: bioconductor-scmet
description: Bayesian modelling of single-cell DNA methylation (scBS-seq) data to quantify mean methylation and biological overdispersion. Use this skill to identify highly variable features (HVFs), perform differential methylation (DM) and differential variability (DV) testing, and handle sparse CpG coverage by sharing information across cells and genomic features.

# bioconductor-scmet

## Overview
scMET is a Bayesian framework designed for sparse single-cell DNA methylation data. It uses a hierarchical beta-binomial (BB) model coupled with a generalized linear model (GLM) to disentangle technical noise from biological variability. It captures a mean-overdispersion trend to derive "residual overdispersion" ($\epsilon$), which identifies cell-to-cell variability not confounded by mean methylation levels.

## Core Workflow

### 1. Data Preparation
scMET requires data in a long-format `data.table` or a `SingleCellExperiment` object.

**Input Format (data.table):**
- `Feature`: Genomic region ID.
- `Cell`: Cell ID.
- `total_reads`: Total CpG sites covered ($n_{ij}$).
- `met_reads`: Number of methylated CpG sites ($Y_{ij}$).

**Optional Covariates (X):**
A matrix where rows are features and columns are covariates (e.g., CpG density). The first column must be an intercept (all 1s).

### 2. Model Inference
Use the `scmet` function to estimate parameters.

```r
library(scMET)

# Using Variational Bayes (VB) for large datasets
fit_obj <- scmet(Y = scmet_dt$Y, X = scmet_dt$X, L = 4, iter = 20000)

# Using MCMC for smaller datasets (more stable/accurate)
fit_obj <- scmet(Y = scmet_dt$Y, X = scmet_dt$X, L = 4, use_mcmc = TRUE)
```
- `L`: Number of radial basis functions for the mean-overdispersion trend.
- `iter`: Number of iterations (recommend 20,000 for VB convergence).

### 3. Feature Selection (HVF)
Identify highly variable features based on residual overdispersion ($\epsilon$).

```r
# Identify HVFs
fit_obj <- scmet_hvf(scmet_obj = fit_obj, 
                     delta_e = 0.75, 
                     evidence_thresh = 0.8, 
                     efdr = 0.1)

# View summary
head(fit_obj$hvf$summary)
```

### 4. Differential Analysis
Compare two groups (e.g., Group A vs Group B) for differences in mean (DM) or variability (DV).

```r
# 1. Fit models for each group separately
fit_A <- scmet(Y = data_A, X = X_A, iter = 20000)
fit_B <- scmet(Y = data_B, X = X_B, iter = 20000)

# 2. Run differential test
diff_obj <- scmet_differential(obj_A = fit_A, obj_B = fit_B,
                               evidence_thresh_m = 0.7,
                               evidence_thresh_e = 0.7,
                               group_label_A = "A",
                               group_label_B = "B")

# Access results
head(diff_obj$diff_mu_summary)      # Mean differences
head(diff_obj$diff_epsilon_summary) # Variability differences
```

### 5. Visualization
scMET provides built-in plotting functions:
- `scmet_plot_mean_var()`: Visualize the mean-overdispersion trend.
- `scmet_plot_volcano()`: Volcano plots for differential testing.
- `scmet_plot_ma()`: MA plots for differential testing.
- `scmet_plot_efdr_efnr_grid()`: Calibration of evidence thresholds.

## Interoperability with SingleCellExperiment
Convert between formats to integrate with other Bioconductor tools.

```r
# scMET to SCE
sce_obj <- scmet_to_sce(Y = scmet_dt$Y, X = scmet_dt$X)

# SCE to scMET
scmet_input <- sce_to_scmet(sce = sce_obj)
```
Note: The SCE object stores methylated counts in the `met` assay and total counts in the `total` assay.

## Tips for Success
- **Convergence**: Always check the ELBO plot or messages. If VB does not converge, increase `iter`.
- **Shrinkage**: scMET performs better than Maximum Likelihood Estimation (MLE) because it shrinks feature-specific estimates toward the population trend, which is critical for sparse data.
- **Residual Overdispersion**: Use `epsilon` rather than `gamma` for clustering or HVF selection to avoid bias from mean methylation levels.

## Reference documentation
- [scMET Bayesian modelling of DNA methylation heterogeneity at single-cell resolution](./references/scMET_vignette.Rmd)
- [scMET analysis using synthetic data](./references/scMET_vignette.md)