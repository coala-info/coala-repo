---
name: bioconductor-rtcga.rnaseq
description: This package provides processed RNA-seq gene expression data from The Cancer Genome Atlas for various cancer cohorts. Use when user asks to load TCGA RNA-seq datasets, extract specific gene expression values, visualize expression across cohorts using boxplots or PCA, or integrate transcriptomic data with clinical and mutation datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RTCGA.rnaseq.html
---

# bioconductor-rtcga.rnaseq

## Overview
The `RTCGA.rnaseq` package is a Bioconductor data package providing processed RNA-seq data from The Cancer Genome Atlas (TCGA). It contains RSEM normalized gene expression values for various cancer cohorts. This skill facilitates the extraction, visualization, and integration of these high-dimensional datasets with other TCGA data types (like clinical or mutation data) using the `RTCGA` ecosystem.

## Loading Data
Datasets in this package are named using the convention `[COHORT].rnaseq`. 

```r
library(RTCGA.rnaseq)
# Example: Load Breast Invasive Carcinoma RNA-seq data
data(BRCA.rnaseq)
# Check available cohorts
?rnaseq 
```

## Key Workflows

### 1. Extracting Gene Expressions
Use `expressionsTCGA()` to extract specific genes from one or more cohort datasets. Genes are typically identified by "GeneSymbol|EntrezID".

```r
library(RTCGA)
library(dplyr)

# Extract MET gene expression for multiple cohorts
expr_data <- expressionsTCGA(
  ACC.rnaseq, 
  BLCA.rnaseq, 
  BRCA.rnaseq, 
  extract.cols = "MET|4233"
) %>%
  rename(cohort = dataset, MET = `MET|4233`) %>%
  # Filter for primary tumor samples (barcode suffix "01")
  filter(substr(bcr_patient_barcode, 14, 15) == "01")
```

### 2. Visualizing Expression Data
The `RTCGA` package provides wrapper functions for `ggplot2` to visualize RNA-seq data.

**Boxplots across cohorts:**
```r
boxplotTCGA(
  expr_data,
  x = "reorder(cohort, log1p(MET), median)",
  y = "log1p(MET)",
  fill = "cohort",
  xlab = "Cohort Type",
  ylab = "Logarithm of MET"
)
```

**Principal Component Analysis (PCA):**
```r
# Compare multiple cohorts via PCA
pca_plot <- pcaTCGA(expr_data, "cohort")
plot(pca_plot)
```

**Heatmaps:**
```r
# Create a heatmap of median expressions
heatmap_data <- expr_data %>%
  group_by(cohort) %>%
  summarise(median_MET = median(MET))

heatmapTCGA(heatmap_data, "cohort", fill = "median_MET")
```

### 3. Integrating with Clinical/Mutation Data
To perform survival analysis or group expressions by mutation status, join the RNA-seq data with clinical or mutation datasets using the `bcr_patient_barcode`.

```r
# Example: Survival analysis based on RNA-seq expression levels
library(RTCGA.clinical)
# 1. Get survival data
surv_data <- survivalTCGA(BRCA.clinical)
# 2. Join with expression data (ensure barcode lengths match)
combined <- inner_join(surv_data, expr_data, by = "bcr_patient_barcode")
```

## Tips
- **Sample Types:** TCGA barcodes indicate sample types. "01" is primary solid tumor, "11" is solid tissue normal. Use `filter(substr(bcr_patient_barcode, 14, 15) == "01")` to focus on cancer samples.
- **Gene Naming:** If you are unsure of the exact column name for a gene, use `colnames(BRCA.rnaseq)` or a regex in `extract.cols`.
- **Log Transformation:** RNA-seq data is often highly skewed; use `log1p()` (log(x+1)) for better visualization in boxplots and PCA.

## Reference documentation
- [Quick Data Download Guide](./references/Data_Download.Rmd)
- [RTCGA package workflow](./references/RTCGA_Workflow.Rmd)
- [Visualizations](./references/Visualizations.Rmd)
- [Using RTCGA package to download RNAseq data](./references/download_rnaseq_datasets.md)