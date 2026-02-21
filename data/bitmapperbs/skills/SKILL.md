---
name: bitmapperbs
description: BitMapperBS is an ultra-fast and memory-efficient read aligner tailored for bisulfite-converted DNA sequences.
homepage: https://github.com/chhylp123/BitMapperBS
---

# bitmapperbs

## Overview

BitMapperBS is an ultra-fast and memory-efficient read aligner tailored for bisulfite-converted DNA sequences. It utilizes a specialized indexing strategy to handle the reduced-complexity alphabet resulting from C-to-T transitions in WGBS data. This tool is ideal for researchers needing to process large datasets on standard hardware, as it requires only about 7GB of RAM for human genome alignment and supports direct BAM output to minimize disk I/O bottlenecks.

## Installation

The recommended way to install BitMapperBS is via Bioconda:

```bash
conda install bioconda::bitmapperbs
```

## Core Workflows

### 1. Building a Reference Index
Before alignment, you must create a specialized index for your reference genome.

```bash
bitmapperBS --index <reference.fa> --index_folder <output_index_directory>
```
*   **Resource Requirements**: For the human genome, this requires approximately 10GB of RAM and 60GB of disk space.
*   **Note**: Ensure the output folder exists or is specified correctly, as the tool will store multiple FM-index components there.

### 2. Read Alignment
BitMapperBS supports both single-end and paired-end reads, with a focus on directional protocols.

**Paired-End Alignment (Recommended Pattern):**
```bash
bitmapperBS --search <index_folder> \
            --seq1 <reads_R1.fastq.gz> \
            --seq2 <reads_R2.fastq.gz> \
            --pe \
            -t 8 \
            --sensitive \
            --bam \
            --mapstats \
            -o output_alignment.bam
```

**Single-End Alignment:**
```bash
bitmapperBS --search <index_folder> --seq <reads.fastq.gz> --bam -o output.bam
```

## Command Line Options and Best Practices

### Performance Optimization
*   **Disk I/O**: The primary bottleneck for BitMapperBS is often disk I/O. Always use compressed input files (`.fastq.gz` or `.fq.gz`) and output directly to BAM format using the `--bam` flag.
*   **Storage**: If possible, store indexes and perform alignment on Solid State Drives (SSD) rather than Hard Disk Drives (HDD) to maximize multi-threading efficiency.
*   **Hardware**: The CPU must support AVX2 or SSE4.2 instructions.

### Mapping Parameters
*   `--sensitive`: Use this flag to improve the alignment rate, though it may slightly increase processing time.
*   `-t <int>`: Set the number of CPU threads. BitMapperBS scales well with multiple cores.
*   `--mapstats`: Generates a summary of mapping results, useful for quality control.

### Troubleshooting Common Issues
*   **Index Errors**: If you encounter "psascan: not found" during indexing on older Linux systems, you may need to compile `pSAscan` manually and place the binary in the BitMapperBS directory.
*   **Memory**: While alignment is efficient (~7GB for human), ensure you have at least 10GB available during the initial indexing phase.
*   **Version Warning**: Avoid using version 1.0.2.0 due to known stability issues. Use version 1.0.2.1 or later.

## Reference documentation
- [BitMapperBS GitHub Repository](./references/github_com_chhylp123_BitMapperBS.md)
- [Bioconda BitMapperBS Overview](./references/anaconda_org_channels_bioconda_packages_bitmapperbs_overview.md)