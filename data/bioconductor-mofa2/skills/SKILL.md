---
name: bioconductor-mofa2
description: MOFA2 integrates heterogeneous multi-omics data sets using an unsupervised framework to infer latent factors that capture shared and unique sources of variation. Use when user asks to train MOFA models, perform variance decomposition, visualize latent factors, or apply the MEFISTO framework for time-series and spatial covariates.
homepage: https://bioconductor.org/packages/release/bioc/html/MOFA2.html
---

# bioconductor-mofa2

name: bioconductor-mofa2
description: Multi-Omics Factor Analysis (MOFA2) for integrating heterogeneous data sets. Use this skill when you need to train MOFA models, perform variance decomposition, visualize latent factors, or use the MEFISTO framework for time-series or spatial covariates in R.

# bioconductor-mofa2

## Overview
MOFA2 is a framework for the unsupervised integration of multi-modal data sets (e.g., mRNA, proteomics, DNA methylation). It infers a set of latent factors that capture the shared and unique sources of variation across different data "views." This skill covers the R workflow for data preprocessing, model training, and downstream interpretation.

## Core Workflow

### 1. Data Preparation
MOFA requires samples to be matched across views. It handles missing data (samples missing entire views) automatically.
- **Input Formats**: List of matrices (features as rows, samples as columns), a long `data.frame`, or a `MultiAssayExperiment`.
- **Normalization**: Use continuous values (Gaussian). For sequencing counts, apply variance-stabilizing transformations (e.g., log-transformation) before input.
- **Feature Selection**: Select Highly Variable Features (HVGs) per view to improve speed and robustness.

### 2. Model Initialization and Training
```r
library(MOFA2)

# Create object
MOFAobject <- create_mofa(data_list)

# Set options
data_opts <- get_default_data_options(MOFAobject)
model_opts <- get_default_model_options(MOFAobject)
train_opts <- get_default_training_options(MOFAobject)

# Prepare and Run
MOFAobject <- prepare_mofa(MOFAobject, data_opts, model_opts, train_opts)
model <- run_mofa(MOFAobject, outfile = "model.hdf5", use_basilisk = TRUE)
```

### 3. Downstream Analysis
- **Variance Explained**: Quantify how much variation each factor explains per view.
  `plot_variance_explained(model, x="view", y="factor")`
- **Factor Visualization**: Inspect sample clustering or gradients.
  `plot_factor(model, factors = 1:2, color_by = "metadata_column")`
- **Feature Weights**: Identify which features drive specific factors.
  `plot_top_weights(model, view = 1, factor = 1)`
- **Heatmaps**: Visualize coordinated patterns in the original data.
  `plot_data_heatmap(model, view = 1, factor = 1, features = 20)`

## MEFISTO (Temporal/Spatial Covariates)
MEFISTO extends MOFA2 to handle structured samples (e.g., time series or spatial coordinates) by enforcing smoothness on factors.
- **Setup**: Use `set_covariates(MOFAobject, covariates = matrix)` before training.
- **Options**: Use `get_default_mefisto_options(MOFAobject)` during the preparation step.
- **Analysis**: Use `get_scales(model)` to check factor smoothness and `plot_factors_vs_cov(model)` to visualize temporal/spatial trends.

## Tips for Success
- **Sample Size**: Aim for at least 15 samples for stable factor inference.
- **Convergence**: If the model doesn't converge, increase `maxiter` or check for extreme outliers in the input data.
- **Python Dependency**: MOFA2 relies on the `mofapy2` Python library. Using `use_basilisk = TRUE` in `run_mofa` is the most reliable way to manage this dependency automatically.

## Reference documentation
- [MEFISTO on simulated data (temporal)](./references/MEFISTO_temporal.md)
- [Downstream analysis: Overview](./references/downstream_analysis.md)
- [MOFA2: How to train a model in R](./references/getting_started_R.md)