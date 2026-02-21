---
name: geco2
description: GeCo2 (Genomic Compression 2) is a specialized tool designed for the lossless compression and information-theoretic analysis of DNA sequences.
homepage: https://github.com/cobilab/geco2
---

# geco2

## Overview
GeCo2 (Genomic Compression 2) is a specialized tool designed for the lossless compression and information-theoretic analysis of DNA sequences. Unlike general-purpose compressors, GeCo2 is optimized for the four-letter alphabet of genomics, providing superior compression ratios. It functions both as a storage tool and an analysis tool, capable of determining absolute measures of information content and local measures to identify genomic patterns. It supports various workflows, including reference-free compression and referential compression (using a known sequence to compress a target sequence).

## Installation
The most reliable way to install GeCo2 is via Bioconda:
```bash
conda install bioconda::geco2
```

## Common CLI Patterns

### Basic Compression
To compress a DNA sequence file using a standard compression level:
```bash
GeCo2 -v -l 5 input_file.seq
```
*   `-v`: Verbose mode (provides progress and statistics).
*   `-l [1-15]`: Compression level. Level 1 is fastest; level 15 provides maximum compression but is computationally intensive.

### Exploring Compression Levels
GeCo2 provides pre-computed modes. To see the characteristics of the available levels:
```bash
GeCo2 -s
```

### Referential Compression
To compress a sequence using another sequence as a reference (useful for resequencing data or closely related species):
```bash
GeCo2 -v -l 7 -r reference_file.seq target_file.seq
```

### Getting Help
To view all available parameters and model settings:
```bash
GeCo2 -h
```

## Expert Tips and Best Practices
*   **Level Selection**: Level 5 is generally considered the "lazy" or balanced level for standard tasks. For large-scale archival where storage cost is the primary concern, use levels 11-15.
*   **Memory Management**: Version 2 introduced specific cache-hash sizes. If running on memory-constrained systems, monitor the process as higher levels and complex models increase RAM usage.
*   **Inverted Repeats**: For sequences known to contain significant inverted repeats, ensure you are using a mode that enables inverted repeat modeling to maximize compression gains.
*   **Analysis Output**: Use GeCo2's ability to quantify information content per element to locate genomic regions with high or low complexity, which often correspond to specific biological features or repetitive elements.

## Reference documentation
- [geco2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_geco2_overview.md)
- [GitHub - cobilab/geco2: An improved compression tool for DNA sequences](./references/github_com_cobilab_geco2.md)