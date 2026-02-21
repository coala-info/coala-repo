---
name: r-corrplot
description: Provides a visual exploratory tool on correlation matrix that supports automatic variable reordering to help detect hidden patterns among variables.</p>
homepage: https://cloud.r-project.org/web/packages/corrplot/index.html
---

# r-corrplot

## Overview
The `corrplot` package is a graphical tool for visualizing correlation matrices. It supports automatic variable reordering (using algorithms like AOE, FPC, and hierarchical clustering) to reveal hidden patterns. It offers extensive customization for visualization methods (circles, squares, ellipses, numbers, etc.), layouts, and statistical significance indicators.

## Installation
```R
install.packages("corrplot")
library(corrplot)
```

## Core Workflow
1. **Prepare Data**: Calculate a correlation matrix using `cor(data)`.
2. **Basic Plot**: Use `corrplot(M)` where `M` is the matrix.
3. **Refine**: Apply reordering, change visualization methods, or add statistical significance.

## Key Functions and Parameters

### corrplot()
The primary function for generating visualizations.
- `method`: Character string for visualization method: `'circle'` (default), `'square'`, `'ellipse'`, `'number'`, `'shade'`, `'color'`, `'pie'`.
- `type`: Layout type: `'full'`, `'upper'`, or `'lower'`.
- `order`: Reordering algorithm:
    - `'AOE'`: Angular order of eigenvectors.
    - `'FPC'`: First principal component order.
    - `'hclust'`: Hierarchical clustering.
    - `'alphabet'`: Alphabetical order.
- `diag`: Logical, whether to display the main diagonal.
- `addrect`: Integer, number of rectangles to draw based on `hclust` results.
- `col`: Vector of colors. Use `COL1()` for sequential or `COL2()` for diverging palettes.
- `is.corr`: Set to `FALSE` to visualize non-correlation rectangular matrices.

### corrplot.mixed()
A wrapper for displaying different methods in the upper and lower triangles.
```R
corrplot.mixed(M, lower = 'number', upper = 'circle', tl.pos = 'd')
```

### cor.mtest()
Performs significance tests to provide p-values and confidence intervals.
```R
res <- cor.mtest(mtcars, conf.level = 0.95)
corrplot(M, p.mat = res$p, sig.level = 0.05, insig = 'blank')
```

## Customization Tips

### Color Palettes
Use the built-in color helpers to generate professional schemes:
- `COL1(sequential, n)`: For non-negative/non-positive matrices (e.g., `'YlOrBr'`).
- `COL2(diverging, n)`: For correlation matrices (e.g., `'RdBu'`, `'PiYG'`, `'BrBG'`).

### Label Control
- `tl.pos`: Text label position (`'lt'`, `'ld'`, `'td'`, `'d'`, `'l'`, `'n'`).
- `tl.srt`: String rotation in degrees.
- `tl.cex`: Size of text labels.
- **Math Labels**: Prefix labels with `$` to use plotmath expressions (e.g., `colnames(M) <- c('$alpha', '$beta')`).

### Handling Insignificant Values
Use the `insig` parameter to handle p-values:
- `'pch'` (default): Adds a cross/character.
- `'blank'`: Removes the glyph entirely.
- `'p-value'`: Prints the p-value number.
- `'label_sig'`: Uses stars (requires `sig.level` vector, e.g., `c(0.001, 0.01, 0.05)`).

## Examples

### Hierarchical Clustering with Rectangles
```R
M <- cor(mtcars)
corrplot(M, order = 'hclust', addrect = 3, method = 'square')
```

### Visualizing Confidence Intervals
```R
res <- cor.mtest(mtcars)
corrplot(M, lowCI = res$lowCI, uppCI = res$uppCI, plotCI = 'rect', cl.pos = 'n')
```

## Reference documentation
- [An Introduction to corrplot Package](./references/corrplot-intro.Rmd)