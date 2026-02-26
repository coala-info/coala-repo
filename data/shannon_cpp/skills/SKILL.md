---
name: shannon_cpp
description: shannon_cpp is a high-performance tool for de novo RNA-Seq transcriptome assembly using a k-mer based graph approach. Use when user asks to perform de novo assembly of RNA-Seq data, reconstruct transcriptomes from raw sequencing reads, or detect isoforms without a reference genome.
homepage: https://github.com/bx3/shannon_cpp.git
---


# shannon_cpp

## Overview
The `shannon_cpp` skill provides a high-performance implementation of the Shannon de novo RNA-Seq assembler. This tool is optimized for reconstructing the transcriptome from raw sequencing data by utilizing a k-mer based graph approach. It is particularly effective for users who need a memory-efficient and fast alternative to the original Python-based Shannon assembler while maintaining high sensitivity for isoform detection.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels before installation.

```bash
# Install via conda
conda install -c bioconda shannon_cpp
```

## Common CLI Patterns
The core functionality revolves around processing input reads (typically in FASTQ format) to generate a set of assembled transcripts.

### Basic Assembly
To run a standard assembly, you must provide the input read files and specify the k-mer size.
```bash
shannon_cpp -left reads_1.fq -right reads_2.fq -K 31 -o output_directory
```

### Key Parameters
- `-left <file>`: Path to the left/forward reads.
- `-right <file>`: Path to the right/reverse reads.
- `-K <int>`: K-mer size (default is often 31; larger k-mers increase specificity but may reduce sensitivity for lowly expressed transcripts).
- `-o <dir>`: Output directory for the assembled fasta files and intermediate logs.
- `-t <int>`: Number of threads to use for parallel processing.

## Expert Tips and Best Practices
- **Memory Management**: `shannon_cpp` is significantly more memory-efficient than its Python predecessor, but for very large datasets (e.g., >100M reads), ensure you have at least 32GB-64GB of RAM available.
- **K-mer Selection**: For 75bp reads, a K of 25-27 is recommended. For 100bp or 150bp reads, a K of 31 is the standard starting point.
- **Pre-processing**: Always perform adapter trimming and quality filtering (e.g., using Fastp or Trimmomatic) before running `shannon_cpp`. The assembler performs best when the input reads are clean of sequencing artifacts.
- **Rcorrector Integration**: The repository includes `Rcorrector` components. It is highly recommended to run error correction on your RNA-Seq reads prior to assembly to reduce the complexity of the de Bruijn graph.

## Reference documentation
- [shannon_cpp Overview](./references/anaconda_org_channels_bioconda_packages_shannon_cpp_overview.md)
- [shannon_cpp GitHub Repository](./references/github_com_bx3_shannon_cpp.md)