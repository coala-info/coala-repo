---
name: mosaicatcher
description: Mosaicatcher processes single-cell Strand-seq data to count reads in genomic bins and classify chromosomal strand states. Use when user asks to count reads in fixed or predefined bins, classify strand states using Hidden Markov Models, or simulate binned Strand-seq counts.
homepage: https://github.com/friendsofstrandseq/mosaicatcher/
---


# mosaicatcher

## Overview

Mosaicatcher is a computational tool designed for the processing of single-cell Strand-seq sequencing data. It performs two primary functions: counting reads within genomic bins and classifying the strand state (e.g., Watson-Watson, Watson-Crick, or Crick-Crick) of each chromosome in every cell. By utilizing a Hidden Markov Model, it provides a robust framework for interpreting the directional information inherent in Strand-seq, which is essential for downstream structural variant discovery and genomic assembly.

## Installation and Setup

The most efficient way to install mosaicatcher is via Bioconda:

```bash
conda install -c bioconda mosaicatcher
```

If building from source, ensure you have `boost >= 1.50` and `HTSlib >= 1.3.1` installed.

## Data Input Requirements

Before running mosaicatcher, ensure your input data meets these criteria:
- **Format**: One BAM file per single cell.
- **Metadata**: Each BAM must contain a single read group (`@RG`).
- **Grouping**: Cells are grouped into samples using the `SM` tag within the BAM header.
- **Preparation**: BAM files must be coordinate-sorted and indexed (`.bai`).

## Common CLI Patterns

### 1. Counting Reads with Fixed-Width Bins
Use the `count` command with the `-w` flag to define a fixed bin size (e.g., 200kb).

```bash
mosaic count \
    -o counts.txt.gz \
    -i counts.info \
    -x references/exclude_list.exclude \
    -w 200000 \
    cell1.bam cell2.bam cell3.bam
```

### 2. Counting Reads with Predefined Bins
If you have specific genomic windows (e.g., based on mappability or GC content), use the `-b` flag.

```bash
mosaic count \
    -o counts.txt.gz \
    -i counts.info \
    -b predefined_bins.bed \
    cell*.bam
```

### 3. Generating Quality Control Plots
After counting, use the provided R script to visualize the data and assess library quality.

```bash
Rscript R/qc.R counts.txt.gz counts.info counts_qc.pdf
```

### 4. Simulating Strand-seq Data
To test pipelines or validate SV callers, you can simulate binned counts based on a configuration file.

```bash
mosaic simulate \
    -o simulated_counts.txt.gz \
    sv_config.txt
```

## Expert Tips and Best Practices

- **Exclusion Lists**: Always provide an exclusion file (`-x`) to mask centromeres, assembly gaps, or problematic regions (e.g., "decoy" sequences in GRCh38) to prevent HMM artifacts.
- **Bin Selection**: For standard human Strand-seq libraries, 100kb to 200kb bins are typically recommended. Smaller bins may be used for higher coverage data but can increase noise in strand state classification.
- **Version Compatibility**: For optimal integration with the larger Strand-seq SV calling pipeline (v1.0), use version `0.3.1-dev`.
- **Memory Management**: When processing hundreds of cells simultaneously, ensure your system has sufficient file descriptors open, as mosaicatcher reads multiple BAM files in parallel.

## Reference documentation

- [Bioconda mosaicatcher Overview](./references/anaconda_org_channels_bioconda_packages_mosaicatcher_overview.md)
- [Mosaicatcher GitHub Repository](./references/github_com_friendsofstrandseq_mosaicatcher.md)