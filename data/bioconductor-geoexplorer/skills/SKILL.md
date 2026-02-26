---
name: bioconductor-geoexplorer
description: GEOexplorer is an R package and Shiny application for the automated retrieval, exploratory analysis, and differential expression analysis of transcriptomic data from the Gene Expression Omnibus. Use when user asks to perform differential gene expression analysis, conduct gene enrichment analysis, or visualize gene expression data from GEO accessions.
homepage: https://bioconductor.org/packages/release/bioc/html/GEOexplorer.html
---


# bioconductor-geoexplorer

## Overview
GEOexplorer is a comprehensive R package and Shiny-based web application designed for the analysis of transcriptomic data. It bridges the gap between raw GEO data and biological insights by providing automated workflows for data retrieval, exploratory data analysis (EDA), differential gene expression analysis (DGEA), and gene enrichment analysis (GEA). It is particularly useful for integrating multiple datasets and performing batch corrections.

## Core Workflow

### 1. Launching the Interface
While the package provides underlying functions, the primary mode of interaction is through its integrated Shiny application.
```r
library(GEOexplorer)
loadApp()
```

### 2. Data Acquisition
Data can be sourced in three ways:
*   **GEO Search:** Use keywords to find relevant datasets within the app.
*   **GEO Accession:** Directly load a dataset using its ID (e.g., "GSE93939").
*   **User Upload:** Upload custom CSV files following the package's templates (Gene Expression File and Experimental File).

### 3. Exploratory Data Analysis (EDA)
Before performing differential analysis, evaluate the data quality:
*   **Log Transformation:** Auto-detect or manually apply log2 transformation.
*   **RNA-seq Specifics:** For RNA-seq, ensure raw counts are used for DGEA. Use the "Expression Density Plot" and "Box-and-Whisker Plot" to verify if data is already transformed (bell-shaped curves or negative values suggest prior transformation).
*   **Normalisation:** Check for consistency across samples. If microarray data is not normalised, "Force Normalisation" should be applied in the next step.
*   **PCA:** Identify clusters and potential batch effects.

### 4. Differential Gene Expression Analysis (DGEA)
GEOexplorer utilizes the `limma` framework for robust statistical analysis:
*   **Group Definition:** Assign samples to Group 1 (e.g., Treatment/Target) and Group 2 (e.g., Control).
*   **P-value Adjustment:** Default is Benjamini & Hochberg (FDR).
*   **Limma Precision Weights (voom):** Always apply for RNA-seq data. For microarray, apply if a strong mean-variance trend is observed in EDA.
*   **Force Normalisation:** Recommended for RNA-seq and non-normalised microarray datasets.
*   **Significance:** Set the alpha level (e.g., 0.05) to identify up- and down-regulated genes.

### 5. Gene Enrichment Analysis (GEA)
Translate gene lists into biological pathways:
*   **Gene Symbols:** Ensure the dataset contains a column with valid gene symbols.
*   **Database Selection:** Choose from available libraries (e.g., Enrichr-supported databases).
*   **Analysis:** Identify significantly enriched biological processes or pathways.

## Tips for Success
*   **RNA-seq Integrity:** Never perform DGEA on RNA-seq data that has already been log-transformed or CPM-transformed; GEOexplorer requires raw counts to correctly apply `voom` weights.
*   **Missing Values:** For microarray data, use the built-in KNN imputation feature if the dataset contains NAs.
*   **Batch Correction:** When merging multiple GEO datasets, utilize the integration features to harmonize data before DGEA.
*   **Templates:** If a GEO dataset fails to load automatically, download the "Gene Expression File Template" from the "Example Datasets" tab and format the data manually in Excel/CSV.

## Reference documentation
- [GEOexplorer](./references/GEOexplorer.Rmd)