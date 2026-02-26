---
name: fastlmm
description: FaST-LMM performs large-scale genome-wide association studies and heritability estimation while controlling for population structure using linear mixed models. Use when user asks to perform univariate GWAS, estimate narrow-sense heritability, test for epistasis, or conduct set-based association tests.
homepage: http://research.microsoft.com/en-us/um/redmond/projects/mscompbio/fastlmm/
---


# fastlmm

## Overview
FaST-LMM (Factored Spectrally Transformed Linear Mixed Model) is a specialized toolset designed for large-scale genomic analysis. You should use this skill when you need to perform association testing while controlling for confounding factors like population stratification without the quadratic computational cost typically associated with LMMs. It excels at univariate GWAS, epistatic testing, and set-based association tests, supporting datasets with up to one million samples by utilizing low-rank approximations of the Genetic Relationship Matrix (GRM).

## Core Workflows and CLI Patterns

### 1. Standard Univariate GWAS
The primary use case is testing individual SNPs for association with a phenotype while using a subset of SNPs to account for relatedness.
- **Input Requirements**: PLINK formatted files (.bed, .bim, .fam).
- **SNP Selection**: For optimal performance and type I error control, use SNPs pruned for Linkage Disequilibrium (LD) to construct the similarity matrix.
- **Command Pattern**:
  ```bash
  fastlmmc -bfile data -pheno pheno.txt -out results.txt
  ```

### 2. Heritability Estimation
Use FaST-LMM to estimate the proportion of phenotypic variance explained by genetic factors (narrow-sense heritability).
- **Best Practice**: Ensure the phenotype file is properly formatted with Family ID and Individual ID matching the .fam file.
- **Command Pattern**:
  ```bash
  fastlmmc -bfile data -pheno pheno.txt -reml -out heritability.txt
  ```

### 3. Epistasis Testing
Testing for interactions between pairs of SNPs.
- **Note**: This is computationally intensive. Use the `-extract` flag to limit testing to specific regions or candidate SNPs if the dataset is massive.
- **Command Pattern**:
  ```bash
  fastlmmc -bfile data -pheno pheno.txt -epistasis -out epistasis_results.txt
  ```

### 4. Set-Based Association Tests
Used for testing groups of variants (e.g., genes or pathways) rather than single SNPs.
- **Advantage**: Uses Likelihood Ratio Tests (LRT) which often provide more power than score tests for rare variant sets.

## Expert Tips and Best Practices
- **Memory Management**: If the number of SNPs ($k$) used for the similarity matrix is less than the number of individuals ($N$), FaST-LMM runs in $O(N \cdot k^2)$ time. If $k > N$, it defaults to $O(N^2 \cdot k)$. Always prefer a pruned subset of SNPs for the kinship matrix to maintain linear scaling.
- **Confounding Control**: Avoid selecting SNPs for the similarity matrix based on their p-value with the phenotype (feature selection), as this can lead to inflated type I error. Stick to LD-based pruning or random subsets.
- **Missing Data**: Ensure phenotypes are standardized and missing values are handled prior to execution, as LMMs are sensitive to scale.
- **Platform Availability**: While a C++ version exists for speed, the Python-based version is the most up-to-date and supports the widest range of features including cellular heterogeneity corrections.

## Reference documentation
- [FaST-LMM Project Overview](./references/www_microsoft_com_en-us_research_project_fastlmm.md)
- [Bioconda FastLMM Package Details](./references/anaconda_org_channels_bioconda_packages_fastlmm_overview.md)