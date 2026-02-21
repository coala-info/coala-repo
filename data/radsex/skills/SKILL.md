---
name: radsex
description: radsex is a specialized computational tool designed to identify sex-determination signals from RAD-Sequencing data.
homepage: https://github.com/RomainFeron/RadSex
---

# radsex

## Overview

radsex is a specialized computational tool designed to identify sex-determination signals from RAD-Sequencing data. It functions by analyzing the presence and depth of genomic markers across individuals to differentiate between heterogametic systems (like XX/XY or ZZ/ZW). The tool follows a modular workflow: first generating a comprehensive marker depth table from raw reads, and then performing statistical analyses to find markers significantly associated with a specific group. While optimized for sex-determination, it can be used to compare any two groups for a binary trait.

## Core Workflow

### 1. Data Preparation
Before using radsex, ensure you have:
- **Demultiplexed reads**: FastQ files named by individual (e.g., `indiv1.fq.gz`).
- **Popmap**: A tab-separated file with two columns: `Individual_ID` and `Group` (e.g., M/F or Case/Control).

### 2. Generate Marker Depths (process)
The first step creates a master table of all markers found in the dataset.
```bash
radsex process --input-dir ./reads --output-file markers_table.tsv --threads 16 --min-depth 1
```
*   **Expert Tip**: Always use `--min-depth 1` during the `process` stage. This preserves all data in the master table, allowing you to experiment with more stringent depth filters in downstream steps without re-processing the raw reads.

### 3. Analyze Marker Distribution (distrib)
Compute how markers are distributed between the two groups to visualize the sex-determination system.
```bash
radsex distrib --markers-table markers_table.tsv --output-file distribution.tsv --popmap popmap.tsv --min-depth 5 --groups M,F
```
*   **Note**: The `--groups` parameter must match the labels used in your popmap exactly.

### 4. Extract Significant Markers (signif)
Identify markers that are statistically associated with one sex.
```bash
radsex signif --markers-table markers_table.tsv --output-file sex_linked_markers.tsv --popmap popmap.tsv --min-depth 5 --groups M,F --output-fasta
```
*   **Expert Tip**: Use the `--output-fasta` flag to generate a FASTA file of the significant markers. This is essential if you plan to align these markers to a reference genome or perform BLAST searches.

## Best Practices and Tips

- **Memory Management**: The `process` command is the most resource-intensive. Ensure your system has sufficient RAM to hold the marker table structure, especially for large populations or high-coverage data.
- **Filtering Strategy**: If your results are noisy, increase the `--min-depth` parameter in the `distrib` or `signif` commands (e.g., to 5 or 10) to filter out sequencing errors or low-confidence markers.
- **Genome Alignment**: If a reference genome is available, use the `map` command (if available in your version) or align the FASTA output from `signif` using BWA or Bowtie2 to identify the genomic location of sex-determining regions.
- **Visualization**: The output files from `distrib` and `signif` are designed to be compatible with the `sgtr` R package for generating tile plots and Manhattan plots.

## Reference documentation
- [RADSex GitHub Repository](./references/github_com_SexGenomicsToolkit_radsex.md)
- [Bioconda radsex Overview](./references/anaconda_org_channels_bioconda_packages_radsex_overview.md)