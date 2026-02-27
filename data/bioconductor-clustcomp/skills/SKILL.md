---
name: bioconductor-clustcomp
description: This tool compares and visualizes relationships between two clusterings using weighted bipartite graphs and the barycentre algorithm. Use when user asks to compare different clustering results, map clusters between partitions, minimize edge crossings in cluster visualizations, or identify superclusters across different clustering methods.
homepage: https://bioconductor.org/packages/release/bioc/html/clustComp.html
---


# bioconductor-clustcomp

name: bioconductor-clustcomp
description: Comparison and visualization of relationships between two clusterings (flat vs. flat or flat vs. hierarchical) using weighted bipartite graphs and the barycentre algorithm. Use this skill when you need to map clusters between different partitions, minimize edge crossings in cluster visualizations, or identify "superclusters" that represent common groupings across different clustering methods.

# bioconductor-clustcomp

## Overview

The `clustComp` package provides tools to visualize and quantify the relationship between two different clusterings of the same dataset. It represents clusters as nodes in a bipartite graph where edge weights represent the number of shared elements. The package is particularly useful for comparing different clustering algorithms (e.g., k-means vs. hierarchical) or different parameter settings. It employs a barycentre algorithm to minimize edge crossings, making the relationships between partitions easier to interpret.

## Typical Workflow

### 1. Data Preparation
Load the package and ensure your clusterings are formatted correctly. Flat clusterings should be vectors (numeric or character), and hierarchical clusterings should be `hclust` objects.

```r
library(clustComp)
# Example: Comparing two k-means results
flat1 <- kmeans(data, centers = 7)$cluster
flat2 <- kmeans(data, centers = 6)$cluster

# Example: Hierarchical clustering
hierar <- hclust(dist(data))
```

### 2. Comparing Flat Clusterings
Use `flatVSflat` to visualize the relationship between two non-hierarchical partitions.

```r
# Basic comparison
flatVSflat(flat1, flat2)

# Refined visualization with specific parameters
flatVSflat(flat1, flat2, 
           line.wd = 5,      # Line width for edges
           h.min = 0.3,      # Minimum distance between nodes
           evenly = TRUE,    # Distribute nodes evenly
           horiz = TRUE)     # Horizontal layout
```

### 3. Identifying Superclusters (Greedy Mapping)
To find one-to-one mappings between groups of clusters (connected components), use the greedy algorithm.

```r
# Generate a mapping object
myMapping <- SCmapping(flat1, flat2)

# Visualize with greedy mapping enabled
flatVSflat(flat1, flat2, greedy = TRUE)
```

### 4. Comparing Flat vs. Hierarchical Clusterings
The `flatVShier` function automatically finds optimal cutoffs in a dendrogram to compare against a flat clustering.

```r
# Compare hierarchical tree to flat clustering
# score.function can be "it" (information theory) or "crossing" (aesthetics)
comparison <- flatVShier(hierar, flat1, 
                         score.function = "it", 
                         look.ahead = 1)

# Expanded view showing the full dendrogram and heatmap
flatVShier(hierar, flat1, 
           expanded = TRUE, 
           expression = exprs(data_matrix))
```

## Key Parameters and Tips

- **`greedy`**: When `TRUE`, the algorithm groups clusters into "superclusters" based on the thickest edges.
- **`look.ahead`**: In `flatVShier`, this determines how many steps down the tree the algorithm looks to decide if a branch should be split. Higher values (1 or 2) often yield more detailed comparisons.
- **`score.function`**: 
    - `"it"`: Uses information theory; generally more stringent and results in fewer branches.
    - `"crossing"`: Minimizes edge crossings; focuses on visual layout aesthetics.
- **`coord1` / `coord2`**: You can manually provide vectors to set the initial ordering of nodes if the heuristic doesn't find the optimal layout.
- **`pausing`**: Set to `FALSE` in non-interactive scripts to prevent the function from waiting for user input between iterations.

## Reference documentation

- [clustComp](./references/clustComp.md)