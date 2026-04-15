---
name: nanoplexer
description: nanoplexer demultiplexes Nanopore long-read data by sorting sequences into bins based on barcode identity. Use when user asks to demultiplex FASTQ files, sort reads by barcode, or process dual-barcoded Nanopore data.
homepage: https://github.com/hanyue36/nanoplexer
metadata:
  docker_image: "quay.io/biocontainers/nanoplexer:0.1.2--h7132678_2"
---

# nanoplexer

## Overview
nanoplexer is a high-performance utility designed to sort Nanopore long-read data into distinct bins based on barcode identity. It specifically targets the front and rear 150bp of sequences to identify the best alignment hit against a provided barcode library. It is an efficient alternative for users who need a lightweight, C-based tool for demultiplexing without the overhead of larger basecalling suites.

## Installation
The most reliable way to install nanoplexer is via Bioconda:
```bash
conda install -c bioconda nanoplexer
```
Alternatively, it can be built from source using `make`, requiring only `zlib`.

## Common CLI Patterns

### Standard Demultiplexing
To demultiplex a FASTQ file using a set of barcodes:
```bash
nanoplexer -b barcodes.fa -p ./output_dir -t 8 input.fastq
```
- `-b`: Path to the FASTA file containing barcode sequences.
- `-p`: Directory where demultiplexed FASTQ files will be saved.
- `-t`: Number of threads (default is 1).

### Dual Barcoding
For experiments using dual barcodes (unique combinations of 5' and 3' adapters), use the `-d` flag:
```bash
nanoplexer -b barcodes.fa -d dual_barcode_pairs.txt -p ./output_dir input.fastq
```
The dual barcode pair file must be a tab-delimited text file with three columns:
1. Output filename (e.g., `sample_01`)
2. 5' barcode name (matching an entry in `barcodes.fa`)
3. 3' barcode name (matching an entry in `barcodes.fa`)

### Processing Streams
nanoplexer supports reading from stdin, which is useful for piping data directly from other tools or concatenated files:
```bash
cat *.fastq | nanoplexer -b barcodes.fa -p ./output_dir -
```

### Generating Alignment Logs
To inspect how reads were assigned or why they were filtered, use the `-l` flag to generate a log file:
```bash
nanoplexer -b barcodes.fa -p ./output_dir -l demux_report.log input.fastq
```

## Expert Tips and Best Practices
- **Barcode Orientation**: Ensure your `barcodes.fa` contains the sequences as they appear in the reads. nanoplexer aligns against the first and last 150bp.
- **Resource Allocation**: For large datasets, scale the `-t` parameter to match your CPU cores. The tool is thread-efficient and benefits significantly from parallelization.
- **Memory Management**: If processing extremely large files, monitor system memory. While nanoplexer is generally efficient, alignment-heavy tasks on high-thread counts can increase memory pressure.
- **Input Format**: While primarily used for FASTQ, ensure your input data is not corrupted; nanoplexer expects standard 4-line FASTQ entries.

## Reference documentation
- [nanoplexer GitHub Repository](./references/github_com_hanyue36_nanoplexer.md)
- [Bioconda nanoplexer Overview](./references/anaconda_org_channels_bioconda_packages_nanoplexer_overview.md)