---
name: r-pheatmap
description: "Implementation of heatmaps that offers more control     over dimensions and appearance.</p>"
homepage: https://cloud.r-project.org/web/packages/pheatmap/index.html
---

# r-pheatmap

name: r-pheatmap
description: Create highly customizable, publication-quality heatmaps in R. Use this skill to visualize matrix data with hierarchical clustering, add row/column metadata annotations, and control aesthetic details like cell dimensions, color scales, and font sizes.

# r-pheatmap

## Overview
The `pheatmap` (Pretty Heatmap) package provides a functional approach to drawing cluster heatmaps in R. It offers significantly more control over the visual dimensions and appearance of the plot compared to the standard `heatmap()` function, particularly for adding annotations and managing cell sizes.

## Installation
To install the package from CRAN:
```R
install.packages("pheatmap")
```

## Core Workflow

### Basic Heatmap Generation
Pass a numeric matrix to the `pheatmap()` function. By default, it performs hierarchical clustering on both rows and columns.

```R
library(pheatmap)

# Create sample data
test_matrix = matrix(rnorm(200), 20, 10)
colnames(test_matrix) = paste("Test", 1:10, sep = "")
rownames(test_matrix) = paste("Gene", 1:20, sep = "")

# Draw basic heatmap
pheatmap(test_matrix)
```

### Data Scaling and Clustering
Control how data is normalized and how clusters are calculated.

- **Scale data**: Use `scale = "row"`, `scale = "column"`, or `scale = "none"`.
- **Clustering distance**: Set `clustering_distance_rows` or `clustering_distance_cols` (e.g., "euclidean", "correlation").
- **Clustering method**: Set `clustering_method` (e.g., "complete", "average", "ward.D").
- **Disable clustering**: Set `cluster_rows = FALSE` or `cluster_cols = FALSE`.

### Adding Annotations
Add metadata to rows or columns using data frames. The row names of the annotation data frame must match the column/row names of the matrix.

```R
# Create column annotation
annotation_col = data.frame(
    CellType = factor(rep(c("Type1", "Type2"), 5)),
    Time = 1:10
)
rownames(annotation_col) = colnames(test_matrix)

# Create custom colors for annotations
ann_colors = list(
    Time = c("white", "firebrick"),
    CellType = c(Type1 = "#1B9E77", Type2 = "#D95F02")
)

pheatmap(test_matrix, 
         annotation_col = annotation_col, 
         annotation_colors = ann_colors)
```

### Aesthetic Customization
- **Colors**: Use `color = colorRampPalette(c("blue", "white", "red"))(100)` to define the gradient.
- **Cell size**: Fix cell dimensions using `cellwidth` and `cellheight`.
- **Labels**: Toggle labels with `show_rownames` and `show_colnames`.
- **Numbers**: Display matrix values in cells using `display_numbers = TRUE`.
- **Gaps**: Insert gaps in the heatmap based on clustering or groups using `gaps_row` or `gaps_col`.

### Saving Output
Directly export the heatmap to a file by providing the `filename` argument. The format is determined by the file extension (.pdf, .png, .jpeg).

```R
pheatmap(test_matrix, filename = "my_heatmap.pdf", width = 10, height = 8)
```

## Tips and Best Practices
- **Matrix Input**: Ensure the input is a `matrix` object; use `as.matrix()` if your data is in a data frame.
- **Reproducibility**: If using `kmeans_k` to cluster rows into a specific number of groups, run `set.seed()` beforehand to ensure consistent results.
- **Legend Control**: Use `legend = FALSE` to hide the color scale and `annotation_legend = FALSE` to hide annotation keys.
- **Large Datasets**: For very large matrices, set `border_color = NA` to remove cell borders, which can significantly improve rendering speed and visual clarity.

## Reference documentation
- [pheatmap: Pretty Heatmaps](./references/home_page.md)