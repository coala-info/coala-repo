---
name: treeswift
description: TreeSwift is a lightweight, pure-Python library engineered for speed and memory efficiency when working with phylogenetic trees.
homepage: https://github.com/niemasd/TreeSwift
---

# treeswift

## Overview
TreeSwift is a lightweight, pure-Python library engineered for speed and memory efficiency when working with phylogenetic trees. While many Python tree libraries struggle with "ultra-large" trees (containing millions of nodes), TreeSwift provides a streamlined API to perform traversals, compute distances, and prune structures without the overhead of complex object-relational mappings. Use this skill to automate phylogenetic workflows, such as extracting subtrees, converting between formats, or calculating tree statistics.

## Installation
TreeSwift can be installed via pip or conda:

```bash
# Using pip
pip install treeswift

# Using conda
conda install -c bioconda treeswift
```

## Core Usage Patterns

### Loading and Saving Trees
TreeSwift supports Newick and Nexus formats. It can handle files or raw strings.

```python
import treeswift

# Load from a Newick string
tree = treeswift.read_tree_newick("((A:0.1,B:0.2)C:0.3,D:0.4);")

# Load from a file
tree = treeswift.read_tree("path/to/tree.nwk", "newick")

# Save to Nexus format
tree.write_tree_nexus("output.nexus")
```

### Tree Traversal
Efficient traversal is the core strength of TreeSwift. Use the appropriate generator for your algorithm:

*   `traverse_postorder()`: Bottom-up traversal (leaves to root).
*   `traverse_preorder()`: Top-down traversal (root to leaves).
*   `traverse_inorder()`: Left-to-right traversal.
*   `traverse_levelorder()`: Breadth-first search (BFS).

```python
for node in tree.traverse_postorder():
    if node.is_leaf():
        print(f"Leaf label: {node.label}")
```

### Tree Manipulation
Common operations for cleaning or subsetting trees:

*   **Subtree Extraction**: Use `tree.extract_tree(labels)` to create a new tree containing only the specified taxa.
*   **Unifurcation Suppression**: Use `tree.suppress_unifurcations()` to remove nodes with only one child, which is common after pruning.
*   **Finding Nodes**: Use `tree.find_node(label)` to quickly locate a specific node by its string identifier.

### Metrics and Analysis
*   **Node Counts**: `node.num_nodes()` returns the count of nodes in the subtree rooted at that node.
*   **Distances**: `tree.distance_between(u, v)` calculates the evolutionary distance between two node objects.
*   **Cherries**: TreeSwift can identify "cherries" (pairs of leaves that share a direct parent), which is a common metric in tree shape analysis.

## Expert Tips
*   **Memory Management**: For ultra-large trees, avoid storing massive amounts of metadata in the `node.params` dictionary unless necessary, as this is the primary source of memory consumption in pure-Python implementations.
*   **Rooting**: TreeSwift assumes trees are rooted. If working with unrooted trees, be mindful that the library will treat the first node in the Newick string as the root.
*   **Speed**: If TreeSwift is still too slow for your specific use case, the author recommends **CompactTree**, a C++ alternative with a similar Python wrapper.

## Reference documentation
- [TreeSwift GitHub Repository](./references/github_com_niemasd_TreeSwift.md)
- [TreeSwift Wiki](./references/github_com_niemasd_TreeSwift_wiki.md)
- [Bioconda TreeSwift Overview](./references/anaconda_org_channels_bioconda_packages_treeswift_overview.md)