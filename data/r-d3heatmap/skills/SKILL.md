---
name: r-d3heatmap
description: This tool creates interactive d3.js heatmaps in R for visualizing matrix data with features like zooming and dendrogram-based clustering. Use when user asks to create interactive heatmaps, visualize matrix data with zoom and hover effects, or generate hierarchical clustering dendrograms in R.
homepage: https://cran.r-project.org/web/packages/d3heatmap/index.html
---

# r-d3heatmap

name: r-d3heatmap
description: Create interactive d3.js heatmaps in R. Use this skill when you need to visualize matrix data with interactive features such as zooming, cell hovering, and dendrogram-based clustering.

# r-d3heatmap

## Overview
The `d3heatmap` package creates interactive heatmap widgets using the D3 JavaScript library. It is designed to handle matrix-like data, providing a functional interface similar to the base R `heatmap()` function but with added interactivity for web-based exploration.

Key features include:
- Interactive zooming and panning.
- Hover effects to display cell values, row names, and column names.
- Automatic hierarchical clustering and dendrogram generation.
- Integration with the `htmlwidgets` framework for use in R Markdown and Shiny.

## Installation
To install the package from CRAN:
```R
install.packages("d3heatmap")
```

## Basic Usage
The primary function is `d3heatmap()`. It requires a numeric matrix.

```R
library(d3heatmap)

# Basic interactive heatmap
d3heatmap(mtcars, scale = "column", colors = "Blues")
```

### Key Arguments
- `x`: A numeric matrix.
- `scale`: Character indicating if the values should be centered and scaled in either the `"row"` direction or the `"column"` direction. Default is `"none"`.
- `colors`: A color palette. Can be a string (e.g., `"Blues"`, `"YlOrRd"`), a vector of colors, or a color function from `colorRamp`.
- `dendrogram`: Control dendrogram display. Options: `"both"`, `"row"`, `"column"`, or `"none"`.
- `Rowv` / `Colv`: Determines if and how the row/column dendrogram should be reordered. Set to `FALSE` to disable clustering.
- `k_row` / `k_col`: Integer specifying the number of clusters to color in the dendrogram.

## Advanced Workflows

### Customizing Interactivity
You can control the behavior of the interactive elements:
```R
d3heatmap(mtcars,
          show_grid = FALSE,
          anim_duration = 500,
          xaxis_font_size = "10px",
          yaxis_font_size = "10px")
```

### Using with RColorBrewer
For better visual perception, use RColorBrewer palettes:
```R
d3heatmap(mtcars, colors = "Reds", k_row = 3)
```

### Integration in Shiny
`d3heatmap` provides `d3heatmapOutput` and `renderD3heatmap` for use in Shiny applications.
```R
# ui.R
d3heatmapOutput("heatmap")

# server.R
output$heatmap <- renderD3heatmap({
  d3heatmap(mtcars)
})
```

## Tips and Best Practices
- **Data Preparation**: Ensure your data is in a numeric matrix format. Use `as.matrix()` if your data is in a data frame.
- **Scaling**: Always consider using `scale = "column"` or `scale = "row"` if the variables in your matrix have different units or magnitudes.
- **Performance**: While D3 is powerful, very large matrices (e.g., > 2000x2000) may cause performance lag in the browser. Consider downsampling or filtering data before visualization.
- **Clustering**: By default, `d3heatmap` uses `hclust`. If you have pre-computed clusters, you can pass a dendrogram object to `Rowv` or `Colv`.

## Reference documentation
None