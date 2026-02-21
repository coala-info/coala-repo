---
name: prophasm
description: ProPhasm (ProPhyle Assembler) is a specialized tool for k-mer set compression.
homepage: https://github.com/prophyle/prophasm
---

# prophasm

## Overview

ProPhasm (ProPhyle Assembler) is a specialized tool for k-mer set compression. It transforms k-mer sets into "simplitigs"—strings representing disjoint paths in a bidirectional de Bruijn graph. Simplitigs are more efficient than standard unitigs, offering a smaller cumulative length and fewer sequences without losing any k-mer information. Beyond assembly, ProPhasm provides high-performance k-mer set operations, allowing users to calculate intersections and differences between multiple sequencing datasets.

## Installation

The most reliable way to install ProPhasm is via Bioconda:

```bash
conda install bioconda::prophasm
```

Alternatively, it can be built from source using `make`.

## Core Usage Patterns

### 1. Basic Simplitig Assembly
To re-assemble a FASTA file into a more compressed simplitig representation:

```bash
prophasm -k <kmer_size> -i input.fa -o simplitigs.fa
```
*   **-k**: Specifies the k-mer size (e.g., 15, 21, 31).
*   **-i**: Input FASTA file.
*   **-o**: Output FASTA file containing the simplitigs.

### 2. K-mer Set Intersection
To find k-mers common to two or more datasets:

```bash
prophasm -k 31 -i sample1.fa -i sample2.fa -x intersection.fa
```
*   **-x**: Computes the intersection of all provided input files and saves it to the specified file.

### 3. Set Difference (Subtraction)
To identify k-mers unique to each dataset by subtracting the intersection:

```bash
prophasm -k 31 -i sample1.fa -i sample2.fa -x intersection.fa -o unique1.fa -o unique2.fa
```
*   When `-o` is used alongside `-x`, ProPhasm saves the intersection to the `-x` file and the remaining unique k-mers (the set difference) to the respective `-o` files.
*   **Note**: You must provide exactly as many `-o` flags as there are `-i` flags.

### 4. Generating Statistics
To output k-mer counts and statistics for the processed sets:

```bash
prophasm -k 31 -i input.fa -s stats.tsv
```
*   **-s**: Saves k-mer statistics to a TSV file.

## Expert Tips and Best Practices

*   **K-mer Size Selection**: Ensure the `-k` value is appropriate for your organism and data type. Smaller k-mers increase sensitivity but may lead to more complex graphs, while larger k-mers increase specificity.
*   **Standard I/O**: ProPhasm supports `-` as a filename to read from standard input or write to standard output, facilitating integration into command-line pipes.
*   **Memory Efficiency**: ProPhasm is designed for rapid computation directly from k-mer sets. Unlike some competitors (e.g., UST), it does not require pre-computed unitigs, making the workflow less resource-intensive.
*   **Silent Mode**: Use the `-S` flag in automated scripts to suppress progress messages and only output critical information.
*   **Set Unions**: ProPhasm does not have a specific flag for set unions because k-mer set unions can be achieved simply by concatenating the source FASTA files before processing them with ProPhasm.

## Reference documentation

- [ProPhasm GitHub README](./references/github_com_prophyle_prophasm.md)
- [Bioconda ProPhasm Overview](./references/anaconda_org_channels_bioconda_packages_prophasm_overview.md)