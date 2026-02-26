---
name: jass
description: JASS performs joint analysis of GWAS summary statistics to identify genetic variants associated with multiple traits simultaneously. Use when user asks to compute multi-trait GWAS, handle trait correlations in overlapping samples, or format summary statistics into HDF5 data structures for joint testing.
homepage: http://statistical-genetics.pages.pasteur.fr/jass/
---


# jass

## Overview
JASS is a specialized tool designed for the joint analysis of GWAS summary statistics. It allows researchers to identify genetic variants associated with multiple traits simultaneously, increasing statistical power over single-trait analyses. The tool handles the correlation between traits (even with overlapping samples) and provides a suite of multi-trait tests. It primarily operates on HDF5 data structures to efficiently manage the high-dimensional data typical of modern biobanks.

## Core Workflow

### 1. Data Preparation
Before running joint tests, input data must be formatted into a JASS-compatible HDFStore.
- **Input Format**: Ensure summary statistics include SNP ID, effect size (beta/OR), and standard error.
- **Initialization**: Use the `jass inittable` command to create the master HDF5 file from flat files.
- **Imputation**: If summary statistics are missing for some SNPs across certain traits, use the imputation module to prevent data loss during joint testing.

### 2. Computing Multi-trait GWAS
The primary command for analysis is `jass compute`.
- **Omnibus Test**: The default approach for detecting any association across the set of traits.
- **Trait Selection**: You can specify subsets of traits within the HDFStore to test specific biological hypotheses.
- **Correlation Matrix**: JASS automatically estimates the phenotypic correlation between traits using genome-wide summary statistics, which is crucial for valid p-values in overlapping samples.

### 3. Accessing Results
Results are stored back into the HDFStore.
- Use the `jass` CLI to export specific regions or significant hits to CSV/TSV for downstream visualization (e.g., Manhattan plots).
- Components of the HDFStore (like the correlation matrix or imputed statistics) can be accessed directly via Python using `pandas.HDFStore`.

## CLI Best Practices
- **Memory Management**: When working with whole-genome data, process by chromosome using the `--chrom` flag to keep memory usage within limits.
- **Reference Panels**: Ensure the reference panel used for imputation matches the ancestry of the GWAS discovery cohorts.
- **Log Files**: Always check the generated log files for "lambda" values (genomic inflation factors) to ensure the joint statistics are not systematically biased.

## Reference documentation
- [JASS Documentation Overview](./references/statistical-genetics_pages_pasteur_fr_jass.md)
- [Bioconda JASS Package Details](./references/anaconda_org_channels_bioconda_packages_jass_overview.md)