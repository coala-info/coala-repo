---
name: flexiplex
description: Flexiplex is a high-performance tool designed for error-tolerant demultiplexing and sequence searching in long-read sequencing data. Use when user asks to identify cell barcodes and UMIs in single-cell workflows, demultiplex reads using a whitelist, or perform error-tolerant searches for specific sequences.
homepage: https://github.com/DavidsonGroup/flexiplex/
metadata:
  docker_image: "quay.io/biocontainers/flexiplex:1.02.5--py313h9948957_1"
---

# flexiplex

## Overview

Flexiplex is a high-performance, multithreaded C++ tool designed to handle the inherent error rates of long-read sequencing (like Oxford Nanopore) during demultiplexing. It uses the `edlib` library to perform fuzzy matching of flanking sequences (primers, polyT tails) and barcodes. It is particularly effective for single-cell workflows where you need to identify cell barcodes and UMIs, even when the exact positions or sequences contain sequencing errors. Beyond single-cell data, it serves as a versatile "error-tolerant grep" for any large-scale sequence search task.

## Core CLI Patterns

### 1. Single-Cell Barcode Discovery (Unknown Barcodes)
When the list of expected barcodes is unknown, run Flexiplex in discovery mode to generate a frequency table.
```bash
# Use -f 0 for strict flanking sequence matching to ensure high-quality discovery
flexiplex -d 10x3v3 -f 0 reads.fastq > discovery_output.fastq
```
*Key Output:* Generates `flexiplex_barcodes_counts.txt`, which is used for knee-plot analysis.

### 2. Demultiplexing with a Known Whitelist
Assign reads to a specific list of barcodes (e.g., from Cell Ranger or a discovery pass).
```bash
flexiplex -d 10x3v3 -k barcode_whitelist.txt reads.fastq > demultiplexed.fastq
```

### 3. Error-Tolerant Sequence Search (Grep Mode)
Search for a specific sequence with a defined maximum edit distance.
```bash
# Search for a 22bp sequence allowing up to 3 mismatches/indels
flexiplex -x "CACTCTTGCCTACGCCACTAGC" -d grep -f 3 reads.fasta
```

### 4. Custom Barcode/UMI Structures
For non-standard chemistries, define the structure manually. The order of `-x`, `-b`, and `-u` flags defines the search pattern.
```bash
# Pattern: [Left Flank] - [10bp UMI] - [Constant] - [16bp Barcode] - [Right Flank]
flexiplex -x GCTCTTC -u "??????????" -x GAAA -b "????????????????" -x TTTTTTT -k barcodes.txt reads.fastq
```

## Expert Tips and Best Practices

*   **Chimeric Read Handling**: Flexiplex automatically detects chimeric reads (multiple barcodes in one read) by masking found sequences and re-searching. Use `-c true` to add a `_C` suffix to these read IDs for easier downstream filtering.
*   **Performance Optimization**:
    *   Use `-p N` to specify the number of threads (default is 1).
    *   Pipe gzipped input directly to avoid disk I/O overhead: `gunzip -c reads.fastq.gz | flexiplex [options]`.
*   **Edit Distance Tuning**:
    *   `-e`: Maximum edit distance for the **barcode** (default 2).
    *   `-f`: Maximum edit distance for the **flanking sequences** (default 8).
    *   For 16bp barcodes, `-e 2` is standard. For ~30bp total flanking sequences, `-f 8` is recommended.
*   **Read ID Modification**: By default (`-i true`), Flexiplex replaces the read ID with the found Barcode and UMI (e.g., `@BC_UMI#OriginalID`). This is essential for downstream tools like `oarfish` or `nailpolish` that expect CB/UB tags or specific ID formats.
*   **Filtering Discovery Results**: Always use the companion `flexiplex-filter` script on the `flexiplex_barcodes_counts.txt` file to identify the "knee" or inflection point, which separates real cells from empty droplets or ambient RNA.



## Subcommands

| Command | Description |
|---------|-------------|
| flexiplex | A versatile demultiplexer and search tool for omics data, used for searching and reporting barcodes, UMIs, and flanking sequences in sequencing reads. |
| flexiplex-filter | A tool to filter flexiplex results, typically processing count data from a file or stdin. |

## Reference documentation
- [Flexiplex Documentation Home](./references/davidsongroup_github_io_flexiplex.md)
- [Long-read Single-cell Tutorial](./references/davidsongroup_github_io_flexiplex_tutorial.html.md)
- [Flexiplex GitHub README](./references/github_com_DavidsonGroup_flexiplex_blob_main_README.md)