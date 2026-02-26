---
name: r-dendextend
description: The r-dendextend package provides a comprehensive set of tools for manipulating, visualizing, and comparing dendrogram objects in R. Use when user asks to modify dendrogram aesthetics, compare multiple trees using tanglegrams, calculate tree correlations, or integrate hierarchical clustering with ggplot2 and heatmaps.
homepage: https://cloud.r-project.org/web/packages/dendextend/index.html
---


# r-dendextend

name: r-dendextend
description: Extending 'dendrogram' functionality in R for visualization and comparison. Use this skill when you need to (1) modify graphical parameters of dendrograms (colors, sizes, labels), (2) compare two or more trees visually (tanglegrams) or statistically (correlation), or (3) integrate dendrograms with heatmaps and ggplot2.

# r-dendextend

## Overview
The `dendextend` package provides an extensive set of tools to manipulate, visualize, and compare dendrogram objects in R. It allows for fine-grained control over the appearance of branches, nodes, and labels, and offers specialized plots like tanglegrams for comparing hierarchical clusterings.

## Installation
To install the package from CRAN:
```R
install.packages("dendextend")
```

## Core Workflow
The typical workflow involves creating a dendrogram from a distance matrix and hierarchical clustering, then using the `set` function or specific piping operators to modify its attributes.

```R
library(dendextend)

# 1. Create a dendrogram
dend <- iris[,-5] %>% dist %>% hclust %>% as.dendrogram

# 2. Modify attributes (Chaining/Piping)
dend <- dend %>%
  color_branches(k = 3) %>%
  set("labels_cex", 0.5) %>%
  set("labels_col", value = c("red", "blue"), k = 3) %>%
  set("branches_lwd", 2) %>%
  hang.dendrogram

# 3. Plot
plot(dend)
```

## Key Functions

### Visualization and Aesthetics
- `set()`: The primary function for adjusting graphical parameters. Common parameters include "labels", "labels_colors", "labels_cex", "branches_col", "branches_lwd", "nodes_pch".
- `color_branches(dend, k, h)`: Colors branches based on a cut at height `h` or into `k` clusters.
- `color_labels(dend, k, h)`: Colors labels based on cluster membership.
- `hang.dendrogram(dend, hang_height)`: Makes the leaves of the dendrogram hang down.
- `circlize_dendrogram(dend)`: Creates a circular (radial) dendrogram (requires `circlize` package).

### Comparison
- `dendlist(dend1, dend2)`: Combines multiple dendrograms into a list for comparison.
- `tanglegram(dend1, dend2)`: Plots two dendrograms side-by-side with lines connecting matching labels.
- `entanglement(dend1, dend2)`: Calculates a measure of how "tangled" the two trees are (0 to 1).
- `untangle(dend1, dend2, method)`: Attempts to rotate branches to minimize entanglement.
- `cor_cophenetic(dend1, dend2)`: Calculates the cophenetic correlation between two trees.
- `Bk_plot(dend1, dend2)`: Plots the Fowlkes-Mallows Index for different k values.

### Manipulation
- `rotate(dend, order)`: Rotates the branches of a dendrogram.
- `prune(dend, labels_to_remove)`: Removes specific leaves from the tree.
- `ladderize(dend)`: Reorganizes the tree so that the "smaller" branches are always on the same side.

## Integration with Other Packages
- **ggplot2**: Use `ggplot(dend)` to create a ggplot2 object of the dendrogram.
- **gplots**: Pass a `dendextend` modified dendrogram to `heatmap.2(Rowv = dend)`.
- **colorspace**: Useful for generating distinct color palettes for clusters (e.g., `rainbow_hcl`).

## Tips and Best Practices
- **Piping**: Use the `magrittr` pipe `%>%` to chain multiple `set` operations for cleaner code.
- **Labels**: If your data has no row names, `labels(dend)` will be integers. You can assign new labels using `labels(dend) <- new_names`.
- **Sorting**: Use `sort(dend)` to ensure a consistent branch order, which is helpful before comparing trees.
- **Interactive Heatmaps**: Use `heatmaply::heatmaply(dend)` for interactive exploration.

## Reference documentation
- [Hierarchical cluster analysis on famous data sets](./references/Cluster_Analysis.Rmd)
- [Frequently asked questions](./references/FAQ.Rmd)
- [Quick Introduction](./references/Quick_Introduction.Rmd)
- [Introduction to dendextend](./references/dendextend.Rmd)