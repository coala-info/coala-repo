---
name: metacortex
description: MetaCortex is a de novo assembler for metagenomic sequence data. Use when user asks to assemble environmental DNA sequences into contigs, reconstruct genomes from mixed microbial communities, or analyze complex microbial ecosystems.
homepage: https://github.com/SR-Martin/metacortex
---


# metacortex

MetaCortex is a de novo assembler for metagenomic sequence data. Use this skill when you need to assemble environmental DNA sequences into contigs, reconstruct genomes from mixed microbial communities, or analyze complex microbial ecosystems.
  This skill is specifically for using the MetaCortex command-line tool.
---
## Overview

MetaCortex is a powerful de novo assembler designed for metagenomic data. It takes raw sequencing reads from environmental samples (like soil, water, or gut microbiomes) and reconstructs contiguous DNA sequences (contigs). This process is crucial for understanding the genetic makeup of microbial communities, identifying novel organisms, and studying their ecological roles. This skill provides guidance on using the MetaCortex command-line interface for assembly tasks.

## Usage Instructions

MetaCortex is a command-line tool. The primary command for assembly is `metacortex`.

### Basic Assembly

To perform a basic assembly, you will need your paired-end sequencing reads.

```bash
metacortex assemble -1 reads_R1.fastq -2 reads_R2.fastq -o output_directory
```

*   `-1`: Path to the first FASTQ file (forward reads).
*   `-2`: Path to the second FASTQ file (reverse reads).
*   `-o`: Directory where the assembly output (contigs) will be saved.

### Advanced Options

MetaCortex offers several options to fine-tune the assembly process. Consult the tool's documentation for a comprehensive list. Some common advanced options include:

*   **Graph construction parameters**: Options to control the de Bruijn graph construction, such as k-mer size.
    *   `-k <kmer_size>`: Specify the k-mer size for graph construction.
*   **Assembly strategies**: Different algorithms or heuristics for traversing the graph and generating contigs.
    *   Refer to the documentation for specific strategy flags.
*   **Output formats**: Control the format of the output contigs.
    *   `--output-format <format>`: Specify output format (e.g., FASTA).

### Example: Specifying K-mer Size

To assemble reads using a k-mer size of 31:

```bash
metacortex assemble -1 reads_R1.fastq -2 reads_R2.fastq -k 31 -o output_k31
```

### Installation

MetaCortex can be installed via Conda:

```bash
conda install bioconda::metacortex
```

## Tool-Specific Best Practices

*   **Input Data Quality**: Ensure your input FASTQ files are of high quality. Low-quality reads can significantly impact assembly results. Perform quality trimming and filtering before assembly if necessary.
*   **K-mer Size Selection**: The choice of k-mer size is critical and depends on the sequencing technology and the complexity of the metagenome. Experiment with different k-mer sizes to find the optimal one for your data. Smaller k-mers can resolve repetitive regions but may lead to more fragmented assemblies, while larger k-mers can produce longer contigs but might struggle with highly variable regions.
*   **Resource Management**: Metagenomic assembly can be computationally intensive, requiring significant RAM and CPU. Monitor your system resources and consider running MetaCortex on a high-performance computing cluster for large datasets.
*   **Output Interpretation**: The output of MetaCortex will typically include contigs in FASTA format. These contigs can then be used for downstream analyses such as genome binning, gene prediction, and functional annotation.

## Reference documentation
- [MetaCortex Overview](https://anaconda.org/bioconda/metacortex)
- [MetaCortex GitHub Repository](https://github.com/SR-Martin/metacortex)