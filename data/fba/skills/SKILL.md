---
name: fba
description: The fba toolbox processes raw sequencing reads from feature barcoding experiments to generate cell-by-feature UMI count matrices. Use when user asks to extract barcodes, map targeted transcripts, quantify UMI counts, or demultiplex single-cell feature data.
homepage: https://github.com/jlduan/fba
---


# fba

## Overview

The `fba` (Feature Barcoding Analysis) toolbox is a specialized suite of command-line utilities designed to process raw sequencing reads from single-cell experiments that utilize feature barcoding. It provides a streamlined workflow to transform paired-end FASTQ files into a cell-by-feature UMI count matrix. Use this skill to navigate the multi-step process of barcode extraction, targeted transcript mapping, UMI deduplication, and cell demultiplexing. It is particularly effective for customized feature specifications that standard pipelines might not support.

## Core Command Patterns

The `fba` workflow typically follows a sequential order: `extract` (or `map`) -> `filter` -> `count` -> `demultiplex`.

### 1. Barcode Extraction
Use `extract` to pull cell partitioning and feature information from FASTQ files.
- **Standard Pattern**: `fba extract -1 <read1.fastq.gz> -2 <read2.fastq.gz> -cb_pos <start-end> -umi_pos <start-end> -fb_config <features.csv>`
- **Tip**: Read 1 typically contains the Cell Barcode (CB) and UMI, while Read 2 contains the feature information.

### 2. Targeted Mapping
For enriched transcripts (e.g., targeted gene panels), use `map` instead of `extract`.
- **Mechanism**: Uses BWA or Bowtie2 for alignment of Read 2 and UMI-tools for deduplication.
- **Usage**: `fba map -1 <read1.fastq.gz> -2 <read2.fastq.gz> -r <reference.fa>`

### 3. Quantification
The `count` command generates the UMI matrix.
- **Input**: Takes the output from `extract` or `filter`.
- **Usage**: `fba count -i <extracted_barcodes.tsv.gz> -o <matrix_output_dir>`

### 4. Demultiplexing
Assign cells to specific features based on abundance.
- **Usage**: `fba demultiplex -i <matrix.mtx> -o <demux_results.csv>`
- **Best Practice**: Review the distribution of feature counts before setting thresholds for demultiplexing to avoid high doublet rates or false negatives.

## Quality Control and Troubleshooting

- **Diagnostic Check**: Run `fba qc` early in the process. If `-1` is omitted, it runs in "bulk mode," analyzing only Read 2 to verify feature barcode quality without cell-level partitioning.
- **Parameter Customization**: `fba` allows high flexibility in specifying barcode positions and lengths. Always verify the library construction (e.g., 10x Genomics v2 vs v3) to ensure `-cb_pos` and `-umi_pos` are accurate.
- **Filtering**: Use `fba filter` to refine results by applying specific sequence filters (`-cb_seq` or `-fb_seq`) if you encounter high background noise or contamination.

## Reference documentation

- [fba GitHub Repository](./references/github_com_jlduan_fba.md)
- [fba Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fba_overview.md)