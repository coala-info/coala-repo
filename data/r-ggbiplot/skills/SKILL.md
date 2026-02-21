---
name: r-ggbiplot
description: "A 'ggplot2' based implementation of biplots, giving a representation of a dataset in     a two dimensional space accounting for the greatest variance, together with variable vectors     showing how the data variables relate to this space. It provides a      replacement for stats::biplot(), but with many enhancements to control the analysis and     graphical display. It implements      biplot and scree plot methods which can be used with the results of prcomp(), princomp(),     FactoMineR::PCA(), ade4::dudi.pca() or MASS::lda() and can be customized using 'ggplot2' techniques.</p>"
homepage: https://cran.r-project.org/web/packages/ggbiplot/index.html
---

# r-ggbiplot

name: r-ggbiplot
description: A ggplot2-based implementation of biplots for visualizing multivariate data. Use this skill when you need to create high-quality biplots or scree plots from principal component analysis (PCA) or linear discriminant analysis (LDA) objects. It supports objects from stats::prcomp(), stats::princomp(), FactoMineR::PCA(), ade4::dudi.pca(), and MASS::lda().

# r-ggbiplot

## Overview
`ggbiplot` provides a grammar of graphics implementation of biplots. It projects multivariate data into a 2D space (usually the first two principal components) and overlays variable vectors to show how original variables contribute to the observed variance. Unlike the base `stats::biplot()`, `ggbiplot` produces `ggplot2` objects, allowing for extensive customization using standard ggplot layers.

## Installation
```r
install.packages("ggbiplot")
```

## Core Workflow

### 1. Prepare the Analysis Object
`ggbiplot` requires an analysis object as input.
```r
# Using prcomp (recommended)
data(wine)
wine.pca <- prcomp(wine, scale. = TRUE)

# Using MASS::lda
library(MASS)
wine.lda <- lda(wine.class ~ ., data = wine)
```

### 2. Basic Biplot
The simplest usage takes the PCA object and plots PC1 vs PC2.
```r
library(ggbiplot)
ggbiplot(wine.pca)
```

### 3. Customizing the Visualization
Common arguments for `ggbiplot()`:
- `choices`: Vector of two integers selecting the components to plot (default: `c(1, 2)`).
- `obs.scale`: Scale factor for observations (default: 1).
- `var.scale`: Scale factor for variables (default: 1).
- `groups`: A factor vector for coloring observations.
- `ellipse`: Boolean; if `TRUE`, draws a confidence ellipse for each group.
- `labels`: Vector of character strings to label observations.
- `var.axes`: Boolean; if `FALSE`, variable vectors are suppressed.

Example with groups and ellipses:
```r
ggbiplot(wine.pca, obs.scale = 1, var.scale = 1, 
         groups = wine.class, ellipse = TRUE, circle = TRUE) +
  scale_color_discrete(name = '') +
  theme_minimal()
```

### 4. Scree Plots
To visualize the variance explained by each component:
```r
ggscreeplot(wine.pca)
```

## Tips and Best Practices
- **Scaling**: Always ensure data is scaled (e.g., `scale. = TRUE` in `prcomp`) if variables are on different units.
- **ggplot2 Integration**: Since `ggbiplot()` returns a `ggplot` object, you can add layers like `labs()`, `theme()`, or `ggtitle()`.
- **Variable Vectors**: If the plot is too cluttered with variable names, use `varname.size` or `varname.adjust` to tweak the labels.
- **LDA**: When using with `lda` objects, the biplot shows the discriminant functions, which is useful for visualizing class separation.

## Reference documentation
- [README](./references/README.md)