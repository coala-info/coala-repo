---
name: kmerinshort
description: KmerInShort is a high-performance utility for counting k-mers with a length strictly less than 15 and calculating sequence complexity. Use when user asks to count short k-mers, calculate Normalized Shannon Entropy, generate k-mer profiles, or analyze sequence composition in genomic data.
homepage: https://github.com/rizkg/KmerInShort
---


# kmerinshort

## Overview
KmerInShort is a high-performance utility for counting k-mers with a length strictly less than 15. Built on the GATB core library, it provides a fast and memory-efficient way to analyze sequence composition in genomic data. This skill should be applied when you need to generate k-mer profiles for short motifs or calculate the Normalized Shannon Entropy (NSE) of sequences, particularly in the context of non-coding RNA annotation or general sequence complexity analysis.

## Usage Patterns and Best Practices

### Basic K-mer Counting
To count k-mers of a specific size and output the results to a text file:
`KmerInShort -file input.fasta -kmer-size 6 -out output_prefix`

### Calculating Normalized Shannon Entropy (NSE)
NSE is a measure of sequence complexity. To compute this for a dataset:
`KmerInShort -file input.fastq.gz -kmer-size 4 -nb-cores 8 -out results -sum -NSE`

*   **-sum**: Aggregates counts across the entire dataset.
*   **-NSE**: Triggers the entropy calculation based on the k-mer distribution.

### Advanced Output Modes
*   **Frequency Mode**: Use `-freq` to output k-mer frequencies instead of raw counts.
*   **Per-Sequence Analysis**: Use `-perSeq` to generate k-mer counts for every individual sequence within the input file rather than a global count for the whole file. This is useful for identifying sequence-specific motifs.

### Performance Optimization
*   **Multi-threading**: Always specify `-nb-cores <number>` to utilize available CPU resources, especially for large FASTQ files.
*   **Compressed Inputs**: The tool natively supports gzipped files (`.gz`), which saves disk space and reduces I/O overhead.

### Constraints and Limitations
*   **K-mer Size**: The tool is strictly limited to `k < 15`. If your analysis requires longer k-mers, you must use a different tool (e.g., Jellyfish or KMC).
*   **Input Types**: Supports both FASTA and FASTQ formats, as well as lists of files.

## Reference documentation
- [KmerInShort Overview](./references/anaconda_org_channels_bioconda_packages_kmerinshort_overview.md)
- [KmerInShort GitHub Repository](./references/github_com_rizkg_KmerInShort.md)