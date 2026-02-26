---
name: r-fdrtool
description: This tool performs multiple testing correction by adaptively estimating the null distribution and false discovery rates from data. Use when user asks to estimate q-values, calculate local false discovery rates, determine the null proportion, or perform monotone regression.
homepage: https://cloud.r-project.org/web/packages/fdrtool/index.html
---


# r-fdrtool

## Overview

The `fdrtool` package is a comprehensive toolkit for multiple testing correction. It is unique in its ability to adaptively estimate the parameters of the null distribution (e.g., the empirical null) from the data itself, which is critical when the theoretical null (like a standard normal) does not fit the observed test statistics. It supports both global (Fdr/q-value) and local (fdr) false discovery rates.

## Installation

```R
install.packages("fdrtool")
library("fdrtool")
```

## Core Workflows

### 1. Estimating False Discovery Rates
The primary function is `fdrtool()`. It automatically estimates the null proportion ($\eta_0$) and the null distribution parameters.

```R
# From p-values
data(pvalues)
result <- fdrtool(pvalues, statistic="pvalue")

# From z-scores (normal)
z = rnorm(1000, sd=1.2) # empirical null with inflation
result <- fdrtool(z, statistic="normal")

# From correlation coefficients
r = rcor0(500, kappa=20)
result <- fdrtool(r, statistic="correlation")

# Accessing results
result$pval  # Adjusted p-values
result$qval  # Tail area-based FDR (q-values)
result$lfdr  # Local FDR
result$param # Estimated eta0 and null parameters
```

### 2. Estimating the Null Proportion (eta0)
If you only need to estimate the fraction of true null hypotheses:

```R
# Methods: "smoother" (default), "bootstrap", "conservative", "adaptive", "quantile"
eta0 <- pval.estimate.eta0(pvalues, method="smoother")
```

### 3. Higher Criticism (HC)
HC is useful for detecting rare and weak signals where standard FDR methods might lack power.

```R
# Compute HC scores for all p-values
scores <- hc.score(pvalues)

# Find the optimal HC threshold
thresh <- hc.thresh(pvalues)
```

### 4. Monotone Regression and Density Estimation
The package provides specialized tools for shape-constrained inference.

```R
# Grenander Estimator (non-parametric decreasing density)
z = rexp(50, 1)
g = grenander(ecdf(z))
plot(g)

# Monotone Regression (Isotonic/Antitonic)
x = 1:20
y = x + rnorm(20)
iso_fit = monoreg(x, y, type="isotonic")

# Greatest Convex Minorant (GCM) / Least Concave Majorant (LCM)
res = gcmlcm(x, y, type="gcm")
```

## Distribution Functions

The package includes specialized distributions used in FDR estimation:
- **Half-Normal**: `dhalfnorm`, `phalfnorm`, `qhalfnorm`, `rhalfnorm`.
- **Correlation (rho=0)**: `dcor0`, `pcor0`, `qcor0`, `rcor0`. Use `kappa` (degrees of freedom) as the parameter.

## Tips and Best Practices
- **Empirical Null**: For z-scores and correlations, `fdrtool` does not assume a standard $N(0,1)$. It fits a scale parameter to account for over/under-dispersion.
- **Cutoff Methods**: If the default `cutoff.method="fndr"` fails or produces warnings, try `"pct0"` (uses a quantile, default 0.75) or `"locfdr"`.
- **Visualization**: By default, `fdrtool(..., plot=TRUE)` produces a four-panel diagnostic plot showing the fit of the null model and the resulting FDR curves. Use `color.figure=FALSE` for black and white.

## Reference documentation
- [fdrtool: Estimation of (Local) False Discovery Rates and Higher Criticism](./references/reference_manual.md)