---
name: bioconductor-matrixqcvis
description: MatrixQCvis provides an interactive Shiny-based dashboard for the quality control and exploration of matrix-like quantitative omics data stored in SummarizedExperiment objects. Use when user asks to perform interactive quality control, identify outliers or batch effects, visualize missing value patterns, or conduct differential expression analysis on proteomics and metabolomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/MatrixQCvis.html
---


# bioconductor-matrixqcvis

## Overview

`MatrixQCvis` provides an interactive Shiny-based dashboard (`shinyQC`) for the quality control (QC) and exploration of matrix-like quantitative omics data. While designed with mass spectrometry (proteomics/metabolomics) in mind—specifically handling missing values—it is compatible with any data stored in a `SummarizedExperiment` object. It enables users to identify outliers, drifts, and batch effects through various visualizations including PCA, UMAP, MA plots, and ECDF plots.

## Core Workflow

### 1. Data Preparation
The package requires a `SummarizedExperiment` object. Ensure your data meets these criteria:
- `rownames(se)` must be feature names (e.g., Protein IDs, Gene symbols).
- `colnames(se)` must be sample names.
- `colnames(se)`, `colnames(assay(se))`, and `rownames(colData(se))` must be identical.

```r
library(MatrixQCvis)
library(SummarizedExperiment)

# Example: Creating a SummarizedExperiment from a matrix
# assay_data: features x samples
se <- SummarizedExperiment(assays = list(counts = assay_data),
                            colData = sample_metadata,
                            rowData = feature_metadata)

# Ensure no features have zero variance (common requirement for QC plots)
se_sds <- apply(assay(se), 1, sd, na.rm = TRUE)
se <- se[!is.na(se_sds) & se_sds > 0, ]
```

### 2. Launching the Interface
The primary entry point is the `shinyQC` function.

```r
# Launch the interactive dashboard
# If assigned to an object, it returns the processed/imputed SE object upon exit
qc_res <- shinyQC(se)
```

### 3. Key Features in the UI
- **Sidebar**: Configure global settings for normalization (sum, quantile), batch correction (limma, ComBat), transformation (log2, vsn), and imputation (KNN, BPCA, MLE, etc.).
- **Samples Tab**: Visualize sample metadata distributions and proportions.
- **Values Tab**: Inspect intensity distributions (Boxplots/Violin), trends/drifts, coefficients of variation, and Mean-SD plots.
- **Missing Values Tab**: (Only visible if `NA`s are present) Analyze the frequency and patterns of missing data across samples and features using UpSet plots.
- **Dimension Reduction**: Perform PCA, PCoA, NMDS, tSNE, or UMAP to identify clusters or batch effects.
- **DE Tab**: Perform differential expression using `limma` (moderated t-tests) or `proDA` (probabilistic dropout analysis for proteomics).

## Differential Expression (DE) Setup
Within the `DE` tab, you must specify the experimental design using R formula syntax:
- **Model Formula**: e.g., `~ condition + 0` (to specify levels without an intercept).
- **Contrasts**: e.g., `conditionA - conditionB`.
- **Methods**: 
    - `limma`: Best for complete data or after imputation.
    - `proDA`: Best for proteomics with missing values (models the dropout probability).

## Tips for Effective QC
- **Batch Correction**: Always inspect dimension reduction plots (PCA/UMAP) *before* applying batch correction to ensure the correction is justified.
- **Imputation**: If your data has missing values, the `imputed` data set will be used for Dimension Reduction and `limma` DE.
- **Reporting**: Use the "Generate report" button in the sidebar to export a Markdown report of all current visualizations and settings.
- **Return Value**: To save the results of your interactive session (e.g., the imputed or batch-corrected matrix), you must assign the `shinyQC` call to a variable.

## Reference documentation

- [MatrixQCvis: shiny-based interactive data quality exploration of omics data](./references/MatrixQCvis.md)