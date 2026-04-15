---
name: prophex
description: ProPhex is a bioinformatics tool for memory-efficient k-mer indexing and sequence read mapping using the Burrows-Wheeler Transform. Use when user asks to build a k-LCP index, query sequencing reads against a reference database, or convert BWT files to FASTA format.
homepage: https://github.com/prophyle/prophex
metadata:
  docker_image: "quay.io/biocontainers/prophex:0.1.1--h5bf99c6_2"
---

# prophex

## Overview

ProPhex is a high-performance bioinformatics tool designed for lossless k-mer indexing. By leveraging the Burrows-Wheeler Transform (BWT) implementation from BWA, it provides a memory-efficient method for mapping sequencing reads to a reference database. It serves as a core computational engine for the ProPhyle metagenomic classifier, enabling fast read assignment through the use of k-LCP (Longest Common Prefix) arrays to accelerate the search process.

## Core Workflows

### 1. Index Construction
To query sequences, you must first build a BWT-based index and a k-LCP array for a specific k-mer length.

*   **Basic Indexing**:
    `prophex index -k 25 reference.fa`
*   **Parallel Construction**: Use the `-s` flag to build the k-LCP and Suffix Array (SA) in parallel to save time.
    `prophex index -k 25 -s reference.fa`

### 2. Querying Reads
ProPhex matches k-mers from input reads against the constructed index.

*   **Standard Query**:
    `prophex query -k 25 index.fa reads.fq`
*   **Accelerated Query (Recommended)**: Use the `-u` flag to enable k-LCP-based searching, which significantly improves performance.
    `prophex query -k 25 -u -t 4 index.fa reads.fq`
*   **Detailed Output**: Use `-v` to see the specific set of chromosomes/contigs associated with every k-mer.
    `prophex query -k 25 -u -v index.fa reads.fq`

### 3. Index Maintenance and Conversion
*   **Standalone k-LCP Generation**: If you have an existing BWT index but need a different k-mer length k-LCP:
    `prophex klcp -k 31 index.fa`
*   **BWT to FASTA**: Reconstruct the original sequence from a BWT file:
    `prophex bwt2fa index.fa output.fa`

## Expert Tips and Best Practices

*   **Memory Optimization**: Before indexing, consider using tools like **ProphAsm** or **BCalm** to remove duplicate k-mers. This reduces the index size and memory footprint during querying.
*   **Thread Scaling**: The `-t` parameter in the `query` command scales well for multi-core systems. Always match this to your available CPU resources for large FASTQ files.
*   **Output Interpretation**: ProPhex uses an extended Kraken format. Column 5 is the most critical, providing a space-delimited list of k-mer blocks. A `0` indicates no match, while `A` indicates an ambiguous match.
*   **Contig Borders**: By default, ProPhex checks if a k-mer spans the border of two contigs. If you are working with continuous genomic data where this check is unnecessary, use `-p` to disable it and potentially show more k-mers in the output.
*   **Format Compatibility**: If using older downstream tools, `bwtdowngrade` can convert the `.bwt` file to a more compact legacy format by removing the Occurrence (Occ) table.



## Subcommands

| Command | Description |
|---------|-------------|
| prophex bwt2fa | Convert BWT index to FASTA format |
| prophex bwtdowngrade | Downgrades a BWT index to an older version. |
| prophex index | Constructs index for prophex |
| prophex klcp | Construct k-LCP array |
| prophex query | Query a prophex index |

## Reference documentation
- [ProPhex README](./references/github_com_prophyle_prophex_blob_master_README.md)
- [ProPhex GitHub Repository](./references/github_com_prophyle_prophex.md)