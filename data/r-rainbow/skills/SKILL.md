---
name: r-rainbow
description: The rainbow package provides tools for functional data analysis, focusing on visualization and outlier detection through functional boxplots, bagplots, and rainbow plots. Use when user asks to visualize functional data sets, identify functional outliers, or create depth-based plots for time-indexed curves.
homepage: https://cloud.r-project.org/web/packages/rainbow/index.html
---

# r-rainbow

## Overview
The `rainbow` package provides specialized tools for functional data analysis (FDA). It focuses on visualization and outlier detection by extending classical exploratory data analysis (EDA) tools—like boxplots and bagplots—into the functional domain. It uses a color-spectrum (rainbow) approach to help identify time-based patterns and depth-based ordering to identify central and outlying curves.

## Installation
To install the package from CRAN:
```R
install.packages("rainbow")
library(rainbow)
```

## Core Functions and Workflows

### 1. Data Structure
The package typically works with `fds` (functional data set) objects. You can create one using the `fds` function:
```R
# x: numeric vector of arguments (e.g., years, ages)
# y: matrix of functional responses (rows = x, columns = observations)
my_fds <- fds(x = 1:10, y = matrix(rnorm(100), 10, 10), xname = "Time", yname = "Value")
```

### 2. Rainbow Plots
Visualizes functional data using a color palette that transitions according to the index of the curves (usually time).
```R
# Basic rainbow plot
plot(my_fds, plot.type = "rainbow", colorblind = FALSE)

# Plot with legend
plot(my_fds, plot.type = "rainbow", legend = TRUE)
```

### 3. Functional Bagplots and Boxplots
These plots use functional principal component analysis (FPCA) to project data into two dimensions, then apply bivariate depth measures to identify the median curve and outliers.

*   **Functional Bagplot**: Displays the "dark" inner region (50% central curves) and "light" outer region (containing non-outlying curves).
*   **Functional Boxplot**: Similar to a standard boxplot, showing the median curve, the central 50% region, and maximum non-outlying envelope.

```R
# Functional Bagplot
fbagplot(my_fds, method = "pairwise", plot.type = "functional")

# Functional Boxplot
fboxplot(my_fds, method = "depth.trim", plot.type = "functional")
```

### 4. Outlier Detection
The package provides specific functions to identify indices of curves that are considered functional outliers.
```R
# Identify outliers using the bagplot method
outliers <- foutliers(my_fds, method = "bagplot")
print(outliers$outliers)
```

## Tips and Best Practices
*   **Method Selection**: For `fbagplot` and `fboxplot`, the `method` argument determines how data depth is calculated. Common options include `HDR` (highest density region), `projections`, and `total` (Tukey's depth).
*   **Colorblind Safety**: Use `colorblind = TRUE` in `plot()` to ensure the rainbow palette is accessible.
*   **Smoothing**: If your functional data is noisy, consider smoothing it (e.g., using splines or kernels) before applying `rainbow` visualization tools to better see the underlying functional shapes.
*   **Integration**: This package is often used in conjunction with the `fds` package (which contains datasets) and the `ftsa` (Functional Time Series Analysis) package.

## Reference documentation
- [rainbow: Bagplots, Boxplots and Rainbow Plots for Functional Data](./references/home_page.md)