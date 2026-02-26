---
name: deploid
description: DEploid deconvolutes mixed genomic samples to estimate the number of strains, their relative proportions, and their individual haplotypes. Use when user asks to disentangle mixed genomes, estimate strain abundance, or perform haplotype deconvolution on multi-strain infections.
homepage: http://deploid.readthedocs.io/en/latest/index.html
---


# deploid

## Overview
DEploid is a specialized tool designed to disentangle mixed genomes from samples where multiple strains are present in unknown proportions. It uses a Bayesian framework to estimate the most likely number of strains (K), their relative abundance, and the specific genetic sequences (haplotypes) of each strain. It is particularly effective for analyzing malaria parasites and other organisms where multi-strain infections are common.

## Core CLI Usage
The primary command for running a deconvolution is `dEploid`.

### Basic Command Pattern
```bash
dEploid -vcf <input.vcf> -ref <reference_panel.vcf> -ploidy <N> -o <output_prefix>
```

### Key Parameters
- `-vcf`: Input VCF file containing the mixed sample data.
- `-ref`: A reference panel of known haplotypes to guide the deconvolution.
- `-ploidy`: The expected ploidy of the organism (e.g., 1 for haploid stages of Plasmodium).
- `-k`: Manually set the number of strains. If unknown, DEploid can attempt to estimate this.
- `-exclude`: Path to a file containing sites to exclude (e.g., high-variability regions or known artifacts).

## Workflow Best Practices

### 1. Data Exploration
Before running a full deconvolution, use the `-noDeploid` flag to perform data exploration. This helps in visualizing the Allele Frequency (AF) distribution to estimate the complexity of the infection.
```bash
dEploid -vcf <input.vcf> -noDeploid -o <exploration_output>
```

### 2. Handling Over-fitting
If the estimated proportions for a strain are near zero, it often indicates over-fitting (setting K too high). In such cases, re-run the analysis with a lower `-k` value.

### 3. Reference Panel Selection
The quality of deconvolution is highly dependent on the reference panel. Ensure the reference panel contains haplotypes that are geographically or genetically relevant to the mixed sample being analyzed.

## Interpreting Outputs
DEploid generates several files with the specified prefix:
- `.prop`: Contains the estimated proportions of each strain.
- `.hap`: Contains the deconvoluted haplotypes for each strain at each site.
- `.llk`: Log-likelihood values of the MCMC chains, useful for checking convergence.

## Reference documentation
- [DEploid ReadTheDocs Index](./references/deploid_readthedocs_io_en_latest_index.html.md)
- [Bioconda DEploid Overview](./references/anaconda_org_channels_bioconda_packages_deploid_overview.md)