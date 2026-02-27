---
name: bioconductor-phenopath
description: PhenoPath performs genomic trajectory analysis by modeling gene expression as a function of latent pseudotime and sample-specific covariates. Use when user asks to infer pseudotime trajectories, identify gene-specific interactions between trajectories and external factors, or account for sample covariates in single-cell transcriptomics.
homepage: https://bioconductor.org/packages/release/bioc/html/phenopath.html
---


# bioconductor-phenopath

name: bioconductor-phenopath
description: Genomic trajectory analysis using PhenoPath to model gene expression as a function of latent pseudotime and sample-specific covariates. Use this skill to identify gene-specific interactions between trajectories and external factors (e.g., treatment, mutation status) in single-cell or bulk transcriptomics.

## Overview

PhenoPath is a Bayesian statistical model for trajectory inference that accounts for sample-specific covariates. Unlike standard pseudotime methods that assume all samples follow the same path, PhenoPath identifies genes where the trajectory is perturbed by external factors (interactions). It uses mean-field variational inference to estimate latent pathway scores ($z$) and interaction coefficients ($\beta$).

## Core Workflow

### 1. Data Preparation
PhenoPath requires an expression matrix $y$ (samples as rows, genes as columns) and a covariate vector/matrix $x$.
- **Expression**: Input should be log-transformed (e.g., $log_2(TPM+1)$). PhenoPath centre-scales data by default.
- **Covariates**: Numeric or factor variables representing the perturbations (e.g., 0/1 for control/treatment).

### 2. Fitting the Model
The primary function is `phenopath()`.

```r
library(phenopath)

# Basic fit
fit <- phenopath(y, x)

# Advanced fit with convergence control
fit <- phenopath(y, x, 
                 elbo_tol = 1e-6, 
                 thin = 40, 
                 maxiter = 1000)
```

### 3. Assessing Convergence
Always check the Evidence Lower Bound (ELBO) to ensure the model has converged to a stable solution.

```r
plot_elbo(fit)
```

### 4. Extracting Results
- **Trajectories**: Use `trajectory(fit)` to get the latent pseudotime scores ($z$).
- **Interactions**: Use `interactions(fit)` to get a data frame containing:
    - `interaction_effect_size`: The $\beta$ coefficient.
    - `significant`: Boolean indicating if the interaction is non-zero.
    - `pathway_loading`: The $\lambda$ coefficient (overall gene effect along the trajectory).

```r
# Detailed interaction results
df_int <- interactions(fit)

# Specific interaction components
beta_means <- interaction_effects(fit)
beta_sds <- interaction_sds(fit)
is_significant <- significant_interactions(fit)
```

## Input Formats

### SummarizedExperiment Support
PhenoPath integrates with `SummarizedExperiment` objects.
- **Assay**: By default, it looks for the `exprs` assay. Change this via the `sce_assay` argument.
- **Covariates**: Can be passed as a column name string or a formula.

```r
# Using a column name from colData(sce)
fit <- phenopath(sce, "treatment_group")

# Using a formula
fit <- phenopath(sce, ~ treatment_group)
```

## Latent Space Initialization
The model is sensitive to initial conditions. Use the `z_init` argument to control this:
- `z_init = 1`: Initialize to the first Principal Component (default).
- `z_init = "random"`: Random initialization from a standard normal.
- `z_init = custom_vector`: Provide a specific starting trajectory.

## Reference documentation

- [Introduction to PhenoPath](./references/introduction_to_phenopath.md)