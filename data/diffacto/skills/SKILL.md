---
name: diffacto
description: Diffacto aggregates peptide-level quantification data into protein-level summaries using factor analysis for comparative shotgun proteomics. Use when user asks to transform peptide abundances into protein fold-changes, handle missing values in proteomics datasets, or perform protein-level quantification with Gaussian Mixture Model normalization.
homepage: https://github.com/statisticalbiotechnology/diffacto
---


# diffacto

## Overview
Diffacto is a specialized tool for comparative shotgun proteomics that aggregates peptide-level quantification data into protein-level summaries. It employs a factor analysis-based approach to handle the inherent noise and missing values common in proteomics datasets. Use this skill when you need to transform a list of peptide abundances into statistically robust protein fold-changes and significance scores, particularly when dealing with complex experimental designs involving multiple sample groups or requiring specific normalization techniques like Gaussian Mixture Models (GMM).

## Installation and Setup
Diffacto can be installed via bioconda or pip:
```bash
conda install bioconda::diffacto
# OR
pip install diffacto
```

## Core CLI Usage
The primary interface is `diffacto.py`. At minimum, you must provide an input file containing peptide abundances.

### Basic Command
```bash
diffacto.py -i peptide_abundances.csv -out protein_results.tsv
```

### Input File Requirements
- **Format**: CSV.
- **Structure**: 
  - First row: Sample names.
  - First column: Unique peptide sequences.
  - Second column: Protein IDs (required if no FASTA database is provided via `-db`).
- **Missing Values**: Should be represented as empty cells, not zeros.

### Defining Experimental Groups
By default, Diffacto treats each column as an individual group. For complex designs, use a sample list file:
```bash
diffacto.py -i peptides.csv -samples sample_groups.tab -out results.tsv
```
*Note: The sample list should be a tab-separated file with one run and its corresponding group per line.*

## Advanced Configuration

### Normalization and Scaling
- **Log Transformation**: If your input data is in linear scale, ensure `-log2 False` (default). If already log-transformed, set `-log2 True`.
- **Normalization Methods**: Choose from `average`, `median`, `GMM` (Gaussian Mixture Model), or `None`.
  ```bash
  diffacto.py -i peptides.csv -normalize GMM -out results.tsv
  ```

### Filtering and Quality Control
- **Unique Peptides**: To restrict analysis to peptides that map to only one protein: `-use_unique True`.
- **Minimum Samples**: Set the minimum number of samples a peptide must be quantified in to be included: `-min_samples 3`.
- **Weight Cutoff**: Exclude peptides with low weights (noise) using `-cutoff_weight` (default is 0.5).

### Statistical Parameters
- **Reference Groups**: Specify which groups to use as the baseline for comparison (separated by semicolons): `-reference "Control;Baseline"`.
- **Imputation**: Control when missing values are imputed using `-impute_threshold`. Imputation occurs if the fraction of missing values in a group exceeds this threshold.

## Common Workflow Patterns

### Analysis with FASTA Database
If your peptide file lacks protein mappings, provide the original FASTA file:
```bash
diffacto.py -i peptides.csv -db proteins.fasta -out results.tsv
```

### High-Sensitivity Discovery
For datasets with significant noise where you want to allow the EM algorithm to terminate early if noise is low:
```bash
diffacto.py -i peptides.csv -fast True -out results.tsv
```

### Generating MCFDR Outputs
To perform Monte Carlo False Discovery Rate estimation:
```bash
diffacto.py -i peptides.csv -mc_out mcfdr_results.tsv -out results.tsv
```

## Reference documentation
- [Diffacto GitHub Repository](./references/github_com_statisticalbiotechnology_diffacto.md)
- [Bioconda Diffacto Overview](./references/anaconda_org_channels_bioconda_packages_diffacto_overview.md)