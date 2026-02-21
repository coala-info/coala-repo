---
name: sgdemux
description: sgdemux is a specialized utility designed for the high-performance demultiplexing of sequencing runs from the Singular Genomics G4 platform.
homepage: https://github.com/Singular-Genomics/singular-demux
---

# sgdemux

## Overview
sgdemux is a specialized utility designed for the high-performance demultiplexing of sequencing runs from the Singular Genomics G4 platform. It processes block-compressed FASTQ files (BGZF) and assigns reads to samples based on user-defined barcode metadata and read structures. The tool is particularly useful for handling complex indexing strategies, including dual-indexing and UMIs, while providing detailed metrics on matching efficiency and barcode hopping.

## Installation
The recommended way to install sgdemux is via Bioconda:
```bash
conda install -c bioconda sgdemux
```

## Core Command Pattern
A standard demultiplexing command requires the input FASTQs, their corresponding read structures, a sample metadata file, and an output directory.

```bash
sgdemux \
  --fastqs R1.fastq.gz R2.fastq.gz I1.fastq.gz I2.fastq.gz \
  --read-structures +T +T 8B 8B \
  --sample-metadata samples.csv \
  --output-dir ./demux_results/
```

## Read Structure Syntax
The `--read-structures` argument defines how to interpret each input FASTQ file. One structure must be provided for every file listed in `--fastqs`.

- **T (Template)**: Genomic DNA or cDNA sequence.
- **B (Barcode)**: Sample index sequence used for demultiplexing.
- **U (UMI)**: Unique Molecular Identifier.
- **S (Skip)**: Bases to be ignored.
- **+ (Rest of read)**: Used as a prefix (e.g., `+T` means the entire read is template).
- **Fixed Length**: A number preceding the letter (e.g., `8B` means the first 8 bases are the barcode).

## Sample Metadata
The `--sample-metadata` file is typically a CSV. While a simple two-column format (sample name and barcode) is supported, the tool often expects specific headers:
- `sample_id`: The unique name for the sample.
- `barcode_sequence`: The expected index sequence (use `+` to separate dual indices, e.g., `ATGC+CGTA`).

## Expert Tips and Best Practices

### 1. Input Requirements
- **BGZF Compression Only**: Input FASTQs must be block-compressed (e.g., via `bgzip`). Standard Gzip or uncompressed files are not supported because the tool relies on BGZF for parallel processing performance.

### 2. Tuning Assignment Logic
The tool uses two primary parameters to decide if a read belongs to a sample:
- `--allowed-mismatches`: (Default: 1) Maximum number of mismatches allowed across all barcode segments.
- `--min-delta`: (Default: 2) The difference in mismatches between the best match and the second-best match. If the best match has 1 mismatch and the second-best has 2, the delta is 1. With a default `--min-delta 2`, this read would be marked "Undetermined" to prevent misassignment.

### 3. Quality Control and Masking
- **Quality Masking**: Use `--quality-mask-threshold <INT>` to convert bases with low quality scores to `N` before matching.
- **Filtering**: Use `--filter-control-reads` and `--filter-failing-quality` to automatically discard reads flagged in the FASTQ headers as controls or QC failures.

### 4. Output Analysis
After a run, check the following files in the output directory for troubleshooting:
- `metrics.tsv`: High-level summary of the demultiplexing run.
- `most_frequent_unmatched.tsv`: Identifies common barcodes that weren't in your sample sheet, useful for detecting sample sheet errors or adapter issues.
- `sample_barcode_hop_metrics.tsv`: Essential for dual-indexed runs to quantify index swapping.

## Reference documentation
- [Singular Genomics Demultiplexing Tool](./references/github_com_Singular-Genomics_singular-demux.md)
- [sgdemux Bioconda Package](./references/anaconda_org_channels_bioconda_packages_sgdemux_overview.md)