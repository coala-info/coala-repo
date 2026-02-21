---
name: adapterremoval
description: AdapterRemoval searches for and removes remnant adapter sequences from High-Throughput Sequencing (HTS) data and (optionally) trims low quality bases.
homepage: https://github.com/MikkelSchubert/adapterremoval
---

# adapterremoval

## Overview
AdapterRemoval is a high-performance tool designed for the rapid pre-processing of raw sequencing data. It is particularly well-suited for workflows involving short-insert libraries (such as ancient DNA) where read merging is essential, but it is equally effective for standard genomic and transcriptomic pipelines. The tool automates the identification and removal of adapter sequences, performs quality-based base clipping, and can generate consensus sequences from overlapping paired-end reads to improve data quality.

## Core CLI Patterns

### Basic Trimming
For standard paired-end reads, use `--file1` and `--file2`. By default, the tool looks for common Illumina adapters.
```bash
AdapterRemoval --file1 reads_R1.fastq.gz --file2 reads_R2.fastq.gz --basename output_prefix
```

### Read Merging (Collapsing)
Merging overlapping pairs is critical for short-insert libraries to create higher-quality single reads.
```bash
AdapterRemoval --file1 R1.fq.gz --file2 R2.fq.gz --collapse --basename merged_sample
```
*   **Note**: This produces `.collapsed` (merged), `.collapsed.truncated` (merged but quality trimmed), and `.pair1/.pair2` (unmerged) files.

### Quality Filtering
Enable quality trimming to remove low-confidence bases from the 3' end.
```bash
AdapterRemoval --file1 R1.fq.gz --trimqualities --minquality 20 --minlength 30
```

### Adapter Identification
If the adapter sequence is unknown, AdapterRemoval can attempt to reconstruct it from the overlap of paired-end reads.
```bash
AdapterRemoval --file1 R1.fq.gz --file2 R2.fq.gz --identify-adapters
```

## Expert Tips and Best Practices

### Performance Optimization
*   **Multi-threading**: Always specify `--threads` to utilize multiple CPU cores, as the tool scales well.
*   **Direct Compression**: Use `--gzip` or `--bzip2` to write compressed output directly, saving disk space and I/O time.
*   **Interleaved Input**: If your paired-end data is in a single file, use the `--interleaved` flag.

### Handling Modern Illumina Data
*   **Poly-G Trimming**: For data from two-color chemistry machines (like NovaSeq or NextSeq), use `--trimpolyg` to remove G-tails caused by dark cycles.
*   **Mate Separators**: If your read headers use non-standard separators, use `--normalize-mate-separator` to ensure the tool correctly identifies pairs.

### Demultiplexing
To demultiplex samples based on inline barcodes, provide a barcode file using `--barcode-list`.
```bash
AdapterRemoval --file1 R1.fq.gz --file2 R2.fq.gz --barcode-list barcodes.txt
```
The barcode file should be a simple tab-separated format: `SampleName Barcode1 Barcode2`.

### Output Management
By default, AdapterRemoval generates several files. Use `--basename` to keep your workspace organized. If you only need specific outputs (e.g., only merged reads), you will still need to manage the auxiliary files created by the tool.

## Reference documentation
- [AdapterRemoval GitHub Repository](./references/github_com_MikkelSchubert_adapterremoval.md)
- [Bioconda AdapterRemoval Overview](./references/anaconda_org_channels_bioconda_packages_adapterremoval_overview.md)