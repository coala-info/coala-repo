---
name: fqtrim
description: fqtrim is a standalone utility designed to trim sequencing adapters, poly-A/T tails, and low-quality bases from next-generation sequencing data. Use when user asks to trim adapters, remove poly-A/T tails, filter reads by quality, or collapse duplicate sequences in FASTQ files.
homepage: https://ccb.jhu.edu/software/fqtrim/
metadata:
  docker_image: "quay.io/biocontainers/fqtrim:0.9.7--h077b44d_7"
---

# fqtrim

## Overview
fqtrim is a standalone utility designed for the pre-processing of next-generation sequencing (NGS) data. It specializes in the removal of technical artifacts such as sequencing adapters, poly-A/T tails, and low-quality terminal bases. Unlike some general-purpose trimmers, fqtrim is optimized for transcriptome workflows and can handle inexact matches to account for sequencing errors. Use this skill when you need to prepare raw reads for downstream applications like assembly or mapping, or when you need to recover unmapped reads by removing residual adapter sequences.

## Core Command Patterns

### Basic Trimming
Trim poly-A/T tails (enabled by default) and discard reads shorter than 16bp:
```bash
fqtrim input.fastq -o trimmed.fastq
```

### Paired-End Processing
To keep pairs synchronized, provide both files separated by a comma or colon (no spaces):
```bash
fqtrim read1.fq,read2.fq -o .trimmed.fq
# Outputs: read1.trimmed.fq and read2.trimmed.fq
```

### Adapter Removal
Specify 5' or 3' adapters directly, or use a file for multiple sequences:
```bash
# Single adapter trimming
fqtrim -5 CGACAGGT... -3 TCGTATGC... input.fq -o trimmed.fq

# Multiple adapters from a file
fqtrim -f adapters.txt input.fq -o trimmed.fq
```
*Note: The adapter file format is `[5'-adapter][delimiter][3'-adapter]`. Use a leading delimiter (e.g., `,TCGTAT...`) if only trimming 3' ends.*

### Quality and Complexity Filtering
Enable sliding-window quality trimming at the 3' end:
```bash
fqtrim -q 20 -w 6 -l 30 input.fq -o trimmed.fq
```
- `-q`: Minimum average quality score.
- `-w`: Window size (default 6).
- `-l`: Minimum length to keep after trimming.

### Disabling Default Behaviors
For genomic DNA (where poly-A/T runs might be biological), disable the default transcriptome-optimized trimming:
```bash
fqtrim -A input.fq -o trimmed.fq
```

## Expert Tips
- **Compression**: If the `-o` suffix ends in `.gz` or `.bz2`, fqtrim will automatically compress the output.
- **Streaming**: Use `-` as the input filename to process data from stdin.
- **Reporting**: Use `-r report.txt` to generate a detailed log of every trimming operation performed on each read. This is essential for debugging over-trimming issues.
- **Duplicate Collapsing**: Use `-C` to collapse identical reads, which is highly effective for small RNA/micro-RNA pipelines to reduce computational load.
- **Validation**: The `-a` parameter (default 6) controls the minimum match length for adapters. Increase this value if you observe "over-trimming" of biological sequences that happen to resemble short adapter fragments.

## Reference documentation
- [fqtrim Overview and Usage](./references/ccb_jhu_edu_software_fqtrim.md)
- [Bioconda fqtrim Package](./references/anaconda_org_channels_bioconda_packages_fqtrim_overview.md)