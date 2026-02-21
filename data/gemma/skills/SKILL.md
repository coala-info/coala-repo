---
name: gemma
description: GEMMA (Genome-wide Efficient Mixed Model Association) is a high-performance software toolkit designed for the rigorous analysis of large-scale genetic datasets.
homepage: https://github.com/genetics-statistics/GEMMA
---

# gemma

## Overview
GEMMA (Genome-wide Efficient Mixed Model Association) is a high-performance software toolkit designed for the rigorous analysis of large-scale genetic datasets. It addresses the primary challenge in GWAS—population stratification—by implementing computationally efficient mixed model algorithms. Beyond standard association testing, it provides specialized workflows for multi-trait analysis and Bayesian modeling for phenotype prediction, making it a versatile tool for both quantitative and binary trait genetics.

## Common CLI Patterns

### 1. Calculating the Kinship (Relatedness) Matrix
A kinship matrix is required for most LMM-based analyses to account for sample relatedness.
```bash
gemma -g [genotypes.txt.gz] -p [phenotypes.txt] -gk 1 -o [output_prefix]
```
- `-gk 1`: Generates a centered relatedness matrix (recommended for most GWAS).
- `-gk 2`: Generates a standardized relatedness matrix.

### 2. Univariate Linear Mixed Model (LMM)
Perform association tests for a single phenotype while controlling for population structure.
```bash
gemma -g [genotypes.txt.gz] -p [phenotypes.txt] -k ./output/[kinship.cXX.txt] -lmm 4 -o [result_prefix]
```
- `-n [column_number]`: Specifies which phenotype column to analyze (default is 1).
- `-lmm 4`: Executes Wald, Likelihood Ratio, and Score tests simultaneously.
- `-a [annotation.txt]`: (Optional) Provides SNP annotations (chromosome and position) for the output.

### 3. Multivariate Linear Mixed Model (mvLMM)
Jointly analyze multiple phenotypes to identify pleiotropic effects or increase power.
```bash
gemma -g [genotypes.txt.gz] -p [phenotypes.txt] -n 1 2 3 -k ./output/[kinship.cXX.txt] -lmm 1 -o [mvlmm_results]
```
- `-n 1 2 3`: Specifies multiple phenotype columns to be analyzed together.

### 4. Bayesian Sparse Linear Mixed Model (BSLMM)
Used for estimating "chip heritability" (PVE) and performing phenotype prediction.
```bash
gemma -g [genotypes.txt.gz] -p [phenotypes.txt] -bslmm 1 -o [bslmm_results]
```
- `-bslmm 1`: Runs the standard BSLMM.
- `-bslmm 2`: Runs the ridge regression (LMM) version within the Bayesian framework.

## Expert Tips and Optimization

- **Speed Optimization**: Once your pipeline is validated, use the `-no-check` flag to bypass internal data consistency checks and significantly reduce runtime.
- **Covariate Integration**: Include fixed effects (such as age, sex, or top Principal Components) using the `-c [covariates.txt]` flag. Note that the covariate file should include a column of 1s if you wish to include an intercept.
- **Handling Large Data**: For initial testing on massive datasets, use `-nind [number]` to limit the analysis to a specific number of individuals to verify command syntax and file formatting.
- **Binary Traits**: While GEMMA is designed for continuous traits, it can be applied to binary traits (case-control). However, ensure you interpret the PVE and effect sizes according to the observed scale or use appropriate transformations.
- **Output Location**: GEMMA automatically creates an `output` directory in the current working directory. The `-o` flag specifies the prefix of the files within that directory.

## Reference documentation
- [GEMMA Overview](./references/anaconda_org_channels_bioconda_packages_gemma_overview.md)
- [GEMMA GitHub Repository](./references/github_com_genetics-statistics_GEMMA.md)