---
name: kmertools
description: kmertools transforms raw DNA sequences into numerical vectors for machine learning and genomic analysis. Use when user asks to vectorize metagenomic datasets, generate sequence composition features, create coverage histograms, or bin reads using minimizers.
homepage: https://github.com/anuradhawick/kmertools
---


# kmertools

## Overview
kmertools is a high-performance utility designed to transform raw DNA sequences into numerical vectors, a process essential for applying machine learning and advanced analytics to genomic data. It bridges the gap between bioinformatics and AI/ML by providing efficient implementations of k-mer analysis, sequence composition metrics, and binning strategies. Use this skill to vectorize metagenomic datasets, analyze sequencing depth through coverage histograms, or reduce data complexity using minimizers.

## Core CLI Commands
The tool is structured around several subcommands for specific vectorization tasks:

- **Sequence Composition (`comp`)**: Generates frequency vectors for oligonucleotides. This is the primary command for creating feature sets for sequence classification or clustering.
- **Coverage Histograms (`cov`)**: Generates coverage-based features from sequencing reads. Useful for identifying species abundance and binning long-read metagenomic data.
- **Minimiser Binning (`min`)**: Bins reads using minimizers to reduce the computational overhead of comparing large biological sequences.
- **K-mer Counting (`ctr`)**: Performs standard k-mer frequency counting across input sequences.
- **Chaos Game Representation (CGR)**: Computes CGR vectors, providing a spatial representation of gene structure based on k-mer transformations.

## Common Usage Patterns

### Generating Sequence Features
To extract composition-based features for downstream ML models:
```bash
kmertools comp [OPTIONS] <INPUT_FASTA>
```

### Metagenomic Binning Support
To generate coverage histograms for long-read binning (based on the Metabcc-lr algorithm):
```bash
kmertools cov [OPTIONS] <INPUT_READS>
```

### Reducing Sequence Complexity
To bin reads efficiently using minimizers:
```bash
kmertools min [OPTIONS] <INPUT_FASTA>
```

## Python Integration
For users working in Jupyter notebooks or Python scripts, the functionality is available via `pykmertools`.

- **Installation**: `pip install pykmertools`
- **Usage**:
  ```python
  import pykmertools as kt
  # Access vectorization functions directly within Python pipelines
  ```

## Expert Tips
- **Vectorization for ML**: When preparing data for neural networks, use the `comp` command to generate fixed-length oligonucleotide frequency vectors, which can be directly fed into standard input layers.
- **Performance**: kmertools is written in Rust; for massive datasets, ensure you are using the multi-threaded capabilities if available in the specific subcommand options.
- **CGR for Visualization**: Use Chaos Game Representation when you need to capture the global patterns of a sequence in a way that preserves local k-mer information in a 2D-like vector space.

## Reference documentation
- [kmertools Overview](./references/github_com_anuradhawick_kmertools.md)
- [kmertools Wiki and Command Reference](./references/github_com_anuradhawick_kmertools_wiki.md)