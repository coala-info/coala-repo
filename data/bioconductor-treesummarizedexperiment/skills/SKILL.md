---
name: bioconductor-treesummarizedexperiment
description: The TreeSummarizedExperiment class integrates hierarchical tree structures with experimental data to manage relationships between assay rows or columns and their corresponding phylogenies. Use when user asks to store phylogenetic trees with single-cell data, subset data by tree nodes, or aggregate assay values to higher taxonomic levels.
homepage: https://bioconductor.org/packages/release/bioc/html/TreeSummarizedExperiment.html
---

# bioconductor-treesummarizedexperiment

## Overview

The `TreeSummarizedExperiment` (TSE) class extends `SingleCellExperiment` to integrate hierarchical structures (trees) with experimental data. It allows for the storage of row-wise trees (e.g., phylogenies of OTUs) and column-wise trees (e.g., sample hierarchies), maintaining the link between tree nodes and assay rows/columns even after subsetting or aggregation.

## Core Workflows

### 1. Construction
To create a `TreeSummarizedExperiment`, you need assays, row/column data, and `phylo` objects.

```r
library(TreeSummarizedExperiment)
library(ape)

# Basic construction
tse <- TreeSummarizedExperiment(
    assays = list(counts = assay_matrix),
    rowData = row_df,
    colData = col_df,
    rowTree = row_phylo,
    rowNodeLab = row_labels_matching_tree,
    colTree = col_phylo
)
```
*Note: If `rowNodeLab` is not provided, the package attempts to match `rownames(assays)` to the tree's node labels.*

### 2. Accessors and Linkage
TSE uses "links" to map assay rows to tree nodes.
- `rowTree(tse)` / `colTree(tse)`: Retrieve the `phylo` objects.
- `rowLinks(tse)` / `colLinks(tse)`: Retrieve the `LinkDataFrame` showing the mapping (nodeLab, nodeNum, isLeaf).
- `referenceSeq(tse)`: Access DNA sequences associated with rows.

### 3. Tree-Based Subsetting
Beyond standard `[` indexing, you can subset by tree nodes.
```r
# Subset to a specific internal node or leaf by label
sub_tse <- subsetByNode(tse, rowNode = "Node_Label")

# Subset by node number
sub_tse <- subsetByNode(tse, rowNode = 15)
```

### 4. Aggregation (aggTSE)
One of the most powerful features is aggregating data to higher taxonomic or hierarchical levels.
```r
# Aggregate rows to a specific level (e.g., Phylum)
agg_tse <- aggTSE(tse, 
                  rowLevel = c("Node1", "Node2"), 
                  rowFun = sum)

# Aggregate both dimensions
agg_both <- aggTSE(tse, 
                   rowLevel = 10:15, 
                   colLevel = "Group_A", 
                   rowFun = sum, 
                   colFun = mean)
```

### 5. Tree Manipulation
- `toTree(data)`: Convert a taxonomic `data.frame` into a `phylo` object.
- `changeTree(tse, rowTree = new_tree)`: Replace a tree while updating links.
- `convertNode(tree, node)`: Translate between node labels and node numbers.
- `findDescendant(tree, node, only.leaf = TRUE)`: Find all leaves under a specific node.

### 6. Combining Objects
- `rbind()`: Combines objects by row. If trees differ, the resulting object will contain multiple trees (accessible via `rowTreeNames`).
- `cbind()`: Combines objects by column. Requires matching row structures; if trees differ, they are dropped with a warning.

## Tips for Success
- **Node Labels**: Ensure your tree has unique node labels if you plan to use character-based subsetting or aggregation.
- **Phylo Class**: The package relies on the `ape` package's `phylo` class. Use `treeio` to convert other tree formats to `phylo`.
- **Link Integrity**: Avoid modifying `rowLinks` or `colLinks` manually. Use `changeTree` or the provided setters to maintain data integrity.
- **Multiple Trees**: A single TSE can store multiple trees in the same slot after an `rbind`. Use the `whichTree` argument in accessors to specify which one to target.

## Reference documentation
- [Introduction to TreeSummarizedExperiment](./references/Introduction_to_treeSummarizedExperiment.md)
- [The combination of multiple TSEs](./references/The_combination_of_multiple_TSEs.md)