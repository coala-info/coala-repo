---
name: bioconductor-treeandleaf
description: This tool creates interactive Tree-and-Leaf visualizations for hierarchical data by converting trees into force-directed graph layouts. Use when user asks to create Tree-and-Leaf plots, convert dendrograms or phylogenetic trees into interactive graphs, map metadata to leaf nodes, or visualize hierarchical data using force-directed layouts.
homepage: https://bioconductor.org/packages/release/bioc/html/TreeAndLeaf.html
---


# bioconductor-treeandleaf

name: bioconductor-treeandleaf
description: Use this skill to create "Tree-and-Leaf" visualizations for hierarchical data using the TreeAndLeaf R package. This skill is appropriate for converting dendrograms (hclust), phylogenetic trees (phylo), or ggtree objects into interactive graph layouts that emphasize leaf-level metadata through node size, color, and force-directed relaxation via the RedeR package.

# bioconductor-treeandleaf

## Overview

The **TreeAndLeaf** package implements a hybrid layout strategy for binary and non-binary trees. Unlike traditional dendrograms that allocate most space to branches, TreeAndLeaf uses a force-directed graph layout to provide more room for leaves. This allows for the simultaneous visualization of multiple layers of information (e.g., gene expression, clinical metadata) mapped onto the terminal nodes of a tree.

## Core Workflow

### 1. Data Preparation and Tree Construction
The package typically starts with an `hclust` object (from hierarchical clustering) or a `phylo` object (from phylogenetic analysis).

```r
library(TreeAndLeaf)
library(RedeR)
library(igraph)

# Example: hclust
hc <- hclust(dist(USArrests), "ave")
```

### 2. Conversion to TreeAndLeaf Object
Convert the tree object into an `igraph` object formatted for the TreeAndLeaf workflow.

```r
# Converts hclust, phylo, or ggtree objects
tal <- treeAndLeaf(hc)
```

### 3. Mapping Metadata
Use `att.mapv` to link external data frames to the tree nodes. The `refcol` parameter specifies which column in the data matches the node names (use `0` for rownames).

```r
# Map USArrests data to the graph vertices
tal <- att.mapv(g = tal, dat = USArrests, refcol = 0)
```

### 4. Setting Visual Attributes
Map variables to visual properties like `nodeColor` and `nodeSize`.

*   **att.setv**: Maps a continuous or discrete variable to an attribute.
*   **att.addv / att.adde**: Sets a fixed value for vertices or edges.

```r
# Map 'Murder' to color and 'UrbanPop' to size
tal <- att.setv(g = tal, from = "Murder", to = "nodeColor", cols = brewer.pal(9, "Reds"), nquant = 5)
tal <- att.setv(g = tal, from = "UrbanPop", to = "nodeSize", xlim = c(10, 50, 5))

# Set global edge and label properties
tal <- att.addv(tal, "nodeLabelSize", value = 15, index = V(tal)$isLeaf)
tal <- att.adde(tal, "edgeWidth", value = 3)
```

### 5. Visualization in RedeR
TreeAndLeaf relies on the **RedeR** package for the interactive force-directed layout.

```r
startRedeR()
resetRedeR()

# Send graph to RedeR
addGraphToRedeR(g = tal, zoom = 75)

# Relax the layout (force-directed algorithm)
# p1: edge force, p2: node repulsion, p3: central force
relaxRedeR(p1 = 25, p2 = 200, p3 = 5, p5 = 5)

# Add legends
addLegendToRedeR(tal, type = "nodecolor")
addLegendToRedeR(tal, type = "nodesize")
```

## Advanced Features

### Integration with ggtree
You can use `ggtree` to define the initial spatial configuration of the tree before converting it.

```r
library(ggtree)
ggt <- ggtree(phylo_tree, layout = 'daylight')
tal <- treeAndLeaf(ggt)
```

### Handling Non-Binary Trees
The package can process phylogenetic trees with polytomies (nodes with more than two children). The workflow remains the same: `treeAndLeaf(phylo_object)`.

### Anchoring Nodes
To prevent internal nodes from moving during the relaxation process (keeping the tree structure more rigid), use `selectNodes` with `anchor=TRUE`.

```r
# Anchor all non-leaf nodes
selectNodes(V(tal)$name[!V(tal)$isLeaf], anchor = TRUE)
relaxRedeR()
```

## Tips for Better Layouts
*   **Initial State**: The final layout depends on the initial unrooted tree state. Use the `zoom` parameter in `addGraphToRedeR` to adjust the initial spread.
*   **Relaxation Parameters**: If nodes are too crowded, increase the repulsion parameter (`p2`). If the tree expands too far, increase the central force (`p3`).
*   **Leaf Focus**: Use `V(tal)$isLeaf` as an index to apply attributes (like labels or specific colors) only to the terminal nodes.

## Reference documentation
- [TreeAndLeaf](./references/TreeAndLeaf.md)