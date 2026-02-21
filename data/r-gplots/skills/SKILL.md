---
name: r-gplots
description: "Various R programming tools for plotting data, including:   - calculating and plotting locally smoothed summary function as     ('bandplot', 'wapply'),   - enhanced versions of standard plots ('barplot2', 'boxplot2',     'heatmap.2', 'smartlegend'),   - manipulating colors ('col2hex', 'colorpanel', 'redgreen',     'greenred', 'bluered', 'redblue', 'rich.colors'),   - calculating and plotting two-dimensional data summaries ('ci2d',     'hist2d'),   - enhanced regression diagnostic plots ('lmplot2', 'residplot'),   - formula-enabled interface to 'stats::lowess' function ('lowess'),   - displaying textual data in plots ('textplot', 'sinkplot'),   - plotting dots whose size reflects the relative magnitude of the     elements ('balloonplot', 'bubbleplot'),   - plotting \"Venn\" diagrams ('venn'),   - displaying Open-Office style plots ('ooplot'),   - plotting multiple data on same region, with separate axes     ('overplot'),   - plotting means and confidence intervals ('plotCI', 'plotmeans'),   - spacing points in an x-y plot so they don't overlap ('space').</p>"
homepage: https://cloud.r-project.org/web/packages/gplots/index.html
---

# r-gplots

## Overview
The `gplots` package is a collection of R programming tools for data plotting. It extends base R graphics with more flexible versions of standard plots and introduces specialized visualizations for high-dimensional data and statistical summaries.

## Installation
To install the package from CRAN:
```R
install.packages("gplots")
library(gplots)
```

## Core Functions and Workflows

### Enhanced Heatmaps (`heatmap.2`)
`heatmap.2` is the most widely used function in the package, offering significantly more control than the base `heatmap` function.

*   **Basic Usage**: `heatmap.2(x, trace="none", col=bluered(100))`
*   **Scaling**: Use `scale="row"` or `scale="column"` to center and scale data.
*   **Dendrograms**: Control display with `dendrogram="both"`, `"row"`, `"col"`, or `"none"`.
*   **Colors**: Use built-in palettes like `bluered`, `redblue`, `rich.colors`, or `colorpanel`.
*   **Layout**: Customize the plot arrangement using `lmat`, `lwid`, and `lhei`.
*   **Side Colors**: Add row/column annotations using `RowSideColors` and `ColSideColors`.

### Venn Diagrams (`venn`)
The `venn` function supports up to five sets.
*   **Input**: Accepts a list of vectors or a binary indicator matrix.
*   **Example**: `venn(list(SetA=1:10, SetB=5:15, SetC=c(1,3,5,7,9)))`
*   **Output**: Returns the intersection counts invisibly.

### Statistical Plotting
*   **`plotmeans`**: Plot group means with confidence intervals.
    *   `plotmeans(y ~ x, data=mydata)`
*   **`balloonplot`**: Visualize tabular data where dot size represents magnitude.
    *   `balloonplot(table(data$var1, data$var2))`
*   **`hist2d`**: Create 2D histograms for large datasets.
*   **`plotCI`**: General purpose function for plotting confidence intervals.

### Color Utilities
*   **`col2hex`**: Convert R color names to hex codes.
*   **`colorpanel`**: Create custom color transitions (e.g., `colorpanel(100, "low"="blue", "mid"="white", "high"="red")`).

## Tips and Best Practices
*   **Layout Conflicts**: `heatmap.2` uses `layout()` internally. It cannot be combined with `par(mfrow=...)`. To put multiple heatmaps in one figure, you must manipulate `lmat`.
*   **Dendrogram Reordering**: By default, `heatmap.2` reorders dendrograms based on row/column means. To keep a specific order, set `Rowv=FALSE` or `Colv=FALSE`.
*   **Large Matrices**: For very large matrices, disable the trace line (`trace="none"`) and density info (`density.info="none"`) to improve rendering speed.
*   **Text in Plots**: Use `textplot()` to capture and display console output or character strings as a plot, which is useful for adding summary tables to multi-page PDF reports.

## Reference documentation
- [Enhanced Heat Maps with heatmap.2](./references/heatmap.2.Rmd)
- [Venn Diagrams with gplots](./references/venn.Rmd)