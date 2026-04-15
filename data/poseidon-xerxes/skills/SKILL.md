---
name: poseidon-xerxes
description: Poseidon-xerxes performs population genetic analyses and calculates f-statistics directly on standardized Poseidon aDNA packages. Use when user asks to calculate f3, f4, or D-statistics, estimate genetic drift, or list available groups and packages within a Poseidon environment.
homepage: https://poseidon-framework.github.io/#/
metadata:
  docker_image: "quay.io/biocontainers/poseidon-xerxes:1.0.1.1--hf48d1a7_0"
---

# poseidon-xerxes

## Overview

The `xerxes` tool is the primary analysis component of the Poseidon aDNA framework. It enables researchers to execute population genetic workflows directly on standardized Poseidon packages, eliminating the need for manual file format conversions (e.g., from EIGENSTRAT or PLINK). Use this skill to facilitate high-throughput analysis of genotype data, specifically for estimating genetic drift and population relationships through f-statistics.

## Usage Instructions

### Core Analysis with fstats
The `fstats` subcommand is the primary interface for population genetic calculations.

- **Define Statistics**: Use the `--stat` flag to specify the test. Supported formats include `f3(PopA, PopB; Outgroup)`, `f4(PopA, PopB; PopC, PopD)`, and `D(PopA, PopB; PopC, PopD)`.
- **Point to Data**: Use the `-d` (or `--baseDir`) flag to specify the directory containing your Poseidon packages. Xerxes will recursively search for valid packages.
- **Group Selection**: Use the `-g` (or `--groupSelection`) flag to define which individuals or groups from the `.janno` files should be included in the analysis.

### Data Inspection
Before running complex analyses, verify the available data within the Poseidon environment.

- **List Packages**: Run `xerxes list --packages` to see all valid Poseidon packages in the specified base directory.
- **List Groups**: Run `xerxes list --groups` to identify the population labels available for f-statistic calculations.

### Performance and Best Practices
- **Jackknife for Error Estimation**: Xerxes uses a block-jackknife procedure by default to estimate standard errors. Ensure your dataset has sufficient SNPs and chromosomal coverage for stable estimates.
- **Standardized Input**: Always ensure your input data contains the required `POSEIDON.yml`, `.geno`, `.snp`, and `.ind` (or `.fam`) files.
- **Output Handling**: Use the `-o` flag to specify an output file for results, which are typically generated in a tab-separated format suitable for downstream R or Python processing.

## Reference documentation

- [poseidon-xerxes - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_poseidon-xerxes_overview.md)
- [Poseidon-aDNA Framework](./references/www_poseidon-adna_org_index.md)