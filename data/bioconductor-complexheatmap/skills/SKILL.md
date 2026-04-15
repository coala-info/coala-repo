---
name: bioconductor-complexheatmap
description: This tool creates, customizes, and concatenates complex heatmaps and annotations for multidimensional data visualization in R. Use when user asks to visualize multidimensional data, integrate annotations, cluster rows or columns, or combine multiple heatmaps into a single layout.
homepage: https://bioconductor.org/packages/release/bioc/html/ComplexHeatmap.html
---

# bioconductor-complexheatmap

name: bioconductor-complexheatmap
description: Specialized guidance for creating, customizing, and concatenating complex heatmaps using the Bioconductor package ComplexHeatmap. Use this skill when a user needs to visualize multidimensional data, integrate annotations, cluster rows/columns, or combine multiple heatmaps into a single layout in R.

# bioconductor-complexheatmap

## Overview
The `ComplexHeatmap` package provides a highly flexible framework for arranging multiple heatmaps and annotations. It allows for sophisticated control over clustering, splitting, and decorative elements, making it superior to standard heatmap functions for high-dimensional genomic or proteomic data.

## Core Workflow

### 1. Basic Heatmap
The primary function is `Heatmap()`. Unlike base R heatmap functions, it returns an object that is only rendered when printed or explicitly called via `draw()`.

```r
library(ComplexHeatmap)
mat = matrix(rnorm(100), 10)
ht = Heatmap(mat, name = "expression", 
             column_title = "Samples", 
             row_title = "Genes")
draw(ht)
```

### 2. Adding Annotations
Use `HeatmapAnnotation()` for column annotations and `rowAnnotation()` for row annotations.
- **Simple annotations**: Vector-based (colors).
- **Complex annotations**: Use `anno_*` functions (e.g., `anno_barplot`, `anno_boxplot`, `anno_points`).

```r
ha = HeatmapAnnotation(foo = 1:10, 
                       bar = anno_barplot(1:10),
                       col = list(foo = c("1" = "red", "2" = "blue", ...)))
Heatmap(mat, top_annotation = ha)
```

### 3. Heatmap Lists (Concatenation)
Heatmaps and annotations can be concatenated horizontally using `+` or vertically using `%v%`.

```r
ht1 = Heatmap(mat, name = "ht1")
ht2 = Heatmap(mat, name = "ht2")
ht_list = ht1 + ht2
draw(ht_list)
```

### 4. Clustering and Splitting
- **Clustering**: Control via `cluster_rows` and `cluster_columns`.
- **Splitting**: Use `row_split` or `column_split` with a number (k-means) or a categorical vector.

```r
Heatmap(mat, row_split = 3, column_split = 2)
```

## Common Troubleshooting & Tips

### Plotting Issues
- **No plot appears**: In scripts or complex loops, you must wrap the heatmap object in `draw()`.
- **Text is cut off**: Use `draw(ht, padding = unit(c(2, 2, 2, 2), "mm"))` to increase margins.

### Customizing Appearance
- **Legend Control**: Use `heatmap_legend_param` within `Heatmap()` or `annotation_legend_param` within `HeatmapAnnotation()`.
- **Dendrogram Axes**: Use `decorate_row_dend()` or `decorate_column_dend()` after drawing the heatmap to add custom axes to dendrograms.
- **Deterministic K-means**: Always run `set.seed()` before calling `Heatmap()` if using `row_km` or `column_km` to ensure reproducibility.

### Advanced Layouts
- **Zero-matrix Heatmaps**: To show only annotations or dendrograms, pass a matrix with zero columns: `Heatmap(matrix(nc = 0, nr = 10), ...)`.
- **Grid Integration**: Use `grid.grabExpr(draw(ht))` to capture the heatmap as a grob for use in complex `grid.layout` arrangements.

## Reference documentation
- [ComplexHeatmap Book](./references/complex_heatmap.md)
- [Most Probably Asked Questions (Rmd)](./references/most_probably_asked_questions.Rmd)
- [Most Probably Asked Questions (Markdown)](./references/most_probably_asked_questions.md)