---
name: r-car
description: This tool provides expert guidance for performing applied regression analysis, diagnostics, and hypothesis testing using the R package car. Use when user asks to perform Type-II or Type-III ANOVA, calculate variance inflation factors, conduct linear hypothesis tests, or apply power transformations to data.
homepage: https://cloud.r-project.org/web/packages/car/index.html
---


# r-car

name: r-car
description: Expert guidance for the 'car' (Companion to Applied Regression) R package. Use this skill when performing regression diagnostics, hypothesis testing (ANOVA, linear hypotheses), data transformations, and model visualizations. It is essential for tasks involving Type-II and Type-III ANOVA, variance inflation factors (VIF), Box-Cox transformations, and identifying influential observations in linear and generalized linear models.

# r-car

## Overview
The `car` package provides a wide array of functions for applied regression analysis, extending the capabilities of base R. It is the standard tool for social scientists and statisticians for performing complex hypothesis tests, diagnostic checking, and power transformations.

## Installation
To install the package from CRAN:
```r
install.packages("car")
```

## Main Functions and Workflows

### Hypothesis Testing
- `Anova(mod, type = "II")`: Calculates Type-II or Type-III sums of squares. Unlike base R `anova()`, `Anova()` provides tests that are invariant to the order of terms in the model.
- `linearHypothesis(mod, hypothesis)`: Performs Wald tests for linear combinations of coefficients (e.g., testing if two coefficients are equal).

### Regression Diagnostics
- `vif(mod)`: Calculates Variance Inflation Factors to detect multicollinearity.
- `outlierTest(mod)`: Bonferroni outlier test for the largest absolute studentized residual.
- `influenceIndexPlot(mod)`: Visualizes Cook's distance, studentized residuals, and hat values to identify influential cases.
- `ncvTest(mod)`: Score test for non-constant error variance (heteroscedasticity).
- `crPlots(mod)`: Component-plus-residual (partial residual) plots to check for non-linearity.

### Data Transformations
- `boxCox(mod)`: Graphical tool to find the optimal lambda for power transformations.
- `bcPower(x, lambda)`: Applies the Box-Cox power transformation.
- `logit(x)`: Performs logit transformations for proportions.

### Visualizations
- `qqPlot(mod)`: Quantile-Comparison plots with confidence envelopes.
- `avPlots(mod)`: Added-variable plots (partial-regression plots).
- `scatterplotMatrix(~ x1 + x2 + x3, data = df)`: Enhanced scatterplot matrices with density estimates and smoothers.

## Usage Tips

### Scoping in User-Defined Functions
When calling `car` functions (like `ncvTest`) inside your own custom R functions, the underlying model evaluation may fail to find the data object.
- **Problem**: `Error in eval(data, ...) : object 'dta' not found`.
- **Solution**: Ensure the data and formula are accessible in the environment where the model was created. If necessary, assign the data to the global environment temporarily or ensure the model object carries the environment of the data.

### Type-II vs Type-III ANOVA
- Use `type = "II"` for models without interactions or when obeying the principle of marginality.
- Use `type = "III"` when you have interactions and want to test main effects in the presence of those interactions (requires specific contrasts, e.g., `options(contrasts=c("contr.sum", "contr.poly"))`).

## Reference documentation
- [Using car and effects Functions in Other Functions](./references/embedding.md)