---
name: spring
description: Spring is a high-performance compression tool designed to provide near-optimal, genomic-aware compression for FASTQ and FASTA files. Use when user asks to compress sequencing reads, decompress spring files, perform lossy quality score binning, or extract specific read ranges using random access.
homepage: https://github.com/shubhamchandak94/Spring
metadata:
  docker_image: "quay.io/biocontainers/spring:1.1.1--h4ac6f70_3"
---

# spring

## Overview
Spring is a high-performance compression tool specifically engineered for FASTQ files containing up to 4.29 billion reads. Unlike general-purpose compressors, Spring utilizes genomic-aware algorithms to achieve near-optimal compression ratios. It supports short reads (up to 511 bp) and long reads, provides options for read reordering to further boost efficiency, and allows for random access to specific read ranges during decompression.

## Installation
The most efficient way to install Spring is via Bioconda:
```bash
conda install bioconda::spring
```

## Common CLI Patterns

### Compression
**Basic Lossless Compression (Single-end)**
```bash
spring -c -i input.fastq -o output.spring
```

**Paired-end Compression**
Provide both input files; Spring preserves pairing information.
```bash
spring -c -i reads_1.fastq reads_2.fastq -o output.spring
```

**Maximum Compression (Read Reordering)**
Use `-r` to allow Spring to reorder reads based on sequence similarity. This significantly improves compression ratios but does not preserve the original file order.
```bash
spring -c -r -i input.fastq -o output.spring
```

**Handling Gzipped Input**
```bash
spring -c -g -i input.fastq.gz -o output.spring
```

### Decompression
**Full Decompression**
```bash
spring -d -i input.spring -o output.fastq
```

**Random Access (Subset Decompression)**
Extract a specific range of reads (e.g., reads 1 to 1,000,000).
```bash
spring -d -i input.spring -o subset.fastq --decompress-range 1 1000000
```

**Decompressing to Gzip**
```bash
spring -d -g -i input.spring -o output.fastq.gz --gzip-level 6
```

## Advanced Quality Score Handling
Spring defaults to lossless compression, but offers several lossy modes to drastically reduce file size:

- **QVZ (Lossy):** `-q qvz <ratio>` (e.g., `-q qvz 1.0` for approx 1 bit per quality value).
- **Illumina 8-level binning:** `-q ill_bin`.
- **Binary Thresholding:** `-q binary <threshold> <high_val> <low_val>`.
- **Discard Qualities:** `--no-quality` (stores only sequences and IDs).

## Expert Tips and Best Practices
- **Long Reads:** For Nanopore or PacBio data, you **must** use the `-l` flag. Note that `-r` (reordering) is disabled in long-read mode.
- **Hardware Optimization:** Use `-t` to specify the number of threads. The default is 8. For high-core servers, increasing this can significantly speed up processing.
- **Temporary Space:** Spring creates temporary files during execution (typically 10-30% of the original file size, or up to 80% if using `-r`). Ensure your working directory (`-w`) has sufficient space to prevent crashes.
- **Memory Efficiency:** Decompression is designed to be memory-efficient, making it suitable for standard workstations even with very large compressed archives.
- **FASTA Support:** If your input is FASTA (no quality scores), use the `--fasta-input` flag.

## Reference documentation
- [Spring GitHub Repository](./references/github_com_shubhamchandak94_Spring.md)
- [Bioconda Spring Package Overview](./references/anaconda_org_channels_bioconda_packages_spring_overview.md)