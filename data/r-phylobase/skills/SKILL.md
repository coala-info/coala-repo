---
name: r-phylobase
description: "Provides a base S4 class for comparative methods, incorporating     one or more trees and trait data.</p>"
homepage: https://cloud.r-project.org/web/packages/phylobase/index.html
---

# r-phylobase

## Overview
The `phylobase` package provides a robust S4 infrastructure for phylogenetic structures and comparative data in R. It improves upon the standard `ape` "phylo" class by providing the `phylo4` class for trees and the `phylo4d` class for trees coupled with data frames. It ensures that data and tree nodes remain synchronized during operations like pruning or subsetting.

## Installation
```r
install.packages("phylobase")
library(phylobase)
```

## Core Classes
- **phylo4**: The base S4 class for phylogenetic trees.
- **phylo4d**: Extends `phylo4` to include tip and/or internal node data (stored as a data frame).

## Key Workflows

### 1. Creating and Converting Objects
Convert existing `ape` objects or create new ones from raw data.
```r
# Convert from ape 'phylo'
library(ape)
tree_ape <- rcoal(10)
tree_p4 <- as(tree_ape, "phylo4")

# Create phylo4d (tree with data)
# Matches data to tips by row names automatically
my_data <- data.frame(trait1 = rnorm(10), row.names = tipLabels(tree_p4))
tree_data <- phylo4d(tree_p4, tip.data = my_data)
```

### 2. Accessing Tree Information
Use accessor functions instead of direct slot access to ensure compatibility.
```r
tipLabels(tree_p4)      # Get/set tip labels
nodeLabels(tree_p4)     # Get/set internal node labels
nodeId(tree_p4, "all")  # Get numeric IDs
edgeLength(tree_p4)     # Get branch lengths
hasEdgeLength(tree_p4)  # Check for branch lengths
rootNode(tree_p4)       # Identify the root
```

### 3. Tree-Walking (Navigation)
Functions to explore relationships between nodes.
```r
ancestor(tree_p4, 5)             # Immediate parent
ancestors(tree_p4, 5, "all")     # All ancestors up to root
children(tree_p4, 12)            # Immediate descendants
descendants(tree_p4, 12, "tips") # Only terminal descendants
siblings(tree_p4, 5)             # Nodes with same ancestor
MRCA(tree_p4, c("tipA", "tipB")) # Most Recent Common Ancestor
shortestPath(tree_p4, 1, 10)     # Nodes connecting two points
```

### 4. Data Manipulation and Subsetting
`phylobase` handles the complex task of keeping data aligned when the tree structure changes.
```r
# Extract data
tdata(tree_data, "tip")      # Get tip data frame
tdata(tree_data, "internal") # Get node data frame

# Subsetting/Pruning
# Retain only specific tips
sub_tree <- subset(tree_data, tips.include = c("sp1", "sp2", "sp3"))

# Remove specific tips
pruned_tree <- prune(tree_data, "sp4")

# Extract a specific clade by internal node ID
clade <- subset(tree_data, node.subtree = 15)
```

### 5. Visualization
```r
# Standard tree plot
plot(tree_p4)

# Plot tree with associated data
plot(tree_data)
```

## Tips and Best Practices
- **Node Indexing**: Tips are indexed $1 \dots n$ and internal nodes $n+1 \dots n+m$.
- **Missing Data**: When creating `phylo4d` objects, use `missing.data="warn"` or `"ok"` if your data frame doesn't cover all tips in the tree.
- **Edge Matrix**: The edge matrix uses `ancestor` and `descendant` columns. The root is identified by having `NA` as its ancestor.
- **Labels**: Always prefer using labels (names) over numeric indices when subsetting to avoid errors if the tree order changes.

## Reference documentation
- [The phylo4 classes and methods](./references/phylobase.Rmd)