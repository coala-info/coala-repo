---
name: unikmer
description: unikmer is a high-performance toolkit for nucleic acid k-mer manipulation that focuses on set operations and taxonomic analysis. Use when user asks to count k-mers, perform set operations like intersection or difference, map k-mers to a reference genome, or compute the lowest common ancestor for taxonomic classification.
homepage: https://github.com/shenwei356/unikmer
metadata:
  docker_image: "quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0"
---

# unikmer

## Overview

`unikmer` is a high-performance toolkit designed for nucleic acid k-mer manipulation with a focus on set theory and taxonomy. Unlike traditional k-mer counters that prioritize abundance, `unikmer` treats k-mers as sets (sketches), allowing for complex operations like finding the Lowest Common Ancestor (LCA) of k-mers shared across different taxa. It supports both encoded k-mers (up to k=32) and hashed k-mers (up to k=64) stored in a specialized binary `.unik` format.

## Core Workflows and CLI Patterns

### 1. Generating K-mer Sketches
To begin analysis, convert FASTA/Q sequences into `.unik` binary files.

*   **Basic Counting:**
    `unikmer count -k 23 -K input.fasta -o output_prefix`
    *   `-K, --canonical`: Highly recommended to ensure k-mers and their reverse complements are treated as the same entity.
    *   `-s, --sort`: Sorting k-mers during counting significantly reduces file size and accelerates downstream set operations.

*   **Generating Sketches (Minimizers/Syncmers):**
    For large genomes, use sketches to reduce the data footprint.
    `unikmer count -k 23 -W 5 -H input.fasta -o sketch_output`

### 2. Set Operations
`unikmer` is optimized for comparing multiple k-mer sets.

*   **Intersection (Finding Shared K-mers):**
    `unikmer inter sample1.unik sample2.unik sample3.unik -o shared_kmers`
    *Note: Most set operations require input files to be sorted.*

*   **Difference (Finding Unique K-mers):**
    To find k-mers present in `target.unik` but absent in `background.unik`:
    `unikmer diff target.unik background.unik -o unique_to_target`

*   **Union:**
    `unikmer union *.unik -o combined_set`

### 3. Searching and Mapping
Once you have a set of k-mers of interest (e.g., unique k-mers), you can map them back to a reference genome.

*   **Locating Positions:**
    `unikmer locate -g reference.fasta query.unik`
    Outputs a BED6 formatted file showing the exact coordinates of k-mer matches.

*   **Extracting Regions:**
    `unikmer map -g reference.fasta query.unik -a`
    Maps k-mers and merges successive matches into longer subsequences/regions.

## Taxonomic Analysis

`unikmer` can integrate NCBI taxonomy data to compute the LCA for k-mer sets.

*   **Setup:** Set the `UNIKMER_DB` environment variable to the directory containing NCBI `nodes.dmp` and `names.dmp`.
*   **Assigning TaxIds during counting:**
    `unikmer count -k 23 -t 511145 input.fasta -o output`
*   **Filtering by Rank:**
    Remove k-mers that belong to specific taxonomic ranks (e.g., keeping only genus-level k-mers).
    `unikmer rfilter -L genus input.unik -o filtered.unik`

## Expert Tips and Best Practices

*   **File Compression:** Use the global `-c, --compact` flag to generate smaller binary files without significant speed loss.
*   **Memory Management:** When dealing with massive k-mer sets, use `unikmer sort -m [chunk-size]` to perform external sorting with limited RAM.
*   **Hashed vs. Encoded:** Use encoded k-mers for $k \le 32$ for maximum performance. For $k > 32$, `unikmer` automatically switches to hashing (ntHash), which is required for longer sequences.
*   **Quick Inspection:** Use `unikmer info` to check the k-mer length, canonical flag, and taxonomic information of a `.unik` file without reading the entire dataset.



## Subcommands

| Command | Description |
|---------|-------------|
| unikmer autocompletion | Generate shell autocompletion script |
| unikmer count | Generate k-mers (sketch) from FASTA/Q sequences |
| unikmer diff | Set difference of k-mers in multiple binary files |
| unikmer dump | Convert plain k-mer text to binary format |
| unikmer filter | Filter out low-complexity k-mers (experimental) |
| unikmer locate | Locate k-mers in genome |
| unikmer map | Mapping k-mers back to the genome and extract successive regions/subsequences |
| unikmer merge | Merge k-mers from sorted chunk files |
| unikmer rfilter | Filter k-mers by taxonomic rank |
| unikmer sort | Sort k-mers to reduce the file size and accelerate downstream analysis |
| unikmer split | Split k-mers into sorted chunk files |
| unikmer tsplit | Split k-mers according to taxid |
| unikmer_common | Find k-mers shared by most of the binary files |
| unikmer_concat | Concatenate multiple binary files without removing duplicates |
| unikmer_decode | Decode encoded integer to k-mer text |
| unikmer_encode | Encode plain k-mer texts to integers |
| unikmer_grep | Search k-mers from binary files |
| unikmer_head | Extract the first N k-mers |
| unikmer_info | Information of binary files |
| unikmer_inter | Intersection of k-mers in multiple binary files |
| unikmer_num | Quickly inspect the number of k-mers in binary files |
| unikmer_sample | Sample k-mers from binary files. |
| unikmer_union | Union of k-mers in multiple binary files |
| unikmer_view | Read and output binary format to plain text |

## Reference documentation

- [unikmer Home and Overview](./references/bioinf_shenwei_me_unikmer.md)
- [Detailed Command Usages](./references/bioinf_shenwei_me_unikmer_usage.md)
- [Quick Start and Examples](./references/github_com_shenwei356_unikmer_blob_master_README.md)