---
name: bacgwasim
description: BacGWASim is a simulation framework for generating synthetic bacterial populations with defined causal variants and phenotypes for association testing. Use when user asks to simulate bacterial genome evolution, generate synthetic GWAS datasets, or evaluate the performance of association mapping methods.
homepage: https://github.com/Morteza-M-Saber/BacGWASim
metadata:
  docker_image: "quay.io/biocontainers/bacgwasim:2.1.1--pyhdfd78af_0"
---

# bacgwasim

## Overview

BacGWASim is a specialized simulation framework for generating synthetic bacterial populations. It bridges the gap between evolutionary simulation and association testing by producing datasets where the ground truth—causal variants, effect sizes, and heritability—is strictly defined. This makes it an essential tool for researchers who need to evaluate the power and false-positive rates of GWAS methods or train machine learning models on bacterial genotypes. The tool handles the entire workflow from genome evolution (mutation and recombination) to phenotype generation and visualization of population structure.

## Installation and Setup

The most reliable way to install BacGWASim is via Bioconda to ensure all bioinformatics dependencies (like PLINK, GCTA, and bcftools) are correctly managed.

```bash
conda create -n BacGWASim bacgwasim -c conda-forge -c bioconda
conda activate BacGWASim
```

## Command Line Usage

BacGWASim is built on Snakemake. While it can use a configuration file, parameters can be passed directly via the command line to override defaults.

### Basic Execution
Run the simulation using the default configuration by specifying the number of CPU cores:
```bash
BacGWASim --cores 4
```

### Handling Filesystem Latency
If running on a high-performance computing (HPC) cluster or a network filesystem where file creation might be delayed, use the latency flag to prevent the workflow from failing prematurely:
```bash
BacGWASim --cores 8 --latency-wait 60
```

### Common Parameter Overrides
You can modify simulation variables directly in the command string. Key parameters include:

*   **Population Size**: `num_species` (e.g., 500)
*   **Genome Scale**: `genome_length` (in base pairs)
*   **Phenotype Type**: `phen_type` (use `quant` for quantitative or `cc` for case-control)
*   **Causal Architecture**: `num_causal_var` (number of variants affecting the trait) and `heritability` (0 to 1)

## Expert Tips and Best Practices

### Reproducibility
Always specify a `random_seed` when generating datasets for publication or benchmarking to ensure the exact same population can be reconstructed later.

### Machine Learning Integration
For Python-based machine learning workflows, skip the VCF parsing step and use the `.pickle` outputs located in the `genSim/` and `phenSim/` directories. These contain pre-processed Pandas DataFrames of the genotype matrix and phenotype vectors.

```python
import pandas as pd
X = pd.read_pickle("results_BacGWASim/genSim/sims.pickle")
y = pd.read_pickle("results_BacGWASim/phenSim/phenSim.pickle")
```

### GWAS Tool Compatibility
*   **GCTA**: The phenotypes in `phenSim/phenSim.phen` are formatted specifically for GCTA.
*   **VCF Tools**: Use `genSim/sims.vcf` for most GWAS tools. Note that `sims_no_selection.vcf` includes rare alleles (below the Minor Allele Frequency threshold), which may increase noise in standard association tests.

### Linkage Disequilibrium (LD) Analysis
Generating LD plots is computationally expensive. If you only need the genotypes and phenotypes, ensure `plot_ld` is set to `False`. If you do require LD plots, limit the `snp_limit` to a reasonable number (e.g., 3000) to avoid extreme memory usage and long runtimes.

## Reference documentation
- [BacGWASim GitHub Repository](./references/github_com_Morteza-M-Saber_BacGWASim.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bacgwasim_overview.md)