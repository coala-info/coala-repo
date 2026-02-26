---
name: ete3
description: ETE3 is a toolkit for the manipulation, analysis, and visualization of phylogenetic trees and hierarchical data. Use when user asks to load or prune trees, visualize alignments with tree structures, query NCBI taxonomy, or perform phylogenomic analyses like calculating Robinson-Foulds distances.
homepage: http://etetoolkit.org/
---


# ete3

## Overview
The ETE (Evolutionary Tree Explorer) Toolkit provides a comprehensive environment for handling hierarchical tree data. It is particularly useful for bioinformaticians working with phylogenomic data who need to automate tree annotation, prune specific clades, or visualize alignments alongside phylogenetic trees. This skill focuses on leveraging the ETE3 Python API and its specialized tools for evolutionary analysis.

## Core Functionality

### Tree Loading and Manipulation
- **Loading**: Use `Tree("newick_string")` or `Tree("file.nwk")`. ETE3 supports multiple Newick formats (0-9) depending on whether internal node names or support values are present.
- **Traversal**: Use `tree.traverse()` for iterative processing or `tree.get_children()`, `tree.get_leaves()`, and `tree.get_common_ancestor()` for specific node retrieval.
- **Pruning**: Use `tree.prune(["leaf_a", "leaf_b"])` to reduce a tree to a specific subset of taxa.

### Visualization Best Practices
- **TreeStyle**: Always define a `TreeStyle()` object to control global parameters like `show_leaf_names`, `show_branch_support`, or `rotation`.
- **NodeStyle**: Customize individual nodes (colors, shapes, sizes) by creating `NodeStyle()` objects and applying them to `node.set_style()`.
- **Layout Functions**: Use a layout function to dynamically add faces (text, images, charts) to nodes during the rendering process.
- **Rendering**: Use `tree.render("output.png", tree_style=ts)` for static images. For interactive exploration in Jupyter, simply calling the tree object or using `tree.explore()` is preferred.

### Taxonomic Integration
- **NCBI Taxonomy**: Use the `NCBITaxa` class to query the NCBI database.
- **Annotation**: Automatically annotate trees with scientific names or lineage information using `ncbi.annotate_tree(tree, taxid_attr="name")`.
- **Conversion**: Convert lists of TaxIDs into a phylogenetic tree structure using `ncbi.get_topology([taxid1, taxid2])`.

### Phylogenomic Tools
- **Tree Comparison**: Use `ete3 compare` via CLI or the `robinson_foulds` method in the API to calculate distances between topologies.
- **Evolutionary Analysis**: The `ete3 evol` tool allows for running CodeML/PAML workflows directly on trees to test for positive selection.

## Expert Tips
- **Memory Management**: When dealing with massive trees (100k+ leaves), avoid GUI-based rendering and use the `tree.traverse()` generator to minimize memory overhead.
- **Format Detection**: If a Newick file fails to load, try specifying `format=1` (flexible) or `format=5` (internal nodes as support values).
- **Detached Nodes**: When pruning or moving nodes, remember that `node.detach()` removes the node from its current parent but keeps the subtree intact in memory.

## Reference documentation
- [ETE Toolkit Overview](./references/etetoolkit_org_index.md)
- [Bioconda ETE3 Package](./references/anaconda_org_channels_bioconda_packages_ete3_overview.md)