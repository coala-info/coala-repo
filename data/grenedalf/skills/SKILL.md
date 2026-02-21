---
name: grenedalf
description: grenedalf is a high-performance C++ toolkit designed for the statistical analysis of pooled sequencing data.
homepage: https://github.com/lczech/grenedalf
---

# grenedalf

## Overview

grenedalf is a high-performance C++ toolkit designed for the statistical analysis of pooled sequencing data. It serves as a modern, scalable alternative to older tools like PoPoolation and PoPoolation2. Use this skill to efficiently process large genomic datasets where individuals are sequenced in pools rather than individually, requiring specific statistical corrections for pool size and sequencing depth. It excels at calculating diversity metrics, allele frequencies, and population differentiation (Fst) across sliding windows or specific genomic sites.

## Command Line Interface

The general syntax for grenedalf is:
`grenedalf <command> [options]`

### Core Commands

- **`diversity`**: Calculates pool-corrected diversity measures including Theta Pi, Theta Watterson, and Tajima's D.
- **`fst`**: Computes pool-corrected Fst values to measure differentiation between populations.
- **`sync`**: Converts VCF or BAM files into the synchronized (sync) format, which lists base counts per sample at each genomic position.
- **`frequency`**: Generates tables of allele frequencies or raw base counts for total or per-sample data.
- **`simulate`**: Creates synthetic frequency data for testing and null-model generation.

### Common Workflow Patterns

#### 1. Calculating Diversity Statistics
To compute Tajima's D and Theta across the genome using a sliding window:
`grenedalf diversity --sync-path input.sync --window-width 1000 --window-stride 500 --pool-sizes 50`

#### 2. Estimating Fst between Pools
To compare two or more pools:
`grenedalf fst --sync-path input.sync --pool-sizes 50 50 --window-width 1000`

#### 3. Data Preparation (Sync Generation)
To create a sync file from a VCF (ensure the VCF contains AD or DP/count tags):
`grenedalf sync --vcf-path input.vcf --out-dir output_folder`

### Expert Tips and Best Practices

- **Pool Size Specification**: Always provide accurate `--pool-sizes`. If all pools have the same size, a single value suffices; otherwise, provide a list matching the order of samples in your input file.
- **Filtering**: Use `--filter-sample-min-count` and `--filter-sample-max-count` to remove low-confidence alleles or repetitive regions (ultra-high coverage) before calculating statistics.
- **Windowing**: For large genomes, use `--window-width` and `--window-stride` to perform sliding window analyses, which smooths local stochasticity in Pool-Seq data.
- **Performance**: grenedalf is multi-threaded. Use the `--threads` option to speed up calculations on large sync files.
- **Citations**: Use `grenedalf citation` to see the specific papers and methods implemented for the commands you are using.

## Reference documentation
- [Home · lczech/grenedalf Wiki](./references/github_com_lczech_grenedalf_wiki.md)
- [grenedalf - Toolkit for Population Genetic Statistics](./references/github_com_lczech_grenedalf.md)
- [grenedalf - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_grenedalf_overview.md)