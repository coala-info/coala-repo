---
name: bioconductor-netreg
description: "bioconductor-netreg fits network-regularized generalized linear models by incorporating external biological or chemical network information into the regression process. Use when user asks to perform network-regularized regression, integrate affinity matrices into GLMs, or smooth regression coefficients using graph Laplacians."
homepage: https://bioconductor.org/packages/3.6/bioc/html/netReg.html
---


# bioconductor-netreg

## Overview

The `netReg` package implements network-regularized regression models. It allows for the integration of external information—represented as adjacency or affinity matrices—into the regularization process of Generalized Linear Models (GLMs). By using graph Laplacians, the package penalizes differences between regression coefficients of variables that are connected in a network, effectively "smoothing" the coefficients over the graph.

Key features:
- **edgenet**: Regularization using affinity matrices for both covariables ($G_X$) and responses ($G_Y$).
- **group.lasso**: Group-based sparsity constraints.
- **Supported Families**: Gaussian, Binomial, and Poisson.
- **Implementation**: Uses TensorFlow as a backend for efficient matrix computations.

## Core Workflow

### 1. Prepare Affinity Matrices
Affinity matrices ($G_X$ for $p$ predictors, $G_Y$ for $q$ responses) should be positive semi-definite matrices representing the strength of interaction between variables.

```r
library(netReg)

# Example: Random affinity matrices for 10 predictors and 10 responses
p <- 10
q <- 10
G.X <- abs(rWishart(1, 10, diag(p))[,,1])
G.Y <- abs(rWishart(1, 10, diag(q))[,,1])
```

### 2. Fit a Model
Use `edgenet()` to fit the model. You must specify the family and can provide $G_X$, $G_Y$, or both.

```r
# Gaussian model
fit <- edgenet(X=X, Y=Y, G.X=G.X, G.Y=G.Y, family=gaussian, lambda=0.1, psix=1, psiy=1)

# Binomial model
fit_bin <- edgenet(X=X, Y=Y_bin, G.X=G.X, family=binomial)

# Poisson model
fit_pois <- edgenet(X=X, Y=Y_pois, G.Y=G.Y, family=poisson)
```

### 3. Model Selection (Cross-Validation)
To find optimal shrinkage parameters ($\lambda$, $\psi_1$, $\psi_2$), use `cv.edgenet`. This uses the BOBYQA algorithm for gradient-free optimization.

```r
cv_fit <- cv.edgenet(X=X, Y=Y, G.X=G.X, G.Y=G.Y, family=gaussian)
summary(cv_fit)
# Access the best model
best_model <- cv_fit$fit
```

### 4. Inspection and Prediction
Standard R generics are available for fitted objects.

```r
# Get coefficients (returns a matrix p x q)
coefficients <- coef(fit)

# Summary of the fit
summary(fit)

# Predict on new data
predictions <- predict(fit, newX)
```

## Implementation Tips

- **TensorFlow Backend**: `netReg` relies on `tensorflow` and `tfprobability`. Ensure a working TensorFlow environment is configured in R (`reticulate::py_config()`).
- **GPU Acceleration**: For large networks or intensive cross-validation, running on a GPU is highly recommended as the package performs many matrix multiplications.
- **Sparsity**: The `lambda` parameter controls the $L_1$ penalty (Lasso). Higher values lead to sparser coefficient matrices.
- **Graph Penalties**: `psix` (or $\psi_1$) controls the smoothing over the predictor network, while `psiy` (or $\psi_2$) controls smoothing over the response network.

## Reference documentation

- [Network-regularized regression models](./references/netReg.Rmd)