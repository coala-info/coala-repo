---
name: r-hdrcde
description: The r-hdrcde package provides tools for calculating and visualizing highest density regions and conditional density estimates for univariate and bivariate data. Use when user asks to calculate highest density regions, create HDR boxplots, perform conditional density estimation, or conduct multimodal regression.
homepage: https://cloud.r-project.org/web/packages/hdrcde/index.html
---

# r-hdrcde

## Overview
The `hdrcde` package provides tools for analyzing and visualizing data through Highest Density Regions (HDRs). Unlike standard confidence intervals, HDRs can be disjoint, making them superior for multimodal distributions. The package also supports Conditional Density Estimation (CDE) to explore how the distribution of a response variable changes relative to a covariate.

## Installation
```R
install.packages("hdrcde")
library(hdrcde)
```

## Core Workflows

### 1. Univariate Highest Density Regions
Use `hdr()` to find the intervals containing the highest density for a given probability.
```R
# Calculate HDRs for 50%, 95%, and 99% coverage
hdr_results <- hdr(faithful$eruptions, prob = c(50, 95, 99))

# Visualize with a density plot
hdr.den(faithful$eruptions)

# Visualize with an HDR boxplot (better for multimodal data)
hdr.boxplot(faithful$eruptions)
```

### 2. Bivariate Highest Density Regions
Analyze the joint density of two variables.
```R
# Create a bivariate HDR scatterplot (points colored by density region)
hdrscatterplot(faithful$waiting, faithful$eruptions)

# Create a 2D HDR boxplot
hdr.boxplot.2d(faithful$waiting, faithful$eruptions)
```

### 3. Conditional Density Estimation (CDE)
Estimate $f(y|x)$ using local polynomial estimation.
```R
# Estimate conditional density
fit_cde <- cde(x = faithful$waiting, y = faithful$eruptions)

# Plot as a 3D surface (stacked densities)
plot(fit_cde)

# Plot as HDRs over the conditioning variable
plot(fit_cde, plot.fn = "hdr")
```

### 4. Multimodal Regression
When a relationship is not a single line but follows multiple paths (modes).
```R
# Perform modal regression
fit_modal <- modalreg(lane2$flow, lane2$speed)
```

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `hdr()` | Calculates endpoints of HDRs for 1D data. |
| `hdr.2d()` | Calculates bivariate HDRs. |
| `hdr.boxplot()` | Draws a boxplot where the "box" represents the HDR. |
| `cde()` | Kernel conditional density estimation. |
| `hdr.cde()` | Calculates HDRs for conditional density estimates. |
| `modalreg()` | Nonparametric multi-valued regression based on conditional modes. |
| `BoxCox()` | Applies Box-Cox transformation (useful for positive-only data). |

## Tips and Best Practices
- **Multimodality**: If `hdr()` returns multiple intervals for a single probability level, the data is likely multimodal. Use `hdr.boxplot()` to visualize this clearly.
- **Bandwidth Selection**: Most functions have automatic bandwidth selection (`hdrbw()`), but you can manually override using the `h` (for 1D) or `a` and `b` (for CDE) arguments.
- **Boundary Constraints**: For data that must be positive (e.g., duration), use the `lambda` argument in `hdr()` or `hdr.den()` to apply a Box-Cox transformation, ensuring the density estimate doesn't leak below zero.
- **CDE Plotting**: When using `plot.cde()`, `plot.fn = "hdr"` is often more readable than the default "stacked" perspective plot for identifying changes in variance or multimodality across $x$.

## Reference documentation
- [Package ‘hdrcde’ Reference Manual](./references/reference_manual.md)