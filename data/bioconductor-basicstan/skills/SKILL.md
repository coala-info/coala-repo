---
name: bioconductor-basicstan
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BASiCStan.html
---

# bioconductor-basicstan

## Overview

`BASiCStan` is a Bioconductor package that provides a Stan-based implementation of the BASiCS (Bayesian Analysis of Single-Cell Sequencing) model. While the original `BASiCS` package uses adaptive Metropolis-within-Gibbs sampling, `BASiCStan` leverages `rstan` to allow for:
- **Hamiltonian Monte Carlo (HMC)** for more efficient posterior sampling.
- **Variational Inference (VI)** for rapid, approximate posterior estimation.
- **Maximum a Posteriori (MAP)** estimation.

The package is designed to be compatible with `SingleCellExperiment` objects and integrates seamlessly with the existing `BASiCS` ecosystem.

## Core Workflow

### 1. Data Preparation
`BASiCStan` requires a `SingleCellExperiment` object. You can use `BASiCS_MockSCE()` to generate a toy dataset for testing.

```r
library(BASiCStan)
set.seed(42)
sce <- BASiCS_MockSCE()
```

### 2. Running the Model
The primary function is `BASiCStan()`. Note that it currently only supports the regression-based prior (`Regression = TRUE`).

```r
# Run using Stan's default HMC sampling
stan_fit <- BASiCStan(sce, Method = "sampling", iter = 1000)

# Run using Variational Inference (faster for large datasets)
stan_vi <- BASiCStan(sce, Method = "vb")

# Run to get MAP estimates
stan_map <- BASiCStan(sce, Method = "optimizing")
```

### 3. Handling Output
By default, `BASiCStan()` returns a `BASiCS_Chain` object, making it compatible with standard `BASiCS` visualization and downstream analysis functions.

```r
# Visualize the fit (mean vs over-dispersion)
BASiCS_ShowFit(stan_fit)
```

### 4. Advanced Stan Diagnostics
To access raw Stan objects for diagnostics (like R-hat or effective sample size), set `ReturnBASiCS = FALSE`.

```r
# Get raw rstan object
stan_obj <- BASiCStan(sce, ReturnBASiCS = FALSE, Method = "sampling", iter = 500)

# View Stan diagnostics
print(summary(stan_obj)$summary)

# Convert back to BASiCS_Chain when ready for BASiCS workflows
chain_obj <- Stan2BASiCS(stan_obj)
```

## Key Functions

- `BASiCStan()`: Main interface for Stan-based BASiCS inference.
- `Stan2BASiCS()`: Converts a raw Stan fit object into a `BASiCS_Chain` object.
- `BASiCS_MCMC()`: (From `BASiCS` package) The original Metropolis-within-Gibbs implementation for comparison.

## Tips and Best Practices

- **Regression Mode**: `BASiCStan` only supports the joint prior between mean and over-dispersion parameters (equivalent to `Regression = TRUE` in the original `BASiCS`).
- **Spike-ins**: The package automatically detects spike-in information if present in the `altExp` slot of the `SingleCellExperiment` object.
- **Convergence**: If using `Method = "sampling"`, always check for divergent transitions. If they occur, consider increasing `adapt_delta` via the `control` argument or increasing the number of iterations.
- **Speed**: For very large datasets where MCMC is prohibitive, `Method = "vb"` (Variational Bayes) provides a significantly faster approximation.

## Reference documentation

- [An introduction to BASiCStan](./references/BASiCStan.md)