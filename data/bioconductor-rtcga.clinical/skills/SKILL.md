---
name: bioconductor-rtcga.clinical
description: This package provides pre-processed clinical data from The Cancer Genome Atlas (TCGA) as tidy R data frames. Use when user asks to load TCGA clinical datasets, extract survival information, perform Kaplan-Meier analysis, or integrate clinical parameters with mutation data.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.clinical.html
---


# bioconductor-rtcga.clinical

## Overview
The `RTCGA.clinical` package provides pre-processed clinical data from The Cancer Genome Atlas (TCGA). It is part of the `RTCGA` family of packages, which simplifies the process of downloading and integrating complex TCGA datasets into tidy R data frames. This skill focuses on loading clinical data, extracting survival information, and preparing data for visualization and statistical analysis.

## Loading Clinical Data
Clinical datasets are named using the convention `[COHORT].clinical`.

```r
library(RTCGA.clinical)

# Load specific cohort data
data(BRCA.clinical)
data(OV.clinical)

# View available columns (clinical parameters)
colnames(BRCA.clinical)
```

## Common Workflows

### 1. Extracting Survival Information
The `survivalTCGA()` function from the base `RTCGA` package is the primary tool for extracting time-to-event data from clinical objects.

```r
library(RTCGA)

# Extract survival data for multiple cohorts
survival_data <- survivalTCGA(
  BRCA.clinical, 
  OV.clinical, 
  extract.cols = "admin.disease_code"
)

# Resulting columns: times, patient.vital_status, and any extracted columns
```

### 2. Survival Analysis (Kaplan-Meier)
Use `kmTCGA()` to generate survival plots. It integrates with `survminer` for high-quality visualizations.

```r
library(RTCGA)
library(magrittr)

BRCA.clinical %>%
  survivalTCGA(extract.cols = "patient.gender") %>%
  kmTCGA(
    explanatory.names = "patient.gender",
    pval = TRUE,
    xlim = c(0, 4000)
  )
```

### 3. Integrating Clinical and Mutation Data
To analyze survival based on mutation status, join clinical data with mutation data using the `bcr_patient_barcode`.

```r
library(RTCGA.mutations)
library(dplyr)

# 1. Get mutation status (e.g., TP53)
mutationsTCGA(BRCA.mutations) %>%
  filter(Hugo_Symbol == 'TP53') %>%
  mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12)) -> brca_tp53

# 2. Get clinical survival data
survivalTCGA(BRCA.clinical) -> brca_surv

# 3. Join and label
brca_surv %>%
  left_join(brca_tp53, by = "bcr_patient_barcode") %>%
  mutate(TP53_Status = ifelse(!is.na(Variant_Classification), "Mutant", "Wild-type")) -> plot_data

# 4. Plot
kmTCGA(plot_data, explanatory.names = "TP53_Status")
```

## Tips and Best Practices
- **Barcode Matching**: TCGA barcodes in clinical data are often 12 characters (Patient level), while RNASeq or Mutation data may be 15+ characters (Sample/Vial level). Use `substr(barcode, 1, 12)` to ensure successful joins.
- **Cohort Abbreviations**: Use `infoTCGA()` to see a list of all available cancer cohort abbreviations (e.g., ACC, BLCA, BRCA, LUAD).
- **Tissue Types**: In barcodes, the 14th and 15th characters indicate tissue type (e.g., "01" is primary solid tumor, "11" is normal tissue). Filter clinical joins accordingly if using sample-specific data.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA package to download clinical data](./references/downloading_clinical_datasets.md)