---
name: skc
description: skc (Shared K-mer Content) is a specialized bioinformatics tool used to find exact k-mer matches between two genomes.
homepage: https://github.com/mbhall88/skc
---

# skc

## Overview

skc (Shared K-mer Content) is a specialized bioinformatics tool used to find exact k-mer matches between two genomes. It works by loading all unique k-mers from a target genome into memory and then scanning a query genome for matches. The tool provides detailed output including the k-mer sequence, its frequency in both genomes, and its specific 1-based genomic coordinates. It is designed for simplicity and speed when working with k-mer sizes up to 32.

## Installation

The tool can be installed via Conda or by downloading the prebuilt binary:

```bash
# Via Conda
conda install bioconda::skc

# Via Shell Script
curl -sSL skc.mbh.sh | sh
```

## Common CLI Patterns

### Basic Comparison
To find shared 21-mers (default) between two FASTA files:
```bash
skc target.fa query.fa
```

### Custom K-mer Size
To search for shorter or longer shared sequences (up to a maximum of 32):
```bash
skc -k 16 target.fa query.fa
```

### Saving Compressed Results
skc automatically detects compression from the file extension. To save results to a gzipped file:
```bash
skc -o shared_kmers.fa.gz target.fa query.fa
```

## Expert Tips and Best Practices

### Memory Optimization
**Critical:** Always pass the smaller genome as the `<TARGET>` (the first positional argument). 
skc loads all unique k-mers from the target genome into a hash table in memory. Using the smaller genome as the target significantly reduces the memory footprint of the analysis.

### Input Flexibility
The tool natively supports compressed input files. You do not need to decompress your genomes before running the tool; it handles `.gz`, `.bz2`, `.xz`, and `.zst` automatically.

### Understanding the Output
The output is formatted as a FASTA-like file where the header contains metadata:
- **ID**: A 64-bit integer representing the k-mer in bit-space.
- **tcount/qcount**: The number of occurrences in the target and query genomes.
- **tpos/qpos**: 1-based starting positions. Multiple positions are comma-separated.

### Technical Constraints
- **Max K-mer Size**: The maximum supported k-mer size is 32.
- **Non-canonical K-mers**: skc does not use canonical k-mers. It treats the forward strand as provided. If you need to check both strands, ensure your input files account for reverse complements or use a pre-processing tool.

## Reference documentation
- [skc GitHub README](./references/github_com_mbhall88_skc.md)
- [skc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_skc_overview.md)