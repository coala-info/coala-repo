---
name: r-beanplot
description: This tool visualizes univariate data distributions by combining density traces, individual observation lines, and average markers into beanplots. Use when user asks to create beanplots, compare data distributions with an alternative to boxplots or violin plots, or visualize individual data points alongside density estimates.
homepage: https://cloud.r-project.org/web/packages/beanplot/index.html
---


# r-beanplot

name: r-beanplot
description: Visualization of univariate data using beanplots, which combine a density trace, a 1-dimensional scatter plot (rug), and average lines. Use this skill when you need an alternative to boxplots, stripcharts, or violin plots that shows individual observations, bimodal distributions, and group comparisons (including asymmetric/split beans for subgroups).

## Overview

The `beanplot` package provides a flexible way to visualize and compare distributions of univariate data. A "bean" consists of:
1.  **The Pod**: A mirrored density trace (similar to a violin plot).
2.  **The Seeds**: A 1D scatter plot showing every individual observation as a small line.
3.  **The Mean**: A central line representing the average of the batch.
4.  **Overall Average**: A dashed line across the entire plot representing the global mean.

## Installation

```R
install.packages("beanplot")
library(beanplot)
```

## Core Functionality

The primary function is `beanplot()`. It is designed to be a drop-in replacement for `boxplot()`.

### Basic Usage
```R
# Using a formula
beanplot(height ~ voice.part, data = singer, main = "Singer Heights")

# Using multiple vectors
beanplot(rnorm(100), runif(100), rgamma(100, 2))
```

### Key Parameters
- `side`: Controls which side the density is plotted. 
  - `"no"`: Symmetric (default).
  - `"left"`, `"right"`: Single-sided.
  - `"both"`: Used for asymmetric beanplots (comparing two subgroups in one bean).
- `col`: A list or vector defining colors for the bean area, the lines, and the averages.
- `ll`: Length of the individual observation lines (default is 0.16).
- `bw`: Bandwidth for density estimation. By default, it uses the Sheather-Jones method and averages it across all beans for fair comparison.
- `log`: Set to `"y"` for log-axis. The package automatically detects if data might require a log scale and calculates geometric means accordingly.
- `overallline`: The method for the horizontal line across the plot (default is `"mean"`).
- `beanlines`: The method for the per-bean average line (default is `"mean"`).

## Common Workflows

### Comparing Subgroups (Asymmetric Beanplots)
To compare two subgroups (e.g., Male vs Female) within the same categories:
```R
# side = "both" requires a specific color list to distinguish sides
beanplot(height ~ voice.part, data = singer, 
         side = "both", 
         col = list("black", c("grey", "white")),
         border = NA)
legend("bottomleft", fill = c("black", "grey"), legend = c("Subgroup 1", "Subgroup 2"))
```

### Handling Duplicate Observations
If multiple observations have the same value, `beanplot` stacks the lines, making the line longer. This makes it easy to spot rounded data or duplicate measurements.

### Customizing Appearance
```R
beanplot(rnorm(100), 
         main = "Custom Bean",
         col = c("#CAB2D6", "#33A02C", "#B2DF8A"), # Bean color, line color, mean color
         border = "#CAB2D6",
         innerborder = "white",
         ll = 0.05)
```

## Tips for AI Agents
- **Small Datasets**: For beans with fewer than 10 observations, the width is automatically scaled down to indicate lower statistical significance.
- **Log Transformation**: If the data is strictly positive and skewed, `beanplot` often suggests or automatically applies a log scale. It uses `shapiro.test` internally to check for normality/log-normality.
- **Comparison with Boxplots**: Use beanplots when you suspect bimodal or non-normal distributions that a boxplot's quartiles might hide.

## Reference documentation
- [Beanplot: A Boxplot Alternative for Visual Comparison of Distributions](./references/beanplot.md)