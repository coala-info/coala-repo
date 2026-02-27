---
name: bioconductor-metacca
description: This tool performs multivariate meta-analysis of genome-wide association studies using summary statistics and canonical correlation analysis. Use when user asks to estimate phenotypic correlations from summary statistics, perform single-SNP or multi-SNP multi-trait association analysis, or meta-analyze GWAS results across multiple cohorts without individual-level data.
homepage: https://bioconductor.org/packages/release/bioc/html/metaCCA.html
---


# bioconductor-metacca

name: bioconductor-metacca
description: Perform multivariate meta-analysis of genome-wide association studies (GWAS) using summary statistics. Use this skill when you need to analyze associations between multiple SNPs and multiple traits without individual-level data, or when meta-analyzing results across multiple cohorts using Canonical Correlation Analysis (CCA).

# bioconductor-metacca

## Overview
The `metaCCA` package enables multivariate meta-analysis of GWAS results using only univariate summary statistics. It extends Canonical Correlation Analysis (CCA) to work with three components: genotype-phenotype association results (SXY), genotype-genotype correlations (SXX, typically from a reference panel like 1000 Genomes), and phenotype-phenotype correlations (SYY, estimated from SXY).

## Data Preparation

### Univariate Summary Statistics (SXY)
Prepare a data frame where row names are SNP IDs.
- Required columns: `allele_0`, `allele_1`.
- Trait columns: For each trait, include `traitID_b` (regression coefficient) and `traitID_se` (standard error).
- Note: Do not use underscores in `traitID` except for the `_b` and `_se` suffixes.

### Genotypic Correlation (SXX)
A data frame or matrix containing correlations between SNPs. Row names must match SNP IDs in SXY. This is only required for multi-SNP analysis.

## Workflow

### 1. Estimate Phenotypic Correlation (SYY)
Estimate the correlation between traits using summary statistics across a large number of SNPs (ideally at least one full chromosome).
```r
# S_XY_full should contain summary stats for many SNPs to ensure estimate quality
S_YY = estimateSyy(S_XY = S_XY_full)
```

### 2. Association Analysis
Use `metaCcaGp` for the standard algorithm or `metaCcaPlusGp` for a variant that applies more aggressive shrinkage to the covariance matrix.

#### Single-SNP–Multi-Trait Analysis (Default)
Tests each SNP individually against a set of traits.
```r
result = metaCcaGp(
  nr_studies = 2,
  S_XY = list(S_XY_study1, S_XY_study2),
  std_info = c(0, 0), # 0 for non-standardized, 1 for standardized genotypes
  S_YY = list(S_YY_study1, S_YY_study2),
  N = c(N1, N2) # Sample sizes for each study
)
```

#### Multi-SNP–Multi-Trait Analysis
Tests a set of SNPs jointly against a set of traits.
```r
result = metaCcaGp(
  nr_studies = 2,
  S_XY = list(S_XY_study1, S_XY_study2),
  std_info = c(0, 0),
  S_YY = list(S_YY_study1, S_YY_study2),
  N = c(N1, N2),
  analysis_type = 2,
  SNP_id = c("rs10", "rs80", "rs140"),
  S_XX = list(S_XX_study1, S_XX_study2)
)
```

## Interpreting Results
The output is a data frame containing:
- `r_1`: The leading canonical correlation value.
- `-log10(p-val)`: The significance of the association.
- `trait_weights`: Canonical weights for each trait, indicating their contribution to the association.
- `snp_weights`: Canonical weights for each SNP (only in multi-SNP analysis).

## Tips
- Ensure that the same SNPs and traits are present across all studies being meta-analyzed.
- If all studies share the same underlying population, you can provide the same `S_XX` reference matrix for each study in the list.
- Use `metaCcaPlusGp` if the phenotypic correlation structure is expected to be very complex or if the standard `metaCcaGp` encounters numerical stability issues.

## Reference documentation
- [metaCCA](./references/metaCCA.md)