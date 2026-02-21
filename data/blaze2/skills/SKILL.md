---
name: blaze2
description: BLAZE (Barcode identification from Long reads for AnalyZing single-cell gene Expression) is a specialized demultiplexing tool optimized for the high error rates associated with Nanopore long-read sequencing.
homepage: https://github.com/shimlab/BLAZE
---

# blaze2

## Overview

BLAZE (Barcode identification from Long reads for AnalyZing single-cell gene Expression) is a specialized demultiplexing tool optimized for the high error rates associated with Nanopore long-read sequencing. It functions by locating the 10X adapter and polyT sequences within reads to accurately extract and error-correct cell barcodes (CB) and Unique Molecular Identifiers (UMI). This tool is a critical precursor for isoform-level single-cell analysis, transforming raw long-read data into tagged, demultiplexed FASTQ files.

## Installation

Install BLAZE via bioconda or pip:

```bash
# Using Conda
conda install bioconda::blaze2

# Using pip
pip3 install blaze2
```

## Core Command Line Usage

The primary command for running the full BLAZE pipeline is `blaze`.

### Basic Execution
You must provide the expected number of cells and the input FASTQ file(s).

```bash
blaze --expect-cells 1000 --output-prefix my_sample input.fastq
```

### Common Parameters
- `--expect-cells <int>`: (Required) A rough estimate of the number of cells. The tool is robust to this number, but it is used to determine count thresholds.
- `--threads <int>`: Number of threads to use for processing.
- `--output-prefix <string>`: Prefix for all output files.
- `--kit-version <version>`: Specify the 10X chemistry. 
    - Options: `3v4`, `3v3` (default), `3v2`, `3v1` (for 3' kits) or `5v3`, `5v2` (for 5' kits).
- `--full-white-list <file>`: Path to a custom barcode whitelist if not using standard 10X chemistry.

## Expert Tips and Best Practices

### Downstream Integration
BLAZE v2.5+ outputs demultiplexed FASTQ files with `CB:Z:` and `UB:Z:` tags in the read headers. To preserve these tags during alignment with `minimap2`, always use the `-y` flag:
```bash
minimap2 -ax splice -y ref.fa demultiplexed.fastq > aligned.sam
```

### Handling Strands
By default (v2.5+), BLAZE restrands the final demultiplexed reads into the transcript strand. If your downstream workflow requires the original sequenced strand, use the `--no-restrand` flag.

### Output Interpretation
- **putative_bc.csv**: Contains raw, non-error-corrected barcodes and UMIs. Useful for troubleshooting if cell counts are lower than expected.
- **Demultiplexed FASTQ**: The primary output for downstream analysis. Read names follow the format: `@{barcode}_{UMI}_{original_id}_{strand} CB:Z:{barcode} UB:Z:{UMI}`.

### Performance Optimization
BLAZE v2.0+ is significantly faster than previous versions. For large datasets, ensure you allocate sufficient threads (`--threads`) as the barcode-to-whitelist assignment step is computationally intensive.

## Reference documentation
- [blaze2 bioconda overview](./references/anaconda_org_channels_bioconda_packages_blaze2_overview.md)
- [BLAZE GitHub README](./references/github_com_shimlab_BLAZE.md)