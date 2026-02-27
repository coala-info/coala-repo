---
name: bioconductor-rtcga.mrna
description: This package provides curated mRNA expression datasets from The Cancer Genome Atlas (TCGA) for various cancer cohorts. Use when user asks to load pre-processed TCGA mRNA data, integrate expression datasets with clinical or mutation data, or visualize gene expression using PCA, boxplots, and heatmaps.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.mRNA.html
---


# bioconductor-rtcga.mrna

name: bioconductor-rtcga.mrna
description: Access and analyze The Cancer Genome Atlas (TCGA) mRNA expression data. Use this skill when you need to load pre-processed mRNA datasets for various cancer cohorts, integrate them with clinical or mutation data, and perform visualizations like PCA, boxplots, or heatmaps using the RTCGA ecosystem.

# bioconductor-rtcga.mrna

## Overview
The `RTCGA.mRNA` package is a data-experiment package providing mRNA expression datasets from The Cancer Genome Atlas (TCGA). It serves as a curated repository of mRNA data (typically from AgilentG4502A platforms) for multiple cancer cohorts, formatted for immediate use in R. It is designed to work seamlessly with the `RTCGA` parent package for data integration and visualization.

## Loading mRNA Data
Datasets are named using the convention `[COHORT].mRNA`. To use them, you must load the library and the specific cohort data.

```r
library(RTCGA.mRNA)
# Example: Load Breast Invasive Carcinoma mRNA data
data(BRCA.mRNA)
# Example: Load Ovarian Serous Cystadenocarcinoma mRNA data
data(OV.mRNA)
```

Commonly available cohorts include: `BRCA`, `OV`, `LUAD`, `LUSC`, `KIRC`, `GBM`, `UCEC`, `COAD`, `READ`, etc.

## Typical Workflow

### 1. Data Integration
Use `RTCGA::expressionsTCGA()` to combine multiple mRNA datasets or extract specific genes.

```r
library(RTCGA)
library(dplyr)

# Combine cohorts and extract specific genes (e.g., MET and ZNF500)
expressionsTCGA(BRCA.mRNA, OV.mRNA, HNSC.mRNA, 
                extract.cols = c("MET", "ZNF500")) %>%
  rename(cohort = dataset) -> combined_data
```

### 2. Visualization
The `RTCGA` package provides specialized functions to visualize the data contained in `RTCGA.mRNA`.

**Principal Component Analysis (PCA):**
```r
# Biplot of 2 main components
pca_plot <- pcaTCGA(combined_data, "cohort")
plot(pca_plot)
```

**Boxplots for Gene Expression:**
```r
# Compare gene expression across cohorts
boxplotTCGA(combined_data, 
            x = "cohort", 
            y = "log1p(MET)", 
            fill = "cohort")
```

**Heatmaps:**
```r
# Create a heatmap of median expressions
combined_data %>%
  group_by(cohort) %>%
  summarise(across(where(is.numeric), median)) -> medians

heatmapTCGA(medians, x = "cohort", y = "MET", fill = "ZNF500")
```

### 3. Survival Analysis Integration
To perform survival analysis, join mRNA data with clinical data from `RTCGA.clinical`.

```r
library(RTCGA.clinical)
data(BRCA.clinical)

# Extract survival info
survivalTCGA(BRCA.clinical) -> brca_surv

# Join with mRNA expression (using bcr_patient_barcode)
brca_surv %>%
  left_join(BRCA.mRNA, by = "bcr_patient_barcode") -> surv_mRNA_data
```

## Tips and Best Practices
- **Barcode Matching:** TCGA barcodes in mRNA data often include sample type (e.g., characters 14-15). "01" usually denotes primary tumor. Use `substr(bcr_patient_barcode, 1, 12)` to match across clinical datasets which often use shorter barcodes.
- **Gene Naming:** Genes are often stored as `Symbol|EntrezID` (e.g., `MET|4233`). Use `extract.cols` in `expressionsTCGA` to handle these names easily.
- **Data Transformation:** mRNA data is often provided in a normalized format, but applying `log1p()` is common for visualization to handle skewness.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA package to download mRNA data](./references/downloading_mRNA_datasets.md)