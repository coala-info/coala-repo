---
name: rvtests
description: rvtests is a toolkit for performing genetic association studies on rare variants using single-variant, burden, and kernel-based statistical tests. Use when user asks to perform rare variant association analysis, run gene-based aggregation tests like SKAT or CMC, handle family-based data with kinship matrices, or prepare summary statistics for meta-analysis.
homepage: https://github.com/zhanxw/rvtests
---


# rvtests

## Overview
The `rvtests` (Rare Variant tests) suite is a specialized toolkit for genetic association studies, optimized for the unique challenges of rare variant analysis in large-scale sequencing datasets. It supports a wide array of statistical models, including single-variant score tests, burden tests (like CMC), variable threshold models, and kernel-based methods (like SKAT). A key strength is its ability to handle both unrelated individuals and complex family structures through efficient linear mixed model implementations, making it capable of processing biobank-scale data.

## Core CLI Patterns

### Single Variant Association
To test every variant in a VCF against a phenotype:
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --out output_prefix --single wald,score
```
*   **Phenotype Format**: Uses the 6th column of a PLINK-formatted `.ped` file.
*   **Trait Detection**: Automatically detects binary vs. quantitative traits. For binary traits, code controls as 1 and cases as 2.

### Groupwise (Gene-based) Tests
To perform aggregation tests, you must provide a gene definition file (refFlat format):
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --geneFile refFlat_hg19.txt.gz --burden cmc --vt price --kernel skat,kbac --out output_prefix
```
*   **Filtering by Gene**: Use `--gene CFH,ARMS2` to restrict analysis to specific genes.
*   **Burden Units**: If not using genes, specify custom groups using `--setFile`.

### Analysis of Related Individuals
For family-based data, first generate a kinship matrix, then run the association:
1. **Generate Kinship**:
   ```bash
   vcf2kinship --inVcf input.vcf --bn --out study_kinship
   ```
   *   `--bn`: Balding-Nicols method (empirical).
   *   `--ibs`: Identity-by-state kinship.
2. **Run Mixed Model**:
   ```bash
   rvtest --inVcf input.vcf --pheno phenotype.ped --kinship study_kinship.kinship --single famScore,famLRT --out output_prefix
   ```

### Meta-Analysis Preparation
Generate score statistics and covariance matrices for use in RAREMETAL:
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --meta score,cov --out meta_stats
```

## Advanced Options and Best Practices

### Covariate Adjustment
Adjust for age, sex, or PCA components by providing a covariate file:
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --covar study.covar --covar-name age,sex,pc1,pc2 --out adjusted_results
```

### Data Transformation
For quantitative traits, it is often beneficial to use inverse normal transformation:
```bash
rvtest --inVcf input.vcf --pheno phenotype.ped --inverseNormal --useResidualAsPhenotype --out transformed_results
```

### Variant Filtering
Apply quality control filters directly within `rvtests` to avoid pre-processing steps:
*   **Frequency**: `--freqUpper 0.05` (only analyze variants with MAF < 5%).
*   **Call Rate**: `--siteCallRateMin 0.95`.
*   **Genotype Quality**: `--genoMinGQ 20`.

### Handling Missing Data
*   **Phenotypes/Covariates**: Samples with missing values are typically dropped.
*   **Genotypes**: Use `--impute [mean|median|zero]` to handle missing genotype calls.

## Reference documentation
- [rvtests GitHub Repository](./references/github_com_zhanxw_rvtests.md)
- [rvtests Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rvtests_overview.md)