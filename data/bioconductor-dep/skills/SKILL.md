---
name: bioconductor-dep
description: The bioconductor-dep package provides an integrated workflow for the differential enrichment analysis of quantitative proteomics data. Use when user asks to analyze quantitative proteomics datasets, impute missing values in protein data, perform differential expression testing, or generate visualizations like volcano plots and heatmaps for proteomics results.
homepage: https://bioconductor.org/packages/release/bioc/html/DEP.html
---


# bioconductor-dep

## Overview
The `DEP` package provides an integrated workflow for analyzing quantitative proteomics data (e.g., from MaxQuant or IsobarQuant). It is designed to handle the high rate of missing values typical in proteomics and uses `limma` for robust statistical testing. The workflow centers around `SummarizedExperiment` objects and provides extensive visualization tools for quality control and result exploration.

## Core Workflow

### 1. Data Preparation
Load your tabular data and ensure protein names are unique.
```r
library(DEP)
library(dplyr)

# Load data (e.g., MaxQuant proteinGroups.txt)
data <- read.delim("proteinGroups.txt")

# Filter contaminants and reverse hits
data <- filter(data, Reverse != "+", Potential.contaminant != "+")

# Make unique names using Gene names and Protein IDs
data_unique <- make_unique(data, "Gene.names", "Protein.IDs", delim = ";")
```

### 2. Creating a SummarizedExperiment
Define the experimental design and convert the data frame.
```r
# Identify columns containing intensity data (e.g., LFQ)
lfq_cols <- grep("LFQ.intensity.", colnames(data_unique))

# Option A: Use an experimental design data.frame (columns: label, condition, replicate)
data_se <- make_se(data_unique, lfq_cols, experimental_design)

# Option B: Parse conditions from column names
data_se <- make_se_parse(data_unique, lfq_cols)
```

### 3. Filtering and Normalization
Filter proteins with too many missing values and normalize the variance.
```r
# Filter: thr=0 means identified in all replicates of at least one condition
data_filt <- filter_missval(data_se, thr = 0)

# Normalize using variance stabilizing transformation (vsn)
data_norm <- normalize_vsn(data_filt)
```

### 4. Imputation
Choose an imputation method based on the nature of missing values (MAR vs. MNAR).
```r
# Visualize missing value patterns to decide method
plot_missval(data_filt)
plot_detect(data_filt)

# MNAR: Left-censored imputation (e.g., MinProb)
data_imp <- impute(data_norm, fun = "MinProb", q = 0.01)

# MAR: k-nearest neighbor
data_imp_knn <- impute(data_norm, fun = "knn", rowmax = 0.9)
```

### 5. Differential Analysis
Test for differences between conditions.
```r
# Test every sample vs. a specific control
data_diff <- test_diff(data_imp, type = "control", control = "Ctrl")

# Define significant proteins (alpha = adjusted p-value, lfc = log2 fold change)
dep <- add_rejections(data_diff, alpha = 0.05, lfc = log2(1.5))
```

## Visualization and Results
`DEP` provides several functions to explore the `dep` object:
- `plot_pca(dep, n = 500)` - PCA plot.
- `plot_cor(dep)` - Correlation matrix.
- `plot_heatmap(dep, type = "centered")` - Heatmap of significant proteins.
- `plot_volcano(dep, contrast = "Ubi6_vs_Ctrl")` - Volcano plot for a specific contrast.
- `plot_single(dep, proteins = c("ProteinA", "ProteinB"))` - Barplots for specific proteins.
- `data_results <- get_results(dep)` - Extract results table with p-values and ratios.

## Wrapper Functions
For standard workflows, use the high-level wrappers:
- `LFQ(data, experimental_design, ...)` for Label-Free Quantification.
- `TMT(data, expdesign, ...)` for Tandem-Mass-Tag data.
- `report(results_object)` to generate an automated HTML/PDF report.

## Reference documentation
- [Introduction to DEP](./references/DEP.md)
- [Missing value handling](./references/MissingValues.md)