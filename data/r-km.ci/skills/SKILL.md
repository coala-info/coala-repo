---
name: r-km.ci
description: "Computes various confidence intervals for the Kaplan-Meier         estimator, namely: Peto's CI, Rothman CI, CI's based on         Greenwood's variance, Thomas and Grunkemeier CI and the         simultaneous confidence bands by Nair and Hall and Wellner.</p>"
homepage: https://cloud.r-project.org/web/packages/km.ci/index.html
---

# r-km.ci

name: r-km.ci
description: Computes various confidence intervals and simultaneous confidence bands for the Kaplan-Meier estimator. Use when performing survival analysis in R and requiring advanced CI methods beyond the standard log-transformed intervals provided by the survival package, such as Peto, Rothman, Thomas-Grunkemeier, or Hall-Wellner/Nair simultaneous bands.

## Overview
The `km.ci` package extends the `survival` package by providing additional methods for calculating point-wise confidence intervals and simultaneous confidence bands for Kaplan-Meier survival curves. It is particularly useful when standard Greenwood-based intervals are insufficient or when simultaneous coverage across the entire time range is required.

## Installation
Install the package from CRAN:
```R
install.packages("km.ci")
```

## Core Workflow
To use `km.ci`, you must first generate a standard survival object using the `survival` package.

1.  **Load libraries**: Load both `survival` and `km.ci`.
2.  **Create survfit object**: Use `survfit(Surv(time, status) ~ 1, data = ...)` to create the base estimator.
3.  **Apply km.ci**: Pass the `survfit` object to the `km.ci()` function to recalculate the confidence intervals using the desired method.

## Main Functions

### km.ci(survobj, conf.level = 0.95, method = ...)
Recalculates the confidence intervals for a `survfit` object.

**Arguments:**
*   `survobj`: A `survfit` object created by the `survival` package.
*   `conf.level`: The confidence level (default is 0.95).
*   `method`: The specific CI or band method to apply.

**Point-wise Confidence Interval Methods:**
*   `"peto"`: Peto's CI.
*   `"rothman"`: Rothman CI.
*   `"grunkemeier"`: Thomas and Grunkemeier CI.
*   `"log"`, `"loglog"`, `"linear"`, `"logit"`, `"arcsin"`: Standard transformations based on Greenwood's variance.

**Simultaneous Confidence Band Methods:**
*   `"hall-wellner"`: Hall-Wellner simultaneous confidence bands.
*   `"nair"`: Nair's (Equal Precision) simultaneous confidence bands.

## Examples

### Basic Point-wise CI (Peto)
```R
library(survival)
library(km.ci)

# Fit standard KM
data(leukemia, package = "survival")
fit <- survfit(Surv(time, status) ~ 1, data = leukemia)

# Apply Peto CI
fit_peto <- km.ci(fit, method = "peto")

# Plot results
plot(fit_peto, main = "KM with Peto CI")
```

### Simultaneous Confidence Bands (Hall-Wellner)
Simultaneous bands are wider than point-wise intervals because they provide coverage for the entire survival curve simultaneously.
```R
# Apply Hall-Wellner bands
fit_hw <- km.ci(fit, method = "hall-wellner")

# Plot results
plot(fit_hw, main = "KM with Hall-Wellner Bands")
```

## Tips and Best Practices
*   **Object Compatibility**: `km.ci` returns a `survfit` object. You can use it with any standard survival plotting functions (e.g., `plot()`, `survminer::ggsurvplot()`).
*   **Method Selection**: Use `"hall-wellner"` or `"nair"` when you need to make statements about the entire survival curve rather than specific time points.
*   **Data Requirements**: Ensure your `survfit` object is not empty and contains valid time and status data, as the package relies on the underlying `surv` component.

## Reference documentation
- [km.ci: Confidence Intervals for the Kaplan-Meier Estimator](./references/home_page.md)