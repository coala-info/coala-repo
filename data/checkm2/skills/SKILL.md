---
name: checkm2
description: CheckM2 uses machine learning models to predict the completeness and contamination of genomic bins across all taxonomic lineages. Use when user asks to assess genome quality, predict completeness and contamination of metagenomic bins, or download the CheckM2 database.
homepage: https://github.com/chklovski/CheckM2
---


# checkm2

## Overview
CheckM2 is a machine learning-based tool designed to predict the completeness and contamination of genomic bins. Unlike its predecessor, CheckM1, which relies on lineage-specific marker genes, CheckM2 uses universally trained models (Gradient Boost and Neural Networks) to provide accurate quality estimates across all taxonomic lineages. It is particularly effective for organisms with reduced genomes or those belonging to novel phyla where traditional marker gene sets may be lacking.

## Database Setup
CheckM2 requires an external DIAMOND database to function. This must be configured before running predictions.

- **Download the database**:
  ```bash
  checkm2 database --download
  ```
- **Specify a custom path**:
  ```bash
  checkm2 database --download --path /path/to/database/
  ```
- **Set environment variable**: To avoid specifying the path every time, set the `CHECKM2DB` variable in your shell profile:
  ```bash
  export CHECKM2DB="/path/to/database/CheckM2_database/uniref100.KO.1.dmnd"
  ```

## Common CLI Patterns

### Basic Prediction
Run quality assessment on a folder of FASTA files:
```bash
checkm2 predict --threads 30 --input <folder_with_bins> --output-directory <output_folder>
```

### Handling Specific File Types
- **Gzipped files**: If passing a directory containing `.gz` files, you must specify the extension:
  ```bash
  checkm2 predict --input <folder> --extension gz --output-directory <output_folder>
  ```
- **List of files**: CheckM2 can accept a space-separated list of files. In this mode, it automatically detects gzipped files:
  ```bash
  checkm2 predict --input bin1.fa bin2.fna.gz bin3.fasta --output-directory <output_folder>
  ```
- **Protein inputs**: If you have already predicted proteins (e.g., via Prodigal), use the `--genes` flag:
  ```bash
  checkm2 predict --genes --input <folder_with_faa_files> --output-directory <output_folder>
  ```

### Resource Management
- **Low Memory**: If running on a machine with limited RAM, use `--lowmem` to reduce DIAMOND's memory footprint by approximately 50% at the cost of speed:
  ```bash
  checkm2 predict --input <folder> --output-directory <output> --lowmem
  ```

## Expert Tips
- **Model Selection**: By default, CheckM2 uses cosine similarity to automatically choose between the 'general' (Gradient Boost) and 'specific' (Neural Network) models. You can force a specific model or output both using `--general`, `--specific`, or `--allmodels` if you suspect the automatic selection is not optimal for your specific dataset.
- **Verification**: Always run `checkm2 testrun` after a new installation or database update to ensure the machine learning models are producing expected values.
- **Output**: The primary result is `quality_report.tsv` in the output directory. Use the `--stdout` flag if you need to pipe results directly into another tool or script.

## Reference documentation
- [CheckM2 GitHub Repository](./references/github_com_chklovski_CheckM2.md)