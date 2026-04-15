---
name: r-gmodels
description: The r-gmodels package provides a collection of R programming tools for model fitting, statistical inference, and SAS/SPSS-style data visualization. Use when user asks to perform cross-tabulations, calculate confidence intervals for model parameters, test general linear hypotheses, or compute custom contrasts for regression models.
homepage: https://cloud.r-project.org/web/packages/gmodels/index.html
---

# r-gmodels

name: r-gmodels
description: Various R programming tools for model fitting, inference, and data visualization. Use this skill when performing SAS/SPSS-style cross-tabulations, calculating confidence intervals for model parameters, testing general linear hypotheses, or computing custom contrasts for regression models (LM, GLM, LME).

## Overview

The `gmodels` package provides a suite of functions that complement base R's modeling capabilities. It is particularly useful for users transitioning from other statistical software who require detailed contingency tables or for researchers needing to test specific linear combinations of model coefficients.

## Installation

Install the package from CRAN:

```R
install.packages("gmodels")
```

## Main Functions and Workflows

### Cross-Tabulation with CrossTable()
Use `CrossTable()` to produce 2-way contingency tables with optional chi-square, Fisher's Exact, and McNemar tests. It provides a layout similar to PROC FREQ in SAS or CROSSTABS in SPSS.

```R
library(gmodels)
# Basic cross-tabulation
CrossTable(data$row_var, data$col_var, prop.r=TRUE, prop.c=TRUE, prop.t=FALSE, chisq=TRUE)
```

### Confidence Intervals with ci()
Use `ci()` to compute confidence intervals for a vector of data or for the parameters of a fitted model.

```R
# For a numeric vector
ci(my_data, confidence=0.95)

# For a model object
fit <- lm(y ~ x1 + x2, data=my_df)
ci(fit)
```

### Testing Contrasts and Estimable Functions
Use `fit.contrast()` and `estimable()` to test specific hypotheses about linear combinations of model coefficients.

*   **fit.contrast()**: Compute and test arbitrary contrasts for regression objects (LM, GLM, ANOVA).
*   **estimable()**: Calculate the value, standard error, and p-value for a linear combination of parameters (e.g., $L\beta$).

```R
# Example: Testing if the average of group A and B is different from group C
fit <- lm(yield ~ group, data=my_data)
fit.contrast(fit, "group", c(0.5, 0.5, -1))

# Using estimable for a specific linear combination
estimable(fit, cm=c("(Intercept)"=0, "groupB"=1, "groupC"=-1))
```

### General Linear Hypothesis Testing
Use `glh.test()` to test the hypothesis $C\beta = d$ for a regression model.

```R
# Test if two coefficients are equal (beta1 - beta2 = 0)
cm <- matrix(c(0, 1, -1), nrow=1)
glh.test(fit, cm)
```

### Efficient PCA
Use `fast.prcomp()` for a more efficient computation of principal components, especially useful for large datasets where only a few components are needed.

## Tips for Model Fitting
*   **Model Summaries**: Use `coefFrame()` to extract model parameters, standard errors, and confidence intervals into a clean data frame for reporting.
*   **Contrast Construction**: Use `make.contrasts()` to create user-specified contrast matrices that can be passed to `contrasts()` in base R.
*   **Compatibility**: Most functions in `gmodels` work seamlessly with `lm`, `glm`, `lme` (from `nlme`), and `merMod` (from `lme4`) objects.

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)