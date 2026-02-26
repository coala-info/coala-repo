---
name: codoff
description: "codoff measures the irregularity of codon usage in a specific genomic region compared to its host genome using Monte Carlo simulations. Use when user asks to quantify codon usage discordance, identify potential horizontal gene transfer, or compare a focal genomic region against a host genome's background distribution."
homepage: https://github.com/Kalan-Lab/codoff
---


# codoff

## Overview

`codoff` is a specialized bioinformatics tool designed to measure the irregularity of codon usage in a focal genomic region relative to its host genome. By employing a Monte Carlo simulation with sequential contiguous-window sampling, it compares the focal region against randomly positioned genomic windows of the same size. The primary output is a discordance percentile, which quantifies how unusual the region's codon usage is, helping researchers distinguish between native genes and those potentially acquired through horizontal gene transfer or subject to unique selective pressures.

## Installation

The recommended way to install `codoff` is via Bioconda:

```bash
conda create -n codoff_env -c conda-forge -c bioconda codoff
conda activate codoff_env
```

Alternatively, it can be installed via pip for Python 3.10+:

```bash
pip install codoff
```

## Common CLI Patterns

### 1. Using GenBank Files (Recommended)
This is the standard workflow for antiSMASH outputs or annotated genomes where CDS features are already defined.

```bash
codoff -f focal_region.gbk -g full_genome.gbk
```
*   `-f`: The focal region GenBank file (can be multiple files if the region is split across scaffolds).
*   `-g`: The full genome GenBank file.

### 2. Using FASTA and Coordinates
Use this pattern for unannotated genomes or when you only have coordinates. `codoff` will use `pyrodigal` for automated gene calling.

```bash
codoff -s scaffold_name -a 1380553 -b 1432929 -g genome.fasta -p distribution_plot.svg
```
*   `-s`: The specific scaffold/sequence ID.
*   `-a`: Start coordinate.
*   `-b`: End coordinate.
*   `-p`: Generates a SVG plot showing the simulated distribution vs. the focal region's distance.

### 3. Adjusting Simulation Depth
For higher statistical confidence or faster exploratory runs, adjust the number of Monte Carlo simulations.

```bash
codoff -f region.gbk -g genome.gbk --num-sims 5000
```
*   `--num-sims`: Default is 10,000. Increase for publication-quality statistics; decrease for rapid screening.

## Expert Tips and Best Practices

*   **Handling Fragmentation**: If a biosynthetic gene cluster (BGC) is split across multiple scaffolds due to assembly fragmentation, provide all relevant GenBank files to the `-f` argument to ensure the codon frequency distribution is calculated across the entire cluster.
*   **Interpreting Results**: A high discordance percentile (e.g., >95th or 99th) suggests the region is highly unusual. However, this does not strictly prove HGT; it can also indicate highly-conditional expression or recent evolutionary divergence.
*   **Input Validation**: Ensure GenBank files contain valid CDS features. `codoff` automatically filters out genes with lengths not divisible by 3 or those with "fuzzy" boundaries (e.g., `<1..500`).
*   **Performance**: For large-scale comparative genomics, use the sequential contiguous-window sampling (default in v1.2.3+) as it provides a more biologically realistic null model than random gene shuffling.

## Reference documentation

- [Main Repository and Usage Guide](./references/github_com_Kalan-Lab_codoff.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_codoff_overview.md)
- [Advanced Wiki and Python API](./references/github_com_Kalan-Lab_codoff_wiki.md)