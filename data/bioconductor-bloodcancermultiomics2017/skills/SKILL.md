---
name: bioconductor-bloodcancermultiomics2017
description: This package provides a multi-omic dataset and analysis scripts integrating drug screens with genomic, transcriptomic, and methylomic profiling for blood cancer patients. Use when user asks to load patient metadata, analyze drug sensitivity, access RNA-seq or mutation data, and reproduce statistical analyses from the 2017 blood cancer study.
homepage: https://bioconductor.org/packages/release/data/experiment/html/BloodCancerMultiOmics2017.html
---

# bioconductor-bloodcancermultiomics2017

## Overview

The `BloodCancerMultiOmics2017` package provides a comprehensive multi-omic dataset and the complete executable transcript of the statistical analysis for the study "Drug-perturbation-based stratification of blood cancer." It integrates functional drug screens (91 drugs) with molecular profiling (RNA-seq, mutations, and methylation) for 271 patient samples.

## Core Workflows

### 1. Loading Data
The package stores data in various Bioconductor objects (`ExpressionSet`, `SummarizedExperiment`, `DESeqDataSet`). Load all primary datasets using:

```r
library(BloodCancerMultiOmics2017)
data("conctab", "drpar", "lpdAll", "patmeta", "drugs", "mutCOM", "dds", "methData")
```

### 2. Exploring Patient Metadata
The `patmeta` data frame contains clinical information, including diagnosis, IGHV status (for CLL), and treatment history.

```r
# Summary of diagnoses
table(patmeta$Diagnosis)

# Check IGHV status for CLL patients
table(patmeta[patmeta$Diagnosis == "CLL", "IGHV"])
```

### 3. Analyzing Drug Sensitivity
Drug screen results are stored in `drpar` (an `NChannelSet`) and `lpdAll`. Viability is measured across 5 concentration steps.

```r
# View available concentration channels
channelNames(drpar)

# Access viability for a specific concentration (e.g., lowest)
viab_low <- assayData(drpar)[["viaraw.1"]]

# Get drug metadata (targets, pathways)
head(drugs)
```

### 4. Genomic and Transcriptomic Integration
- **Mutations:** `mutCOM` contains binary mutation data.
- **Expression:** `dds` is a `DESeqDataSet` containing RNA-seq counts.
- **Methylation:** `methData` contains beta values for the 5,000 most variable CpG sites.

```r
# Access mutation matrix
mut_matrix <- assayData(mutCOM)$binary

# Access RNA-seq counts
library(SummarizedExperiment)
counts_data <- assay(dds)
```

### 5. Reproducing Paper Figures
The package includes helper functions and specific data subsets used in the original publication, such as `exprTreat` (expression changes after 12h drug treatment).

```r
# Example: Correlation between drugs in CLL
# Note: This requires internal package functions or standard R correlation analysis
cll_samples <- rownames(patmeta[patmeta$Diagnosis == "CLL", ])
viab_cll <- assayData(drpar)[["viaraw.4_5"]][, cll_samples]
cor_matrix <- cor(t(viab_cll), use = "pairwise.complete.obs")
```

## Tips for Analysis
- **Patient IDs:** Ensure consistency across objects. Use `colnames(drpar)`, `rownames(patmeta)`, and `colData(dds)$PatID` to align samples.
- **Drug IDs:** Drugs are often referenced by IDs (e.g., "D_002"). Use the `drugs` object to map these to common names (e.g., "Ibrutinib").
- **Missing Data:** Not every patient has every omic type. Use `complete.cases` or intersection logic when performing multi-omic integration.

## Reference documentation
- [BloodCancerMultiOmics2017 - data overview](./references/BloodCancerMultiOmics2017-dataOverview.md)
- [BloodCancerMultiOmics2017 - complete analysis](./references/BloodCancerMultiOmics2017.md)