---
name: r-clustree
description: The clustree package visualizes the relationships between clusterings at different resolutions by building a clustering tree to identify stable clusters and over-clustering. Use when user asks to visualize clustering trees, compare cluster assignments across resolutions, identify stable clusters, or overlay clustering trees on dimensionality reduction plots.
homepage: https://cloud.r-project.org/web/packages/clustree/index.html
---

# r-clustree

## Overview

The `clustree` package provides a way to visualize the relationships between clusterings at different resolutions. It builds a "clustering tree" where each node is a cluster and edges represent samples moving between clusters as the resolution increases. This helps identify stable clusters, unstable regions, and the point where over-clustering occurs.

## Installation

```R
install.packages("clustree")
```

## Core Workflow

### 1. Prepare Data
The input must contain multiple columns representing cluster assignments at different resolutions (e.g., k=1, k=2, k=3).

```R
library(clustree)
data("nba_clusts")
# Columns: K1, K2, K3, K4, K5
```

### 2. Basic Clustering Tree
Use the `clustree()` function. You must specify the `prefix` that identifies the clustering columns.

```R
# Basic tree
clustree(nba_clusts, prefix = "K")
```

### 3. Customizing Aesthetics
You can map node size, color, and transparency to attributes in your data. Since a node represents multiple samples, you must provide an aggregation function (e.g., "mean", "median", "max").

```R
# Color nodes by a specific variable's mean
clustree(nba_clusts, prefix = "K", 
         node_colour = "ReboundPct", 
         node_colour_aggr = "mean")

# Use the SC3 stability index (calculated automatically)
clustree(nba_clusts, prefix = "K", node_colour = "sc3_stability")
```

### 4. Layout Options
- **Reingold-Tilford (default):** Standard tree layout.
- **Sugiyama:** Minimizes edge crossings.
- **use_core_edges:** Set to `FALSE` to use all edges for layout calculation instead of just the most significant ones.

```R
clustree(nba_clusts, prefix = "K", layout = "sugiyama", use_core_edges = FALSE)
```

## Integration with Single-Cell Objects

`clustree` has native support for common scRNA-seq objects.

### Seurat Objects
```R
# Uses the 'res.' prefix by default for Seurat metadata
clustree(seurat_object, prefix = "res.")

# Color by gene expression
clustree(seurat_object, prefix = "res.", 
         node_colour = "GeneName", 
         node_colour_aggr = "median")
```

### SingleCellExperiment Objects
```R
clustree(sce_object, prefix = "sc3_", suffix = "_clusters")
```

## Overlaying Trees on Dimensionality Reduction
To see how the tree relates to a t-SNE or UMAP plot, use `clustree_overlay`.

```R
# 3D-like view looking down on the tree
clustree_overlay(nba_clusts, prefix = "K", x_value = "PC1", y_value = "PC2")

# Get side views (X vs Resolution and Y vs Resolution)
overlay_list <- clustree_overlay(nba_clusts, prefix = "K", 
                                 x_value = "PC1", y_value = "PC2", 
                                 plot_sides = TRUE)
plot(overlay_list$x_side)
```

## Tips and Best Practices
- **Identifying Over-clustering:** Look for nodes with multiple incoming edges from different parent clusters; this suggests the resolution is too high and samples are being forced into unstable groups.
- **Modifying Plots:** `clustree` returns a `ggplot` object. You can add `theme()`, `scale_color_*`, or `guides()` to modify the appearance.
- **Legend Management:** If legends are too large, use `guides(edge_colour = FALSE, edge_alpha = FALSE)` to hide edge-specific legends.

## Reference documentation
- [Plotting clustering trees](./references/clustree.Rmd)