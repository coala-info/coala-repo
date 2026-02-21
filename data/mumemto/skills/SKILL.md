---
name: mumemto
description: Mumemto is a high-performance tool designed to find exact matches across large, repetitive collections of sequences, such as pangenomes.
homepage: https://github.com/vikshiv/mumemto
---

# mumemto

## Overview

Mumemto is a high-performance tool designed to find exact matches across large, repetitive collections of sequences, such as pangenomes. By utilizing the prefix-free parse (PFP) algorithm for suffix array construction, it maintains efficiency even as dataset size and repetitiveness increase. It is primarily used to compute multi-MUMs (Maximal Unique Matches present across a collection) and multi-MEMs (Maximal Exact Matches), providing a structural framework for pangenome analysis and visualization.

## Core CLI Usage

### Finding Matches
The primary command computes multi-MUMs across a set of FASTA files.

```bash
# Basic multi-MUM finding
mumemto -o output_prefix input1.fasta input2.fasta input3.fasta

# Using a directory of assemblies
mumemto assemblies/*.fa -o pangenome_results
```

### Visualization
After computing matches, use the `viz` subcommand to generate synteny visualizations.

```bash
mumemto viz -i output_prefix
```

### Merging Partitions (v1.3+)
For large-scale or parallel processing, Mumemto supports merging results from different partitions.

```bash
# Merge multiple .mums files into a global set
mumemto merge p1.mums p2.mums p3.mums -o global_pangenome
```

## Parameter Tuning & Best Practices

### Match Filtering Flags
Control the sensitivity and specificity of the matches using the following flags:

*   `-k <int>`: Minimum number of sequences a match must appear in.
    *   *Expert Tip*: Use negative integers for relative subsets. `-k -1` finds matches in at least $N-1$ sequences (all but one).
*   `-f <int>`: Maximum number of occurrences allowed within *each* sequence (useful for finding or filtering duplications).
*   `-F <int>`: Maximum total occurrences across the entire collection (useful for filtering low-complexity regions).

### Merging Strategies
When working with very large pangenomes, use partitioned runs with merging:

*   **Anchor-based (`-Mn`)**: Use this if the first sequence in every partition is the same (e.g., a common reference). It is significantly faster.
*   **String-based (`-M`)**: Use this when there is no common overlap between partitions.
*   **Incremental Updates**: You can add new assemblies to an existing pangenome by merging the new results into the global set using the `.thresh` files generated during the run.

### Input Management
For datasets with many files, avoid shell globbing limits by providing a file-list:
```bash
# Create a list of paths
ls data/*.fasta > fasta_list.txt
# Run mumemto using the list
mumemto fasta_list.txt -o pangenome_output
```

## Reference documentation
- [Mumemto GitHub Repository](./references/github_com_vikshiv_mumemto.md)
- [Mumemto Wiki](./references/github_com_vikshiv_mumemto_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mumemto_overview.md)