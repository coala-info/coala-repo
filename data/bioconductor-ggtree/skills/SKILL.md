---
name: bioconductor-ggtree
description: This tool visualizes and annotates phylogenetic trees and associated data using the ggplot2 grammar of graphics. Use when user asks to create tree plots, map external data onto tree nodes, highlight clades, or combine trees with heatmaps and alignments.
homepage: https://bioconductor.org/packages/release/bioc/html/ggtree.html
---


# bioconductor-ggtree

name: bioconductor-ggtree
description: Visualizing and annotating phylogenetic trees and associated data. Use this skill when you need to create publication-quality tree plots, map external data onto tree nodes, highlight specific clades, or combine trees with other data types (heatmaps, barplots, MSA) using the ggplot2 syntax.

# bioconductor-ggtree

## Overview
`ggtree` is an R package that extends the `ggplot2` ecosystem to support the visualization and annotation of phylogenetic trees. It provides a grammar of graphics for tree-like structures, allowing users to layer annotations, link external data to nodes, and manipulate tree layouts (rectangular, circular, fan, unrooted, etc.) seamlessly.

## Installation and Loading
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ggtree")

library(ggtree)
# Often used with treeio for reading various tree formats
library(treeio) 
```

## Core Workflow

### 1. Loading Tree Data
`ggtree` works with `phylo` objects (from `ape`) or `treedata` objects (from `treeio`).
```r
# Read Newick
tree <- read.tree(text = "((A:1,B:1):1,C:2);")
# Read BEAST/MrBayes/NHX/jplace using treeio
# tree <- read.beast("my_beast_output.tree")
```

### 2. Basic Plotting
The `ggtree()` function initializes the plot.
```r
# Default rectangular layout
ggtree(tree) + geom_tiplab()

# Circular layout with branch lengths
ggtree(tree, layout="circular") + geom_tiplab()

# Unrooted layout
ggtree(tree, layout="daylight")
```

### 3. Tree Annotation
Use specific geoms to add information to the tree:
- `geom_tiplab()`: Adds labels to the tips.
- `geom_nodelab()`: Adds labels to internal nodes.
- `geom_tippoint()` / `geom_nodepoint()`: Adds points to tips or nodes.
- `geom_hilight()`: Highlights a specific clade (requires node number).
- `geom_cladelabel()`: Adds a text label and bar to a specific clade.
- `geom_strip()`: Adds a bar/label between two specific taxa.

Example:
```r
ggtree(tree) + 
  geom_tiplab() + 
  geom_hilight(node=4, fill="steelblue", alpha=0.5) +
  geom_cladelabel(node=4, label="Clade A", color="red", offset=.5)
```

### 4. Mapping External Data
You can attach a dataframe to the tree using the `%<+%` operator. The dataframe must have a column that matches the tip labels or node numbers.
```r
dd <- data.frame(taxa=c("A", "B", "C"), value=c(10, 20, 30))
ggtree(tree) %<+% dd + 
  geom_tippoint(aes(size=value, color=value)) +
  geom_tiplab(hjust=-0.5)
```

### 5. Advanced Visualizations
- **gheatmap**: Display a heatmap aligned to the tree tips.
  ```r
  gheatmap(p, matrix_data, offset=0.5, width=0.5, colnames=FALSE)
  ```
- **facet_plot**: Combine the tree with other ggplot2 layers (e.g., bar charts) in a faceted view.
  ```r
  facet_plot(p, panel="Bar", data=dd, geom=geom_col, aes(x=value), orientation='y')
  ```
- **msaplot**: Visualize Multiple Sequence Alignment (MSA) alongside the tree.
  ```r
  msaplot(p, "alignment.fasta")
  ```

## Tips and Best Practices
- **Node Numbers**: Use `ggtree(tree) + geom_text(aes(label=node))` to identify node numbers for highlighting or labeling clades.
- **Coordinate System**: `ggtree` uses a specific coordinate system where the tree is on the y-axis (1 to N tips).
- **Tree Manipulation**: Use `viewClade()`, `collapse()`, or `expand()` to focus on specific parts of large trees.
- **Scale**: Use `geom_treescale()` to add a distance scale bar.

## Reference documentation
- [ggtree](./references/ggtree.md)