---
name: cgt
description: The cgt tool calculates statistically robust thresholds for labeling genes as core, rare, or accessory by accounting for genome completeness. Use when user asks to determine core genome thresholds, classify genes based on presence-absence matrices, or account for missing genes in metagenome-assembled genomes.
homepage: https://github.com/bacpop/cgt
---


# cgt

## Overview
The `cgt` (Core Genome Threshold) tool provides a robust statistical framework for labeling genes as core, rare, or accessory. While traditional methods often use an arbitrary 95% or 99% presence cutoff, `cgt` accounts for the probability that a gene was missed during sequencing by incorporating genome completeness scores (e.g., from CheckM). It uses a Poisson binomial distribution to simulate the likelihood of gene observations, allowing users to choose a threshold that balances the risk of missing true core genes against the risk of wrongly assigning non-core genes to the core genome.

## Installation
Install the tool via Bioconda:
```bash
conda install bioconda::cgt
```

## Core Workflow and CLI Patterns

### Basic Execution
To calculate thresholds, you need a metadata file containing completeness scores and a gene presence-absence matrix in `.Rtab` format.

```bash
cgt <genome_metadata.tsv> <gene_presence_absence.Rtab> --completeness-column <INDEX>
```

### Key Arguments
- `genome_metadata.tsv`: A tab-separated file where one column contains the completeness score (0-100 or 0-1) for each genome.
- `gene_presence_absence.Rtab`: A matrix where rows are genes and columns are samples, with 1 for presence and 0 for absence.
- `--completeness-column`: The 1-based index of the column in the metadata file that contains the completeness values (e.g., if completeness is the 7th column, use `7`).

### Expert Tips and Best Practices
- **Completeness Scores**: Ensure your completeness scores are derived from reliable tools like CheckM. If your metadata file has a header, ensure the tool handles it correctly or use `tail -n +2` to pipe data if necessary.
- **Handling MAGs**: This tool is essential when working with Metagenome-Assembled Genomes (MAGs). Because MAGs are rarely 100% complete, a gene present in 90% of samples might actually be a 100% core gene that was simply not recovered in the remaining 10% of bins.
- **Interpreting Output**: `cgt` reports the probability of missing core genes. If the probability is too high for your specific research question, consider adjusting the input parameters (such as the Beta distribution priors) if the CLI version supports it, or re-evaluating your sample inclusion criteria.
- **Data Consistency**: The sample names in the first column of your metadata file must match the column headers in your `.Rtab` file exactly.

## Reference documentation
- [cgt - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cgt_overview.md)
- [bacpop/cgt: Calculate sensible core gene thresholds for metagenomic data](./references/github_com_bacpop_cgt.md)