---
name: dashing
description: Dashing rapidly estimates similarities between genomic datasets using the HyperLogLog algorithm to create compact probabilistic sketches. Use when user asks to calculate pairwise distances, estimate Jaccard similarity or containment indices, pre-compute genomic sketches, or build distance matrices for large-scale metagenomic analysis.
homepage: https://github.com/dnbaker/dashing
---


# dashing

## Overview
Dashing is a high-performance tool designed for the rapid estimation of similarities between genomic datasets. By utilizing the HyperLogLog (HLL) algorithm, it creates compact probabilistic sketches of sequences, enabling massive pairwise comparisons with significantly lower memory and time requirements than exact k-mer counting methods. It is particularly effective for large-scale metagenomic analysis and building distance matrices for phylogenomic workflows.

## Core CLI Patterns

### Calculating Pairwise Distances
The `dist` command is the primary interface for comparing genomes.
```bash
# Basic Jaccard distance with k=31 and 12 threads
dashing dist -k31 -p12 -O distance_matrix.txt genome1.fna genome2.fna.gz
```

### Handling Large Datasets
To avoid shell argument limits, use a file containing paths to your genomes (one per line).
```bash
dashing dist -k31 -p16 -F genome_list.txt -O output_matrix.txt
```

### Containment and Asymmetric Analysis
Use the `-Q` (query) and `-F` (reference) flags to perform asymmetric comparisons, such as checking if a small sequence is contained within a larger database.
```bash
dashing dist --containment-index -k21 -Q queries.txt -F references.txt -O containment_results.txt
```

### Sketching and Caching
You can pre-compute sketches to speed up future comparisons.
```bash
# Create sketches only
dashing sketch -k31 -p8 -F genome_list.txt

# Use -c to cache sketches during a distance calculation
dashing dist -k31 -c -F genome_list.txt -O matrix.txt
```

## Advanced Features and Optimization

### Similarity Measures
Dashing supports multiple metrics via flags:
- `--jaccard`: Jaccard Similarity (default)
- `--mash`: Mash distance
- `--containment-index`: Containment index
- `--intersection`: Intersection size
- `--symmetric-containment`: Symmetric Containment Index

### Filtering Sequencing Noise
When working with raw sequencing reads (FASTQ) rather than assemblies, use the Count-Min Sketch filter to ignore rare k-mers likely caused by sequencing errors.
```bash
dashing dist -y --min-count 2 -k31 genome1.fastq genome2.fastq
```

### Data Structures
While HLL is the default, you can trade speed for accuracy using alternative structures:
- `--use-bb-minhash`: b-bit minhashing
- `--use-range-minhash`: bottom-k minhashing
- `--use-full-khash-sets`: Exact hash sets (highest accuracy, highest memory)
- `--use-bloom-filter`: Bloom filter Jaccard index

## Expert Tips
- **Binary Selection**: If using manual binary releases, choose the version matching your CPU instructions for maximum speed: `dashing_s512` (AVX512), `dashing_s256` (AVX2), or `dashing_s128` (SSE2).
- **K-mer Limits**: Exact k-mer encoding is supported for $k \le 32$. For $k > 32$, Dashing automatically switches to rolling hashing.
- **Memory Locality**: Use `--nperbatch` to control the number of sketches processed at once, which can improve cache locality and double computation speed on some systems.
- **Output Formats**: Use `-p` for PHYLIP format or binary output for downstream compatibility with phylogenetic software.

## Reference documentation
- [Dashing GitHub Repository](./references/github_com_dnbaker_dashing.md)
- [Bioconda Dashing Overview](./references/anaconda_org_channels_bioconda_packages_dashing_overview.md)