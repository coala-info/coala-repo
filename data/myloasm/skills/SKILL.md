---
name: myloasm
description: "Myloasm is a high-resolution metagenome assembler for noisy long reads. Use when user asks to assemble metagenomic data from long-read sequencing."
homepage: https://github.com/bluenote-1577/myloasm
---


# myloasm

yaml
name: myloasm
description: |
  High-resolution metagenome assembler for noisy long reads.
  Use when you need to assemble metagenomic data from long-read sequencing (e.g., PacBio, Oxford Nanopore)
  to generate high-quality contigs, especially in the presence of sequencing errors or complex microbial communities.
  This tool is suitable for de novo assembly of metagenomes.
```
## Overview
Myloasm is a de novo metagenome assembler specifically designed for long-read sequencing data, including noisy reads from technologies like PacBio and Oxford Nanopore. It excels at producing high-resolution, polished contigs from complex microbial communities. Use myloasm when your goal is to reconstruct the genomes of organisms within a metagenomic sample, particularly when dealing with challenging datasets that may contain significant sequencing errors.

## Usage Instructions

Myloasm is a command-line tool that takes sequencing reads as input and outputs assembled contigs. The primary command structure is straightforward, but understanding key parameters can optimize assembly.

### Basic Assembly

The most basic usage involves specifying the input read file(s) and an output prefix.

```bash
myloasm <reads.fastq.gz> <output_prefix>
```

Or for multiple input files:

```bash
myloasm <reads1.fastq.gz> <reads2.fastq.gz> <output_prefix>
```

### Key Parameters

While myloasm aims for a single-command assembly, several parameters can influence the output quality and performance. Refer to the official documentation for a comprehensive list, but here are some commonly useful ones:

*   **`-t, --threads <N>`**: Number of threads to use for computation. Defaults to the number of logical cores.
*   **`-m, --memory <N>`**: Maximum memory to use in GB. This is crucial for large datasets.
*   **`--kmer-size <N>`**: The size of k-mers to use. The default is often suitable, but adjusting this can impact assembly of different repeat structures.
*   **`--min-contig-len <N>`**: Minimum length of contigs to output. Defaults to 1000 bp.
*   **`--output-dir <DIR>`**: Specify a directory for output files.

### Expert Tips

*   **Input Data Quality**: While myloasm is designed for noisy reads, pre-processing or quality filtering of input reads can still be beneficial. However, avoid aggressive filtering that might remove longer, potentially informative reads.
*   **Memory Management**: Metagenome assembly is memory-intensive. Monitor your system's memory usage and adjust the `--memory` parameter accordingly. If you encounter out-of-memory errors, reduce the number of threads or increase the allocated memory if possible.
*   **Output Interpretation**: Myloasm produces polished contigs. These are the primary output for downstream analysis such as genome binning, gene prediction, and taxonomic profiling.
*   **Parameter Tuning**: For particularly challenging datasets or specific research questions, experimenting with `--kmer-size` and `--min-contig-len` might yield improved results. Always validate assembly quality using metrics like N50, L50, and by comparing against known reference genomes if available.
*   **Documentation**: The official documentation at `https://myloasm-docs.github.io/` and the README on the GitHub repository (`https://github.com/bluenote-1577/myloasm`) are the definitive sources for detailed parameter explanations and advanced usage.

## Reference documentation
- [myloasm README](./references/github_com_bluenote-1577_myloasm.md)