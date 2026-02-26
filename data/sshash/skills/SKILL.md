---
name: sshash
description: sshash is a high-performance tool for building space-efficient associative dictionaries to store and query large sets of k-mers. Use when user asks to index genomic unitigs, perform fast sequence membership lookups, or extract k-mer frequency counts from a dataset.
homepage: https://github.com/jermp/sshash
---


# sshash

## Overview
sshash is a high-performance tool designed to store and query large sets of k-mers (DNA strings of length k) with extreme space efficiency. It utilizes Sparse and Skew Hashing to create a compressed, associative dictionary. This skill enables agents to index genomic unitigs, perform fast lookups to determine if specific sequences exist in a dataset, and extract frequency counts (weights) associated with those sequences. It is particularly useful for pangenome analysis and sequence search where memory footprint is a constraint.

## Installation and Setup
The tool can be installed via Bioconda or compiled from source for maximum performance.

- **Conda**: `conda install bioconda::sshash`
- **Source Build**:
  ```bash
  mkdir build && cd build
  cmake .. -D SSHASH_USE_ARCH_NATIVE=On
  make -j
  ```
- **K-mer Length**: By default, k is limited to 31. For k up to 63, compile with `-DSSHASH_USE_MAX_KMER_LENGTH_63=On`.

## Core CLI Workflows

### 1. Building an Index
To create a dictionary, you must provide a file of stitched unitigs. The value of `k` must match the value used to generate the unitigs.

- **Basic Build**:
  `./sshash build -i input.fa.gz -k 31 -m 13 -o index.sshash`
- **Weighted Build** (to store k-mer frequencies):
  `./sshash build -i input.fa.gz -k 31 -m 13 --weighted -o index.sshash`
- **Parameters**:
  - `-k`: K-mer length.
  - `-m`: Minimizer length (typically $m < k$).
  - `--check`: Validates the index integrity after construction.

### 2. Querying the Index
Once an index is built, you can perform various lookups.

- **Membership/Benchmark**:
  `./sshash bench -i index.sshash`
- **Streaming Queries**:
  Process a DNA file to check which k-mers are present in the dictionary.
  `./sshash query -i index.sshash -f query.fasta`
- **Navigational Queries**:
  Explore the neighborhood of a k-mer or string to find adjacent sequences in the graph.

## Expert Tips and Best Practices
- **Memory Management**: For large-scale indexing, increase the file descriptor limit using `ulimit -n 2048` before running the build command.
- **Nucleotide Encoding**: sshash uses a specific 2-bit encoding (A=00, C=01, G=11, T=10). If integrating with tools expecting traditional encoding (G=10, T=11), recompile with `-DSSHASH_USE_TRADITIONAL_NUCLEOTIDE_ENCODING=On`.
- **Reverse Complements**: The tool assumes a k-mer and its reverse complement are identical. You do not need to manually provide both orientations.
- **Input Preparation**: Use "stitched unitigs" as input. If starting from raw reads, k-mers must be assembled into unitigs first (e.g., using BCALM2 or UST) before indexing with sshash.
- **Thresholding**: For membership queries on long sequences, use the coverage threshold `E`. A sequence is considered "present" if at least $E \times (|S| - k + 1)$ of its k-mers are found.

## Reference documentation
- [sshash GitHub Repository](./references/github_com_jermp_sshash.md)
- [Bioconda sshash Overview](./references/anaconda_org_channels_bioconda_packages_sshash_overview.md)