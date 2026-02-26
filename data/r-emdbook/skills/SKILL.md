---
name: r-emdbook
description: The emdbook package provides auxiliary functions and datasets to support ecological modeling and maximum likelihood estimation in R. Use when user asks to visualize likelihood surfaces, calculate profile confidence intervals, work with ecological distributions like beta-binomial or zero-inflated models, or access ecological datasets.
homepage: https://cloud.r-project.org/web/packages/emdbook/index.html
---


# r-emdbook

## Overview
The `emdbook` package is a collection of auxiliary functions and datasets designed to support the book "Ecological Models and Data in R" by Benjamin Bolker. It is primarily used for maximum likelihood estimation (MLE), providing tools to visualize likelihood surfaces, calculate profile confidence intervals, and handle common ecological distributions (like the beta-binomial or zero-inflated distributions).

## Installation
To install the package from CRAN:
```R
install.packages("emdbook")
```

## Key Functions and Workflows

### Likelihood Visualization
One of the core strengths of `emdbook` is visualizing the "shape" of a model fit.
- `curve3d()`: Evaluates a function over a 2D grid. Useful for plotting likelihood surfaces.
- `calc_loglik()`: A helper to calculate log-likelihoods over a grid.
- `contour_mle()`: Creates contour plots of the likelihood surface around the maximum likelihood estimate.

### Probability Distributions
The package provides density, distribution, and random generation functions for distributions common in ecology:
- `dbetabinom()` / `rbetabinom()`: Beta-binomial distribution (overdispersed binomial data).
- `dzinbinom()` / `rzinbinom()`: Zero-inflated negative binomial distribution.
- `dmvnorm()`: Multivariate normal distribution.

### Model Fitting Utilities
- `mle2()`: While `mle2` is technically in the `bbmle` package (a successor to `emdbook`), `emdbook` provides the foundational logic and several wrappers for optimization.
- `lumped_mle()`: Fits models where some data points are "lumped" or censored.
- `profile.mle2()`: Methods for calculating likelihood profiles to find robust confidence intervals.

### Ecological Datasets
The package includes several classic ecological datasets for practice and benchmarking:
- `seedpred`: Seed predation data.
- `ChlorellaGrowth`: Algal growth data.
- `GobySurvival`: Survival data for neon gobies.
- `FirDBH`: Diameter at breast height for fir trees.

## Example Workflow: Visualizing a Likelihood Surface
```R
library(emdbook)

# Define a simple negative log-likelihood function
nll <- function(mu, sigma) {
  -sum(dnorm(rnorm(100, mean=5, sd=2), mean=mu, sd=sigma, log=TRUE))
}

# Create a 3D surface of the likelihood
curve3d(nll(x, y), 
        xlim=c(3, 7), ylim=c(1, 4), 
        sys3d="contour",
        xlab="mu", ylab="sigma")
```

## Tips
- **Optimization**: If `optim` fails, use `curve3d` to visualize the surface; it often reveals local minima or "flat" regions that prevent convergence.
- **Overdispersion**: Use `dbetabinom` when your count data has more variance than a standard binomial distribution would suggest.
- **Integration**: `emdbook` works best alongside the `bbmle` package for more advanced model formula interfaces.

## Reference documentation
- [Ecological Models and Data in R](./references/home_page.md)