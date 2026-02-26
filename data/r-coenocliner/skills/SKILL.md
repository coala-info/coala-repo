---
name: r-coenocliner
description: This tool simulates species occurrence and abundance data along environmental gradients using various response and error models. Use when user asks to generate synthetic ecological community data, model species response curves, or simulate species distributions along environmental gradients.
homepage: https://cloud.r-project.org/web/packages/coenocliner/index.html
---


# r-coenocliner

name: r-coenocliner
description: Simulate species occurrence and abundance data along environmental gradients using Gaussian or generalized beta response models. Use this skill when you need to generate synthetic ecological community data, model species response curves (coenoclines), or test multivariate analysis methods with known ground-truth data.

# r-coenocliner

## Overview

The `coenocliner` package provides a framework for simulating species distributions along one or two environmental gradients. It separates the ecological response (the expected abundance/probability) from the error distribution (the sampling process), allowing for realistic simulations of count or occurrence data.

## Installation

```R
install.packages("coenocliner")
library("coenocliner")
```

## Core Workflow

The primary function is `coenocline()`. The general workflow involves:
1. Defining gradient locations (`x`).
2. Choosing a response model (`"gaussian"` or `"beta"`).
3. Defining species-specific parameters (`params`).
4. Choosing a count/error model (e.g., `"poisson"`, `"negbin"`, `"bernoulli"`).

### 1. Defining Parameters

Use `showParams()` to see required parameters for a model.

```R
# For Gaussian: opt (optimum), tol (tolerance), h (max abundance)
showParams("gaussian")

# For Beta: a0 (max), m (modal loc), r (range), alpha/gamma (shape)
showParams("beta")
```

### 2. Single Gradient Simulation

```R
# 1. Gradient locations
locs <- seq(1, 10, length.out = 100)

# 2. Species parameters (3 species)
pars <- cbind(opt = c(3, 5, 7), 
              tol = rep(0.8, 3), 
              h = c(10, 20, 30))

# 3. Simulate counts (Poisson error)
out <- coenocline(locs, responseModel = "gaussian", params = pars, countModel = "poisson")
```

### 3. Two Gradient Simulation

For two gradients, `x` should be a matrix of coordinates (e.g., from `expand.grid`), and `params` should be a list of two matrices.

```R
# Gradient grid
g1 <- seq(1, 10, length = 20)
g2 <- seq(1, 100, length = 20)
locs2d <- expand.grid(x = g1, y = g2)

# Parameters for each gradient
px <- cbind(opt = c(3, 7), tol = c(1, 2), h = c(20, 50))
py <- cbind(opt = c(30, 70), tol = c(10, 20)) # h is only in px
pars2d <- list(px = px, py = py)

# Simulate with correlation between gradients
sim2d <- coenocline(locs2d, responseModel = "gaussian", 
                    params = pars2d, 
                    extraParams = list(corr = 0.5),
                    countModel = "negbin", 
                    countParams = list(alpha = 1))
```

## Key Functions and Arguments

- `coenocline()`: Main simulation engine.
    - `expectation = TRUE`: Returns the underlying response curve values without random sampling (useful for plotting).
    - `countModel`: Supports `"poisson"`, `"negbin"`, `"bernoulli"`, `"binomial"`, `"betabinomial"`, and zero-inflated variants (`"ZIP"`, `"ZINB"`, `"ZIB"`, `"ZIBB"`).
    - `countParams`: List of additional distribution parameters (e.g., `list(alpha = 0.5)` for negative binomial).
- `plot()`: S3 method for visualizing 1D coenoclines.
- `persp()`: S3 method for visualizing 2D coenoclines as perspective plots.

## Tips for Realistic Data

- **Overdispersion**: Use `countModel = "negbin"` instead of `"poisson"` to simulate the high variance typical of real-world ecological counts.
- **Zero-Inflation**: If your simulated data has too few zeros compared to real observations, use the `ZIP` or `ZINB` models.
- **Parameter Lists**: While matrices are common for `params`, you can also use lists of vectors if species have different parameter requirements.

## Reference documentation

- [coenocliner: a coenocline simulation package for R](./references/coenocliner.md)