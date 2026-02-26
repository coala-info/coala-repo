---
name: raptor
description: Raptor is a high-performance bioinformatics tool that uses compressed index structures to query nucleotide sequences against large collections of reference data. Use when user asks to build a Hierarchical Interleaved Bloom Filter index, search query sequences against reference bins, or perform fast approximate membership queries across thousands of genomes.
homepage: https://github.com/seqan/raptor
---


# raptor

## Overview
Raptor is a high-performance bioinformatics tool designed to handle the "needle in a haystack" problem for genomic data. It allows users to query nucleotide sequences against vast collections of reference data by using a compressed index structure. Use this skill to guide the indexing of reference genomes and the subsequent searching of query sequences to determine which reference bins contain potential matches. It is particularly effective when dealing with thousands of genomes where traditional alignment is too slow.

## Installation
The most straightforward way to install Raptor is via Bioconda:

```bash
conda install -c bioconda -c conda-forge raptor
```

For maximum performance, consider compiling from source on the target machine to allow for host-specific optimizations (e.g., SIMD instructions).

## Core Workflow

Raptor operates in two primary stages: building an index and searching against it.

### 1. Building the Index
The `build` command creates a Hierarchical Interleaved Bloom Filter (HIBF) from your reference sequences.

*   **Input Preparation**: Organize your reference sequences into "bins" (e.g., one bin per species or per genome).
*   **Command Structure**:
    ```bash
    raptor build --input <ref_list.txt> --output <index_name.hibf>
    ```
*   **Expert Tip**: Since version 1.1.0, Raptor can accept a file containing paths to the bins. This is much more manageable than passing thousands of file paths directly to the CLI.

### 2. Searching the Index
Once the index is created, use the `search` command to query your sequences.

*   **Command Structure**:
    ```bash
    raptor search --index <index_name.hibf> --query <queries.fastq> --output <results.txt>
    ```
*   **Approximate Search**: Raptor is designed for approximate membership queries. It identifies which bins likely contain the query based on k-mer counts and thresholds.

## Command Line Best Practices

*   **Help Discovery**: Raptor uses a nested help system. Use `raptor --help` for general commands, and `raptor build --help` or `raptor search --help` for specific parameter details.
*   **Memory Management**: HIBFs are space-efficient, but very large indices can still consume significant RAM. If you encounter large index issues, verify your binning strategy or adjust the false positive rate (FPR) if the version allows.
*   **Input/Output**: Always specify explicit `--input` and `--output` paths to avoid confusion, especially when working with complex directory structures in bioinformatics pipelines.

## Troubleshooting and Performance
*   **Large Indices**: If the HIBF index is unexpectedly large, check the number of unique k-mers across your bins. High redundancy across bins is handled well by HIBF, but unique noise can bloat the filter.
*   **Optimization**: Use minimizers (if supported by the specific version's build parameters) to reduce the index size and speed up the search process without significantly sacrificing sensitivity.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_seqan_raptor.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_raptor_overview.md)