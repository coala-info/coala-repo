---
name: phytop
description: Phytop detects and visualizes phylogenetic discordance by quantifying incomplete lineage sorting and hybridization signals between gene trees and species trees. Use when user asks to visualize gene tree conflict, calculate ILS and IH indices, map discordance data onto species trees, or screen lineages for introgression.
homepage: https://github.com/zhangrengang/phytop/
metadata:
  docker_image: "quay.io/biocontainers/phytop:0.3--pyhdc42f0e_0"
---

# phytop

## Overview

Phytop is a specialized tool for evolutionary biologists to detect and visualize phylogenetic discordance. It quantifies the degree of discordance between gene trees and species trees by calculating specific ILS and IH indices. By mapping these signals onto species tree branches, it helps researchers distinguish between random sorting processes (ILS) and directional gene flow (hybridization). The tool is particularly useful for screening lineages for further downstream introgression analysis and producing publication-quality visualizations of gene tree conflict.

## Installation and Setup

Phytop is available via Bioconda. It is recommended to run it within a dedicated environment:

```bash
conda install bioconda::phytop
```

## Core Usage Patterns

### Basic Visualization
To generate the default visualization (bar charts on nodes) from an ASTRAL species tree:

```bash
phytop astral.tree
```

### Mapping Data to Alternative Trees
If you have a timetree or a tree with different branch lengths but the same topology as your ASTRAL tree, use the `-alter` flag to project the discordance data onto it:

```bash
phytop astral.tree -alter timetree.nwk
```

### Customizing Visual Output
Adjust the aesthetics for better clarity or publication requirements:

*   **Change to Pie Charts**: `phytop astral.tree -pie`
*   **Adjust Chart Size**: `phytop astral.tree -figsize 1.5`
*   **Custom Colors**: `phytop astral.tree -colors red,blue,grey` (sets colors for q1, q2, and q3 respectively)
*   **Font Sizes**: Use `-branch_size` for branch labels and `-leaf_size` for taxa names.

### Focusing on Specific Lineages
For large trees, you can limit the visualization to specific clades of interest:

*   **Show only specific nodes**: `phytop astral.tree -onshow taxon_list.txt`
*   **Hide specific nodes**: `phytop astral.tree -noshow taxon_list.txt`
*   **Visualize a subset**: `phytop astral.tree -subset taxon_list.txt` (shows the clade containing the MRCA of the listed taxa)

## Expert Tips and Best Practices

*   **ASTRAL Requirement**: Phytop requires the quartet frequency information embedded in the ASTRAL output. You **must** run ASTRAL with `-u 2` (C++ versions like ASTRAL-Pro) or `-t 2` (Java versions like ASTRAL-III) for the input to be compatible.
*   **Interpreting q2 vs q3**: 
    *   If $q2 \approx q3$, the discordance is likely explained by **ILS**.
    *   If $q2 \gg q3$ (or vice versa), it strongly suggests **Introgression/Hybridization** between specific lineages.
*   **Statistical Testing**: Use the `-polytomy_test` flag to perform a Chi-square test to check if the observed discordance significantly deviates from the null hypothesis of a polytomy.
*   **Output Files**: 
    *   `*.pdf`: The primary visualization.
    *   `*.info.tsv`: Contains the raw numerical values for ILS-i, IH-i, and p-values for every node, which is essential for supplementary data tables.
*   **Branch Lengths**: Use the `-bl` flag if you want to check or display specific branch lengths associated with the discordance signals.

## Reference documentation
- [Phytop GitHub Repository](./references/github_com_zhangrengang_phytop.md)
- [Bioconda Phytop Overview](./references/anaconda_org_channels_bioconda_packages_phytop_overview.md)