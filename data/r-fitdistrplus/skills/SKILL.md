---
name: r-fitdistrplus
description: The r-fitdistrplus package provides a comprehensive toolbox for fitting univariate distributions to both non-censored and censored data using various estimation methods. Use when user asks to fit probability distributions to data, estimate distribution parameters, evaluate goodness-of-fit, or compare different distribution models.
homepage: https://cloud.r-project.org/web/packages/fitdistrplus/index.html
---


# r-fitdistrplus

## Overview
The `fitdistrplus` package provides a comprehensive toolbox for fitting univariate distributions. It extends the functionality of `MASS::fitdistr` by supporting multiple estimation methods, censored data, and extensive graphical tools for goodness-of-fit assessment.

## Installation
To install the package from CRAN:
```r
install.packages("fitdistrplus")
library(fitdistrplus)
```

## Core Workflow

### 1. Data Exploration
Before fitting, visualize the data and check empirical moments.
- `plotdist(data)`: Plots a histogram, density, and CDF.
- `descdist(data)`: Provides a Cullen and Frey graph (skewness vs. kurtosis) to suggest candidate distributions.

### 2. Fitting Non-Censored Data
Use `fitdist(data, distr, method, ...)` where `distr` is the root name (e.g., "norm", "gamma").
- **Methods**:
  - `"mle"`: Maximum Likelihood Estimation (default).
  - `"mme"`: Moment Matching Estimation.
  - `"qme"`: Quantile Matching Estimation (requires `probs` argument).
  - `"mge"`: Maximum Goodness-of-Fit Estimation (requires `gof` argument like "CvM", "AD", or "KS").
  - `"mse"`: Maximum Spacing Estimation.

Example:
```r
fit_g <- fitdist(my_data, "gamma", method = "mle")
summary(fit_g)
```

### 3. Fitting Censored Data
Censored data must be a dataframe with two columns: `left` and `right`.
- `NA` in `left`: Left-censored.
- `NA` in `right`: Right-censored.
- `left == right`: Non-censored.
- `left != right`: Interval-censored.

Use `fitdistcens(censdata, distr)`:
```r
# Example censored data frame
d_cens <- data.frame(left = c(10, 20, NA, 40), right = c(10, 30, 15, NA))
fit_c <- fitdistcens(d_cens, "lnorm")
```

### 4. Evaluating and Comparing Fits
Compare multiple objects of class `fitdist` or `fitdistcens`.
- **Graphical Comparison**: `denscomp()`, `cdfcomp()`, `qqcomp()`, `ppcomp()`.
- **Statistics**: `gofstat()` provides Chi-squared, KS, AD, and CvM statistics along with AIC/BIC.

```r
fit_n <- fitdist(my_data, "norm")
fit_l <- fitdist(my_data, "lnorm")
gofstat(list(fit_n, fit_l), fitnames = c("normal", "lognormal"))
```

### 5. Uncertainty Estimation
Use bootstrap to estimate confidence intervals for parameters and quantiles.
- `bootdist(fitoat, niter = 1000)`: Non-parametric bootstrap.
- `quantile(boot_obj, probs = 0.05)`: Confidence intervals for quantiles.

## Advanced Tips
- **Starting Values**: If optimization fails, provide `start = list(param1 = val1, ...)` or use `prefit()`.
- **Custom Distributions**: You can fit any distribution as long as the `d`, `p`, `q` functions are defined in the environment.
- **Optimization**: Change the algorithm via `optim.method` (e.g., "Nelder-Mead", "BFGS", "SANN"). Use `lower` and `upper` for constrained optimization.
- **ggplot2 Support**: Most plotting functions support `plotstyle = "ggplot"`.

## Reference documentation
- [Frequently Asked Questions](./references/FAQ.Rmd)
- [Which optimization algorithm to choose?](./references/Optimalgo.Rmd)
- [Overview of the fitdistrplus package](./references/fitdistrplus_vignette.Rmd)
- [Starting values for fitdist](./references/starting-values.Rmd)