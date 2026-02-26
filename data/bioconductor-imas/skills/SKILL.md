---
name: bioconductor-imas
description: IMAS performs integrative analysis of multi-omics data to interpret alternative splicing by linking transcriptomic data with genomic variants. Use when user asks to detect differential alternative splicing events, identify splicing quantitative trait loci, or evaluate the functional impact of splicing variations.
homepage: https://bioconductor.org/packages/release/bioc/html/IMAS.html
---


# bioconductor-imas

name: bioconductor-imas
description: Integrative analysis of multi-omics data for Alternative Splicing (AS). Use this skill when performing differential alternative splicing analysis, integrating GWAS SNPs with AS events (sQTL), or evaluating the functional impact of splicing variations using Bioconductor.

# bioconductor-imas

## Overview
IMAS (Integrative analysis of Multi-omics data for Alternative Splicing) is an R package designed to facilitate the interpretation of alternative splicing (AS) by integrating transcriptomic data with genomic variants. It allows users to detect differential AS events across groups and identify splicing quantitative trait loci (sQTLs) by linking AS levels (Percent Spliced In - PSI) with SNP genotypes.

## Core Workflow

### 1. Data Preparation
IMAS requires two primary types of data:
- **Splicing Data**: A matrix of PSI (Percent Spliced In) values where rows are AS events and columns are samples.
- **Genotype Data**: A matrix of SNP genotypes (typically coded as 0, 1, 2) where rows are SNPs and columns are samples.

```r
library(IMAS)

# Load example data provided by the package
data(SampleData) 
# This typically loads objects like:
# psi: PSI matrix
# snp: Genotype matrix
# pheno: Phenotype/group information
# group: Grouping factor
```

### 2. Differential Splicing Analysis
To identify AS events that differ significantly between experimental conditions or groups:

```r
# Calculate differential PSI
# group is a factor defining the two groups to compare
diff_results <- DiffAS(psi, group)

# View top significant events
head(diff_results)
```

### 3. sQTL Analysis (SNP-AS Integration)
To find genetic variants that influence alternative splicing:

```r
# Identify sQTLs
# This function correlates SNP genotypes with PSI values
sqtl_results <- sQTL(psi, snp)

# Filter for significant associations
significant_sqtls <- sqtl_results[sqtl_results$pvalue < 0.05, ]
```

### 4. Functional Impact Assessment
IMAS can evaluate the potential functional consequences of AS events, such as whether they affect known protein domains.

```r
# Map AS events to functional domains
# Requires specific annotation objects or database connections
# Example logic:
final_impact <- IVAS(psi, snp, group)
```

## Key Functions
- `DiffAS()`: Performs statistical testing to detect differential alternative splicing between groups.
- `sQTL()`: Performs association analysis between SNPs and PSI values to identify splicing QTLs.
- `IVAS()`: The main wrapper function for integrative analysis of variation in alternative splicing.

## Tips for Success
- **PSI Values**: Ensure PSI values are normalized and range between 0 and 1.
- **Sample Matching**: Ensure that the column names (sample IDs) in the PSI matrix match exactly with the column names in the SNP genotype matrix.
- **Annotation**: AS event IDs should follow a consistent nomenclature (e.g., coordinates or gene symbols) compatible with the reference genome used.

## Reference documentation
- [IMAS Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/IMAS.html)