---
name: rvtests
description: rvtests is a high-performance software package for conducting genetic association studies of rare variants using single-variant, gene-level, and family-based statistical models. Use when user asks to perform single-variant association tests, run burden or kernel-based groupwise tests, analyze related individuals with kinship matrices, or generate summary statistics for meta-analysis.
homepage: https://github.com/zhanxw/rvtests
metadata:
  docker_image: "quay.io/biocontainers/rvtests:2.0.7--h3d151dd_2"
---

# rvtests

## Overview
rvtests is a high-performance software package designed for genetic association studies involving rare variants. It transforms raw genomic data (VCF/BCF/BGEN) into statistical insights by supporting a wide array of models for both quantitative and binary traits. It is optimized for efficiency, capable of handling up to one million individuals in linear mixed models, making it a standard tool for analyzing large-scale sequencing projects and biobank datasets.

## Core Workflows

### 1. Single Variant Association
Perform association tests for every variant in a VCF file.
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --out output --single wald,score
```
*   **Note**: For binary traits, code controls as 1 and cases as 2. Missing phenotypes should be 0 or -9.

### 2. Groupwise (Gene-level) Tests
To test rare variants collectively (e.g., by gene), you must provide a grouping unit.
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --geneFile refFlat.txt.gz --burden cmc --vt price --kernel skat,kbac --out output
```
*   **Burden Tests**: CMC, Zeggini, Madsen-Browning (MB).
*   **Kernel Methods**: SKAT, KBAC (useful when variants have different effect directions).
*   **Filtering**: Use `--gene CFH,ARMS2` to restrict analysis to specific genes.

### 3. Family-Based Analysis (Related Individuals)
Requires a kinship matrix, which can be generated using the companion tool `vcf2kinship`.
```bash
# Step 1: Generate Kinship
vcf2kinship --inVcf input.vcf --bn --out study_kinship

# Step 2: Run Association with Kinship
rvtest --inVcf input.vcf --pheno phenotype.ped --kinship study_kinship.kinship --single famScore,famLRT --out output
```

### 4. Meta-Analysis Preparation
Generate summary statistics and genotype covariance matrices for RAREMETAL-compatible meta-analysis.
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --covar covar.txt --meta score,cov --out study_meta
```

## Expert Tips and Best Practices

### Data Filtering and Quality Control
*   **Frequency Cutoffs**: Use `--freqUpper 0.05` to restrict analysis to variants with a Minor Allele Frequency (MAF) below 5%.
*   **Site Filters**: Use `--siteMACMin 5` to exclude extremely rare variants that may cause statistical instability.
*   **Depth Filters**: Use `--indvDepthMin 10` to ignore genotypes with low sequencing coverage.

### Handling Missing Data
*   **Genotypes**: By default, missing genotypes are imputed to the mean. Use `--impute drop` to exclude them instead.
*   **Phenotypes/Covariates**: Use `--imputePheno` or `--imputeCov` to impute missing values to the mean rather than dropping the entire sample.

### Phenotype Transformations
*   **Non-normal Traits**: Use `--inverseNormal` to apply an inverse normal transformation to quantitative traits, ensuring they meet model assumptions.
*   **Residuals**: Use `--useResidualAsPhenotype` to fit a null model (phenotype ~ covariates) and use the residuals for the association test.

### Chromosome X Analysis
*   Specify the PAR (Pseudo-Autosomal Region) to handle sex chromosomes correctly:
```bash
rvtest --inVcf input.vcf --pheno pheno.ped --xLabel 23 --xParRegion hg19 --out output
```



## Subcommands

| Command | Description |
|---------|-------------|
| rvtests_rvtest | RVTESTS is a powerful and flexible software package for association testing of genetic variants. |
| rvtests_vcf2kinship | Calculate kinship from VCF files. |

## Reference documentation
- [GitHub README](./references/github_com_zhanxw_rvtests.md)
- [Command Line Options](./references/github_com_zhanxw_rvtests_wiki_Command-Line-Options.md)