---
name: regenie
description: REGENIE is a highly efficient tool designed for large-scale genetic association studies.
homepage: https://rgcgithub.github.io/regenie/
---

# regenie

## Overview
REGENIE is a highly efficient tool designed for large-scale genetic association studies. It operates in two distinct steps to account for population structure and relatedness without the computational burden of a traditional Genetic Relatedness Matrix (GRM). Step 1 fits a whole-genome regression model using a subset of markers to capture polygenic effects. Step 2 performs the actual association testing on a larger set of variants (e.g., imputed data), using the predictions from Step 1 as an offset. This skill provides the necessary command-line patterns and best practices to navigate these steps, optimize memory usage, and apply appropriate corrections for unbalanced binary traits.

## Core Workflow

### Step 1: Whole-Genome Regression
Fits the null model to capture polygenic effects. Use a subset of ~500k high-quality, LD-pruned SNPs.

```bash
regenie \
  --step 1 \
  --bed [genotype_prefix] \
  --phenoFile [phenotypes.txt] \
  --covarFile [covariates.txt] \
  --bsize 1000 \
  --lowmem \
  --lowmem-prefix tmp_rg \
  --out [output_prefix] \
  [--bt for binary traits]
```

### Step 2: Association Testing
Tests variants for association using the LOCO (Leave One Chromosome Out) predictions from Step 1.

```bash
regenie \
  --step 2 \
  --bgen [imputed_data.bgen] \
  --ref-first \
  --phenoFile [phenotypes.txt] \
  --covarFile [covariates.txt] \
  --pred [output_prefix]_pred.list \
  --bsize 400 \
  --firth --approx \
  --pThresh 0.01 \
  --out [test_results_prefix] \
  [--bt for binary traits]
```

## Expert Tips and Best Practices

### Data Preparation
- **SNP Selection for Step 1**: Use directly genotyped SNPs with MAC > 100. Avoid using >1M SNPs in Step 1 as it increases computational burden without significant gains.
- **Binary Traits**: Ensure binary traits are coded as 0=control, 1=case, NA=missing. Use `--1` if using 1/2/NA encoding.
- **Missing Data**: REGENIE handles missing phenotypes via mean-imputation in Step 1. For Step 2, samples with missing phenotypes are dropped for that specific trait.

### Performance Optimization
- **Memory Management**: Always use `--lowmem` in Step 1 for large cohorts to write temporary predictions to disk instead of keeping them in RAM.
- **Threading**: Use `--threads` to speed up execution. Step 2 is highly parallelizable across chromosomes.
- **BGEN Format**: For maximum speed in Step 2, use BGEN v1.2 with 8-bit encoding and provide a `.bgi` index file.

### Handling Unbalanced Binary Traits
- **Firth Correction**: Use `--firth --approx` to prevent inflated Type I error in rare variants when case-control ratios are imbalanced (e.g., < 1:10).
- **SPA Test**: Alternatively, use `--spa` for saddle point approximation, which is also robust for unbalanced traits.
- **P-value Thresholding**: Use `--pThresh` (e.g., 0.01) with Firth to only apply the correction to variants that meet a preliminary significance level, saving time.

### Gene-Based Testing
- **Masks**: Define variant sets using annotation files and mask definitions.
- **Tests**: Supports `--burden`, `--skat`, and `--acat` tests.
- **Parallelization**: When running gene-based tests, parallelize by genomic regions (groups of genes) rather than high thread counts per process (recommend max 2 threads for SKAT/ACAT).

## Reference documentation
- [REGENIE Options](./references/rgcgithub_github_io_regenie_options.md)
- [Installation and Requirements](./references/rgcgithub_github_io_regenie_install.md)
- [Frequently Asked Questions](./references/rgcgithub_github_io_regenie_faq.md)
- [UK Biobank Analysis Recommendations](./references/rgcgithub_github_io_regenie_recommendations.md)
- [Methodology Overview](./references/rgcgithub_github_io_regenie_overview.md)