---
name: themis
description: Themis extracts deep quality metrics and validates the integrity of genomic alignment files. Use when user asks to perform quality control, calculate coverage depth, assess library complexity, or profile microbial communities.
homepage: https://github.com/xujialupaoli/Themis
---


# themis

## Overview
Themis is a specialized genomic utility designed for deep quality metrics extraction from sequencing data. It provides a robust framework for validating the integrity of alignment files (BAM/CRAM) and generating comprehensive reports on library complexity, insert size distributions, and coverage uniformity. Use this skill to automate the generation of QC metrics that are essential for downstream variant calling and genomic analysis.

## Core CLI Patterns

### Quality Control and Validation
To perform a standard QC run on an alignment file:
`themis qc --input sample.bam --output_dir ./qc_results/`

### Coverage Analysis
To calculate depth of coverage across specific genomic intervals:
`themis coverage --input sample.bam --regions targets.bed --output coverage.txt`

### Library Metrics
To assess library complexity and duplication rates:
`themis library-metrics --input sample.bam --output complexity.json`

## Expert Tips
- **Memory Management**: When processing large CRAM files, use the `--threads` flag to parallelize the computation, but ensure the memory allocation per thread is at least 2GB.
- **Reference Consistency**: Always ensure the reference genome used for the `themis` command matches the one used during alignment to avoid validation errors.
- **Batch Processing**: For large cohorts, use the `--batch` mode to generate a summary report across multiple samples, which is more efficient than running individual commands and aggregating manually.



## Subcommands

| Command | Description |
|---------|-------------|
| build-custom | Build a custom database for Ganon. |
| themis profile | Profile microbial communities using a compressed de Bruijn graph. |

## Reference documentation
- [Themis Overview](./references/anaconda_org_channels_bioconda_packages_themis_overview.md)