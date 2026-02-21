---
name: isaac4
description: Isaac4 is a high-performance genomic alignment tool optimized for Illumina sequencing platforms.
homepage: https://github.com/Illumina/Isaac4
---

# isaac4

## Overview

Isaac4 is a high-performance genomic alignment tool optimized for Illumina sequencing platforms. It is designed to handle large-scale whole-genome sequencing (WGS) data by utilizing a hardware-aware approach to maximize alignment speed. This skill provides the necessary command-line patterns to configure and execute alignments, manage memory resources, and handle various input formats.

## Installation

The tool is most easily managed via the Bioconda channel:

```bash
conda install bioconda::isaac4
```

## Common CLI Patterns

### Basic Paired-End Alignment
To align a pair of FASTQ files against a reference genome and produce BAM output:

```bash
isaac-align \
  -r /path/to/reference/genome.fa \
  -b /path/to/fastq/directory \
  -f fastq \
  --use-bases-mask y150,y150 \
  -m 40
```

### Key Parameters
- `-r, --reference-genome`: Path to the FASTA file of the reference genome.
- `-b, --base-calls`: Path to the directory containing the input data (e.g., FASTQ files).
- `-f, --input-format`: Specifies the input format (typically `fastq`).
- `--use-bases-mask`: Defines how to interpret the cycles in the sequence data. For example, `y150,y150` indicates 150 cycles of data for both Read 1 and Read 2.
- `-m, --memory-limit`: Sets the maximum memory usage in GB. For human WGS, 40-64GB is a common starting point.

## Expert Tips and Best Practices

### Memory Management
Isaac4 is highly sensitive to memory allocation. If the tool fails with "Failed to allocate a file handle" or "blocked allocation error," ensure that:
1. The `-m` flag is set to a value appropriate for the system's available RAM.
2. The temporary directory has sufficient space and high I/O throughput, as Isaac4 performs significant disk-based sorting.

### Handling Variable Read Lengths
By default, Isaac4 expects uniform read lengths. If your dataset contains reads of varying lengths, you must explicitly enable support to avoid errors:
- Use the `--variable-read-length` flag when processing datasets where reads have been trimmed or are naturally non-uniform.

### Reference Genome Preparation
While Isaac4 can take a standard FASTA file, it performs best when the reference is indexed. Ensure the reference path points to a clean FASTA file without complex headers to prevent parsing issues.

### Performance Optimization
- **Multi-threading**: Isaac4 automatically utilizes available cores. Ensure the environment's CPU affinity allows the process to scale across all intended threads.
- **I/O Bottlenecks**: Because Isaac4 is extremely fast, the primary bottleneck is often disk I/O. Running the tool with input/output on SSDs or high-performance parallel file systems (like Lustre) is highly recommended.

## Reference documentation
- [Isaac4 Overview](./references/anaconda_org_channels_bioconda_packages_isaac4_overview.md)
- [Illumina Isaac4 Repository](./references/github_com_Illumina_Isaac4.md)