---
name: finemap
description: FINEMAP identifies causal variants in genomic regions by integrating GWAS summary statistics with linkage disequilibrium information using a Bayesian framework. Use when user asks to perform statistical fine-mapping, identify causal SNPs, or process large-scale correlation matrices using binary formats.
homepage: http://www.christianbenner.com
---

# finemap

# finemap

## Overview
FINEMAP is a specialized tool for the statistical fine-mapping of causal variants in genomic regions. It implements a Bayesian framework to identify the most likely set of causal variants by integrating GWAS summary statistics with Linkage Disequilibrium (LD) information. It is designed for high-performance analysis, supporting multiple causal variants per locus and providing efficient handling of large-scale data through custom binary formats (BCOR for correlations and BDOSE for dosages).

## Core Workflows

### 1. Basic Fine-Mapping (SSS)
The Stochastic Search Strategy (SSS) is the primary method for identifying causal variants.

```bash
finemap --sss --in-files <master_file> [options]
```

**Key Options:**
- `--n-causal-snps`: Maximum number of causal variants to search for (default is 5).
- `--prior-snps`: Prior probability of a SNP being causal.
- `--prob-threshold`: Threshold for including configurations in the output.

### 2. Input File Preparation
FINEMAP requires a "master" file that points to the specific data files for each locus. The master file is a space-delimited text file with the following header:
`z;ld;snp;config;cred;log;n_samples`

- **Z-file**: Contains summary statistics (rsid, chromosome, position, allele1, allele2, maf, beta, se).
- **LD-file**: Contains the SNP correlation matrix (text or BCOR format).
- **SNP-file**: Output file for SNP-level posterior probabilities.
- **Config-file**: Output file for configuration-level probabilities.
- **Cred-file**: Output file for credible sets.

### 3. Working with Binary Formats
FINEMAP uses optimized binary formats to handle large datasets efficiently.

#### BCOR (Binary Correlation) v1.1
Used for storing SNP correlation matrices.
- **Compression Levels**: Supports 1-byte (level 3), 2-byte (level 0), 4-byte (level 1), and 8-byte (level 2) precision.
- **Missing Values**: Coded specifically based on compression level (e.g., `53248` for 2-byte).
- **Conversion**: Integer values $y$ are converted to floating-point $x$ via $x = 2^{(2 - 8 \times N_{bytes})} \times y - 1$.

#### BDOSE (Binary Dosage) v1.1
Used for storing standardized dosages.
- **Structure**: Includes a header with BGEN metadata, SNP identifiers, sample IDs, and Zstandard compressed dosage data.
- **Conversion**: Dosage values $y$ are converted to floating-point $x$ via $x = 2^{(2 - 8 \times N_{bytes})} \times y$.

## Expert Tips and Best Practices

- **Allele Alignment**: Ensure that the effect alleles (allele2) in your Z-file are consistent with the alleles used to calculate the LD matrix. Misalignment will lead to incorrect causal variant identification.
- **Sample Size**: Always provide the correct sample size ($N$) in the master file, as this directly impacts the calculation of the Bayes Factors.
- **BCOR vs. Text LD**: For regions with more than 5,000 SNPs, always use the BCOR format. It significantly reduces memory overhead and speeds up the stochastic search.
- **Convergence Check**: Review the `.log` file output to ensure the SSS algorithm has converged. If the number of causal variants identified is equal to `--n-causal-snps`, consider increasing the limit.
- **Standardization**: FINEMAP expects summary statistics to be standardized. If using non-standardized betas, ensure the standard errors are correctly scaled.



## Subcommands

| Command | Description |
|---------|-------------|
| finemap | Welcome to FINEMAP v1.4.2 |
| finemap | Welcome to FINEMAP v1.4.2 |

## Reference documentation
- [BCOR v1.1 file format](./references/www_christianbenner_com_bcor_v1.1.html.md)
- [BDOSE v1.1 file format](./references/www_christianbenner_com_bdose_v1.1.html.md)
- [BDOSE v1.0 file format](./references/www_christianbenner_com_bdose_v1.0.html.md)
- [FINEMAP Overview](./references/anaconda_org_channels_bioconda_packages_finemap_overview.md)