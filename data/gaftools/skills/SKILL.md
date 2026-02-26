---
name: gaftools
description: gaftools is a toolkit for processing and analyzing Graph Alignment Format files within pangenomic workflows. Use when user asks to convert GFA to rGFA, order graph nodes, sort and index GAF files, realign sequences to a graph, or generate alignment statistics.
homepage: https://github.com/marschall-lab/gaftools
---


# gaftools

## Overview

gaftools is a high-performance toolkit tailored for the pangenomics ecosystem. It provides a suite of utilities to manage Graph Alignment Format (GAF) files, which are typically produced by aligners like minigraph or GraphAligner. The tool is essential for workflows involving rGFA (reference-based Graphical Fragment Assembly) graphs, offering the ability to normalize graph coordinates, improve alignment accuracy through realignment, and prepare files for rapid genomic queries via indexing and sorting.

## Core Workflows and CLI Patterns

### Graph Normalization and Preparation
Before analyzing alignments, ensure the graph and the GAF files are in the expected format and order.

*   **Convert GFA to rGFA**: Use `gfa2rgfa` to convert a standard GFA into a reference-based GFA. This is often a prerequisite for other subcommands.
    ```bash
    gaftools gfa2rgfa input.gfa > output.rgfa
    ```
*   **Order GFA Nodes**: Use `order_gfa` to determine a linear order for nodes in the graph, which can help in visualization and certain analysis types.
    ```bash
    gaftools order_gfa input.gfa > ordered.gfa
    ```

### Alignment Processing
GAF files often need to be sorted and indexed for efficient access by other tools or for viewing specific genomic regions.

*   **Sort GAF**: Sorting is required before indexing.
    ```bash
    gaftools sort -o sorted.gaf input.gaf
    ```
*   **Index GAF**: Create an index for a sorted GAF file to enable fast random access.
    ```bash
    gaftools index sorted.gaf
    ```
*   **Realignment**: Improve the quality of existing alignments, particularly around indels or complex graph structures. This typically requires the original sequence file.
    ```bash
    gaftools realign --gaf input.gaf --graph input.gfa --fasta sequences.fa > realigned.gaf
    ```

### Analysis and Inspection
*   **Statistics**: Generate a summary of the alignments, including identity, coverage, and mapping quality.
    ```bash
    gaftools stat input.gaf
    ```
*   **View**: Filter or convert GAF files for inspection.
*   **Find Path**: Search for specific paths or walks within the graph structure.
    ```bash
    gaftools find_path -k <path_name> input.gfa
    ```

## Expert Tips

*   **rGFA Dependency**: Most `gaftools` subcommands expect rGFA-based GAF files. If your alignments are against a non-reference-stable graph, use `gfa2rgfa` first.
*   **Memory Management**: When running `realign` on large pangenomes, ensure the `--fasta` file is indexed (samtools faidx) to reduce memory overhead during random access.
*   **Branching Graphs**: When using `order_gfa` on complex graphs with many branches, use the `--ignore-branching` flag if the tool struggles to find a valid linear order.
*   **Validation**: Always run `gaftools stat` after a `realign` or `sort` operation to verify that the number of records remains consistent and the alignment identities have improved as expected.

## Reference documentation
- [github_com_marschall-lab_gaftools.md](./references/github_com_marschall-lab_gaftools.md)
- [anaconda_org_channels_bioconda_packages_gaftools_overview.md](./references/anaconda_org_channels_bioconda_packages_gaftools_overview.md)
- [github_com_marschall-lab_gaftools_commits_main.md](./references/github_com_marschall-lab_gaftools_commits_main.md)