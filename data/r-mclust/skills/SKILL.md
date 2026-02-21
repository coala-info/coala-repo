---
name: r-mclust
description: "Gaussian finite mixture models fitted via EM algorithm for   model-based clustering, classification, and density estimation,    including Bayesian regularization, dimension reduction for    visualisation, and resampling-based inference.</p>"
homepage: https://cloud.r-project.org/web/packages/mclust/index.html
---

# r-mclust

## Overview
The `mclust` package provides a comprehensive framework for Gaussian Mixture Modelling (GMM). It automates the process of selecting the best model (e.g., spherical, diagonal, or ellipsoidal covariance structures) and the optimal number of mixture components using BIC. It supports clustering, discriminant analysis (MclustDA), and non-parametric density estimation.

## Installation
```R
install.packages("mclust")
library(mclust)
```

## Core Workflows

### 1. Model-Based Clustering
The primary function `Mclust()` performs hierarchical clustering, EM estimation, and model selection.

```R
# Basic clustering
data(diabetes)
X <- diabetes[,-1]
mod <- Mclust(X)

# Summary and Visualization
summary(mod)
plot(mod, what = "BIC")           # Model selection criteria
plot(mod, what = "classification") # Cluster assignments
plot(mod, what = "uncertainty")    # Observation-level uncertainty
```

### 2. Classification (Discriminant Analysis)
Use `MclustDA` for supervised learning where classes are known.

```R
# EDDA: Each class is a single Gaussian
mod_edda <- MclustDA(X, class, modelType = "EDDA")

# General MclustDA: Each class can be a mixture of Gaussians
mod_da <- MclustDA(X, class)

# Cross-validation
cv <- cvMclustDA(mod_da, nfold = 10)
```

### 3. Density Estimation
Estimate the probability density function of a dataset.

```R
# Univariate or Multivariate density
mod_dens <- densityMclust(faithful)

# Visualization
plot(mod_dens, what = "density", type = "hdr")   # High-density regions
plot(mod_dens, what = "density", type = "persp") # Perspective plot
```

### 4. Dimension Reduction
Visualize high-dimensional clustering or classification results in a lower-dimensional subspace.

```R
dr <- MclustDR(mod)
summary(dr)
plot(dr, what = "boundaries") # Decision boundaries
```

### 5. Bootstrap Inference
Perform resampling to obtain standard errors and confidence intervals for mixture parameters.

```R
boot <- MclustBootstrap(mod, nboot = 999)
summary(boot, what = "ci")
plot(boot, what = "mean")
```

## Model Selection and Initialization
- **BIC**: Higher values indicate better models in `mclust` (note: this is the negative of the standard BIC definition used in some other packages).
- **ICL**: Use `mclustICL()` if the goal is to find well-separated clusters rather than the best fit for the underlying density.
- **Initialization**: By default, `mclust` uses model-based hierarchical clustering (`hc()`). For large datasets, you can provide a subset or use random starts via `hcRandomPairs()`.

## Tips
- **Colorblind Safety**: Use `mclust.options("classPlotColors" = cbPalette)` to update default plotting colors.
- **Large Data**: For very large datasets, use the `initialization` argument in `Mclust()` to provide a starting partition or use a subset of the data for the initial hierarchical phase.
- **Missing Values**: `mclust` does not handle missing values natively; impute data before fitting.

## Reference documentation
- [A quick tour of mclust](./references/mclust.Rmd)