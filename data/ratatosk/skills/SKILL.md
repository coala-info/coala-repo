---
name: ratatosk
description: Ratatosk performs hybrid error correction of long reads by mapping them to a de Bruijn graph constructed from accurate short reads. Use when user asks to correct errors in long reads, reduce raw error rates for ONT data, or perform hybrid error correction using short reads.
homepage: https://github.com/DecodeGenetics/Ratatosk
metadata:
  docker_image: "quay.io/biocontainers/ratatosk:0.9.0--h077b44d_2"
---

# ratatosk

## Overview

Ratatosk is a specialized tool for hybrid error correction that significantly reduces the raw error rate of long reads (such as ONT R9.4 or R10). It functions by constructing a compacted and colored de Bruijn graph from accurate short reads. Long reads are then mapped to paths within this graph, allowing for the correction of SNPs and indels. This process is essential for researchers aiming to achieve high F1 scores in variant calling or high N50 values in de novo assemblies using long-read data.

## Installation

The most efficient way to install Ratatosk is via Bioconda:

```bash
conda install bioconda::ratatosk
```

## Core CLI Usage

### Standard Single-Step Correction
For most datasets, a single command handles the index construction and correction:

```bash
Ratatosk correct -v -G -c 16 -s short_reads.fastq -l in_long_reads.fastq -o out_prefix
```
- `-s`: Paired-end short reads (required).
- `-l`: Input long reads.
- `-o`: Output filename prefix.
- `-c`: Number of threads.
- `-G`: Compress the output (fastq.gz).

### Handling ONT R10 Data
By default, Ratatosk assumes a maximum base quality of 40 (standard for ONT R9.4). For ONT R10 or other high-quality long reads, you must adjust the quality ceiling:

```bash
Ratatosk correct -Q 90 -s short_reads.fastq -l in_long_reads.fastq -o out_prefix
```

### Multi-Step Execution for Large Datasets
If working on a system with strict wall-clock limits, split the process into two passes. The first pass is typically the most resource-intensive.

**Pass 1:**
```bash
Ratatosk correct -1 -v -c 16 -s short_reads.fastq -l in_long_reads.fastq -o out_prefix
```

**Pass 2:**
```bash
Ratatosk correct -2 -v -G -c 16 -s short_reads.fastq -l out_prefix.2.fastq -L in_long_reads.fastq -o out_prefix
```

## Expert Tips and Best Practices

### Input Preparation
- **Paired-End Consistency**: Ratatosk performs best with paired-end short reads. Ensure that reads in a pair have identical names. If your short reads are in BAM format, use `samtools bam2fq -n` to maintain this naming convention.
- **Insert Size**: If using single-end short reads, set the insert size (`-i`) to the read length. For paired-end, the default is ~500bp, but providing an exact estimate (`read length * 2 + fragment size`) improves graph navigation.

### Resource Management
- **Disk Space**: Ratatosk generates several large temporary files in the output directory. Ensure the target filesystem has significantly more free space than the size of the input long reads.
- **Memory**: The indexing phase (Pass 1) is the peak memory usage point. If the process crashes on a single node, consider using the four-step execution (indexing and correcting separately for both k-mer sizes) to isolate resource usage.

### Quality Filtering
Use the `-t` flag to trim or split reads based on correction quality scores. This is useful if you prefer high-confidence fragments over long, partially corrected reads:

```bash
# Output only subsequences with a correction quality score >= 20
Ratatosk correct -t 20 -s short_reads.fastq -l in_long_reads.fastq -o out_prefix
```

## Reference documentation
- [Ratatosk GitHub Repository](./references/github_com_DecodeGenetics_Ratatosk.md)
- [Bioconda Ratatosk Package](./references/anaconda_org_channels_bioconda_packages_ratatosk_overview.md)