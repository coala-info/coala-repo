---
name: ropebwt3
description: ropebwt3 is a high-performance bioinformatics tool designed for the construction and searching of the Burrows-Wheeler Transform (BWT) and FM-index.
homepage: https://github.com/lh3/ropebwt3
---

# ropebwt3

## Overview

ropebwt3 is a high-performance bioinformatics tool designed for the construction and searching of the Burrows-Wheeler Transform (BWT) and FM-index. It is specifically optimized for "redundant" genomic data, where many sequences are nearly identical (e.g., hundreds of strains of the same bacteria). It can compress terabytes of raw DNA into small, searchable indices. Use this skill to guide the creation of indices, the discovery of exact matches, and the execution of local alignments using the BWA-SW algorithm.

## Core Workflows

### 1. Index Construction (build)
The `build` command creates the `.fmd` (run-length encoded BWT) file.

*   **General usage**: `ropebwt3 build -t [threads] -bo [output.fmd] [input.fa]`
*   **Incremental building**: To add new sequences to an existing index:
    `ropebwt3 build -i [old.fmd] -bo [new.fmd] [new_sequences.fa]`
*   **Memory management**: Use `-m [mem]` (e.g., `-m 2g`) to set the memory limit for the block-based construction.
*   **Short reads**: For high-coverage short reads, apply the `-r` flag for RCLO (Run-length Conditional Line Ordering) optimization.

### 2. Finding Maximal Exact Matches (mem)
Use `mem` to find exact matches between a query and the index.

*   **Basic SMEM search**: `ropebwt3 mem -l [min_len] [index.fmd] [query.fa] > [output.bed]`
*   **Reporting positions**: By default, `mem` only counts hits. Use `-p` to report the positions of matches.
*   **Coverage analysis**: Use `--cov` to calculate the total length of regions covered by SMEMs of at least length `-l`.

### 3. Local and End-to-End Alignment (sw)
The `sw` command implements a revised BWA-SW algorithm for alignment.

*   **Local alignment**: `ropebwt3 sw -t [threads] [index.fmd] [query.fa] > [output.paf]`
*   **End-to-end alignment**: Add the `-e` flag to force the query to align from start to finish. This is useful for retrieving similar haplotypes.
*   **Accuracy vs. Speed**: Increase `-N` (bandwidth) for better accuracy or `-k` (seed length) for faster initial matching.

### 4. Index Components for Full Output
To get standard PAF output with coordinates and sequence names, you must have three files with the same base name:
1.  `<base>.fmd`: The BWT (created by `build`).
2.  `<base>.fmd.ssa`: Sampled Suffix Array (created by `ropebwt3 ssa <base>.fmd`).
3.  `<base>.fmd.len.gz`: Sequence names and lengths (created via `seqtk comp input.fa | cut -f1,2 | gzip`).

## Expert Tips

*   **Pangenome Advantage**: Unlike standard BWA, ropebwt3's performance improves or stays stable as redundancy increases, making it the preferred choice for pangenome indices.
*   **Reverse Complements**: By default, `build` indexes both strands. If you only need the forward strand, use `-R`.
*   **Large-scale Indexing**: For extremely large datasets (e.g., hundreds of human assemblies), consider using the `grlBWT` workflow (fa2line -> grlbwt-cli -> grl2plain -> plain2fmd) which can be faster and more memory-efficient than the standard `build` command.
*   **Retrieving Sequences**: Use the `get` command to extract specific sequences from the index by their internal ID: `ropebwt3 get [index.fmd] [id]`.

## Reference documentation

- [GitHub README](./references/github_com_lh3_ropebwt3.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ropebwt3_overview.md)