---
name: bioconductor-mbqtl
description: The mbQTL package identifies associations between microbial taxa abundance and host genetic variants using linear regression, correlation analysis, and logistic regression. Use when user asks to identify microbiome quantitative trait loci, perform taxa-SNP correlation analysis, or model the association between host genotypes and microbial presence.
homepage: https://bioconductor.org/packages/release/bioc/html/mbQTL.html
---


# bioconductor-mbqtl

## Overview

The `mbQTL` package provides tools to identify significant associations between microbial taxa abundance and host genetic variants (SNPs). It supports three primary statistical methodologies:
1.  **Linear Regression**: Uses the `MatrixeQTL` engine to model taxa abundance against genotype (0, 1, 2).
2.  **Correlation Analysis (Rho Estimation)**: A novel method that estimates the strength of relationships between taxa-taxa and taxa-SNP simultaneously to identify clusters and linkage disequilibrium (LD) effects.
3.  **Logistic Regression**: Models the association between SNP genotypes and the presence/absence (binary) of specific taxa.

## Data Preparation

The package accepts data frames, `MRexperiment` objects, or text files.

### Input Requirements
- **Microbe Abundance**: Rows = Taxa, Columns = Samples.
- **SNP File**: Rows = SNPs, Columns = Samples (Genotypes coded as 0, 1, 2).
- **Covariates (Optional)**: Rows = Covariates, Columns = Samples. Highly recommended for linear models.

### Converting metagenomeSeq Objects
If starting with a `metagenomeSeq` object, use `metagenomeSeqToMbqtl` to normalize and aggregate data:

```r
library(mbQTL)

# Normalize, log-transform, and aggregate at Genus level
mbqtl_df <- metagenomeSeqToMbqtl(metagenomeSeqObj, 
                                 norm = TRUE, 
                                 log = TRUE, 
                                 aggregate_taxa = "Genus")
```

## Workflow A: Linear Regression

Best for identifying quantitative associations between abundance and genotype.

```r
# Run linear analysis
results_lm <- linearTaxaSnp(microbeAbund, SnpFile, Covariate = CovFile)

# Visualization
histPvalueLm(results_lm)
qqPlotLm(microbeAbund, SnpFile, Covariate = CovFile)
```

## Workflow B: Correlation & Rho Estimation

Used to evaluate how much variance in a taxon explains the variance in a SNP, accounting for taxa-taxa communities.

```r
# 1. Estimate taxa-taxa correlation
cor_microbes <- coringTaxa(microbeAbund)

# 2. Estimate R2 for all SNPs and all taxa
all_rsids <- allToAllProduct(SnpFile, microbeAbund)

# 3. Estimate rho values
taxa_snp_rho <- taxaSnpCor(all_rsids, cor_microbes)

# 4. Filter for significant relationships (optional)
taxa_snp_rho_lim <- taxaSnpCor(all_rsids, cor_microbes, probs = c(0.0001, 0.9999))

# 5. Visualize with heatmap
mbQtlCorHeatmap(taxa_snp_rho_lim)
```

## Workflow C: Logistic Regression

Best for modeling the association between host genotype and the simple presence or absence of a microbe.

```r
# Run logistic regression for all pairs
results_log <- logRegSnpsTaxa(microbeAbund, SnpFile)

# Run for a specific microbe
results_haemo <- logRegSnpsTaxa(microbeAbund, SnpFile, selectmicrobe = "Haemophilus")

# Visualize specific SNP-Taxa relationship
# Note: ref, alt, and het labels should match the SNP's actual alleles
logitPlotSnpTaxa(microbeAbund, SnpFile, 
                 selectmicrobe = "Neisseria", 
                 rsID = "chr2.241072116_A", 
                 ref = "GG", alt = "AA", het = "AG")
```

## Tips for Success
- **Sample Matching**: Ensure sample names and order are identical across the abundance, SNP, and covariate files.
- **Genotype Coding**: SNPs must be numeric (0 for reference, 1 for heterozygous, 2 for alternate).
- **Memory Efficiency**: The package is optimized for large datasets; a 500x500 matrix typically runs in under 2 minutes with ~90MB RAM.

## Reference documentation
- [mbQTL Vignette](./references/mbQTL_Vignette.md)