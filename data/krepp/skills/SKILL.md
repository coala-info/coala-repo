---
name: krepp
description: krepp analyzes sequencing reads using k-mer frequencies and maximum likelihood models to estimate evolutionary distances and perform phylogenetic placement. Use when user asks to index reference genomes, estimate distances between reads and references, perform phylogenetic placement, or sketch and seek sequences.
homepage: https://github.com/bo1929/krepp
---

# krepp

## Overview
krepp is a specialized bioinformatics tool that utilizes k-mer frequencies and maximum likelihood models to analyze the relationship between sequencing reads and reference genomes. You should use this skill to guide the creation of reference indices, estimate evolutionary distances, or perform rapid phylogenetic placement of metagenomic or genomic reads without the need for full sequence alignment. It is particularly effective for high-throughput taxonomic assignment and evolutionary analysis of short-read data.

## Core Workflows

### 1. Indexing Reference Genomes
Before querying, you must build an index from a set of reference genomes and, optionally, a phylogenetic tree.

```bash
# Basic indexing command
krepp index -k 27 -w 35 -h 11 -o <index_prefix> -i <input_map.tsv> -t <tree.nwk> --num-threads 8
```
*   **-k**: K-mer size (e.g., 27).
*   **-w**: Window size for minimizers (e.g., 35).
*   **-h**: Hash size (e.g., 11).
*   **-i**: A TSV file mapping genome IDs to their fasta file paths.
*   **-t**: A Newick format tree file for phylogenetic placement.

### 2. Estimating Distances
Use the `dist` command to calculate the maximum likelihood distance between query reads and the indexed references.

```bash
krepp dist -i <index_prefix> -q <query.fq> --num-threads 4 > distances.tsv
```
*   **Output**: A TSV containing `SEQ_ID`, `REFERENCE_NAME`, and `DIST`.

### 3. Phylogenetic Placement
Use the `place` command to determine the most likely position of reads on the reference tree.

```bash
# Standard jplace output (JSON)
krepp place -i <index_prefix> -q <query.fq> --num-threads 8 > placements.jplace

# Tabular output for easier parsing
krepp place -i <index_prefix> -q <query.fq> --tabular --num-threads 8 > placements.tsv
```
*   **jplace**: Compatible with downstream tools like `gappa` for visualization (e.g., heat trees).
*   **--tabular**: Provides a flat file with `SEQ_ID`, `DISTAL_NODE`, `EDGE_NUM`, `LWR` (Likelihood Weight Ratio), and `DIST`.

### 4. Simple Sketching and Seeking
For quick comparisons against a single reference without a full index:

```bash
# Create a sketch of a reference
krepp sketch <reference.fa> -o <ref_sketch>

# Query against the sketch
krepp seek -i <ref_sketch> -q <query.fq>
```

## Expert Tips and Best Practices
*   **Thread Optimization**: Always specify `--num-threads` to match your environment, as k-mer counting and likelihood calculations are highly parallelizable.
*   **Memory Management**: Indexing large datasets (e.g., GTDB) requires significant RAM. For toy examples or small batches, memory usage is typically <1.5GB.
*   **Handling Ns**: krepp automatically ignores 'N' characters in query sequences to maintain accuracy.
*   **Downstream Analysis**: If using `place`, use the `.jplace` output to generate visualizations with `gappa examine heat-tree`.
*   **Prebuilt Indices**: Check the official documentation for available prebuilt microbial indices to save time on the indexing stage.



## Subcommands

| Command | Description |
|---------|-------------|
| krepp dist | Estimate distances of queries to genomes in an index. |
| krepp index | Build an index from k-mers of reference genomes. |
| krepp inspect | Display statistics and information for a given index. |
| krepp place | Place queries on a tree with respect to an index. |
| krepp seek | Seek query sequences in a sketch and estimate distances. |
| krepp sketch | Create a sketch from k-mers in a single FASTA/FASTQ file. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_bo1929_krepp.md)
- [A toy example for testing](./references/github_com_bo1929_krepp_wiki_A-toy-example-for-testing.md)
- [Estimating distances](./references/github_com_bo1929_krepp_wiki_Estimating-distances.md)
- [Placing on a tree](./references/github_com_bo1929_krepp_wiki_Placing-on-a-tree.md)
- [Indexing reference genomes](./references/github_com_bo1929_krepp_wiki_Indexing-reference-genomes.md)