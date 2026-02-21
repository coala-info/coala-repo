---
name: bioconductor-hpastainr
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.12/bioc/html/HPAStainR.html
---

# bioconductor-hpastainr

## Overview

HPAStainR is an R package that facilitates the querying of the Human Protein Atlas (HPA) to identify cell types and tissues associated with a user-defined list of genes or proteins. It automates the process of downloading HPA staining data, calculating enrichment scores, and providing p-values for the likelihood of specific cell-type associations based on protein expression levels (High, Medium, Low, or Not Detected).

## Installation

Install the package using `BiocManager`:

```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("HPAStainR")
```

## Workflow: Data Acquisition

HPAStainR requires HPA data frames for normal and cancer tissues. You can obtain these via the built-in downloader or via the `hpar` package for version-controlled analysis.

### Option 1: Live Download (Most Up-to-Date)
```r
library(HPAStainR)
# Downloads and loads data into a list containing hpa_dat and cancer_dat
HPA_data <- HPA_data_downloader(tissue_type = "both", save_file = FALSE)
```

### Option 2: Using hpar (Version Controlled)
```r
library(hpar)
data(hpaNormalTissue)
data(hpaCancer)
```

## Workflow: Querying Proteins

The primary function is `HPAStainR()`. It takes a character vector of gene symbols and returns a ranked tibble of cell types.

```r
gene_list <- c("PRSS1", "PNLIP", "CELA3A", "PRL")

results <- HPAStainR(gene_list = gene_list,
                     hpa_dat = HPA_data$hpa_dat,
                     cancer_dat = HPA_data$cancer_dat,
                     cancer_analysis = "both", # Options: "normal", "cancer", "both"
                     stringency = "normal")    # Options: "normal", "high", "low"
```

### Key Parameters
- `gene_list`: Vector of HGNC gene symbols.
- `cancer_analysis`: Determines if the output includes normal tissues, cancer tissues, or both.
- `stringency`: Filters HPA data based on reliability scores (e.g., "high" only uses "Supported" or "Approved" data).

## Interpreting Results

The output tibble includes:
- **cell_type**: The specific tissue or cancer cell type.
- **percent_high/medium/low**: The percentage of your gene list detected at that staining level.
- **staining_score**: A weighted rank based on staining intensity.
- **p_val / p_val_adj**: Statistical significance of enrichment for rarely staining proteins (those found in <29% of HPA cell types).

## Shiny Interface

To explore the data interactively or generate a summary for the Shiny app:

```r
# Generate summary data for the app
hpa_summary <- HPA_summary_maker(hpa_dat = HPA_data$hpa_dat)

# Launch the local Shiny app
shiny_HPAStainR(hpa_dat = HPA_data$hpa_dat,
                cancer_dat = HPA_data$cancer_dat,
                cell_type_data = hpa_summary)
```

## Reference documentation
- [HPAStainR Vignette (Rmd)](./references/HPAStainR.Rmd)
- [HPAStainR Vignette (Markdown)](./references/HPAStainR.md)