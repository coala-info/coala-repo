---
name: artic
description: The `artic` tool is a specialized bioinformatics suite designed for the analysis of viral genomes sequenced using Oxford Nanopore Technologies (ONT).
homepage: https://github.com/artic-network/fieldbioinformatics
---

# artic

## Overview

The `artic` tool is a specialized bioinformatics suite designed for the analysis of viral genomes sequenced using Oxford Nanopore Technologies (ONT). It is optimized for data generated from tiling amplicon protocols, providing a standardized workflow to transform basecalled reads into high-quality consensus sequences and validated variant calls. It automates complex steps such as read length filtering, primer site stripping, and coverage normalization.

## Installation and Setup

The recommended way to install the ARTIC pipeline is via Conda:

```bash
conda install -c bioconda -c conda-forge artic
```

Ensure you have the necessary primer schemes downloaded. The pipeline expects a scheme directory containing the reference FASTA and the primer BED file.

## Common CLI Patterns

### 1. Read Filtering (guppyplex)
Before running the main pipeline, use `guppyplex` to filter reads by length (to remove fragments/chimeras) and quality.

```bash
artic guppyplex --min-length 400 --max-length 700 --directory <path_to_fastq> --prefix <sample_name>
```
*   **Tip**: Set the min/max length to approximately ±50-100bp of your expected amplicon size.

### 2. The Main Pipeline (minion)
The `minion` command is the primary entry point for Nanopore data. It handles alignment, signal-level or medaka-based polishing, and variant calling.

```bash
artic minion --medaka --optimised --threads 8 --scheme-directory ~/artic/schemes --read-file <filtered_fastq>.fastq <scheme_name> <sample_name>
```

*   **--medaka**: Uses Medaka for consensus correction (standard for newer ONT chemistry).
*   **--nanopolish**: Use this if you have raw fast5 signal data and wish to use signal-level polishing.
*   **--optimised**: Applies performance optimizations for the variant caller.

### 3. Handling Segmented Genomes
For viruses with segmented genomes or multi-reference schemes (like Mpox), ensure you are using version 1.6.0+ which supports reference selection.

## Expert Tips and Best Practices

*   **Scheme Matching**: The `<scheme_name>` must match the folder name in your `--scheme-directory`. Ensure the version (e.g., V3, V4.1) matches the physical primers used in the lab.
*   **Variant Callers**: Recent versions (1.8.x) have improved support for **Clair3**. If using Clair3, ensure the model matches your flowcell and basecalling kit.
*   **Primer Trimming**: The pipeline uses `align_trim` to remove primer sequences from the ends of reads. This is critical to prevent primer-derived sequences from being interpreted as biological variants.
*   **Normalisation**: The pipeline automatically performs amplicon coverage normalisation to speed up processing and reduce bias in high-coverage regions.
*   **Troubleshooting**: If the pipeline fails at the consensus stage, check the `make_depth_mask` output to see if low coverage in specific regions is preventing a complete sequence from being generated.

## Reference documentation
- [ARTIC Fieldbioinformatics GitHub](./references/github_com_artic-network_fieldbioinformatics.md)
- [ARTIC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_artic_overview.md)
- [ARTIC Version Tags and Release Notes](./references/github_com_artic-network_fieldbioinformatics_tags.md)