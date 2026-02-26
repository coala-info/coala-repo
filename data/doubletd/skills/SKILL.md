---
name: doubletd
description: doubletd detects doublets in single-cell DNA sequencing data by analyzing variant allele frequencies through a probabilistic framework. Use when user asks to identify droplets containing multiple cells, distinguish singlets from doublets in scDNA-seq, or account for allelic dropout and amplification imbalance in cell capture data.
homepage: https://github.com/elkebir-group/doubletD
---


# doubletd

## Overview

doubletD is a specialized tool for detecting doublets in single-cell DNA sequencing (scDNA-seq) data. In single-cell experiments, errors in cell capture can lead to droplets containing more than one cell, which can confound downstream analysis. doubletD uses the observed variant allele frequencies—the ratio of alternate read counts to total read counts—as its primary signal. It employs a probabilistic framework to distinguish between singlets and doublets while accounting for common sequencing errors, such as allelic dropout (ADO) and amplification imbalance.

## Installation

The recommended way to install doubletd is via Bioconda:

```bash
conda install -c bioconda doubletd
```

## Command Line Usage

The tool requires two primary input files: a table of total read counts and a table of alternate read counts.

### Basic Command Pattern

```bash
doubletd --inputTotal <TOTAL_COUNTS_CSV> --inputAlternate <ALT_COUNTS_CSV> -o <OUTPUT_FILE>
```

### Common Parameters and Best Practices

| Argument | Description | Default/Recommendation |
| :--- | :--- | :--- |
| `--delta` | Expected doublet rate | Default is `0.1`. Adjust based on your specific cell loading concentration. |
| `--beta` | Allelic dropout (ADO) rate | Default is `0.05`. Increase this if your library prep is known to have high dropout. |
| `--missing` | Handle missing data | Use this flag if your input matrices contain missing values/NaNs. |
| `--binomial` | Use binomial distribution | By default, the tool uses a beta-binomial model. Use this flag to switch to a standard binomial model. |
| `--prec` | Beta-binomial precision | Only applicable if using the default model; can be estimated from data if left as `None`. |
| `--noverbose` | Silence output | Use this to suppress logs from internal solvers during large-scale processing. |

### Input Data Format
- **Format**: Comma-separated (CSV) or Tab-separated (TSV) dataframes.
- **Structure**: Rows represent individual droplets (cells); columns represent genomic loci.
- **Files**:
    - `inputTotal`: Total read depth (DP) at each locus.
    - `inputAlternate`: Alternate allele read counts (AD) at each locus.

### Output Format
The output is a dataframe containing:
1. **Posterior probability of being a singlet.**
2. **Posterior probability of being a doublet.**
3. **Prediction**: A final classification label ('singlet' or 'doublet').

## Expert Tips

- **Parameter Estimation**: If you do not know the specific error rates for your experiment (e.g., `mu_hetero`, `mu_hom`, `alpha_fp`, `alpha_fn`), leave them as `None`. doubletD will attempt to estimate these parameters directly from your data.
- **Doublet Rate (`--delta`)**: This is a prior probability. If your experimental protocol (like 10x Genomics) provides an expected doublet rate based on the number of cells recovered, ensure you update this parameter for more accurate posterior probabilities.
- **Example Workflow**:
  ```bash
  # Running with a 20% expected doublet rate and 5% ADO rate
  doubletd --inputAlternate AD.csv --inputTotal DP.csv --delta 0.2 --beta 0.05 -o prediction.tsv
  ```

## Reference documentation
- [doubletD GitHub Repository](./references/github_com_elkebir-group_doubletD.md)
- [doubletD Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_doubletd_overview.md)