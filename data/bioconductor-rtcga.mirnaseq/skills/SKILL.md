---
name: bioconductor-rtcga.mirnaseq
description: This tool provides access to pre-processed miRNA expression data from The Cancer Genome Atlas (TCGA) for genomic analysis. Use when user asks to load miRNASeq datasets for cancer cohorts, extract specific miRNA expression levels, or integrate miRNA data with clinical information for survival analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.miRNASeq.html
---


# bioconductor-rtcga.mirnaseq

name: bioconductor-rtcga.mirnaseq
description: Access and analyze miRNASeq data from The Cancer Genome Atlas (TCGA) using the RTCGA.miRNASeq data package. Use this skill to load pre-processed miRNA expression datasets for various cancer cohorts, integrate them with other TCGA data types, and perform comparative genomic analyses.

## Overview
The `RTCGA.miRNASeq` package is a Bioconductor data experiment package providing miRNA expression profiles from The Cancer Genome Atlas (TCGA). It contains tidy-formatted data for multiple cancer cohorts (e.g., BRCA, OV, LUAD), typically sourced from Illumina Genome Analyzer or Illumina HiSeq 2000 platforms. This skill helps you load these datasets and use them alongside the core `RTCGA` package for visualization and survival analysis.

## Loading miRNASeq Data
Datasets are named using the convention `[COHORT].miRNASeq`. To use them, you must load both the data package and the core `RTCGA` package.

```r
library(RTCGA)
library(RTCGA.miRNASeq)

# List available miRNASeq datasets
data(package = "RTCGA.miRNASeq")

# Load specific cohort data (e.g., Breast Invasive Carcinoma)
data(BRCA.miRNASeq)
head(BRCA.miRNASeq[, 1:5])
```

## Typical Workflow

### 1. Extracting Specific miRNA Expressions
Use `expressionsTCGA()` to combine multiple cohorts or extract specific miRNA columns. Note that miRNA names in these datasets often follow the TCGA naming convention (e.g., `mimiR-145`).

```r
library(dplyr)
# Extract specific miRNA for multiple cohorts
expressionsTCGA(BRCA.miRNASeq, OV.miRNASeq, 
                extract.cols = "hsa-mir-145") %>%
  rename(cohort = dataset) -> mir_data
```

### 2. Data Cleaning and Filtering
TCGA barcodes contain metadata. Use `substr()` to filter for primary tumor samples (code "01").

```r
mir_data %>%
  filter(substr(bcr_patient_barcode, 14, 15) == "01") -> tumor_samples
```

### 3. Visualization
The `RTCGA` package provides wrapper functions for ggplot2 to visualize expression data.

```r
# Boxplot of miRNA expression across cohorts
boxplotTCGA(tumor_samples, 
            x = "cohort", 
            y = "`hsa-mir-145`", 
            fill = "cohort")

# PCA plot
pcaTCGA(tumor_samples, "cohort")
```

### 4. Integration with Clinical Data
To perform survival analysis, join miRNA expression data with clinical data from `RTCGA.clinical`.

```r
library(RTCGA.clinical)
data(BRCA.clinical)

survivalTCGA(BRCA.clinical) %>%
  left_join(BRCA.miRNASeq, by = "bcr_patient_barcode") -> survival_mir_data
```

## Key Functions to Use
- `expressionsTCGA()`: The primary tool for gathering expression data from RTCGA data packages.
- `boxplotTCGA()`: Create comparative boxplots for expression levels.
- `pcaTCGA()`: Perform and plot Principal Component Analysis.
- `heatmapTCGA()`: Generate heatmaps of expression medians.

## Tips
- **Machine Metadata**: Datasets in this package often include a `machine` column indicating whether data was produced by "Illumina Genome Analyzer" or "Illumina HiSeq 2000".
- **Column Names**: miRNA names may contain special characters; use backticks (e.g., `` `hsa-mir-21` ``) when referencing them in formulas or dplyr verbs.
- **Barcode Length**: When joining with clinical data, ensure barcodes are trimmed to the same length (usually 12 characters for patient-level matching).

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA package to download miRNASeq data](./references/downloading_miRNASeq_datasets.md)