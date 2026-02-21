---
name: gsearch
description: `gsearch` is a high-performance tool designed for large-scale genomic comparisons.
homepage: https://github.com/jean-pierreBoth/gsearch
---

# gsearch

## Overview
`gsearch` is a high-performance tool designed for large-scale genomic comparisons. It leverages locality-sensitive hashing (LSH) and Hierarchical Navigable Small World (HNSW) graphs to provide near-instantaneous search results across tens of thousands of genomes. It is particularly effective for calculating Average Nucleotide Identity (ANI) or Average Amino Acid Identity (AAI) proxies at scale, transforming genomic sequences into compact "sketches" for efficient storage and retrieval.

## Core Workflows

### 1. Building a Database (`tohnsw`)
Use this command to initialize a searchable index from a directory of reference genomes (FASTA/multi-FASTA).

```bash
gsearch --pio 2000 --nbthreads 24 tohnsw -d ./ref_genomes -k 21 -s 18000 -n 128 --ef 1600 --algo optdens
```
- `-k`: K-mer size (e.g., 21 for species-level DNA, 15 for genus-level).
- `-s`: Sketch size (number of hashes). Larger values increase accuracy but also memory/disk usage.
- `--algo`: Use `optdens` (Optimal Densification) or `prob` (ProbMinHash) for best results.
- `--nbthreads`: Match this to your available CPU cores for maximum speed.

### 2. Searching Queries (`request`)
Compare query genomes against a pre-built HNSW index to find the closest relatives.

```bash
gsearch --pio 2000 --nbthreads 24 request -b ./database_dir -r ./query_genomes -n 50
```
- `-b`: The directory containing the `.hnsw` and metadata files.
- `-r`: Directory containing query FASTA files.
- `-n`: Number of nearest neighbors to return.

### 3. Updating an Index (`add`)
Add new genomes to an existing database without rebuilding the entire graph.

```bash
gsearch --pio 2000 --nbthreads 24 add -b ./database_dir -n ./new_genomes
```

## Expert Tips & Best Practices
- **Memory Management**: `gsearch` is optimized for speed and can be memory-intensive during graph construction. Use the `--pio` flag to control parallel I/O if you encounter disk bottlenecks.
- **Algorithm Selection**: 
    - Use `prob` (ProbMinHash) when k-mer multiplicity (abundance) is important.
    - Use `optdens` for standard Jaccard-based presence/absence comparisons.
    - Use `super2` if you need maximum speed with integer-type sketches.
- **ANI Estimation**: The tool uses the Jaccard index as a proxy for ANI. For DNA, a k-mer size of 21 is standard for resolving species-level differences.
- **Scaling**: For massive datasets (e.g., GTDB), ensure your `--ef` (entry factor) and `-n` (neighbors) parameters are balanced; higher `--ef` improves search accuracy but increases search time.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_jean-pierreBoth_gsearch.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_gsearch_overview.md)