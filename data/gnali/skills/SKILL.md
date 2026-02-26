---
name: gnali
description: gNALI identifies and filters high-confidence loss-of-function variants to help researchers find potentially nonessential genes in humans. Use when user asks to identify nonessential genes, filter high-confidence loss-of-function variants, or analyze gene lists using gnomAD or custom variation data.
homepage: https://github.com/phac-nml/gnali
---


# gnali

## Overview

gNALI (gene Nonessentiality And Loss-of-function Identifier) is a bioinformatics tool used to find and filter high-confidence loss-of-function variants. It helps researchers identify genes that may be nonessential in humans by analyzing variation data from large-scale databases. The tool provides built-in support for gnomAD datasets and can be extended to work with custom VCF files.

## Installation and Setup

The recommended way to install gnali is via Conda:

```bash
conda install bioconda::gnali
```

### Reference Data Management

Before running analysis on custom databases without existing LoF annotations, you must download the necessary reference files.

- **For gnomAD v2/v3**: No extra data download is required.
- **For custom databases with LoF annotations**: No extra data download is required.
- **For custom databases WITHOUT LoF annotations**: Run the data acquisition tool for your specific genome build:
  - GRCh37: `gnali_get_data grch37`
  - GRCh38: `gnali_get_data grch38`

*Note: These downloads require approximately 35GB of disk space.*

## Usage Patterns

### Input Format
Input files must be `.csv`, `.txt`, or `.tsv`. They should contain a list of HGNC gene symbols, one per line, with no blank lines.

Example `genes.txt`:
```text
CCR5
ALCAM
```

### Basic Execution
Run a standard analysis by providing an input file and an optional output directory:

```bash
gnali -i my_genes.txt -o my_results
```

### Population Frequency Analysis
To include population-specific metrics (Allele Count, Allele Number, and Allele Frequency), use the population frequency flag:

```bash
gnali -i my_genes.txt -o my_results -P
```

## Output Files
gNALI generates a results folder (defaulting to `results-<unique_id>`) containing two primary files:
1. **Basic Output**: Lists genes from the input that contain high-confidence PLoF variants passing all filters.
2. **Detailed Output**: Provides comprehensive variant-level information, including transcript-level details and specific annotations.

## Expert Tips
- **Genome Build Consistency**: Always ensure your input gene list and the database being queried (gnomAD v2 vs v3) correspond to the correct genome build (GRCh37 vs GRCh38), as LoF status is highly sensitive to the reference assembly.
- **Testing**: If you are setting up a new environment, run `gnali_get_data test` to install minimal files required for verifying the installation.
- **Memory Requirements**: While the tool can run on 16GB of RAM, processing large gene lists against custom VCFs may benefit from higher memory allocations during the annotation phase.

## Reference documentation
- [gnali - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gnali_overview.md)
- [GitHub - phac-nml/gnali: gene Nonessentiality And Loss-of-function Identifier](./references/github_com_phac-nml_gnali.md)