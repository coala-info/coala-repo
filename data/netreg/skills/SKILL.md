---
name: netreg
description: The netreg tool fits network-regularized linear models by incorporating graph-based penalties into generalized linear models. Use when user asks to apply network-regularized regression, fit models with graph-based penalties, or incorporate interaction information into high-dimensional data analysis.
homepage: https://github.com/dirmeier/netReg
metadata:
  docker_image: "quay.io/biocontainers/netreg:1.8.0--h9fd3d4c_0"
---

# netreg

## Overview

The `netreg` skill enables the application of network-regularized linear models within R. Unlike standard Lasso or Ridge regression, `netreg` utilizes graph-based penalties to incorporate interaction information directly into the loss function of a Generalized Linear Model (GLM). This approach is particularly effective for reducing variance in coefficient estimation when working with high-dimensional datasets where variables are known to interact, such as gene regulatory networks or protein-protein interaction maps.

## Installation and Environment Setup

Before using `netreg`, ensure the underlying Python requirements for TensorFlow are met, as the package relies on TensorFlow for the estimation of regression coefficients.

```r
# 1. Install Python dependencies via R
install.packages(c("tensorflow", "tfprobability"))
tensorflow::install_tensorflow(extra_packages = "tensorflow-probability")

# 2. Install netReg from GitHub
remotes::install_github("dirmeier/netReg")
```

## Core Usage Pattern

The primary function is `edgenet`, which fits the network-regularized model.

### Basic Workflow

```r
library(netReg)

# Prepare data: X (covariates), Y (responses)
# G.X and G.Y are adjacency matrices representing the networks
fit <- edgenet(X, Y, G.X, G.Y, family = "gaussian")

# Inspect the model
summary(fit)

# Extract coefficients
coefficients <- coef(fit)
```

## Expert Tips and Best Practices

- **Network Specification**: The adjacency matrices `G.X` (for covariates) and `G.Y` (for responses) should be provided as affinity matrices. If you only have interactions for one side, you can omit the other or provide an identity matrix.
- **Hyperparameter Tuning**: The model relies on three main parameters: `lambda` (general sparsity), `psigx` (network penalty for X), and `psigy` (network penalty for Y). Use the built-in cross-validation framework to find optimal values.
- **TensorFlow Integration**: Since version 1.9.0, `netreg` uses TensorFlow for optimization. If you encounter execution errors, verify your `reticulate` configuration and ensure `tensorflow-probability` is correctly mapped in your R session.
- **Data Scaling**: Like most regularized regression methods, it is highly recommended to center and scale your input matrices `X` and `Y` before fitting the model to ensure the penalties are applied uniformly.
- **Family Selection**: While Gaussian is the default, `netreg` supports generalized linear models. Ensure your `family` argument matches the distribution of your response variable `Y`.

## Reference documentation

- [netReg Overview](./references/anaconda_org_channels_bioconda_packages_netreg_overview.md)
- [netReg GitHub Repository](./references/github_com_dirmeier_netReg.md)