---
name: rad
description: The rad utility demultiplexes single-cell long-read sequencing data using an alignment-based approach to identify and correct barcodes. Use when user asks to demultiplex single-cell long-reads, perform barcode error correction against a whitelist, or process sequencing data with inconsistent read structures.
homepage: https://github.com/indianewok/rad
---


# rad

## Overview
The `rad` (Read-structure Agnostic Demultiplexer) utility provides a robust solution for processing single-cell long-read sequencing data. Unlike traditional tools that require fixed offsets for barcodes, `rad` uses an alignment-based approach to locate and correct whitelisted barcodes. This makes it particularly effective for technologies where read structures may be inconsistent or where insertions/deletions are common in the adapter sequences.

## Core CLI Usage
The tool is typically invoked via the command line to process raw fastq files against a known whitelist of cell barcodes.

### Basic Command Structure
```bash
rad [options] --input <reads.fastq> --whitelist <barcodes.txt> --output <output_prefix>
```

### Key Parameters
- `--input` / `-i`: Path to the input FASTQ or FASTA file (supports gzipped files).
- `--whitelist` / `-w`: A text file containing the expected cell barcodes (one per line).
- `--output` / `-o`: Prefix for the generated demultiplexed files.
- `--threads` / `-t`: Number of threads for parallel processing (utilizes OpenMP).
- `--edit-dist` / `-e`: Maximum edit distance allowed for barcode matching (default is usually 2).

## Best Practices
- **Barcode Correction**: Always provide a high-quality whitelist (e.g., from 10x Genomics or similar platforms) to enable `rad` to perform error correction on noisy long-read barcodes.
- **Resource Allocation**: Since `rad` bundles `edlib` for fast alignment and uses OpenMP, ensure you set `--threads` to match your available CPU cores for significant speedups in large datasets.
- **Input Quality**: While `rad` is robust to indels, pre-filtering very low-quality reads can improve the accuracy of the alignment-based demultiplexing.

## Troubleshooting
- **Low Match Rate**: If few reads are being demultiplexed, check if the orientation of the barcodes in your whitelist matches the orientation of the reads. You may need to reverse-complement the whitelist.
- **Dependencies**: Ensure `zlib` and `libomp` (or `gcc-opentmp`) are available in your environment if running the binary outside of a managed conda environment.

## Reference documentation
- [rad Overview](./references/anaconda_org_channels_bioconda_packages_rad_overview.md)