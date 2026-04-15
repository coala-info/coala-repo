---
name: r-segmented
description: The r-segmented package fits regression models with segmented or piece-wise constant relationships to estimate unknown break-points and their corresponding slopes. Use when user asks to fit broken-line regressions, estimate threshold locations in linear models, or test for the existence of break-points in data.
homepage: https://cloud.r-project.org/web/packages/segmented/index.html
---

# r-segmented

## Overview

The `segmented` package provides tools to fit regression models where one or more predictors have a segmented (broken-line) or stepmented (piece-wise constant) effect. It automatically estimates the locations of the break-points (thresholds) along with the regression coefficients. It supports linear models, GLMs, Cox models, and linear mixed-effects models.

## Installation

```R
install.packages("segmented")
library(segmented)
```

## Core Workflow

### 1. Fit a Standard Model
First, fit a non-segmented model (e.g., `lm` or `glm`) using the variables you suspect have break-points.

```R
# Example: Linear model
out.lm <- lm(y ~ x + z, data = mydata)
```

### 2. Estimate Break-points
Use the `segmented()` function to transform the standard model into a segmented one.

```R
# Estimate one break-point for variable 'x'
# psi provides starting values; if NA, the function tries to find them
os <- segmented(out.lm, seg.Z = ~x, psi = NA)

# Multiple break-points or multiple variables
os2 <- segmented(out.lm, seg.Z = ~x + z, psi = list(x = c(10, 20), z = 5))
```

### 3. Summarize and Inspect
The summary provides estimates for the slopes (left and right of the break-point) and the break-point locations.

```R
summary(os)
# Get the estimated break-points specifically
breakpoints(os)
# Get the slopes in each segment
slope(os)
```

## Key Functions

- `segmented(obj, seg.Z, psi, ...)`: The main function to fit segmented relationships. `seg.Z` is a one-sided formula for the segmented variables.
- `stepmented(obj, seg.Z, psi, ...)`: Fits piece-wise constant (step) relationships instead of broken lines.
- `selgmented(obj, ...)`: Selects the number of break-points automatically using various criteria (e.g., BIC or score test).
- `pscore.test(obj, seg.Z, ...)`: Performs a score test for the existence of a break-point.
- `davies.test(obj, seg.Z, ...)`: Tests for a non-zero difference in slope (hypothesis testing for a break-point).
- `draw.history(obj)`: Visualizes the iterative process of break-point estimation.

## Visualizing Results

The `plot()` method for segmented objects displays the fitted lines and the estimated break-points.

```R
plot(os, res = TRUE, conf.level = 0.95)
lines(os, col = "red")
# Add lines for the confidence intervals of the break-points
plot(os, add = TRUE, link = FALSE, lwd = 2)
```

## Advanced Usage: Mixed Models

For models with random effects in the break-points, use `segmented.lme`.

```R
library(nlme)
# Standard lme model
o.lme <- lme(y ~ x, random = ~1|id, data = mydata)
# Segmented lme
os.lme <- segmented(o.lme, seg.Z = ~x, psi = 10)
```

## Tips
- **Starting Values**: If `psi = NA` fails to converge, provide a numeric guess based on a scatter plot of the data.
- **Model Comparison**: Use `anova(out.lm, os)` to compare the linear model against the segmented model.
- **U-shape/V-shape**: Segmented models are excellent for capturing "V" or "U" shaped relationships where the slope changes sign at a specific threshold.

## Reference documentation
- [segmented: Regression Models with Break-Points / Change-Points Estimation (with Possibly Random Effects)](./references/home_page.md)