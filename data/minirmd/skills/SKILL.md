---
name: minirmd
description: minirmd identifies and removes redundant or near-identical sequences from FASTQ files to reduce sequencing bias and computational costs. Use when user asks to deduplicate FASTQ files, remove redundant reads with allowed mismatches, or perform paired-end sequence deduplication.
homepage: https://github.com/yuansliu/minirmd
---


# minirmd

## Overview
minirmd is a high-performance C++ utility designed to identify and remove redundant sequences from FASTQ files. It is particularly valuable in bioinformatics workflows where sequencing depth is high and exact or near-identical reads may bias results or unnecessarily increase computational costs. Unlike many deduplication tools that only target 100% identical sequences, minirmd allows for a configurable number of mismatches, making it robust against sequencing errors.

## Installation
The tool is most easily installed via Bioconda:
```bash
conda install -c bioconda minirmd
```

## Core CLI Usage

### Single-End Deduplication
To remove exact duplicates from a single FASTQ file:
```bash
minirmd -i input.fastq -o output.fastq
```

To allow for near-duplicates (e.g., allowing 1 mismatch):
```bash
minirmd -i input.fastq -o output.fastq -d 1
```

### Paired-End Deduplication
When working with paired-end data, provide both the forward (-i) and reverse (-f) files. The tool will output a single merged file or processed result as specified:
```bash
minirmd -i reads_1.fastq -f reads_2.fastq -o output_dedup.fastq -d 2
```

## Parameters and Options

| Flag | Description | Default |
|------|-------------|---------|
| `-i` | Primary input FASTQ file | Required |
| `-f` | Secondary input FASTQ file (for paired-end) | Optional |
| `-o` | Output FASTQ file path | Required |
| `-d` | Number of allowed mismatches for "near-duplicates" | 0 |
| `-t` | Number of threads for parallel processing | 24 |
| `-r` | Remove duplicates found on the reverse-complement strand | Off |
| `-k` | File path to store values of k | Optional |

## Best Practices and Expert Tips

### Handling Sequencing Errors
If your data has known high error rates (e.g., older Illumina runs or specific library preps), increase the `-d` parameter. A setting of `-d 1` or `-d 2` is often sufficient to catch near-duplicates that differ only by a single base call error.

### Reverse Complement Deduplication
For libraries where reads may originate from either strand (non-strand-specific libraries), always use the `-r` flag. This ensures that a read and its reverse complement are recognized as the same sequence, preventing artificial inflation of read counts.

### Performance Optimization
minirmd is multi-threaded. While it defaults to 24 threads, you should match this to your specific HPC environment or workstation capabilities using the `-t` flag to avoid resource contention.

### Input Format Sensitivity
Note that minirmd expects standard FASTQ formatting. If a file contains duplicate headers for different sequences (e.g., `@header123` appearing twice with different sequence data), the tool may ignore subsequent entries with the same header. Ensure your headers are unique or properly formatted before processing.

## Reference documentation
- [minirmd GitHub Repository](./references/github_com_yuansliu_minirmd.md)
- [Bioconda minirmd Package Overview](./references/anaconda_org_channels_bioconda_packages_minirmd_overview.md)