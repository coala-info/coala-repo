---
name: tssv
description: `tssv` performs targeted analysis of short structural variations, microsatellites, and short tandem repeats. Use when user asks to characterize a sequencing library, identify specific alleles, quantify allele frequencies, identify stutter patterns, or detect insertions or deletions.
homepage: The package home page
---


# tssv

## Overview
The `tssv` tool is designed for the targeted analysis of short structural variations. Unlike general-purpose aligners, it uses a knowledge-based approach to characterize sequences between known flanking regions. It is particularly effective for analyzing microsatellites, short tandem repeats (STRs), and other complex variations where traditional mapping might fail or provide insufficient detail.

## Core Workflows

### Library Characterization
To perform a full characterization of a sequencing library against a set of targets:
```bash
tssv <input.fastq> <config.ini> > report.txt
```
The configuration file defines the flanking sequences and the expected structure of the targeted loci.

### Targeted Alignment and Counting
Use `tssv` to identify specific alleles by matching sequences that bridge defined upstream and downstream "anchors." This is useful for:
- Quantifying allele frequencies in a population.
- Identifying stutter patterns in STR analysis.
- Detecting insertions or deletions between fixed flanking sequences.

## Best Practices
- **Flank Selection**: Choose flanking sequences (anchors) that are unique within your library to prevent off-target matching.
- **Mismatches**: Adjust the allowed mismatch rate based on the quality of your sequencing data; too high a rate may increase noise, while too low may miss valid biological variants.
- **Input Quality**: Ensure FASTQ files are pre-processed for quality, though `tssv` is robust to minor sequencing errors due to its flanking-sequence approach.

## Reference documentation
- [tssv Overview](./references/anaconda_org_channels_bioconda_packages_tssv_overview.md)