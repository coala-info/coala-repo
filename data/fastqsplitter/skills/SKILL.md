---
name: fastqsplitter
description: fastqsplitter partitions FASTQ files into multiple chunks while preserving the mandatory four-line record structure. Use when user asks to split FASTQ files, partition sequencing data into smaller parts, or divide compressed FASTQ files.
homepage: https://github.com/LUMC/fastqsplitter
---


# fastqsplitter

## Overview
`fastqsplitter` is a high-performance utility for partitioning FASTQ files while preserving the mandatory four-line record structure (header, sequence, plus sign, and quality scores). It is a bioinformatics-specific alternative to the standard GNU `split` command. The tool is highly efficient at handling compressed data, utilizing the `xopen` library to manage gzip compression and decompression on the fly based on file extensions.

## Installation and Setup
The recommended installation method is via Conda to ensure all optimized compression dependencies are included:
```bash
conda install -c bioconda fastqsplitter
```

## Common CLI Patterns

### Basic Splitting
To split an input file into a specific number of parts:
```bash
fastqsplitter input.fastq -n 4 --prefix split_output
```
This generates `split_output.0.fastq`, `split_output.1.fastq`, `split_output.2.fastq`, and `split_output.3.fastq`.

### Handling Compressed Files
The tool automatically detects compression based on the file extension. To split a gzipped file into gzipped chunks:
```bash
fastqsplitter input.fastq.gz -n 3 --prefix output.fastq.gz
```

### Working with STDIN
You can pipe data into `fastqsplitter` by using `-` as the input file:
```bash
zcat large_file.fastq.gz | fastqsplitter - -n 5 --prefix part
```

## Expert Tips and Best Practices

### Distribution Methods
*   **Round-Robin (Default):** Distributes records one by one across all output files. This is the most effective way to ensure perfectly even distribution when the total record count is known or the file is being read from disk.
*   **Sequential Distribution:** Useful when reading from STDIN where the total input size is unknown. It fills one output file to a maximum size before moving to the next.

### Performance Optimization
*   **Conda vs. Pip:** Always prefer the Conda installation. It includes system-level dependencies that make `.gz` processing significantly faster than the pure-python fallback used by pip.
*   **Thread Management:** `fastqsplitter` uses threads for compression/decompression. Ensure your environment has sufficient CPU cores available when splitting into many compressed files simultaneously.
*   **Extension Awareness:** Always include the `.gz` extension in your `--prefix` if you want the output to be compressed. If you omit it, the tool will produce uncompressed text files even if the input was compressed.

### Limitations
*   **Multiline FASTQ:** This tool does not support FASTQ files where the sequence or quality scores span multiple lines. Ensure your data is in the standard 4-line-per-record format.

## Reference documentation
- [fastqsplitter Overview](./references/anaconda_org_channels_bioconda_packages_fastqsplitter_overview.md)
- [LUMC fastqsplitter GitHub Repository](./references/github_com_LUMC_fastqsplitter.md)