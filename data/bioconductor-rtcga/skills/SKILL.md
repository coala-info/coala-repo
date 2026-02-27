---
name: bioconductor-rtcga
description: The RTCGA package provides a streamlined interface for downloading, processing, and visualizing genomic and clinical data from The Cancer Genome Atlas via the Broad GDAC Firehose. Use when user asks to download TCGA datasets, load clinical or mutation data into tidy formats, perform survival analysis, or create genomic visualizations like PCA plots and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/RTCGA.html
---


# bioconductor-rtcga

## Overview
The `RTCGA` package provides a streamlined interface for downloading and integrating data from The Cancer Genome Atlas (TCGA) via the Broad GDAC Firehose. It simplifies the process of accessing complex genomic and clinical datasets by providing wrapper functions for data acquisition, cleaning, and visualization.

## Core Workflow

### 1. Data Discovery
Before downloading, identify available cohorts and release dates.
```r
library(RTCGA)

# List all available cancer cohorts (e.g., BRCA, OV, LUAD)
infoTCGA()

# Check available release dates
checkTCGA('Dates')

# List datasets for a specific cohort and date
checkTCGA('DataSets', cancerType = 'BRCA', date = '2016-01-28')
```

### 2. Downloading Data
Use `downloadTCGA` to fetch data to a local directory.
```r
dir.create("tcga_data")
downloadTCGA(
    cancerTypes = "BRCA",
    dataSet = "Merge_Clinical.Level_1",
    destDir = "tcga_data"
)
```

### 3. Loading Data
The package provides specific functions to read different data types into tidy formats.
- `readTCGA(path, dataType)`: General reader for downloaded files.
- `expressionsTCGA()`: Specifically for RNASeq/mRNA data.
- `mutationsTCGA()`: Specifically for mutation data.
- `clinicalTCGA()`: Specifically for clinical data.
- `survivalTCGA()`: Extracts survival information (times and status).

### 4. Visualization
`RTCGA` includes high-level plotting functions tailored for TCGA data structures:

**Survival Analysis (Kaplan-Meier):**
```r
# Requires survival data (times, patient.vital_status)
kmTCGA(data, explanatory.names = c("gene_status", "cohort"), pval = TRUE)
```

**Principal Component Analysis (PCA):**
```r
# Useful for RNASeq expression data
pca_plot <- pcaTCGA(expression_data, "cohort_variable")
plot(pca_plot)
```

**Boxplots:**
```r
# Compare gene expression across cohorts
boxplotTCGA(data, x = "cohort", y = "log1p(GENE_NAME)", fill = "cohort")
```

**Heatmaps:**
```r
# Visualize medians or expression levels
heatmapTCGA(data, x = "variable1", y = "variable2", fill = "expression_value")
```

## Tips for Success
- **Patient Barcodes:** TCGA barcodes are often 12, 15, or 28 characters. Use `substr(bcr_patient_barcode, 1, 12)` to normalize IDs when joining clinical data with mutation or expression data.
- **Sample Types:** In the barcode, the 14th and 15th characters indicate sample type (e.g., "01" is Primary Solid Tumor, "11" is Solid Tissue Normal). Filter your data accordingly: `filter(substr(bcr_patient_barcode, 14, 15) == "01")`.
- **Data Packages:** For faster access without downloading from Firehose, Bioconductor hosts pre-processed data packages like `RTCGA.clinical`, `RTCGA.rnaseq`, and `RTCGA.mutations`.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [RTCGA Workflow Summary](./references/RTCGA_Workflow.md)
- [Visualizations](./references/Visualizations.Rmd)