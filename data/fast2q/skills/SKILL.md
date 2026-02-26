---
name: fast2q
description: 2FAST2Q is a high-performance sequence counting tool that maps FASTQ reads to a reference library or extracts novel sequences between known adapters. Use when user asks to count sgRNA occurrences in CRISPRi-Seq data, extract barcodes flanked by adapter sequences, or perform quality-filtered sequence mapping.
homepage: https://github.com/afombravo/2FAST2Q
---


# fast2q

## Overview

2FAST2Q is a high-performance sequence counting tool designed for functional genomics workflows. It maps reads from FASTQ files to a reference library (Counter mode) or identifies novel sequences located between known adapter sequences (Extractor + Counter mode). It is specifically optimized for CRISPRi-Seq, allowing for multiple feature extractions per read, mismatch tolerance, and strict Phred-score quality filtering to ensure data integrity in screening experiments.

## Installation and Setup

Install 2FAST2Q via Bioconda or PyPI:

```bash
# Via Conda
conda install bioconda::fast2q

# Via pip
pip install fast2q
```

Verify the installation using the built-in test suite:
`2fast2q -c -t`

## Common CLI Patterns

### 1. Standard Counter Mode (CRISPRi-Seq)
Use this mode when you have a known library of sequences (e.g., sgRNAs) and want to count their occurrences in your sequencing data.

```bash
2fast2q -c --s /path/to/fastq_folder --g library.csv --o ./output_dir --m 1 --ph 30
```
*   `--s`: Directory containing `.fastq` or `.fastq.gz` files.
*   `--g`: CSV file containing feature names and sequences.
*   `--m`: Number of allowed mismatches (default is 1).
*   `--ph`: Minimum Phred-score (default is 30).

### 2. Extractor + Counter Mode (De Novo Discovery)
Use this mode to extract and count unknown sequences (like barcodes) that are flanked by known upstream and downstream sequences.

```bash
2fast2q -c --mo EC --us GTTTG --ds GTTT --l 20 --o ./output_dir
```
*   `--mo EC`: Sets mode to Extractor + Counter.
*   `--us`: Upstream search sequence.
*   `--ds`: Downstream search sequence.
*   `--l`: Expected length of the feature to extract.

### 3. Fixed Position Extraction
If features are always at a specific coordinate in the read, use the start position and length flags.

```bash
2fast2q -c --st 0 --l 20 --s ./data --g library.csv
```
*   `--st`: Start position (0-indexed).
*   `--l`: Length of the sequence to extract.

## Feature File Configuration

The features CSV (`--g`) should follow this format:
*   **Column 1**: Feature Name (e.g., sgRNA_001)
*   **Column 2**: Nucleotide Sequence

**Advanced: Multiple Features per Read**
To search for multiple sequences within a single read (e.g., dual-guide systems), separate the sequences with a colon in the CSV:
`sgRNA_dual_01,AATAGCATAGAAATCATACA:GATTACA`

## Performance Optimization

*   **CPU Allocation**: By default, the tool uses `max(cpu)-2`. Manually override this with `--cp X`.
*   **Large Files**: Use `--fs` (File Split mode) when processing very large FASTQ files to enable multiprocessing within a single file.
*   **Memory Management**: If processing many small files, keep `--fs` disabled to process multiple files in parallel instead.

## Expert Tips

*   **Phred-Score Filtering**: 2FAST2Q uses Sanger ASCII 33. If your data has lower quality but you want to retain more reads, consider lowering `--ph` to 20, though 30 is recommended for CRISPRi.
*   **Mismatch Handling**: In `EC` mode, the `--m` parameter is ignored because the tool returns all unique sequences found between the delimiters.
*   **Output**: The tool generates a "compiled" file by default. Use `--fn my_experiment_counts` to give the output a specific prefix.

## Reference documentation
- [Welcome to 2FAST2Q](./references/github_com_afombravo_2FAST2Q.md)
- [fast2q - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fast2q_overview.md)