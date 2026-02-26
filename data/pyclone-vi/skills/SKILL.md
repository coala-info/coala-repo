---
name: pyclone-vi
description: PyClone-VI is a high-performance tool for inferring the clonal architecture of tumors by clustering mutations and estimating their cellular prevalence. Use when user asks to infer clonal populations, cluster mutations, or estimate cellular prevalence while accounting for tumor purity and copy number variations.
homepage: https://github.com/Roth-Lab/pyclone-vi
---


# pyclone-vi

## Overview
PyClone-VI is a high-performance tool for inferring the clonal architecture of tumors. It groups mutations into clusters (clones) and estimates their cellular prevalence while accounting for tumor purity and local copy number variations. It is significantly faster than the original PyClone, making it suitable for large-scale whole-genome sequencing datasets. The workflow typically involves fitting a variational inference model to mutation count data and then post-processing the best fit to generate a human-readable summary of clonal assignments.

## Installation and Setup
The tool is best managed via Conda:
```bash
conda create --name pyclone-vi -c bioconda pyclone-vi
conda activate pyclone-vi
```

## Input Data Preparation
Input files must be tab-delimited (.tsv) with the following mandatory columns:
- **mutation_id**: Unique string for the mutation (must be consistent across samples).
- **sample_id**: Unique identifier for the tumor sample.
- **ref_counts**: Number of reads supporting the reference allele.
- **alt_counts**: Number of reads supporting the alternate allele.
- **major_cn**: Major copy number of the segment containing the mutation.
- **minor_cn**: Minor copy number of the segment containing the mutation.
- **normal_cn**: Total copy number in healthy tissue (2 for autosomes, 1 for male sex chromosomes).

**Optional Columns:**
- **tumour_content**: Cellularity/purity of the sample (default: 1.0).
- **error_rate**: Sequencing error rate (default: 0.001).

## Core Workflow

### 1. Model Fitting
Use the `fit` command to perform inference. This generates an HDF5 file containing the model parameters.
```bash
pyclone-vi fit -i input.tsv -o model_output.h5 -c 40 -d beta-binomial -r 10
```
**Key Parameters:**
- `-c, --num-clusters`: Set higher than the expected number of clones (e.g., 10-40). The model will automatically prune unused clusters.
- `-d, --density`: Use `beta-binomial` for over-dispersed sequencing data or `binomial` for standard data.
- `-r, --num-restarts`: Number of random restarts (10-100). More restarts increase the chance of finding the global optimum.
- `-g, --num-grid-points`: Default is 100. Increase for very deeply sequenced data to improve posterior approximation.

### 2. Exporting Results
Extract the best solution from the HDF5 file into a TSV format:
```bash
pyclone-vi write-results-file -i model_output.h5 -o final_results.tsv
```

## Expert Tips and Best Practices
- **Handling Missing Data**: PyClone-VI removes mutations that do not have entries for all samples. If a mutation is not detected in a sample, do not leave it out; instead, extract the reference and alternate counts from the BAM file for that position to provide a complete multi-sample profile.
- **Cluster Selection**: If the output contains too few clusters or seems under-fitted, increase the `-c` (clusters) and `-r` (restarts) parameters.
- **Confidence Filtering**: Use the `cluster_assignment_prob` column in the output to filter out mutations with low posterior probability (e.g., < 0.9) to ensure high-confidence clonal assignments.
- **CCF Interpretation**: The `cellular_prevalence` column represents the Cancer Cell Fraction (CCF). A value near 1.0 across all samples typically indicates a truncal (founder) mutation.

## Reference documentation
- [PyClone-VI GitHub Repository](./references/github_com_Roth-Lab_pyclone-vi.md)
- [PyClone-VI Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyclone-vi_overview.md)