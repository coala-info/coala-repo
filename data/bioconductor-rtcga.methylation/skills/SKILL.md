---
name: bioconductor-rtcga.methylation
description: This tool provides access to tidy-formatted DNA methylation data from The Cancer Genome Atlas (TCGA) for various cancer cohorts. Use when user asks to load TCGA methylation datasets, integrate methylation data with clinical or mutation data, or analyze CpG site levels across cancer samples.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.methylation.html
---


# bioconductor-rtcga.methylation

name: bioconductor-rtcga.methylation
description: Access and process The Cancer Genome Atlas (TCGA) methylation data. Use this skill when you need to load, analyze, or visualize DNA methylation datasets from various cancer cohorts provided by the RTCGA project.

# bioconductor-rtcga.methylation

## Overview
The `RTCGA.methylation` package is a data-experiment package providing DNA methylation data from The Cancer Genome Atlas (TCGA). It works in conjunction with the `RTCGA` core package to provide tidy-formatted methylation data, typically measured using the Illumina HumanMethylation27 platform. This skill helps you load these large datasets and integrate them with clinical or mutation data for comprehensive genomic analysis.

## Loading Methylation Data
The package contains pre-processed datasets for various cancer cohorts (e.g., BRCA, OV, LUAD).

```r
# Load the package
library(RTCGA.methylation)

# List available methylation datasets in the package
data(package = "RTCGA.methylation")

# Load a specific cohort (e.g., Breast Invasive Carcinoma)
data(BRCA.methylation)

# View the structure (tidy format: patients in rows, CpG sites in columns)
head(BRCA.methylation[, 1:5])
```

## Typical Workflow

### 1. Data Integration
Methylation data is most powerful when joined with clinical data to analyze survival or disease progression.

```r
library(RTCGA)
library(RTCGA.clinical)
library(dplyr)

# Load clinical and methylation data
data(BRCA.clinical)
data(BRCA.methylation)

# Join datasets by bcr_patient_barcode
# Note: Methylation barcodes often have extra suffixes; use substr to match
BRCA.methylation %>%
  mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12)) %>%
  inner_join(BRCA.clinical, by = "bcr_patient_barcode") -> combined_data
```

### 2. Extracting Specific Probes
Since methylation datasets are high-dimensional, you often need to extract specific CpG sites or genes of interest.

```r
# Using RTCGA's expressionsTCGA-like logic or standard dplyr
# Methylation data in this package is already in a data.frame format
target_probes <- BRCA.methylation %>%
  select(bcr_patient_barcode, starts_with("cg000")) 
```

### 3. Visualization
Use the `RTCGA` package's visualization functions to explore methylation patterns.

```r
# Boxplot of methylation levels across different cohorts (if multiple are loaded)
library(RTCGA.rnaseq) # For boxplotTCGA
# Example: Comparing methylation of a specific probe across cohorts
# (Requires merging datasets first)
```

## Working with Large Cohorts
Some cohorts (like Ovarian Cancer - OV) are split into multiple parts (e.g., `OV.methylation1`, `OV.methylation2`) due to size constraints. You should bind them before analysis:

```r
data(OV.methylation1)
data(OV.methylation2)
OV.methylation <- rbind(OV.methylation1, OV.methylation2)
```

## Tips
- **Barcode Matching**: TCGA barcodes for methylation samples often include sample type codes (e.g., "-01" for primary tumor). Always check barcode lengths when joining with clinical data (which usually uses the 12-character participant ID).
- **Memory Management**: Methylation data is memory-intensive. Load only the cohorts necessary for your specific analysis.
- **Data Version**: The standard `RTCGA.methylation` package typically contains the 2015-11-01 release. For other dates, you may need to use `downloadTCGA`.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA package to download methylation data](./references/downloading_methylation_datasets.md)