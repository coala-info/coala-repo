---
name: coast
description: The coast tool identifies and quantifies sequence conservation across diverse genomic datasets using the Conserved Oligonucleotide Alignment Strategy. Use when user asks to identify conserved genomic blocks, perform comparative genomics without traditional alignments, or quantify sequence conservation across multiple genomes.
homepage: https://gitlab.com/coast_tool/COAST
---


# coast

## Overview
The `coast` tool is a specialized utility for comparative genomics that implements the Conserved Oligonucleotide Alignment Strategy. It is designed to identify and quantify sequence conservation across diverse genomic datasets without requiring traditional multiple sequence alignments. This skill provides the necessary command-line patterns to execute genomic comparisons, manage input sequences, and interpret conservation metrics efficiently.

## Usage Guidelines

### Core Command Pattern
The basic execution of coast typically follows this structure:
```bash
coast [options] -i <input_sequences> -o <output_directory>
```

### Best Practices
- **Input Preparation**: Ensure input files are in standard FASTA format. For large-scale comparisons, grouping related genomes into single multi-FASTA files can improve processing efficiency.
- **Memory Management**: When dealing with high-coverage or very large genomes, monitor RAM usage. Use the `-t` or `--threads` flag to balance speed with available system resources.
- **K-mer Selection**: The sensitivity of the conservation detection is often tied to the oligonucleotide length. Use shorter lengths for divergent species and longer lengths for closely related strains.

### Common CLI Tasks
- **Basic Comparison**: Run a standard analysis with default parameters to identify conserved blocks.
- **Sensitivity Tuning**: Adjust the threshold parameters to filter out low-confidence alignments or to capture highly divergent conserved elements.
- **Output Analysis**: The tool generates tabular data and alignment scores. Focus on the `.score` or `.csv` outputs for downstream statistical analysis or visualization.

### Expert Tips
- **Parallelization**: Always specify the number of threads (`-t`) matching your CPU cores to significantly reduce computation time for large datasets.
- **Incremental Runs**: If the tool supports checkpointing or incremental updates, use them when adding new genomes to an existing comparison to avoid redundant calculations.
- **Filtering**: Use pre-processing tools to mask repetitive elements or low-complexity regions in your input genomes to reduce noise in the COAST scores.



## Subcommands

| Command | Description |
|---------|-------------|
| coast | A tool for searching, reporting, retrieving, and comparing data (COAST). |
| coast | COAST (Coastal Ocean Analysis and Statistics Tool) command-line interface for searching, reporting, retrieving, and comparing data. |

## Reference documentation
- [Anaconda Bioconda: Coast Overview](./references/anaconda_org_channels_bioconda_packages_coast_overview.md)