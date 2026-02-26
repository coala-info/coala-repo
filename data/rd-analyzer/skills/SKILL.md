---
name: rd-analyzer
description: rd-analyzer detects Regions of Difference in Mycobacterium tuberculosis complex sequencing data to identify strains and genomic deletions. Use when user asks to identify MTBC lineages, detect genomic deletions from FASTQ reads, or analyze user-defined genomic regions for presence or absence.
homepage: https://github.com/xiaeryu/RD-Analyzer
---


# rd-analyzer

## Overview

rd-analyzer is a specialized bioinformatics tool for the in silico detection of Regions of Difference (RD) within the Mycobacterium tuberculosis complex. It processes raw FASTQ sequencing reads to predict genomic deletions and identify specific strains based on established markers. The tool provides a standard workflow for common MTBC lineages and an extended workflow for analyzing user-defined genomic regions.

## Prerequisites

Ensure the following dependencies are available in the environment:
- Python 2.7
- BWA-MEM (for sequence alignment)
- SAMtools (specifically version 0.1.19 is recommended for compatibility)

## Standard RD Analysis

Use `RD-Analyzer.py` for strain identification based on previously defined RD markers.

### Basic Command Structure
```bash
python2.7 RD-Analyzer.py [options] FASTQ_1 [FASTQ_2]
```

### Common Patterns
- **Paired-end reads**: `python2.7 RD-Analyzer.py -O output_dir -o sample_name reads_R1.fastq reads_R2.fastq`
- **Single-end reads**: `python2.7 RD-Analyzer.py -O output_dir -o sample_name reads.fastq`
- **Custom thresholds**: Use `-p` to enable personalized cut-offs for depth (`-m`) and coverage (`-c`).
  `python2.7 RD-Analyzer.py -p -m 0.1 -c 0.6 reads_R1.fastq reads_R2.fastq`

## Extended RD Analysis

Use `RD-Analyzer-extended.py` to predict deletions in user-specified sequences.

### Basic Command Structure
```bash
python2.7 RD-Analyzer-extended.py [options] REF.FASTA FASTQ_1 [FASTQ_2]
```

### Reference FASTA Requirements
The input `REF.FASTA` must follow a strict header format with four fields separated by hyphens (`-`):
`>Name-DepthCutoff-CoverageCutoff-Description`

- **Field 1**: Reference sequence name.
- **Field 2**: Read-depth cutoff (0-1 scale). Use `default` for 0.09.
- **Field 3**: Sequence coverage cutoff (0-1 scale). Use `default` for 0.5.
- **Field 4**: Descriptive information shown if the RD is detected.

**Example Header**: `>Lineage4.6.1.2-default-default-Lineage4.6.1.2_Marker`

## Expert Tips and Best Practices

- **Header Formatting**: In extended mode, do not include spaces in the FASTA header. Do not use hyphens except as field delimiters.
- **Parameter Optimization**: Stick to default cut-offs (0.09 depth, 0.5 coverage) for most MTBC datasets as they are optimized for standard sequencing depths.
- **Troubleshooting**: Use the `-d` or `--debug` flag to keep intermediate files (SAM/BAM) for manual inspection if results are unexpected.
- **Output Management**: Always specify an output directory with `-O` to prevent cluttering the working directory with intermediate alignment files.

## Reference documentation
- [RD-Analyzer GitHub Repository](./references/github_com_xiaeryu_RD-Analyzer.md)
- [RD-Analyzer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rd-analyzer_overview.md)