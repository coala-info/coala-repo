---
name: bioconductor-ggtreedendro
description: The bioconductor-ggtreedendro package extends ggtree to visualize and annotate hierarchical clustering objects using the ggplot2 framework. Use when user asks to visualize dendrograms from hclust or cluster objects, annotate trees with bootstrap values from pvclust, or apply custom layouts and scales to clustering results.
homepage: https://bioconductor.org/packages/release/bioc/html/ggtreeDendro.html
---

# bioconductor-ggtreedendro

## Overview

The `ggtreeDendro` package extends the `ggtree` framework to support hierarchical clustering objects. It provides `autoplot()` methods that automatically convert various clustering outputs into `ggtree` objects. This allows users to leverage the full power of `ggtree`, `ggplot2`, and `ggtreeExtra` to annotate dendrograms with clinical data, bootstrap values, or custom visual scales.

## Core Workflow

1.  **Perform Clustering**: Use standard R packages (`stats`, `cluster`, `mdendro`, `pvclust`) to generate a clustering object.
2.  **Initialize Plot**: Use `autoplot(object, ...)` to create a `ggtree` object.
3.  **Annotate**: Add layers like `geom_tiplab()` for labels or `geom_tippoint()` for nodes.
4.  **Customize**: Apply scales like `scale_color_subtree()` or themes like `theme_tree()`.

## Supported Objects and Examples

### Standard Stats Objects
For `hclust` and `dendrogram` objects:
```r
library(ggtreeDendro)
library(ggtree)

hc <- hclust(dist(USArrests), "ave")
autoplot(hc) + geom_tiplab()
```

### Cluster Package Objects
Supports `agnes`, `diana`, and `twins` objects:
```r
library(cluster)
x <- agnes(mtcars)
autoplot(x) + geom_tiplab()
```

### PVClust (Bootstrap Analysis)
`pvclust` objects automatically include AU (Approximately Unbiased) and BP (Bootstrap Probability) values.
```r
library(pvclust)
# result <- pvclust(data, ...)
autoplot(result, label_edge = TRUE, pvrect = TRUE) + geom_tiplab()
```
*   `label_edge = TRUE`: Displays p-values on the edges.
*   `pvrect = TRUE`: Highlights significant clusters with rectangles.

### Linkage Objects
For `mdendro` linkage objects, often used with circular layouts:
```r
library(mdendro)
lnk <- linkage(dist(USArrests))
autoplot(lnk, layout = 'circular') + 
  geom_tiplab() + 
  scale_color_subtree(4)
```

## Key Functions and Tips

*   **`autoplot()`**: The primary entry point. It returns a `ggtree` object, meaning you can use any `ggtree` geom (e.g., `geom_hilight`, `geom_cladelab`).
*   **`scale_color_subtree(n)`**: A helper function to quickly color the tree based on a specific number of clusters (*n*).
*   **Layouts**: Supports standard ggtree layouts such as `'rectilinear'`, `'circular'`, `'slanted'`, and `'fan'`.
*   **Combining Plots**: Use the `aplot` package (specifically `plot_list()`) to align multiple dendrograms or side-by-side comparisons.

## Reference documentation

- [Visualizing Dendrogram using ggtree](./references/ggtreeDendro.md)