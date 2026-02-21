---
name: nwkit
description: nwkit is a specialized command-line suite designed for the efficient handling and transformation of Newick-formatted phylogenetic trees.
homepage: https://github.com/kfuku52/nwkit
---

# nwkit

## Overview

nwkit is a specialized command-line suite designed for the efficient handling and transformation of Newick-formatted phylogenetic trees. It provides a modular set of subcommands to bridge the gap between raw tree files and downstream evolutionary analysis. Use this skill to perform structural modifications like rooting and pruning, manage node metadata through labeling, and calculate comparative metrics such as topological distances between trees.

## Core CLI Usage

The general syntax for nwkit follows a standard subcommand pattern:
`nwkit <subcommand> [options] <input_file>`

### Tree Manipulation and Structural Changes

*   **Rooting**: Use the `root` subcommand to place or transfer a tree root.
    *   *Expert Tip*: Use the Minimum Ancestor Deviation (MAD) method for rooting without an outgroup:
        `nwkit root --method mad input.nwk > rooted.nwk`
*   **Pruning**: Remove specific leaves from a tree.
    *   `nwkit prune --leaf_list leaves.txt input.nwk > pruned.nwk`
*   **Subtrees**: Generate a Newick file for a specific clade or subtree.
    *   `nwkit subtree --node_label "Clade_A" input.nwk > subtree.nwk`
*   **Rescaling**: Adjust branch lengths by a specific factor.
    *   `nwkit rescale --factor 0.5 input.nwk > rescaled.nwk`

### Metadata and Labeling

*   **Labeling Nodes**: Add unique labels to internal nodes, which is often required for downstream software.
    *   `nwkit label input.nwk > labeled.nwk`
*   **Marking**: Add specific text to node labels based on leaf name regex matches.
    *   `nwkit mark --regex "Homo_.*" --text "Hominid" input.nwk`
*   **Printing Labels**: Search and display specific node labels.
    *   `nwkit printlabel input.nwk`

### Analysis and Comparison

*   **Tree Info**: Get a quick summary of tree statistics (number of leaves, nodes, etc.).
    *   `nwkit info input.nwk`
*   **Topological Distance**: Calculate the distance between two trees.
    *   `nwkit dist tree1.nwk tree2.nwk`
*   **Intersection**: Drop non-overlapping leaves between a tree and an alignment or another tree.
    *   `nwkit intersection --alignment seqs.fasta input.nwk`

### Data Cleaning and Constraints

*   **Sanitize**: Use this to eliminate non-standard Newick flavors and resolve polytomies to ensure compatibility with other tools.
    *   `nwkit sanitize --resolve_polytomy input.nwk`
*   **Constrain**: Generate species-tree-like Newick files for topological constraints.
    *   `nwkit constrain --taxid_tsv taxonomy.tsv input.nwk`
*   **MCMCTree**: Specifically for PAML users, this introduces divergence time constraints.
    *   `nwkit mcmctree --config constraints.txt input.nwk`

## Best Practices

1.  **Pre-processing**: Always run `nwkit sanitize` on trees obtained from diverse sources to ensure they follow standard Newick formatting before performing complex operations.
2.  **Piping**: nwkit subcommands typically output to stdout, making them ideal for shell pipes (e.g., `nwkit sanitize input.nwk | nwkit root --method mad - > final.nwk`).
3.  **Verification**: Use `nwkit info` after structural changes (like pruning or intersection) to verify that the resulting tree contains the expected number of taxa.

## Reference documentation
- [nwkit GitHub Repository](./references/github_com_kfuku52_nwkit.md)
- [nwkit Wiki and Subcommands](./references/github_com_kfuku52_nwkit_wiki.md)