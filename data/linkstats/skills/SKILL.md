---
name: linkstats
description: LinkStats extracts and processes metadata from barcoded genomic reads to evaluate linked-read library quality and molecule metrics. Use when user asks to evaluate linked-read libraries, determine molecule length distributions, or visualize coverage gaps from alignment data.
homepage: https://github.com/wtsi-hpag/LinkStats
metadata:
  docker_image: "quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6"
---

# linkstats

## Overview
LinkStats is a specialized bioinformatics utility designed to extract and process metadata from barcoded genomic reads. It bridges the gap between raw alignments and high-level library metrics by identifying "molecules" based on shared barcodes and genomic proximity. Use this skill to evaluate the quality of linked-read libraries, determine molecule length distributions (N50/auN), and visualize coverage gaps through generated CSV reports and graphical plots.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::linkstats
```

## Core CLI Usage
The primary command is `LinkStats`. A typical workflow involves reading alignment data and simultaneously generating CSV reports and plots.

### Basic Command Pattern
```bash
LinkStats sam-data input.bam --save-csvs output/csv_prefix --save-plots output/plot_prefix
```

### Input Requirements
- **Format**: SAM, BAM, or CRAM.
- **Sorting**: Files must be coordinate-sorted.
- **Tags**: Requires `BX:Z:` tags for barcodes.
- **Optional Tags**: `MI:i` tags can be used for additional grouping; `SM:Z:` or `RG:Z:` tags are used for sample naming.

## Pipeline Stages
LinkStats operates in a three-stage internal pipeline:
1. **Compilation**: Reads alignment sources and compiles linked-read data into summary, molecule, and coverage datasets.
2. **Processing**: Transforms the compiled data into histograms.
3. **Visualization**: Generates PDF/CDF plots for molecule lengths and coverage gaps.

## Expert Tips & Best Practices
- **Sample Identification**: If your alignment file lacks `SM` tags, check the command-line help (`LinkStats --help`) for options to manually set the sample name to ensure reports are labeled correctly.
- **Performance**: For large CRAM files, ensure your environment has `htslib >= 1.12` to handle efficient data streaming and decompression.
- **Interpreting Results**:
    - **N50 Molecule Length**: This is a critical metric for linked-read libraries; higher values generally indicate better long-range information for scaffolding or phasing.
    - **Reads Per Molecule**: Use the summary CSV to check the `Mean Reads Per Molecule`. A very low number may suggest low sequencing depth or high barcode collision rates.
    - **Coverage Gaps**: Analyze the `Coverage Gap Data` to identify regions where physical coverage is interrupted, which can impact the success of de novo assembly.
- **Data Extraction**: If you only need the raw data without plots, you can omit the `--save-plots` flag to save processing time and dependencies.

## Reference documentation
- [LinkStats Wiki](./references/github_com_wtsi-hpag_LinkStats_wiki.md)
- [LinkStats GitHub Overview](./references/github_com_wtsi-hpag_LinkStats.md)