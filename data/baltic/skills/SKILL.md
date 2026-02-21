---
name: baltic
description: The `baltic` (Backronymed Adaptable Lightweight Tree Import Code) skill provides a specialized workflow for handling phylogenetic data.
homepage: https://github.com/evogytis/baltic
---

# baltic

---

## Overview

The `baltic` (Backronymed Adaptable Lightweight Tree Import Code) skill provides a specialized workflow for handling phylogenetic data. It transforms raw tree strings or files into navigable Python objects, allowing for sophisticated evolutionary analysis. You should use this skill when working with pathogen evolution data, investigating speciation patterns, or needing to integrate phylogenetic trees with other biological datasets. It is particularly effective for users within the Nextstrain ecosystem or those requiring a lightweight alternative to more complex bioinformatic libraries.

## Core Classes and Structure

Understanding the object hierarchy is essential for effective tree manipulation:

- **Tree**: The top-level container for the entire phylogeny.
- **Node**: Represents internal branches; contains a list of `children` and `leaves`.
- **Leaf**: Represents external branches (tips); contains `name` and `numName`.
- **Objects List**: The recommended way to interact with the tree is via `myTree.Objects`, which is a flat list of all branches (nodes and leaves) in the tree.

## Loading Trees

`baltic` supports multiple input formats. Choose the loader based on your source data:

```python
import baltic as bt

# From a Newick string
myTree = bt.make_tree('((A:1.0,B:2.0):1.0,C:3.0);')

# From a Newick file
myTree = bt.loadNewick('path/to/tree.newick')

# From a Nexus file (useful for BEAST outputs)
myTree = bt.loadNexus('path/to/tree.nex', absoluteTime=False)

# From Nextstrain JSON (returns tree and metadata)
myTree, myMeta = bt.loadJSON('https://nextstrain.org/charon/getDataset?prefix=/dengue/denv1')
```

## Common Workflows and Best Practices

### Tree Traversal and Filtering
Instead of complex recursive functions, use the `Objects` list to filter branches based on attributes:

- **Find specific tips**: `[l for l in myTree.Leaves if l.name == 'Target_Name']`
- **Filter by trait**: `[k for k in myTree.Objects if k.traits['location'] == 'Africa']`
- **Get internal nodes**: `myTree.getInternal()`

### Manipulating Tree Structure
- **Extracting a Subtree**: Use `myTree.subtree(node)` to create a new tree object rooted at a specific internal node.
- **Finding the MRCA**: Use `myTree.commonAncestor(leaf_list)` to find the Most Recent Common Ancestor of a set of tips.
- **Collapsing Clades**: Use `myTree.collapseSubtree(node)` to simplify large trees for visualization.

### Temporal Analysis
If your tree has branch lengths representing time:
- Use `myTree.setAbsoluteTime(root_time)` to convert relative branch lengths into calendar dates.
- Use helper functions like `bt.decimalDate('2023-12-25')` or `bt.calendarDate(2023.98)` to convert between formats.

### Visualization Tips
`baltic` is designed to work with Matplotlib for plotting:
- **Standard Plot**: `myTree.plotTree(ax)`
- **Circular Plot**: `myTree.plotCircularTree(ax)`
- **Customizing**: Iterate through `myTree.Objects` to plot points or text at specific coordinates (`k.x` and `k.y`).

## Expert Tips
- **Memory Efficiency**: For very large trees, use `myTree.reduceTree(leaf_list)` to prune the tree down to only the tips of interest before performing heavy computations.
- **Trait Access**: Most loaders automatically populate the `traits` dictionary for each node/leaf. Always check `k.traits.keys()` to see what metadata is available.
- **Hanging Nodes**: If a tree manipulation results in single-child nodes, run `myTree.fixHangingNodes()` to clean up the structure.

## Reference documentation
- [baltic GitHub README](./references/github_com_evogytis_baltic.md)
- [baltic Wiki - Home](./references/github_com_evogytis_baltic_wiki.md)