---
name: bioconductor-treeio
description: This tool processes, imports, and exports phylogenetic trees while integrating associated metadata into a unified data structure. Use when user asks to read tree files in various formats, link external data to phylogenetic nodes, convert between different tree objects, or export annotated trees for visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/treeio.html
---


# bioconductor-treeio

name: bioconductor-treeio
description: A skill for processing, importing, and exporting phylogenetic trees with associated data using the R package treeio. Use this skill when you need to: (1) Read tree files in various formats (Newick, Nexus, NHX, JPLACE, BEAST, MrBayes, etc.), (2) Link external data (CSV, TSV, data frames) to phylogenetic tree nodes, (3) Convert between different tree objects (phylo, treedata, phylo4), or (4) Export annotated trees for visualization in ggtree or other software.

# bioconductor-treeio

## Overview
The `treeio` package is a fundamental tool in the Bioconductor ecosystem for phylogenetic analysis. It bridges the gap between various phylogenetic analysis software outputs and the R environment. Its primary strength lies in its ability to integrate diverse types of data (evolutionary rates, ancestral states, bootstrap values, or custom metadata) directly onto the nodes and branches of a tree structure using the `treedata` class.

## Core Workflows

### 1. Importing Tree Data
`treeio` provides specific functions for different software outputs. Use the appropriate function based on the file source:

- **Standard Formats**: `read.newick()`, `read.nexus()`
- **Software Specific**: 
  - BEAST/MrBayes: `read.beast()`
  - EPA/pplacer: `read.jplace()`
  - PAML: `read.paml_rst()`, `read.codeml()`
  - RevBayes: `read.revbayes()`
  - NHX: `read.nhx()`
  - RAxML: `read.raxml()`

Example:
```r
library(treeio)
# Reading a BEAST output file
beast_tree <- read.beast("path/to/file.tree")
# View the associated data
get.fields(beast_tree)
```

### 2. Linking External Data
To attach your own experimental data (e.g., phenotypic traits, geographic locations) to an existing tree:

- Use `full_join()` to merge a `phylo` or `treedata` object with a `data.frame` or `tibble`.
- Ensure the data frame has a column that matches the node labels or tip labels in the tree.

```r
library(tibble)
# Create dummy data
extra_data <- tibble(label = c("tip_A", "tip_B"), trait = c(1.5, 2.3))
# Join with tree
annotated_tree <- full_join(beast_tree, extra_data, by = "label")
```

### 3. Data Manipulation and Extraction
- **Accessing Data**: Use `as_tibble()` to convert the tree's internal data into a flat table for inspection.
- **Subsetting**: Use `treeio::drop.tip()` or `treeio::keep.tip()` to prune trees while preserving associated metadata.
- **Conversion**: Use `as.phylo()` to strip metadata and return a standard `ape` phylo object, or `as.treedata()` to convert other formats into the `treeio` standard.

### 4. Exporting Trees
To save trees with their annotations for use in other programs or for reproducibility:

- **BEAST-compatible Nexus**: `write.beast(treedata_obj, file = "output.tree")`
- **JPLACE**: `write.jplace()`

## Tips for Success
- **The treedata Object**: Remember that `treeio` uses the `treedata` S4 class to store the tree structure (`@phylo`) and the associated data (`@data`).
- **Namespace Conflicts**: `treeio` often works alongside `dplyr`. If functions like `filter` or `mutate` behave unexpectedly on tree objects, ensure you have loaded `tidytree` or use the `treeio::` prefix.
- **Visualization**: While `treeio` handles the data, use the `ggtree` package to visualize the `treedata` objects created here.

## Reference documentation
- [treeio](./references/treeio.md)