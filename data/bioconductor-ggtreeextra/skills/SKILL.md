---
name: bioconductor-ggtreeextra
description: This tool extends ggtree to visualize phylogenetic trees with multiple layers of associated data in circular, fan, or radial layouts. Use when user asks to align external data layers to tree tips, add heatmaps or bar plots to circular trees, and visualize complex metadata alongside phylogenetic structures.
homepage: https://bioconductor.org/packages/release/bioc/html/ggtreeExtra.html
---

# bioconductor-ggtreeextra

name: bioconductor-ggtreeextra
description: Use this skill when visualizing phylogenetic trees with associated data in circular, fan, or radial layouts. It provides the geom_fruit function to align external data layers (heatmaps, bar plots, points, etc.) to tree tips in a ring-like fashion.

## Overview

The `ggtreeExtra` package extends the `ggtree` ecosystem by allowing users to align multiple layers of experimental or clinical data to phylogenetic trees. While `ggtree`'s native `facet_plot` works well for rectangular layouts, `ggtreeExtra` is specifically designed to handle circular, fan, and radial layouts. It uses a "grammar of graphics" approach, allowing users to add data rings using the `geom_fruit()` function.

## Core Workflow

### 1. Setup and Data Preparation
Ensure the tree and associated data are loaded. Data should be in a "long" format where one column matches the tip labels of the tree.

```r
library(ggtree)
library(ggtreeExtra)
library(ggplot2)
library(ggnewscale) # Highly recommended for multiple fill scales

# Load tree
tree <- read.tree("my_tree.nwk")

# Load data (long format)
# Column 'ID' should match tree tip labels
dat <- read.csv("metadata.csv")
```

### 2. Basic Usage of geom_fruit
The `geom_fruit()` function is the primary tool. It acts as a wrapper for standard `ggplot2` geoms.

```r
p <- ggtree(tree, layout="fan", open.angle=10)

p + geom_fruit(
    data = dat,
    geom = geom_tile,
    mapping = aes(y = ID, fill = Category),
    pwidth = 0.1,
    offset = 0.05
)
```

### 3. Key Parameters
- `geom`: The ggplot2 geom to use (e.g., `geom_tile`, `geom_col`, `geom_star`, `geom_boxplot`).
- `mapping`: Aesthetic mappings. **Crucial**: The `y` aesthetic must be mapped to the column containing tip labels.
- `pwidth`: The relative width of the layer (default is 0.2).
- `offset`: The distance between the tree (or previous layer) and the current layer.
- `axis.params`: A list to configure the axis (e.g., `list(axis="x", text.angle=-45)`).
- `grid.params`: A list to add background grid lines to the layer.

### 4. Handling Multiple Layers
When adding multiple layers that use the same aesthetic (like `fill`), use `ggnewscale::new_scale_fill()` between `geom_fruit()` calls to prevent the scales from overwriting each other.

```r
p + geom_fruit(geom = geom_tile, mapping = aes(y=ID, fill=Var1)) +
    new_scale_fill() +
    geom_fruit(geom = geom_col, mapping = aes(y=ID, x=Value, fill=Var2))
```

### 5. Grouping Multiple Geoms
Use `geom_fruit_list()` to add multiple geoms to the same external panel/ring. The first element must be a `geom_fruit` call.

```r
p + geom_fruit_list(
    geom_fruit(data=df, geom=geom_col, mapping=aes(y=id, x=val, fill=grp)),
    new_scale_fill(),
    geom_fruit(data=df, geom=geom_star, mapping=aes(y=id, x=val, fill=grp))
)
```

## Tips and Best Practices
- **Layouts**: While designed for circular/fan layouts, `ggtreeExtra` also works with rectangular layouts.
- **Tip Alignment**: To add points directly on tip nodes rather than in an external ring, set `position = "identity"` within `geom_fruit`.
- **Legend Management**: Use `guide_legend(order = ...)` within scales to control the sequence of legends when multiple data rings are present.
- **Data Transformation**: If your data is in "wide" format, use `tidyr::pivot_longer` before plotting.

## Reference documentation
- [ggtreeExtra Vignette](./references/ggtreeExtra.md)
- [ggtreeExtra R Markdown](./references/ggtreeExtra.Rmd)