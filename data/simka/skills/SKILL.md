---
name: simka
description: Simka is a de novo comparative metagenomics tool that computes ecological distances between multiple large NGS datasets using k-mer spectra. Use when user asks to compare metagenomic read sets without a reference genome, calculate ecological distance matrices like Bray-Curtis or Jaccard, or perform rapid k-mer subsampling with SimkaMin.
homepage: https://github.com/GATB/simka
---


# simka

## Overview

Simka is a de novo comparative metagenomics suite that enables the comparison of multiple metagenomic read sets by representing each dataset as a k-mer spectrum. It computes a wide range of classical ecological distances (such as Bray-Curtis, Jaccard, and Chord) between samples. The tool is particularly useful for analyzing large NGS datasets where reference genomes are unavailable. For users requiring faster results with significantly lower computational overhead, the suite includes **SimkaMin**, which utilizes k-mer subsampling to approximate distances with high accuracy.

## CLI Usage and Best Practices

### Input File Preparation
Simka requires a specific input file format (passed via `-in`) to define the datasets. Each line represents one dataset.

*   **Standard Syntax**: `ID: path/to/file.fastq`
*   **Paired-end Reads**: Use a semicolon to separate pairs: `ID: pair1.fastq ; pair2.fastq`
*   **Concatenating Split Files**: Use commas to list multiple files for a single ID: `ID: part1.fastq, part2.fastq`
*   **Complex Combination**: `ID: part1_R1.fq, part2_R1.fq ; part1_R2.fq, part2_R2.fq`

### Core Command Patterns

**Standard Analysis**
```bash
simka -in input.txt -out-tmp ./tmp -out ./results
```

**Resource-Frugal Analysis (SimkaMin)**
Use `simkaMin` for rapid approximations on large cohorts:
```bash
simkaMin -in input.txt -out ./results_min
```

### Expert Tips and Resource Management

*   **Mandatory Temporary Storage**: The `-out-tmp` option is required. Simka generates significant intermediate data. Always point this to your fastest available disk (e.g., local SSD) with ample free space.
*   **Incremental Updates**: If you expect to add more datasets to your project later, use the `-keep-tmp` flag. This allows Simka to reuse existing k-mer counts instead of recomputing the entire matrix from scratch.
*   **Read Sampling**: Use `-max-reads <N>` to limit the number of reads processed per dataset. This is useful for normalizing datasets of vastly different depths or for quick pilot runs. Note that when using paired-end syntax, `-max-reads` applies to the first N reads of *each* file in the pair.
*   **Memory Constraints**: Simka requires a minimum of 500 MB to run, but 2 GB+ is recommended for stability. The tool will issue a warning if available memory is below 2 GB.
*   **K-mer Size**: The default k-mer size is typically 21. For very low-complexity environments or specific sensitivity requirements, adjust this using the `-kmer-size` parameter (maximum value depends on the build, usually 31 or 63).

## Reference documentation
- [Simka Overview](./references/anaconda_org_channels_bioconda_packages_simka_overview.md)
- [Simka GitHub Repository and Manual](./references/github_com_GATB_simka.md)