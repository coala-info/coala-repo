---
name: r-minpack.lm
description: The nls.lm function provides an R interface to lmder and lmdif from the MINPACK library, for solving nonlinear least-squares problems by a modification of the Levenberg-Marquardt algorithm, with support for lower and upper parameter bounds.  The implementation can be used via nls-like calls using the nlsLM function.  </p>
homepage: https://cloud.r-project.org/web/packages/minpack.lm/index.html
---

# r-minpack.lm

name: r-minpack.lm
description: Solving nonlinear least-squares problems using the Levenberg-Marquardt algorithm. Use this skill when you need to perform nonlinear regression in R, especially when standard nls() fails to converge, requires parameter bounds (lower/upper), or when high-performance optimization from the MINPACK library is needed.

## Overview

The `minpack.lm` package provides an R interface to the Levenberg-Marquardt nonlinear least-squares algorithm found in the MINPACK library. It is particularly robust for fitting nonlinear models to data, even when starting values are far from the solution. The package offers two primary interfaces: `nlsLM()`, which mimics the standard R `nls()` function, and `nls.lm()`, which provides a lower-level functional interface.

## Installation

To install the package from CRAN:

```r
install.packages("minpack.lm")
```

## Main Functions

### nlsLM
The recommended high-level function. It uses a formula-based interface similar to `nls()` but utilizes the Levenberg-Marquardt algorithm and supports parameter bounds.

```r
library(minpack.lm)

# Basic usage with bounds
fit <- nlsLM(y ~ a * exp(b * x), 
             data = my_data, 
             start = list(a = 1, b = 0),
             lower = c(a = 0, b = -Inf),
             upper = c(a = 10, b = 2))
```

### nls.lm
A lower-level function for more complex problems where a formula is not suitable. It requires a function that returns a vector of residuals.

```r
# Define residual function: (observed - theory)
resid_fun <- function(p, observed, x) {
  observed - (p$a * exp(p$b * x))
}

par_start <- list(a = 1, b = 0)
fit_lm <- nls.lm(par = par_start, fn = resid_fun, 
                 observed = y_val, x = x_val)
```

## Workflows

### 1. Formula-based Fitting (nlsLM)
1.  **Prepare Data**: Ensure variables are in a data frame.
2.  **Define Model**: Write the nonlinear formula.
3.  **Set Starting Values**: Provide a named list of initial guesses.
4.  **Set Bounds (Optional)**: Use `lower` and `upper` arguments (vectors matching the order of `start`).
5.  **Execute**: Run `nlsLM()`.
6.  **Inspect**: Use `summary(fit)`, `coef(fit)`, and `predict(fit)`.

### 2. Residual-based Fitting (nls.lm)
1.  **Define Residual Function**: Create a function `fn(par, ...)` that returns the vector of residuals.
2.  **Initialize Parameters**: Create a list or vector of starting values.
3.  **Optimize**: Call `nls.lm(par, fn, ...)` passing additional data via `...`.
4.  **Extract Results**: Access `$par` for estimates and `$hessian` for uncertainty.

## Tips and Best Practices

-   **Convergence Issues**: If the model fails to converge, try adjusting `control = nls.lm.control(maxiter = 100)`.
-   **Bounds**: Unlike base `nls()`, `nlsLM` handles bounds natively without needing to switch to the "port" algorithm.
-   **Starting Values**: Even though Levenberg-Marquardt is robust, providing physically sensible starting values significantly improves performance and reliability.
-   **Weighting**: Use the `weights` argument in `nlsLM` for weighted least squares (minimizing `sum(w * resid^2)`).

## Reference documentation

- [minpack.lm: R Interface to the Levenberg-Marquardt Nonlinear Least-Squares Algorithm](./references/home_page.md)