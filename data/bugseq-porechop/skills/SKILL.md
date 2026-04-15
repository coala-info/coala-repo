---
name: bugseq-porechop
description: bugseq-porechop identifies and removes adapter sequences from Oxford Nanopore Technologies sequencing data. Use when user asks to trim adapters from ONT reads, demultiplex barcoded samples, or detect and remove chimeric reads.
homepage: https://gitlab.com/bugseq/porechop
metadata:
  docker_image: "quay.io/biocontainers/bugseq-porechop:0.3.4pre--py36h2ad2d48_2"
---

# bugseq-porechop

## Overview
bugseq-porechop is a specialized fork of the original Porechop tool, optimized for cleaning Oxford Nanopore Technologies (ONT) data. It identifies and removes adapter sequences from the ends of reads and can detect internal adapters which may indicate chimeric reads. This tool is essential for pre-processing raw ONT fastq files before assembly or alignment to ensure that non-biological adapter sequences do not interfere with downstream bioinformatics analyses.

## Usage Guidelines

### Basic Adapter Trimming
To trim adapters from a single fastq file and save the output:
```bash
porechop -i input_reads.fastq.gz -o trimmed_reads.fastq.gz
```

### Demultiplexing Barcoded Reads
If your run contains multiple barcoded samples, use the `-b` (or `--barcode_bin_out`) flag to specify an output directory where the tool will sort reads into separate files based on their barcodes:
```bash
porechop -i input_reads.fastq -b output_directory/
```

### Common CLI Options
- `-i`, `--input`: Input fastq or fasta file (can be gzipped).
- `-o`, `--output`: Output file for trimmed reads (if not demultiplexing).
- `-b`, `--barcode_bin_out`: Directory to store demultiplexed files.
- `--threads`: Number of CPU threads to use (default is all available).
- `--keep_split`: When internal adapters are found, the read is split. Use this to keep both parts.
- `--discard_middle`: Discard reads that contain internal adapters (useful for removing chimeras).

### Expert Tips
- **Sensitivity**: If you find that adapters are not being removed aggressively enough, you can adjust the `--threshold` (default is 75.0). Lowering this value makes adapter detection more sensitive but increases the risk of false positives.
- **Verbosity**: Use `-v 2` to get detailed information about which adapters were found and where they were trimmed, which is helpful for troubleshooting unexpected trimming behavior.
- **Memory Management**: For very large datasets, ensure you have sufficient RAM, as Porechop loads sets of reads into memory for processing.

## Reference documentation
- [bugseq-porechop Overview](./references/anaconda_org_channels_bioconda_packages_bugseq-porechop_overview.md)