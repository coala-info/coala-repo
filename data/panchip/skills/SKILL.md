---
name: panchip
description: PanChIP identifies protein colocalization by comparing experimental peak sets against a large library of ChIP-seq data for the hg38 genome assembly. Use when user asks to initialize the reference library, perform multi-threaded colocalization analysis, or filter BED6 files for quality control.
homepage: https://github.com/hanjunlee21/PanChIP
---

# panchip

## Overview
PanChIP (Pan-ChIP-seq Analysis of Peak Sets) is a specialized tool for identifying protein colocalization by comparing experimental peak sets against a large library of ChIP-seq data. It currently supports the hg38 genome assembly. Use this skill to manage the workflow of library initialization, multi-threaded colocalization analysis, and quality control filtering of BED6 files.

## Core Commands and Usage

### 1. Library Initialization
Before running any analysis, you must initialize the reference library. This is a one-time setup that downloads and prepares the necessary genomic data.
- **Command**: `panchip init <library_directory>`
- **Requirement**: Ensure the target system has at least 14 GB of available storage.

### 2. Colocalization Analysis
Run this command to compare your peak sets against the initialized library to find colocalized proteins.
- **Command**: `panchip analysis [options] <library_directory> <input_directory> <output_directory>`
- **Input**: The `input_directory` must contain only 6-column BED files (.bed6).
- **Options**:
  - `-t <int>`: Set the number of threads for parallel processing (default: 1).
  - `-r <int>`: Set the number of repeats to perform (default: 1).

### 3. Quality Control Filtering
Use the filter command to process specific peak sets for quality control within the context of the PanChIP library.
- **Command**: `panchip filter [options] <library_directory> <input_file> <output_directory>`
- **Input**: A single 6-column BED file.

## Expert Tips and Best Practices

### BED File Requirements
- **Strict BED6 Format**: Ensure all input files are in 6-column BED format.
- **Score Column Optimization**: It is highly recommended to use constant non-zero values in the 5th column (the score column) of your BED files (e.g., setting all scores to 1, 500, or 1000).
- **Genome Version**: Verify that all input peaks are mapped to the **hg38** assembly.

### Performance and Environment
- **Parallelization**: Always use the `-t` flag to match the available CPU cores on your machine, as ChIP-seq library comparisons are computationally intensive.
- **Input Directory Hygiene**: When running `analysis`, ensure the `input_directory` does not contain hidden files, READMEs, or non-BED files, as the tool expects a clean directory of peak sets.
- **Dependencies**: Ensure `BEDTools` is installed and available in your system PATH, as PanChIP relies on it for genomic interval operations.



## Subcommands

| Command | Description |
|---------|-------------|
| panchip analysis | Analysis of a list peak sets |
| panchip filter | Filtering library for quality control |
| panchip init | Initialization of the PanChIP library |

## Reference documentation
- [PanChIP README](./references/github_com_hanjunlee21_PanChIP_blob_main_README.md)