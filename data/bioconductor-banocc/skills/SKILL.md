---
name: bioconductor-banocc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/banocc.html
---

# bioconductor-banocc

name: bioconductor-banocc
description: Bayesian Analysis of Compositional Covariance (BAnOCC) for inferring correlation structures in compositional data (e.g., microbiome, geology, economics). Use this skill to handle sum-constrained data where naive correlation measures are inappropriate, specifically for estimating log-basis correlations using Hamiltonian Monte Carlo.

## Overview
BAnOCC is designed to estimate the correlation between features in compositional data. Compositional data (where samples sum to a fixed value, like 1 or 100%) suffer from spurious correlations. BAnOCC addresses this by assuming the underlying unobserved counts follow a log-normal distribution and uses a Bayesian Graphical LASSO (GLASSO) prior to infer a parsimonious correlation matrix of the log-basis.

## Typical Workflow

1. **Compile the Model**: The Stan model must be compiled once per session to save time during sampling.
2. **Prepare Data**: Input data `C` should be an $N \times P$ matrix where row sums are $\leq 1$.
3. **Run Sampling**: Use `run_banocc` to generate posterior samples.
4. **Extract Results**: Use `get_banocc_output` to calculate estimates and credible intervals.
5. **Assess Convergence**: Check Rhat statistics and traceplots to ensure the MCMC chains have mixed.

## Core Functions

### Model Compilation
```r
library(banocc)
library(rstan)
# Compile the built-in Stan model
compiled_model <- rstan::stan_model(model_code = banocc::banocc_model)
```

### Running BAnOCC
The `run_banocc` function is a wrapper for `rstan::sampling`.
```r
# Basic run with default priors
# C: Compositional matrix (N samples x P features)
fit <- run_banocc(C = my_data, 
                  compiled_banocc_model = compiled_model,
                  chains = 2, 
                  iter = 1000)
```

### Extracting Output
`get_banocc_output` processes the `stanfit` object into readable matrices.
```r
# Get median estimates and 95% credible intervals
results <- get_banocc_output(banoccfit = fit, conf_alpha = 0.05)

# Access median correlation matrix
cor_median <- results$Estimates.median

# Access credible intervals (Lower and Upper)
ci_lower <- results$CI.lower
ci_upper <- results$CI.upper
```

## Advanced Configuration

### Setting Priors
- **Log-basis mean (n, L)**: Default is uninformative (mean 0, large variance).
- **GLASSO Shrinkage (a, b)**: Parameters for the Gamma hyperprior on $\lambda$. 
  - Set `a < 1` to put more mass near zero for sparsity.
  - Large `b` decreases the variance of the shrinkage parameter.

```r
p <- ncol(my_data)
fit_custom <- run_banocc(C = my_data,
                         compiled_banocc_model = compiled_model,
                         n = rep(0, p),
                         L = 10 * diag(p),
                         a = 0.5,
                         b = 0.01)
```

### Convergence Diagnostics
If `get_banocc_output` returns `NA` for estimates, the model likely failed convergence checks.
- **Traceplots**: `rstan::traceplot(fit$Fit, pars = "O[1,2]")`
- **Rhat**: `rstan::summary(fit$Fit)$summary[, "Rhat"]` (Values should be close to 1.0).
- **Manual Override**: To see results even if convergence failed, set `eval_convergence = FALSE` in `get_banocc_output`.

## Tips for Success
- **Parallelization**: Use `cores = parallel::detectCores()` in `run_banocc` to speed up sampling.
- **Initial Values**: Setting the initial precision matrix `O` to the identity matrix (via the `init` argument) often helps the model converge to a parsimonious solution.
- **Zero Inflation**: While BAnOCC handles compositional constraints, extremely sparse data (many zeros) may require pre-processing or specific prior tuning.

## Reference documentation
- [Introduction to BAnOCC](./references/banocc-vignette.md)