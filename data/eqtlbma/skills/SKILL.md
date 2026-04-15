---
name: eqtlbma
description: eqtlbma is a statistical software package designed to detect expression quantitative trait loci by jointly analyzing multiple subgroups using Bayesian Model Averaging. Use when user asks to detect eQTLs across different tissues or populations, compute Bayes Factors for genetic associations, or estimate the proportion of null hypotheses and control false discovery rates.
homepage: https://github.com/timflutre/eqtlbma
metadata:
  docker_image: "quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0"
---

# eqtlbma

## Overview
eqtlbma is a statistical software package designed to detect expression quantitative trait loci (eQTLs) by jointly analyzing multiple subgroups, such as different tissue types or populations. By utilizing Bayesian Model Averaging (BMA), the tool allows researchers to borrow information across these subgroups and across genes (via an empirical Bayes approach) to improve the power of eQTL discovery and accurately model how genetic effects vary across different biological contexts.

## Installation and Setup
The package is available via Bioconda or can be compiled from source.

**Conda Installation:**
```bash
conda install bioconda::eqtlbma
```

**Source Installation Requirements:**
- ZLIB >= v1.2.6
- GSL (GNU Scientific Library) <= 1.16 OR >= 2.3 (versions between 1.16 and 2.3 are unsupported)
- GCC >= 4.7

## Command Line Usage and Best Practices

### Primary Analysis Workflow
The core of the package is the computation of Bayes Factors (BF) to quantify the evidence for an eQTL across the provided subgroups.

1. **Bayes Factor Computation (`eqtlbma_bf`)**:
   Use this command to perform the primary association testing. It supports batched output to manage memory and disk space for large genomic datasets.
   - Use `--maf [value]` to filter by Minor Allele Frequency.
   - Use `--lik normal` to specify the likelihood model (standard for most expression data).
   - Use `--wrtsize [value]` to control the batch size of the output, which is critical when running large-scale permutations or genome-wide scans.

2. **Permutation Testing**:
   The tool supports adaptive permutations to assess the significance of observed associations. Handle `NaN` values in permutation outputs by ensuring input data quality and checking for subgroups with zero variance.

3. **Post-Processing**:
   After computing Bayes Factors, use the associated scripts/functions to:
   - Estimate the proportion of null hypotheses ($\pi_0$) using `estimatePi0WithEbf`.
   - Control the False Discovery Rate (FDR) using `controlBayesFdr`.

### Expert Tips
- **Subgroup Heterogeneity**: The primary advantage of eqtlbma is its ability to model whether an eQTL is shared across all tissues, specific to one, or present in a subset. Ensure your input data includes all relevant subgroups to maximize the benefit of the BMA framework.
- **System Documentation**: Access the built-in manual directly from the terminal using `info eqtlbma` if the package was installed via standard GNU procedures.
- **Memory Management**: When working with VCF files or large data bundles, use the batched output behavior in `eqtlbma_bf` to prevent system crashes during the SVD (Singular Value Decomposition) steps.
- **Mac OS X Compatibility**: If using macOS, ensure you have GNU `getopt` installed (via `brew install gnu-getopt`) to use the provided bash wrapper scripts correctly.

## Reference documentation
- [eqtlbma Wiki Home](./references/github_com_timflutre_eqtlbma_wiki.md)
- [eqtlbma GitHub README](./references/github_com_timflutre_eqtlbma.md)
- [Bioconda eqtlbma Overview](./references/anaconda_org_channels_bioconda_packages_eqtlbma_overview.md)