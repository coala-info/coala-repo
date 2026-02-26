---
name: hyphy
description: HyPhy is a software package for molecular evolution research that performs hypothesis testing to identify signatures of natural selection in genetic sequences. Use when user asks to detect gene-wide selection, identify branch-specific or site-specific selection, test for relaxed selection, or screen for recombination.
homepage: http://hyphy.org/
---


# hyphy

## Overview

HyPhy (Hypothesis Testing using Phylogenies) is a specialized software package designed for molecular evolution research. It allows users to test specific hypotheses about how genetic sequences evolve over time, with a primary focus on identifying signatures of natural selection. This skill helps you navigate the suite of available methods to determine whether selection is acting on an entire gene, specific lineages, or individual sites within an alignment. It also provides the necessary command-line patterns to execute these analyses and prepare results for visualization.

## Method Selection Guide

Choosing the correct method is critical for a valid evolutionary hypothesis test. Use the following logic to select a tool:

| Goal | Recommended Method |
| :--- | :--- |
| **Gene-wide selection** (Has the gene experienced selection anywhere?) | **BUSTED** |
| **Branch-specific selection** (Which lineages are under selection?) | **aBSREL** |
| **Pervasive site selection** (Which sites are selected across the whole tree?) | **FUBAR** (preferred) or **FEL** |
| **Episodic site selection** (Which sites are selected on some branches?) | **MEME** |
| **Relaxed selection** (Has selection pressure weakened on certain branches?) | **RELAX** |
| **Directional selection** (Is there a bias toward a specific amino acid?) | **FADE** |
| **Recombination detection** (Pre-processing to avoid false positives) | **GARD** |

## Command Line Usage

HyPhy 2.4+ functions as a standard CLI tool. The general syntax is:
`hyphy <method> --alignment <path> [options]`

### Common CLI Patterns

*   **Basic Analysis (Tree included in alignment file):**
    `hyphy busted --alignment data/ksr2.fna`

*   **Analysis with Separate Tree File:**
    `hyphy mem --alignment data/lysin.fna --tree data/lysin.nwk`

*   **Interactive Mode:**
    Use `-i` to be prompted for parameters (genetic code, p-value thresholds, etc.):
    `hyphy -i`

*   **Mixed Mode (Specify some flags, prompt for others):**
    `hyphy -i slac --alignment data/CD2.fasta --code Universal`

### Key Arguments
*   `--alignment`: Path to the multiple sequence alignment (FASTA, PHYLIP, NEXUS).
*   `--tree`: Path to the Newick-formatted phylogeny.
*   `--code`: Genetic code (default is `Universal`).
*   `--output`: Specify a custom path for the resulting JSON file.

## Best Practices and Expert Tips

1.  **Recombination Screening:** Always run **GARD** on your alignment before selection analysis. Recombination can mimic the signal of positive selection, leading to false positives. If GARD finds breakpoints, use the resulting partitioned NEXUS file for subsequent analyses.
2.  **Synonymous Rate Variation:** When prompted or configuring FEL/SLAC, always enable synonymous rate variation. Assuming a constant *dS* across sites is often biologically unrealistic and can bias *dN/dS* estimates.
3.  **FUBAR vs. FEL:** For site-specific pervasive selection, **FUBAR** is generally preferred over FEL because it is faster and uses a Bayesian approach that is more robust to small datasets.
4.  **Visualization:** HyPhy outputs results in JSON format. Do not attempt to read these manually for interpretation. Upload the JSON file to [HyPhy Vision](https://vision.hyphy.org/) for interactive trees and plots.
5.  **Branch Labeling:** For methods like BUSTED or RELAX that compare "Test" vs "Reference" branches, use the [Phylotree Widget](https://hyphy.org/resources/phylotree/) to label your Newick tree with `{Test}` or `{Reference}` tags before running the CLI.

## Reference documentation

- [Selection Methods Overview](./references/hyphy_org_methods_selection-methods.md)
- [CLI Tutorial](./references/hyphy_org_tutorials_CLI-tutorial.md)
- [Getting Started with HyPhy](./references/hyphy_org_getting-started.md)
- [HyPhy Installation and Environment](./references/hyphy_org_installation.md)