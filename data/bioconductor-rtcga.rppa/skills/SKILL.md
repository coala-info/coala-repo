---
name: bioconductor-rtcga.rppa
description: This tool provides access to pre-processed Reverse Phase Protein Array (RPPA) data from The Cancer Genome Atlas (TCGA) for proteomic analysis. Use when user asks to load TCGA protein expression datasets, integrate RPPA data with clinical or mutation information, or compare protein expression levels across different cancer cohorts.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.RPPA.html
---


# bioconductor-rtcga.rppa

name: bioconductor-rtcga.rppa
description: Access and process Reverse Phase Protein Array (RPPA) data from The Cancer Genome Atlas (TCGA). Use this skill to load pre-processed RPPA datasets for various cancer cohorts, integrate protein expression data with clinical or mutation data, and perform comparative proteomics analysis across TCGA studies.

# bioconductor-rtcga.rppa

## Overview
The `RTCGA.RPPA` package is a data-experiment package providing protein expression data (Level 3) from The Cancer Genome Atlas (TCGA) project. It contains normalized RPPA values for thousands of samples across multiple cancer types. This package is part of the RTCGA family, designed to make TCGA data easily accessible in a tidy format compatible with `ggplot2` and `dplyr`.

## Loading RPPA Data
The package provides pre-loaded datasets named using the convention `[COHORT].RPPA`.

```r
library(RTCGA.RPPA)

# List available RPPA datasets in the package
data(package = "RTCGA.RPPA")

# Load specific cohort data (e.g., Breast Invasive Carcinoma)
data(BRCA.RPPA)

# View structure (usually bcr_patient_barcode + protein columns)
head(BRCA.RPPA[, 1:5])
```

## Common Workflows

### Integrating RPPA with Clinical Data
To analyze protein expression in the context of patient survival or clinical stages, join RPPA data with clinical data from `RTCGA.clinical`.

```r
library(RTCGA.clinical)
library(dplyr)

# Load RPPA and Clinical data
data(BRCA.RPPA)
data(BRCA.clinical)

# Extract survival information
survivalTCGA(BRCA.clinical) -> brca_surv

# Join datasets by barcode
# Note: RPPA barcodes are often longer (sample level); clinical are patient level (12 chars)
brca_surv %>%
  mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12)) %>%
  inner_join(BRCA.RPPA %>% 
               mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12)), 
             by = "bcr_patient_barcode") -> joined_data
```

### Comparing Protein Expression Across Cohorts
Use `RTCGA::expressionsTCGA` to combine multiple RPPA datasets for comparative analysis.

```r
library(RTCGA)
# Combine RPPA data for Ovarian and Breast cancer
combined_rppa <- expressionsTCGA(OV.RPPA, BRCA.RPPA)

# The 'dataset' column identifies the cohort
combined_rppa %>%
  group_by(dataset) %>%
  summarise(mean_HER2 = mean(`HER2`, na.rm = TRUE))
```

### Visualizing Protein Expression
Since the data is in a tidy format, use `boxplotTCGA` or standard `ggplot2` for visualization.

```r
library(RTCGA)
# Boxplot of a specific protein across cohorts
boxplotTCGA(combined_rppa, 
            x = "dataset", 
            y = "HER2", 
            fill = "dataset",
            ylab = "Protein Expression (RPPA)",
            title = "HER2 Expression: OV vs BRCA")
```

## Data Acquisition (Advanced)
If you need to download the latest RPPA data directly from Firehose instead of using the package defaults:

1. Use `infoTCGA()` to find cohort names.
2. Use `downloadTCGA` with `dataSet = "protein_normalization__data.Level_3"`.
3. Use `readTCGA(path, dataType = "RPPA")` to import and automatically transpose the data into the tidy format used by this package.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA package to download RPPA data](./references/downloading_RPPA_datasets.md)