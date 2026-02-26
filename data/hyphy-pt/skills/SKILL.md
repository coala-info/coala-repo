---
name: hyphy-pt
description: HyPhy is a comprehensive software suite for comparative sequence analysis used to infer the strength of natural selection by calculating dN/dS ratios across protein-coding alignments. Use when user asks to detect recombination, identify site-specific pervasive or episodic selection, test for branch-specific or gene-wide selection, or compare selection pressure between groups of branches.
homepage: http://hyphy.org/
---


# hyphy-pt

## Overview

HyPhy (Hypothesis Testing using Phylogenies) is a comprehensive software suite for comparative sequence analysis. It is primarily used to infer the strength of natural selection by calculating dN/dS ratios (nonsynonymous to synonymous substitution rates) across protein-coding alignments. This skill enables the execution of specialized evolutionary models to determine if specific sites, branches, or entire genes are subject to pervasive or episodic selection.

## CLI Usage and Best Practices

HyPhy is executed as a command-line tool using the `hyphy` command (for multi-threaded MP versions) or `HYPHYMPI` (for cluster environments).

### Common Command Pattern
```bash
hyphy <method> --alignment <path_to_alignment> --tree <path_to_tree> [options]
```
*Note: If the tree is already embedded in the alignment file (e.g., NEXUS or FASTA with Newick footer), the `--tree` flag is optional.*

### Method Selection Guide
Choose the specific HyPhy method based on your research question:

| Goal | Recommended Method | Notes |
| :--- | :--- | :--- |
| **Detect Recombination** | `gard` | **Critical**: Run this first; recombination can cause false positives in selection tests. |
| **Site-specific (Pervasive)** | `fubar` | Preferred for speed and power in medium-to-large datasets. |
| **Site-specific (Episodic)** | `meme` | Best for finding sites under selection on only a subset of branches. |
| **Branch-specific** | `absrel` | Tests if specific lineages have experienced selection. |
| **Gene-wide Test** | `busted` | Tests if the gene has experienced selection anywhere in the tree. |
| **Compare Groups** | `relax` | Tests if selection pressure is relaxed or intensified between sets of branches. |
| **Directional Selection** | `fade` | Used for protein alignments to find bias toward specific amino acids. |

### Essential Arguments
- `--alignment`: Path to the multiple sequence alignment (FASTA, NEXUS, PHYLIP).
- `--tree`: Path to the Newick-formatted phylogeny.
- `--code`: Genetic code (default is `Universal`). Use `1` for Universal.
- `--output`: Specify the path for the resulting JSON file.

### Expert Tips
1. **Recombination Screening**: Always run GARD on your alignment before selection analysis. If GARD finds breakpoints, use the resulting partitioned NEXUS file as input for selection methods to avoid artifacts.
2. **Interactive Mode**: If you are unsure of the required parameters for a method, run `hyphy -i <method>`. HyPhy will prompt you for genetic codes, p-value thresholds, and branch selections.
3. **Synonymous Rate Variation**: When using FEL or SLAC, always enable synonymous rate variation (dS variation) to improve the accuracy of dN/dS estimates.
4. **Visualization**: HyPhy outputs results in JSON format. These are best viewed by uploading them to [HyPhy Vision](https://vision.hyphy.org/).
5. **MPI for Large Jobs**: For methods like GARD or FUBAR on very large alignments, use `mpirun -np <cores> HYPHYMPI` to distribute the workload.

## Reference documentation
- [HyPhy Methods Overview](./references/hyphy_org_methods_selection-methods.md)
- [CLI Tutorial](./references/hyphy_org_tutorials_CLI-tutorial.md)
- [Getting Started with HyPhy](./references/hyphy_org_getting-started.md)
- [Installation and Environment](./references/hyphy_org_installation.md)