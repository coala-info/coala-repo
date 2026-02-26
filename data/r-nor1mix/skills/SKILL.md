---
name: r-nor1mix
description: "The r-nor1mix package provides tools for creating, fitting, and visualizing one-dimensional normal mixture models. Use when user asks to create normal mixture objects, fit models using EM or MLE algorithms, calculate mixture densities, or access Marron-Wand benchmark densities."
homepage: https://cloud.r-project.org/web/packages/nor1mix/index.html
---


# r-nor1mix

## Overview
The `nor1mix` package provides an S3 class `norMix` for one-dimensional Normal Mixture models. It is designed for density estimation, clustering research, and teaching. It includes the famous Marron-Wand benchmark densities (e.g., "Claw", "Asymmetric Double Claw") and efficient tools for calculating densities, cumulative distributions, and quantiles for mixtures.

## Installation
```R
install.packages("nor1mix")
```

## Core Workflows

### 1. Creating and Using Mixture Models
Create a mixture by specifying weights ($w$), means ($\mu$), and standard deviations ($\sigma$).

```R
library(nor1mix)

# Create a 2-component mixture: 40% N(0, 1) and 60% N(5, 2)
mw <- norMix(mu = c(0, 5), sigma = c(1, 2), w = c(0.4, 0.6))

# Basic functions (d/p/r/q)
x <- seq(-5, 15, length=200)
d <- dnorMix(x, mw)      # Density
p <- pnorMix(x, mw)      # CDF
r <- rnorMix(500, mw)    # Random generation
q <- qnorMix(c(0.1, 0.5, 0.9), mw) # Quantiles
```

### 2. Fitting Models to Data
The package provides two primary methods for fitting a mixture to a numeric vector `x`.

*   **EM Algorithm**: Traditional Expectation-Maximization.
    ```R
    # Fit a 3-component model using EM
    fit_em <- norMixEM(x, m = 3)
    ```
*   **Maximum Likelihood (ML)**: Direct optimization of the log-likelihood.
    ```R
    # Fit a 3-component model using ML
    fit_ml <- norMixMLE(x, m = 3)
    ```

### 3. Visualization
The package provides specialized plotting methods for `norMix` objects.

```R
# Plot the density of a model
plot(mw, main = "My Mixture Model")

# Overlay a fit on a histogram of data
hist(r, prob = TRUE, col = "lightgray")
lines(mw, col = "red", lwd = 2)
```

### 4. Marron-Wand Benchmarks
Access standard test densities used in smoothing and density estimation literature.

```R
# List available Marron-Wand densities
# Examples: MW.nm1 (Gaussian), MW.nm5 (Outlying), MW.nm10 (Claw)
plot(MW.nm10, main = "The Claw Density")
```

## Key Functions Reference
*   `norMix()`: Constructor for `norMix` objects.
*   `dnorMix(x, obj)`, `pnorMix(q, obj)`, `qnorMix(p, obj)`, `rnorMix(n, obj)`: Distribution functions.
*   `norMixMLE(x, m)`: Maximum Likelihood Estimation for $m$ components.
*   `norMixEM(x, m)`: EM Algorithm for $m$ components.
*   `logLik(obj)`: Extract log-likelihood from a fitted model.
*   `MW.nm1` through `MW.nm15`: Marron-Wand benchmark densities.

## Tips
*   **Component Selection**: Use `AIC()` or `BIC()` on objects returned by `norMixMLE` or `norMixEM` to compare models with different numbers of components ($m$).
*   **Initial Values**: `norMixEM` and `norMixMLE` are sensitive to starting values. If convergence fails, try different seeds or check for outliers.
*   **Mass**: Use `mass(obj)` to get the total mass (should be 1).

## Reference documentation
- [README](./references/README.md)
- [home_page](./references/home_page.md)