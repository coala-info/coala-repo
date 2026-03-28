---
name: nwkit
description: nwkit is a toolkit for the programmatic manipulation, rooting, pruning, and analysis of Newick-formatted phylogenetic trees. Use when user asks to root trees, prune leaves, rename nodes, calculate topological distances, or convert between Newick and tabular formats.
homepage: https://github.com/kfuku52/nwkit
---


# nwkit

## Overview

nwkit is a comprehensive toolkit designed for the programmatic manipulation of Newick-formatted phylogenetic trees. It provides a suite of subcommands to handle common bioinformatic tasks such as rooting, pruning, relabeling, and format sanitization. Use this skill to automate tree processing workflows, extract specific clades, or convert between Newick trees and tabular data.

## Core CLI Patterns

### Tree Rooting and Pruning
Rooting is a critical step for many comparative analyses. nwkit supports multiple rooting strategies.

*   **Root by outgroup**: `nwkit root -i tree.nwk --method outgroup --outgroup species_A,species_B`
*   **Midpoint rooting**: `nwkit root -i tree.nwk --method midpoint`
*   **Prune specific leaves**: `nwkit prune -i tree.nwk --target species_X,species_Y > pruned.nwk`
*   **Extract a subtree**: `nwkit subtree -i tree.nwk --node label_or_species > subtree.nwk`

### Node and Label Manipulation
Use these commands to clean up or standardize tree labels.

*   **Add unique labels to internal nodes**: `nwkit label -i tree.nwk > labeled.nwk`
*   **Rename nodes using a TSV map**: `nwkit rename -i tree.nwk --map_tsv names.tsv > renamed.nwk`
*   **Search and print specific labels**: `nwkit printlabel -i tree.nwk --pattern "Homo_sapiens"`
*   **Sanitize Newick flavors**: `nwkit sanitize -i tree.nwk --resolve_polytomy > clean.nwk`

### Analysis and Statistics
Extract topological information or compare multiple trees.

*   **Get tree summary info**: `nwkit info -i tree.nwk`
*   **Calculate topological distance**: `nwkit dist -i tree1.nwk -j tree2.nwk`
*   **Summarize clade frequencies**: `nwkit cladefreq -i tree_collection.nwk -o frequencies.tsv`
*   **Check monophyly**: `nwkit monophyly -i tree.nwk --group_tsv groups.tsv`

### Format Conversion
Convert trees to tables for easier manipulation in R or Python (Pandas).

*   **Tree to Parent-Child table**: `nwkit nwk2table -i tree.nwk > table.tsv`
*   **Table to Newick**: `nwkit table2nwk -i table.tsv > tree.nwk`

## Expert Tips

*   **PAML Integration**: Use `nwkit mcmctree` to introduce divergence time constraints specifically formatted for PAML's mcmctree analysis.
*   **NHX Support**: If working with Extended Newick (NHX) from tools like OrthoFinder or TreeFam, use `nwkit nhx2nwk` to convert them to standard Newick for broader tool compatibility.
*   **Piping**: Most nwkit commands support standard input/output, allowing for complex one-liners:
    `nwkit sanitize -i raw.nwk | nwkit root --method midpoint | nwkit prune --target outgroup_sp > final.nwk`
*   **Visualization**: For quick visual checks, `nwkit draw` can generate ASCII or basic graphical representations of the tree structure.



## Subcommands

| Command | Description |
|---------|-------------|
| mcmctree | Calculate divergence times for a given newick tree. |
| nhx2nwk | Convert NHX-annotated Newick trees to standard Newick format. |
| nwkit dist | Calculate distances between two Newick trees. |
| nwkit drop | Drop nodes from a newick tree. |
| nwkit intersection | Computes the intersection of two phylogenetic trees. |
| nwkit label | Label nodes in a Newick tree. |
| nwkit mark | Mark nodes in a Newick tree based on a pattern and target type. |
| nwkit printlabel | Print labels from a newick tree based on a pattern. |
| nwkit prune | Prune leaves from a newick tree based on a pattern. |
| nwkit sanitize | Sanitize a Newick tree file. |
| nwkit subtree | Extract subtrees from a Newick file. |
| nwkit_constrain | Constrain a newick tree based on taxonomic information. |
| nwkit_info | Show information about a newick file. |
| nwkit_root | Root a newick tree. |
| nwkit_shuffle | Shuffle newick trees |
| nwkit_skim | Prunes a newick tree based on trait data. |
| nwkit_transfer | Transfer information between two Newick trees. |
| rescale | Rescale branch lengths of a newick tree. |

## Reference documentation

- [nwkit Wiki Home](./references/github_com_kfuku52_nwkit_wiki.md)
- [nwkit root documentation](./references/github_com_kfuku52_nwkit_wiki_nwkit-root.md)
- [nwkit cladefreq documentation](./references/github_com_kfuku52_nwkit_wiki_nwkit-cladefreq.md)
- [nwkit rename documentation](./references/github_com_kfuku52_nwkit_wiki_nwkit-rename.md)
- [nwkit mcmctree documentation](./references/github_com_kfuku52_nwkit_wiki_nwkit-mcmctree.md)