---
name: r-sads
description: The r-sads tool provides maximum likelihood methods to fit, compare, and simulate species abundance and rank-abundance distributions. Use when user asks to fit probability distributions to ecological community data, generate Preston octaves, create Whitaker plots, or compare species abundance models using AIC.
homepage: https://cran.r-project.org/web/packages/sads/index.html
---


# r-sads

name: r-sads
description: Maximum likelihood tools to fit and compare models of species abundance distributions (SADs) and species rank-abundance distributions (RADs). Use this skill when analyzing ecological community data to fit probability distributions (like log-series, Poisson-lognormal, or Zipf) to species abundance data, generate Preston octaves, or create Whitaker plots.

## Overview

The `sads` package provides a comprehensive framework for fitting, comparing, and simulating Species Abundance Distributions (SADs). It builds upon the `bbmle` package to provide maximum likelihood estimates (MLE) for various ecological models.

## Installation

```R
install.packages("sads")
library(sads)
```

## Core Workflows

### 1. Exploratory Data Analysis
Before fitting models, use these functions to visualize the distribution of species:

*   **Octaves (Preston's classes):** Use `octav()` to tabulate species into log2 abundance classes.
    ```R
    oc <- octav(moths)
    plot(oc)
    # Use prop = TRUE for relative frequencies
    plot(oc, prop = TRUE)
    ```
*   **Rank-Abundance (Whitaker plots):** Use `rad()` to sort abundances and assign ranks.
    ```R
    rd <- rad(moths)
    plot(rd, ylab = "Abundance")
    ```

### 2. Model Fitting
The package provides two primary fitting functions:

*   **`fitsad(x, sad, ...)`**: Fits a Species Abundance Distribution to a vector of abundances.
    *   Common `sad` models: `'ls'` (log-series), `'poilog'` (Poisson-lognormal), `'lnorm'` (lognormal), `'geom'` (geometric).
    *   Example: `fit1 <- fitsad(moths, sad = 'ls')`
*   **`fitrad(x, rad, ...)`**: Fits a Rank-Abundance Distribution.
    *   Common `rad` models: `'gs'` (geometric series), `'rbs'` (broken-stick), `'zipf'` (Zipf), `'mand'` (Zipf-Mandelbrot).
    *   Example: `fit2 <- fitrad(moths, rad = 'zipf')`
*   **`fitsadC()`**: Specifically for abundance class data (e.g., percent cover) using histogram objects.

### 3. Model Diagnostics and Comparison
Objects returned by `fitsad` and `fitrad` inherit from `mle2`.

*   **Summaries:** `summary(fit1)` provides coefficients and standard errors.
*   **Likelihood:** `logLik(fit1)`, `AIC(fit1)`, and `profile(fit1)`.
*   **Visual Diagnostics:** `plot(fit1)` generates four plots: Octave, RAD, Q-Q, and P-P plots.
*   **Comparison:** Use `bbmle::AICtab()` to compare multiple models.
    ```R
    library(bbmle)
    AICtab(fit_ls, fit_poilog, fit_lnorm, base = TRUE)
    ```
    *Note: Do not compare `fitsad` and `fitrad` objects in the same table; they use different likelihood definitions.*

### 4. Predicted Values
To overlay model fits on empirical plots:
*   Use `octavpred(fit_object)` for octave lines.
*   Use `radpred(fit_object)` for rank-abundance lines.
```R
plot(octav(moths))
lines(octavpred(fit1), col = "red")
```

### 5. Simulations
Use `rsad()` to simulate community samples.
```R
# Simulate a Poisson sample (10% fraction) from a lognormal community
samples <- rsad(S = 100, frac = 0.1, sad = "lnorm", coef = list(meanlog = 5, sdlog = 2))
```

## Tips and Constraints
*   **Truncation:** Many SAD models are zero-truncated by default. You can specify truncation points using the `trunc` argument in `fitsad`.
*   **Data Format:** `fitsad` expects a numeric vector of abundances. `fitrad` can take a numeric vector or a `rad` object.
*   **Optimization:** If a fit fails to converge, try providing better starting values via the `start` list argument.

## Reference documentation
- [Fitting species abundance models with maximum likelihood](./references/sads_intro.md)