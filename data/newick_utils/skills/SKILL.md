---
name: newick_utils
description: The newick_utils suite provides a high-performance toolkit for processing, manipulating, and visualizing phylogenetic tree data. Use when user asks to visualize trees in ASCII or SVG formats, re-root clades, prune or keep specific taxa, collapse low-support nodes, or extract tree statistics and labels.
homepage: http://cegg.unige.ch/newick_utils
---


# newick_utils

## Overview
The `newick_utils` suite provides a high-performance toolkit for handling phylogenetic tree data. It is particularly useful for automated pipelines where trees need to be programmatically modified—such as removing specific taxa, collapsing nodes with low support, or changing the outgroup—before final visualization or downstream analysis.

## Common CLI Patterns

### Tree Visualization
*   **ASCII Preview**: Quickly view a tree structure in the terminal.
    `nw_display tree.nwk`
*   **SVG Generation**: Create a publication-quality image.
    `nw_display -s tree.nwk > tree.svg`
*   **Radial Layout**: Useful for large trees.
    `nw_display -r tree.nwk > radial_tree.svg`

### Tree Manipulation
*   **Re-rooting**: Set a specific node or clade as the outgroup.
    `nw_reroot tree.nwk Leaf_A Leaf_B`
*   **Pruning**: Remove specific leaves from the tree.
    `nw_prune tree.nwk Leaf_X Leaf_Y`
*   **Trimming**: Keep only a specific subset of leaves.
    `nw_keep tree.nwk Leaf_A Leaf_B Leaf_C`
*   **Condensing**: Collapse nodes with bootstrap support below a threshold (e.g., 70).
    `nw_condense 70 tree.nwk`

### Data Extraction
*   **List Leaves**: Output all taxa names.
    `nw_labels tree.nwk`
*   **Tree Statistics**: Get number of leaves, nodes, and path lengths.
    `nw_stats tree.nwk`
*   **Subtree Extraction**: Grab a specific clade based on a common ancestor of two nodes.
    `nw_clade tree.nwk Leaf_A Leaf_B`

## Expert Tips
*   **Piping**: Commands are designed to be piped together. For example, to prune a tree and then display it: `nw_prune tree.nwk Taxon_1 | nw_display -`
*   **Label Management**: Use `nw_rename` to map cryptic IDs to readable species names using a tab-delimited map file.
*   **Order Matters**: When re-rooting, ensure the outgroup specified is monophyletic in the input tree to avoid unexpected topologies.



## Subcommands

| Command | Description |
|---------|-------------|
| nw_prune | Prune nodes from a Newick tree. (Note: The provided help text contained only system error messages; arguments are derived from standard tool documentation for nw_prune). |
| nw_reroot | Reroot a phylogenetic tree at a specified node or outgroup. |

## Reference documentation
- [EZlab Tools Overview](./references/www_ezlab_org_index.md)