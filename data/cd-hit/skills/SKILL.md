---
name: cd-hit
description: CD-HIT is a high-performance suite used to cluster biological sequences and remove redundancy based on user-defined similarity thresholds. Use when user asks to cluster protein or nucleotide sequences, collapse redundant datasets, compare two sequence databases, or identify duplicates in sequencing reads.
homepage: https://github.com/weizhongli/cdhit
---


# cd-hit

## Overview
CD-HIT (Cluster Database at High Identity with Tolerance) is a high-performance sequence clustering suite. It groups biological sequences into clusters based on user-defined similarity thresholds, selecting a single representative sequence for each group. This is primarily used to "collapse" redundant datasets, making downstream analyses (like multiple sequence alignment or phylogenetic tree construction) computationally feasible. The suite includes specialized tools for proteins, nucleotides, and specific sequencing technologies like Illumina or 454.

## Core Programs
- **cd-hit**: Clusters protein (peptide) sequences.
- **cd-hit-est**: Clusters nucleotide (DNA/RNA) sequences.
- **cd-hit-2d**: Compares a protein query dataset against a protein reference dataset.
- **cd-hit-est-2d**: Compares a nucleotide query dataset against a nucleotide reference dataset.
- **psi-cd-hit**: Designed for clustering proteins at low identity thresholds (typically <40%).
- **cd-hit-dup**: Specifically identifies duplicates in Illumina single or paired-end reads.
- **cd-hit-otu**: Specialized for clustering rRNA tags into Operational Taxonomic Units.

## Common CLI Patterns

### Basic Protein Clustering
To cluster a protein FASTA file at 90% identity:
`cd-hit -i input.faa -o output_90.faa -c 0.9 -n 5`

### Basic Nucleotide Clustering
To cluster DNA sequences at 95% identity:
`cd-hit-est -i input.fna -o output_95.fna -c 0.95 -n 10`

### Comparing Two Datasets
To find sequences in `db2` that are similar to `db1` (at 90% identity):
`cd-hit-2d -i db1.faa -i2 db2.faa -o comparison_results -c 0.9 -n 5`

## Expert Tips and Best Practices

### 1. Selecting the Correct Word Size (-n)
The word size parameter `-n` is critical for performance and must be adjusted based on the identity threshold `-c`. If `-n` is too large, the tool will fail to find clusters; if too small, it becomes slow.
- **For cd-hit (Protein):**
  - `-c 0.7 - 1.0`: `-n 5`
  - `-c 0.6 - 0.7`: `-n 4`
  - `-c 0.5 - 0.6`: `-n 3`
  - `-c 0.4 - 0.5`: `-n 2`
- **For cd-hit-est (Nucleotide):**
  - `-c 0.95 - 1.0`: `-n 10` (or 11)
  - `-c 0.90 - 0.95`: `-n 8` (or 9)
  - `-c 0.88 - 0.90`: `-n 6` (or 7)
  - `-c 0.85 - 0.88`: `-n 5`
  - `-c 0.80 - 0.85`: `-n 4`

### 2. Memory and Threading
CD-HIT is highly optimized for multi-core systems. Always specify threads and memory limits for large datasets:
- `-T <number>`: Number of threads (0 for all available cores).
- `-M <number>`: Memory limit in MB (e.g., `-M 16000` for 16GB). Use `0` for unlimited, but be cautious on shared systems.

### 3. Handling Sequence Descriptions
By default, CD-HIT truncates sequence headers at the first space. To keep the full description in the `.clstr` file, use:
`-d 0`

### 4. Hierarchical Clustering
For very low identity thresholds (e.g., 30%), a single run is inefficient. Use a hierarchical approach:
1. Cluster at 90% identity.
2. Use the 90% representatives to cluster at 60%.
3. Use the 60% representatives to cluster at 30%.
This is often implemented via the `h-cd-hit` script or manual sequential runs.

### 5. Output Files
Every run produces two main files:
- **The FASTA file**: Contains the representative sequences for each cluster.
- **The .clstr file**: A text file mapping every input sequence to its assigned cluster. Use the provided Perl scripts (e.g., `clstr2txt.pl`) to parse this into more readable formats.

## Reference documentation
- [Home · weizhongli/cdhit Wiki](./references/github_com_weizhongli_cdhit_wiki.md)
- [weizhongli/cdhit GitHub Repository](./references/github_com_weizhongli_cdhit.md)