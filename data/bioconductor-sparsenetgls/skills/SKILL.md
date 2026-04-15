---
name: bioconductor-sparsenetgls
description: This tool performs multivariate regression and Gaussian Graphical Model estimation by combining graph structure learning with generalized least squares. Use when user asks to estimate sparse precision matrices, perform multivariate regression on high-throughput omic data, or improve regression coefficients using latent covariance structures.
homepage: https://bioconductor.org/packages/release/bioc/html/sparsenetgls.html
---

# bioconductor-sparsenetgls

name: bioconductor-sparsenetgls
description: Multivariate regression and Gaussian Graphical Model (GGM) estimation using sparsenetgls. Use this skill to improve regression estimation by combining graph structure learning with generalized least squares (GLS), specifically for high-throughput "omic" data where response variables have latent covariance structures.

## Overview

The `sparsenetgls` package implements a method for multivariate regression that utilizes Gaussian Graphical Models (GGM) to estimate the structure of sparse variance-covariance and precision matrices. By identifying the underlying network of response variables, the package improves the estimation of regression coefficients through a sandwich estimator in a Generalized Least Squares (GLS) framework.

## Core Workflow

### 1. Data Preparation
The package expects response data ($Y$) and predictor data ($X$). Response variables should be Gaussian distributed.

```r
library(sparsenetgls)
# databand_Y: matrix of response variables
# databand_X: matrix of explanatory variables
```

### 2. Model Fitting with sparsenetgls()
The primary function `sparsenetgls()` performs the penalized estimation and GLS regression.

```r
fitgls <- sparsenetgls(
  responsedata = databand_Y, 
  predictdata = databand_X, 
  nlambda = 10,      # Number of regularization parameters
  ndist = 5,         # Distance tuning parameter for graph structure
  method = "glasso"  # Options: "glasso", "lasso", "mb", "elastic"
)
```

**Method Options:**
- `glasso`: Graphical lasso (Yuan and Lin).
- `lasso` / `mb`: Meinshausen-Buhlmann neighborhood selection.
- `elastic`: Combination of L1 (lasso) and L2 (ridge) penalties.

### 3. Coefficient Selection and Conversion
Results are often returned on a standardized scale. Use `convertbeta()` to return to the original scale and select the best model based on criteria like AIC, BIC, or minimal variance.

```r
# Convert coefficients for a specific lambda index
q <- dim(databand_X)[2]
beta_orig <- convertbeta(Y=databand_Y, X=databand_X, q=q+1, beta0=fitgls$beta[,i])$betaconv

# Select best model via BIC
best_idx <- which(fitgls$bic == min(fitgls$bic, na.rm=TRUE), arr.ind=TRUE)
best_betas <- fitgls$beta[, best_idx[1]]
```

### 4. Visualization and Assessment
- `plotsngls(fitgls, ith_lambda=5)`: Generates line plots of penalized parameters and graph structures.
- `path_result_for_roc()`: Calculates sensitivity, specificity, and predictive values if the true precision matrix is known.
- `plot_roc()`: Plots the ROC curve for GGM accuracy.

```r
# Example ROC assessment
roc_res <- path_result_for_roc(PREC_for_graph=true_prec, OMEGA_path=estimated_omega_array, pathnumber=10)
plot_roc(roc_res, group=FALSE)
```

## Tips for Success
- **High-Throughput Data**: This package is specifically optimized for "omic" data where the number of variables is large and the covariance matrix is expected to be sparse.
- **Tuning Parameters**: The `ndist` parameter controls the distance in the graph structure used to derive the sandwich estimators; experiment with this if the default structure seems too dense or sparse.
- **Matrix Format**: Ensure your input data are matrices. The package identifies covariance structures automatically during the `glasso` phase.

## Reference documentation
- [Introduction to sparsenetgls](./references/vignettes_sparsenetgls.md)