---
name: bioconductor-rtcga.mutations
description: This package provides somatic mutation data from various cancer cohorts for use in the RTCGA analysis workflow. Use when user asks to load TCGA mutation datasets, merge and filter somatic mutations, perform survival analysis based on mutation status, or visualize mutations alongside gene expression data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.mutations.html
---


# bioconductor-rtcga.mutations

## Overview
The `RTCGA.mutations` package is a data-only experiment package providing somatic mutation information from the Broad GDAC Firehose. It contains Mutation Annotation Format (MAF) data for various cancer cohorts, processed into a tidy format compatible with the `RTCGA` workflow. This skill facilitates loading these datasets and using them alongside `RTCGA` visualization and analysis tools.

## Loading Mutation Data
Datasets are named using the convention `[COHORT].mutations`. To use them, you must load both the data package and the core `RTCGA` package.

```r
library(RTCGA)
library(RTCGA.mutations)

# List available mutation datasets
data(package = "RTCGA.mutations")

# Load specific cohorts (e.g., Breast Cancer and Ovarian Cancer)
data(BRCA.mutations)
data(OV.mutations)
```

## Common Workflows

### 1. Merging and Filtering Mutations
Use `mutationsTCGA()` to combine multiple mutation datasets and filter for specific genes or tissue types.

```r
library(dplyr)

# Combine cohorts and filter for TP53 mutations in primary tumor samples (barcode suffix "01")
tp53_mutations <- mutationsTCGA(BRCA.mutations, OV.mutations) %>%
  filter(Hugo_Symbol == "TP53") %>%
  filter(substr(bcr_patient_barcode, 14, 15) == "01") %>%
  mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12))
```

### 2. Survival Analysis by Mutation Status
Integrate mutation data with clinical data from `RTCGA.clinical` to perform Kaplan-Meier survival analysis.

```r
library(RTCGA.clinical)

# 1. Get survival data
survival_data <- survivalTCGA(BRCA.clinical, OV.clinical, extract.cols = "admin.disease_code")

# 2. Join with mutation status
survival_mut_status <- survival_data %>%
  left_join(tp53_mutations, by = "bcr_patient_barcode") %>%
  mutate(TP53_Status = ifelse(!is.na(Variant_Classification), "Mutant", "Wild-type"))

# 3. Plot Kaplan-Meier curves
kmTCGA(survival_mut_status, 
       explanatory.names = c("TP53_Status", "admin.disease_code"),
       pval = TRUE)
```

### 3. Visualizing Mutations with Expression Data
Compare gene expression levels (from `RTCGA.rnaseq`) between mutated and wild-type samples using boxplots.

```r
library(RTCGA.rnaseq)

# Extract expression for a gene (e.g., MET)
expr_data <- expressionsTCGA(BRCA.rnaseq, OV.rnaseq, extract.cols = "MET|4233") %>%
  rename(cohort = dataset, MET = `MET|4233`) %>%
  mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12))

# Join and plot
expr_mut_join <- expr_data %>%
  left_join(tp53_mutations, by = "bcr_patient_barcode") %>%
  mutate(TP53 = ifelse(!is.na(Variant_Classification), "Mut", "WILD"))

boxplotTCGA(expr_mut_join, x = "cohort", y = "log1p(MET)", fill = "TP53")
```

## Tips for Mutation Data
- **Barcodes**: TCGA barcodes in mutation files are often longer than the 12-character patient ID. Use `substr(barcode, 1, 12)` for joining with clinical data and `substr(barcode, 1, 15)` for joining with expression data.
- **Sample Types**: Always filter by the 14th and 15th character of the barcode to ensure you are analyzing "01" (Primary Solid Tumor) vs "11" (Normal Tissue).
- **Missing Data**: If a patient is in the clinical dataset but not the mutation dataset, they are typically considered "Wild-type" or "No Mutation Found" for the specific gene of interest.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA package to download mutations data](./references/downloading_mutations_datasets.md)