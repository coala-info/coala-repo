---
name: f5c
description: f5c is an optimized re-implementation of Nanopolish modules that uses hardware acceleration to perform high-speed nanopore signal analysis. Use when user asks to index reads, call DNA methylation, calculate methylation frequencies, or perform event alignment.
homepage: https://github.com/hasindu2008/f5c
---


# f5c

## Overview

f5c is an ultra-fast, optimized re-implementation of specific modules from Nanopolish (index, call-methylation, and eventalign). It is designed to handle the heavy computational load of nanopore signal analysis by utilizing multi-threading and hardware acceleration (NVIDIA CUDA or AMD ROCm). Use this skill to guide users through the workflow of linking basecalled FASTQ files to raw signal data and extracting epigenetic information or signal alignments.

## Core Workflow

### 1. Indexing
Before analysis, you must link basecalled reads to their corresponding raw signal files (FAST5 or SLOW5/BLOW5).

```bash
# For FAST5 files
f5c index -d /path/to/raw_fast5_dir/ reads.fastq

# For SLOW5/BLOW5 files (Recommended for performance)
f5c index reads.fastq
```

### 2. Methylation Calling
Detect methylated cytosines (e.g., CpG sites).

```bash
# Basic CPU usage
f5c call-methylation -b alignment.bam -g reference.fa -r reads.fastq > methylation_calls.tsv

# Using GPU acceleration (NVIDIA)
f5c call-methylation --cuda-dev 0 -b alignment.bam -g reference.fa -r reads.fastq > methylation_calls.tsv
```

### 3. Methylation Frequency
Summarize the per-read calls into site-specific frequencies.

```bash
f5c meth-freq -i methylation_calls.tsv > methylation_freq.tsv
```

### 4. Event Alignment
Align raw nanopore signals to the reference k-mers.

```bash
f5c eventalign -b alignment.bam -g reference.fa -r reads.fastq > events.tsv
```

## Optimization and Best Practices

### Data Formats
*   **Prefer BLOW5**: For maximum performance, convert FAST5 to BLOW5 using `slow5tools` or POD5 to BLOW5 using `blue-crab`. f5c is natively optimized for the SLOW5/BLOW5 format, significantly reducing I/O overhead.
*   **Automatic Detection**: When using S/BLOW5, f5c automatically detects the pore type and chemistry.

### Hardware Acceleration
*   **GPU Usage**: Always check if the binary supports CUDA (`f5c_x86_64_linux_cuda`). Use the `--cuda-dev` flag to specify the device ID.
*   **Batch Size**: Adjust `-K` (batch size in terms of bases) and `-B` (batch size in terms of reads) to fit your GPU memory. Larger values generally improve throughput but require more VRAM.

### Chemistry-Specific Flags
If using FAST5 input (where autodetection may fail), manually specify the pore type:
*   **R10.4.1**: Use `--pore r10`
*   **RNA004**: Use `--pore rna004`

### Multi-threading
Use the `-t` flag to specify the number of CPU threads. For hybrid CPU/GPU execution, ensure `-t` is set high enough to feed the GPU efficiently (e.g., `-t 8` or `-t 16`).

## Common CLI Patterns

| Task | Command Option |
| :--- | :--- |
| **Specify Reference** | `-g reference.fasta` |
| **Specify BAM** | `-b alignment.bam` |
| **Specify Reads** | `-r reads.fastq` |
| **Thread Count** | `-t [num]` |
| **Batch Size (Bases)** | `-K [num]` (Default: 2.0M) |
| **Batch Size (Reads)** | `-B [num]` (Default: 512) |
| **Output to File** | `-o output.tsv` |

## Reference documentation
- [f5c Overview and Installation](./references/anaconda_org_channels_bioconda_packages_f5c_overview.md)
- [f5c GitHub Repository and Usage Guide](./references/github_com_hasindu2008_f5c.md)