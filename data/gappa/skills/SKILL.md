---
name: gappa
description: Gappa is a command-line toolset designed for the downstream analysis, visualization, and manipulation of phylogenetic placement data. Use when user asks to assign sequences to taxa, visualize placement density on trees, calculate phylogenetic distances between samples, or filter and merge placement files.
homepage: https://github.com/lczech/gappa
---

# gappa

## Overview

Gappa (Genesis Applications for Phylogenetic Placement Analysis) is a high-performance C++ command-line toolset designed to handle the downstream analysis of phylogenetic placement results produced by tools like EPA-ng or pplacer. It provides a modular interface to transform raw placement data into biological insights through statistical analysis, data manipulation, and tree-based visualizations. It is particularly effective for large-scale metagenomic studies where memory efficiency and speed are critical.

## Core CLI Patterns

Gappa uses a hierarchical command structure:
`gappa <module> <subcommand> [options]`

### 1. Examining and Assigning Placements
Use the `examine` module to summarize data or perform taxonomic classification.

*   **Taxonomic Assignment**: Assign query sequences to taxa based on their placements.
    ```bash
    gappa examine assign --jplace-path placements.jplace --taxonomy-file taxonomy.csv
    ```
*   **Visualizing Mass**: Create a "heat-tree" where branch colors represent placement density.
    ```bash
    gappa examine heat-tree --jplace-path sample.jplace --out-dir ./viz/
    ```
*   **Grafting**: Create a Newick tree where query sequences are added as actual pendant edges.
    ```bash
    gappa examine graft --jplace-path sample.jplace
    ```

### 2. Analyzing Multiple Samples
Use the `analyze` module to compare different samples or find patterns across datasets.

*   **Phylogenetic Distance (KRD)**: Calculate the Kantorovich-Rubinstein distance between samples.
    ```bash
    gappa analyze krd --jplace-path ./samples/ --out-dir ./results/
    ```
*   **Edge PCA**: Perform Principal Component Analysis on the placement masses.
    ```bash
    gappa analyze edgepca --jplace-path ./samples/
    ```
*   **Clustering**: Group samples using Squash Clustering or Phylogenetic k-means.
    ```bash
    gappa analyze squash --jplace-path ./samples/
    ```

### 3. Editing and Filtering Data
Use the `edit` module to clean or restructure `.jplace` files.

*   **Merging**: Combine multiple placement files into one.
    ```bash
    gappa edit merge --jplace-path file1.jplace file2.jplace --out-dir ./merged/
    ```
*   **Filtering**: Remove placements based on likelihood weight ratios (LWR) or specific taxa.
    ```bash
    gappa edit filter --jplace-path input.jplace --threshold 0.01
    ```
*   **Accumulation**: Move placement mass up to basal branches to reach a confidence threshold.
    ```bash
    gappa edit accumulate --jplace-path input.jplace --threshold 0.95
    ```

### 4. Data Preparation
Use the `prepare` module to format reference data.

*   **Tree Cleaning**: Fix Newick trees that have incompatible formatting for other tools.
    ```bash
    gappa prepare clean-tree --tree-path reference.tre
    ```
*   **Taxonomy to Tree**: Convert a tabular taxonomy into a constraint tree.
    ```bash
    gappa prepare taxonomy-tree --taxonomy-file tax.csv
    ```

## Expert Tips

*   **Directory Processing**: Most commands accept a directory for `--jplace-path`. Gappa will automatically process all `.jplace` and `.jplace.gz` files within that folder.
*   **Performance**: Use the `--threads` flag to speed up heavy analytical tasks like KRD or Edge PCA.
*   **Memory Efficiency**: Gappa is significantly more memory-efficient than its predecessor `guppy`. If you are hitting memory limits with other tools on large datasets, Gappa is the preferred alternative.
*   **Output Prefixes**: Use `--file-prefix` and `--file-suffix` to prevent overwriting results when running multiple iterations of the same subcommand in the same directory.



## Subcommands

| Command | Description |
|---------|-------------|
| gappa analyze | Commands for analyzing and comparing placement data, that is, finding differences and patterns. |
| gappa edit | Commands for editing and manipulating files like jplace, fasta or newick. |
| gappa examine | Commands for examining, visualizing, and tabulating information in placement data. |
| gappa tools | Auxiliary commands of gappa. |

## Reference documentation
- [Gappa Wiki Home](./references/github_com_lczech_gappa_wiki.md)
- [Subcommand: assign](./references/github_com_lczech_gappa_wiki_Subcommand_-assign.md)
- [Subcommand: accumulate](./references/github_com_lczech_gappa_wiki_Subcommand_-accumulate.md)
- [Subcommand: heat-tree](./references/github_com_lczech_gappa_wiki_Subcommand_-heat-tree.md)