---
name: smafa
description: "smafa is a tool for efficiently indexing, querying, and clustering biological sequences of identical length. Use when user asks to create a searchable sequence database, query sequences against a reference, or cluster sequences into representative centroids."
homepage: https://github.com/wwood/smafa
---


# smafa

## Overview

smafa (Small Aligner for Aligned sequences) is a specialized tool written in Rust that provides efficient mechanisms for handling biological sequences that have already been aligned. Its primary constraint and strength is that it operates on sequences of identical length. This allows for significantly faster processing compared to general-purpose aligners. The tool is primarily used to create searchable databases from sequence sets, query those databases for matches, or cluster sequences into representative centroids.

## Installation

The tool is available via Bioconda or Cargo:

```bash
# Using Conda
conda install -c bioconda smafa

# Using Cargo
cargo install smafa
```

## Core Workflows

### 1. Database Creation and Querying
For searching a set of sequences against a reference, you must first index the reference sequences.

```bash
# Create a database from a FASTA file
smafa makedb reference_sequences.fasta output_db_name

# Query the database with new sequences
smafa query output_db_name query_sequences.fasta
```

### 2. Sequence Clustering
Use the cluster mode to group similar sequences and identify centroids.

```bash
# Cluster sequences in a FASTA file
smafa cluster input_sequences.fasta > clusters.tsv
```

## CLI Best Practices and Tips

- **Sequence Length Consistency**: Ensure all sequences in your input FASTA files are the same length. smafa will throw an error if it encounters sequences of varying lengths.
- **DNA Encoding**: The tool supports standard DNA nucleotides and handles lowercase symbols. It also supports degenerate base notation (e.g., R, Y, S, W, K, M, B, D, H, V, N).
- **Managing Output**: When running large queries, use the `--limit-per-sequence` flag to restrict the number of hits returned for each query sequence, preventing excessively large output files.
- **Help Documentation**: Detailed options for each subcommand can be accessed using the help flag:
  - `smafa makedb --help`
  - `smafa query --help`
  - `smafa cluster --help`

## Reference documentation
- [smafa Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_smafa_overview.md)
- [smafa GitHub Repository](./references/github_com_wwood_smafa.md)