---
name: kmertools
description: The kmertools skill transforms DNA sequences into numerical representations like k-mer frequencies, Chaos Game Representations, and coverage histograms for genomic analysis. Use when user asks to generate oligonucleotide frequencies, create 2D spatial embeddings, calculate sequence coverage, count k-mers, or perform minimizer binning.
homepage: https://github.com/anuradhawick/kmertools
---


# kmertools

## Overview

The `kmertools` skill provides a high-performance interface for transforming raw DNA sequences into numerical representations suitable for machine learning and comparative genomics. It bridges the gap between biological sequence data and vector-based analytics by offering optimized implementations of k-mer counting, sequence composition features, and coverage depth analysis. This skill is particularly useful for metagenomic binning, viral sequence embedding, and preparing genomic datasets for neural networks or clustering algorithms.

## Core CLI Patterns

### Sequence Composition (`comp`)
Use the `comp` subcommand to extract features based on the nucleotide makeup of sequences.

*   **Oligonucleotide Frequencies**: Generate frequency vectors for k-mers of a specific size.
    ```bash
    kmertools comp oligo -i input.fasta -o output.vec -k 4
    ```
*   **Chaos Game Representation (CGR)**: Generate 2D spatial embeddings of DNA sequences.
    *   **Full Sequence CGR**: `kmertools comp cgr -i input.fasta -o output.cgr`
    *   **K-mer based CGR**: `kmertools comp cgr -i input.fasta -o output.cgr -k 4`
    *   **Custom Matrix Size**: Use `-v <SIZE>` to set the output square matrix dimensions.

### Coverage Analysis (`cov`)
Generate coverage histograms from sequencing reads to estimate depth and abundance.
```bash
kmertools cov -i reads.fastq -o coverage.hist
```

### K-mer Counting (`ctr`)
Perform fast k-mer frequency counting across a dataset.
```bash
kmertools ctr -i input.fasta -o counts.txt -k 31
```

### Minimizer Binning (`min`)
Reduce data complexity by binning sequences based on minimizers (the lexicographically smallest k-mer in a window).
```bash
kmertools min -i input.fasta -o binned_output.txt -k 15 -w 10
```

## Expert Tips & Best Practices

*   **Thread Optimization**: Most subcommands support the `-t` or `--threads` flag. Setting this to `0` (the default) allows the tool to automatically detect and use all available CPU cores for parallel processing.
*   **CGR Normalization**: When using `comp cgr` in k-mer mode, the tool automatically normalizes counts by the total number of valid k-mers. To obtain raw counts instead, append the `-c` or `--counts` flag.
*   **Handling Invalid Bases**: In k-mer based modes, windows containing non-ACGT characters (like N, R, Y) are automatically ignored. However, for sequence-wide CGR computations, ensure your input FASTA contains only standard bases to avoid errors.
*   **K-size Selection**: For CGR, k-mer sizes between 3 and 7 are recommended. Note that the output vector size grows exponentially ($4^k$); using $k > 7$ may result in extremely large files and high memory consumption.
*   **Python Integration**: For downstream analysis (e.g., plotting with Matplotlib or training with Scikit-learn), use the `pykmertools` library to load the generated vectors directly into Python environments.



## Subcommands

| Command | Description |
|---------|-------------|
| comp | Generate sequence composition based features |
| kmertools min | Bin reads using minimisers |
| kmertools_cov | Generates coverage histogram based on the reads |
| kmertools_ctr | Count k-mers |

## Reference documentation

- [Home](./references/github_com_anuradhawick_kmertools_wiki.md)
- [CGR Computations](./references/github_com_anuradhawick_kmertools_wiki_CGR-computations.md)
- [Composition Computations](./references/github_com_anuradhawick_kmertools_wiki_Composition-computations.md)
- [Minimiser Computations](./references/github_com_anuradhawick_kmertools_wiki_Minimiser-computations.md)