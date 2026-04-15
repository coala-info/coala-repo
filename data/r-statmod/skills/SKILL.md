---
name: r-statmod
description: The r-statmod package provides specialized algorithms for advanced statistical modeling, including limiting dilution analysis, complex generalized linear models, and numerical integration. Use when user asks to perform limiting dilution analysis, fit Tweedie or Digamma GLMs, calculate Gauss quadrature points, work with inverse-Gaussian distributions, or compare growth curves.
homepage: https://cloud.r-project.org/web/packages/statmod/index.html
---

# r-statmod

name: r-statmod
description: Expert guidance for the R package 'statmod'. Use this skill when performing advanced statistical modeling tasks in R, including: (1) Limiting dilution analysis (ELDA) for estimating frequency of responding cells, (2) Fitting Generalized Linear Models (GLMs) with Tweedie or Digamma families, (3) Calculating Gauss quadrature points and weights for numerical integration, (4) Working with Inverse-Gaussian distributions, (5) Heteroscedastic regression, and (6) Comparing growth curves or fitting mixed linear models.

## Overview
The statmod package provides a collection of specialized algorithms and functions for statistical modeling that extend the core capabilities of R. It is particularly well-known for its implementation of Extreme Limiting Dilution Analysis (ELDA), advanced GLM families (Tweedie, Digamma), and robust numerical integration tools like Gauss quadrature.

## Installation
To install the package, use the following command in R:
install.packages("statmod")

## Main Functions and Workflows

### Limiting Dilution Analysis (ELDA)
The elda() function is used to estimate the frequency of responding units (e.g., stem cells) from limiting dilution assays.
- Use elda(count, dose, group) where count is the number of positive responses and dose is the number of cells seeded.
- It provides a chi-squared test for the single-hit model assumption.
- Use limdil() for a more general interface to limiting dilution calculations.

### Generalized Linear Models (GLMs)
statmod provides families and tools for complex GLM scenarios:
- tweedie(var.power, link.power): Defines a Tweedie family for GLMs, useful for data with a mass at zero and positive continuous values.
- digamma(link): Defines a Digamma family, often used for modeling variances or dispersion.
- glmdm(): Fits a GLM with a model for the dispersion as well as the mean (heteroscedastic regression).
- qresiduals(): Calculates randomized quantile residuals, which are superior for checking GLM fit, especially for discrete distributions.

### Numerical Integration (Gauss Quadrature)
For high-performance numerical integration:
- gauss.quad(n, kind): Computes nodes and weights for Gauss-Legendre, Gauss-Chebyshev, or other quadrature rules.
- gauss.quad.prob(n, dist): Computes nodes and weights for integration against a probability distribution (e.g., "normal", "gamma").

### Probability Distributions
- Inverse Gaussian: Use dinvgauss(), pinvgauss(), qinvgauss(), and rinvgauss() for density, distribution, quantile, and random generation.
- Gumbel: Use dgumbel(), pgumbel(), qgumbel(), and rgumbel().

### Linear Mixed Models and Growth Curves
- remlscore(): Fits linear mixed models using REML scoring, providing an alternative to lme4 for specific variance component structures.
- compareGrowthCurves(): A permutation-based approach to compare groups of growth curves without assuming a specific functional form.

## Tips and Best Practices
- Convergence: If standard GLM fitting fails, statmod functions often include more secure convergence algorithms.
- Tweedie Power: When using the Tweedie family, the power parameter p=1 is Poisson, p=2 is Gamma, and 1 < p < 2 is the compound Poisson-Gamma distribution.
- Quadrature: Always check the number of nodes (n) required for accuracy; for smooth functions, n=20 is often sufficient, but highly peaked functions may require more.
- ELDA: Ensure your data follows the "single-hit" hypothesis; if the elda() output shows a significant p-value for the goodness-of-fit test, the estimated frequency may be biased.

## Reference documentation
- [statmod: Statistical Modeling](./references/home_page.md)