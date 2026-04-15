---
name: bloomfiltertrie
description: The Bloom Filter Trie is a succinct data structure used for indexing pan-genomes and representing colored de Bruijn graphs. Use when user asks to build a k-mer index from multiple genomes, query sequence presence across a population, or extract k-mers from an existing index.
homepage: https://github.com/GuillaumeHolley/BloomFilterTrie
metadata:
  docker_image: "quay.io/biocontainers/bloomfiltertrie:0.8.7--h779adbc_2"
---

# bloomfiltertrie

## Overview

The Bloom Filter Trie (BFT) is a succinct data structure designed for pan-genome indexing. It represents a colored de Bruijn graph, where "colors" correspond to the specific genomes or samples containing a particular k-mer. This tool is particularly effective for large-scale comparative genomics tasks where you need to determine the distribution of k-mers across a population without performing traditional sequence alignment. While the library is currently unmaintained, it remains a functional choice for incremental indexing and efficient k-mer set operations.

## Installation

The most reliable way to install the tool is via Bioconda:

```bash
conda install bioconda::bloomfiltertrie
```

## Core CLI Usage

The `bft` binary supports two primary modes: `build` for creating new indexes and `load` for querying or updating existing ones.

### Building an Index
To create a new BFT index from a set of genome files:

```bash
bft build <k_length> <input_type> <list_file> <output_file>
```

*   **k_length**: The length of the k-mers (e.g., 31).
*   **input_type**: Use `kmers` for standard k-mer files or `kmers_comp` for compressed formats.
*   **list_file**: A text file containing the paths to your genome/k-mer files, with one path per line.
*   **output_file**: The filename for the resulting BFT index.

### Querying Sequences
To check if sequences exist within the indexed genomes:

```bash
bft load <index_file> -query_sequences <threshold> <mode> <query_list>
```

*   **threshold**: A float (0.0 to 1.0) representing the percentage of k-mers in a query sequence that must be present to report a match.
*   **mode**: Use `canonical` to search the lexicographically smaller of a k-mer and its reverse-complement; use `non_canonical` for exact matches only.
*   **query_list**: A file containing paths to the sequences you wish to query.

### Querying K-mers
To perform a direct k-mer presence check:

```bash
bft load <index_file> -query_kmers <input_type> <kmer_list>
```

The output is a CSV file where columns represent genomes in the BFT and rows represent the queried k-mers, with binary values indicating presence.

### Extracting Data
To retrieve all k-mers stored within an existing index:

```bash
bft load <index_file> -extract_kmers <input_type> <output_kmers_file>
```

## Expert Tips and Best Practices

*   **Input Preparation**: Ensure your `list_genome_files` contains absolute paths or paths relative to the execution directory to avoid loading errors.
*   **Memory Management**: BFT relies on Judy Arrays and Jemalloc. If compiling from source on Linux, ensure `libjudy-dev` and `libjemalloc-dev` are installed to prevent compilation failures.
*   **Canonical Searching**: In most biological contexts, use the `canonical` flag during queries to account for the double-stranded nature of DNA.
*   **Incremental Updates**: You can add new genomes to an existing index without rebuilding from scratch using the `-add_genomes` option within the `load` command.
*   **Maintenance Note**: The author recommends **Bifrost** as a modern, maintained alternative for dynamic de Bruijn graph applications if BFT does not meet specific performance or compatibility requirements.

## Reference documentation

- [BloomFilterTrie Overview](./references/anaconda_org_channels_bioconda_packages_bloomfiltertrie_overview.md)
- [BloomFilterTrie GitHub Repository](./references/github_com_GuillaumeHolley_BloomFilterTrie.md)