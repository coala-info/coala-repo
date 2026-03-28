---
name: dashing
description: Dashing is a high-performance tool that uses HyperLogLog sketches to estimate genomic distances and sequence similarities. Use when user asks to calculate Jaccard similarity, estimate Mash distances, determine containment indices, or perform fast k-mer based comparisons across large genomic datasets.
homepage: https://github.com/dnbaker/dashing
---


# dashing

## Overview
Dashing is a high-performance tool designed for genomic distance estimation. It utilizes HyperLogLog (HLL) sketches to represent sequence data, allowing for extremely fast comparisons of massive datasets with low memory overhead. It is particularly useful for calculating Jaccard similarity, Mash distance, and containment indices across thousands of genomes or raw sequencing reads.

## Core Workflows

### Distance Calculation
The `dist` command is the primary entry point for comparing sequences.

- **Basic Pairwise Comparison**:
  `dashing dist -k31 -p13 -Omatrix.txt genome1.fna genome2.fna`
- **Using a File List**: To avoid shell argument limits, provide a text file containing one path per line.
  `dashing dist -k31 -F genome_paths.txt -O distance_matrix.txt`
- **Caching Sketches**: Use `-c` to save sketches to disk, speeding up future comparisons.
  `dashing dist -k31 -c -F genome_paths.txt`

### Containment and Asymmetric Comparison
Use asymmetric mode to determine how much of a query sequence is contained within a reference.

- **Containment Index**:
  `dashing dist --containment-index -k21 -Q queries.txt -F references.txt -O containment_mat.txt`
- **Symmetric Containment**: Useful when genome sizes differ significantly.
  `dashing dist --symmetric-containment -k21 -F genome_paths.txt`

### Sketching and Set Operations
- **Pre-sketching**: Generate sketches without performing comparisons.
  `dashing sketch -k31 -p8 -F genome_paths.txt`
- **Union of Sketches**: Merge existing HLL sketches (must be the same size).
  `dashing union sketch1.hll sketch2.hll -o merged.hll`
- **Cardinality Estimation**: Estimate unique k-mers in a file.
  `dashing hll -k31 sequence.fastq`

## Expert Tips and Best Practices

### Performance Optimization
- **SIMD Selection**: Use the specific binary optimized for your CPU architecture for significant speedups:
  - `dashing_s512`: AVX512BW
  - `dashing_s256`: AVX2
  - `dashing_s128`: SSE2
- **Threading**: Always specify threads with `-p` to match your hardware capabilities.

### Handling Raw Sequencing Data
- **Filtering Noise**: When working with raw reads (FASTQ), use the Count-Min Sketch filter to ignore rare k-mers (likely sequencing errors).
  `dashing dist -y --min-count 2 -k31 -F reads_list.txt`
- **Compressed Inputs**: Dashing natively handles `.gz` (zlib) and zstd-compressed files; there is no need to decompress them manually.

### Parameter Selection
- **K-mer Size (`-k`)**: 
  - Use `k=21` or `k=31` for most bacterial/viral applications.
  - For `k <= 32`, Dashing uses exact k-mer encoding.
  - For `k > 32`, it defaults to rolling hashing.
- **Output Formats**:
  - Default: Upper triangular TSV.
  - PHYLIP: Use for downstream phylogenetic software.
  - Top-K: Use `--nearest-neighbors <N>` to output only the closest matches for each query.



## Subcommands

| Command | Description |
|---------|-------------|
| dashing | Dashing version: v1.0 |
| sketch | Sketching genomes with sketch: 0/HLL/HyperLogLog |

## Reference documentation
- [Dashing README](./references/github_com_dnbaker_dashing_blob_main_README.md)
- [Dashing Makefile and Build Info](./references/github_com_dnbaker_dashing_blob_main_Makefile.md)