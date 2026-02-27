---
name: bioconductor-qfeatures
description: This tool provides a standardized infrastructure for managing and processing hierarchical quantitative mass spectrometry data in R. Use when user asks to import quantitative data, manage relationships between PSMs and proteins, perform data normalization, handle missing values, or aggregate features.
homepage: https://bioconductor.org/packages/release/bioc/html/QFeatures.html
---


# bioconductor-qfeatures

name: bioconductor-qfeatures
description: Infrastructure for managing and processing quantitative features from mass spectrometry experiments (proteomics/metabolomics). Use when you need to: (1) Import quantitative data from spreadsheets/MaxQuant into R, (2) Manage hierarchical relationships between PSMs, peptides, and proteins, (3) Perform data cleaning, log-transformation, normalization, and missing value imputation, (4) Aggregate features (e.g., PSMs to peptides), or (5) Visualize quantitative feature hierarchies.

# bioconductor-qfeatures

## Overview

The `QFeatures` package provides a standardized Bioconductor infrastructure for handling quantitative mass spectrometry data. It extends `MultiAssayExperiment` and `SummarizedExperiment` to maintain the hierarchical links between different levels of biological features (e.g., spectra/PSMs -> peptides -> proteins). This allows for seamless navigation and data propagation across different levels of an experiment while tracking how features were aggregated.

## Core Workflow

### 1. Data Import
Use `readQFeatures` to convert a data frame or spreadsheet into a `QFeatures` object.

```r
library(QFeatures)
# x is a data.frame, quantCols are indices of intensity columns
cptac <- readQFeatures(x, quantCols = 56:61, name = "peptides", fnames = "Sequence")
```

### 2. Experimental Design
Update sample annotations via `colData`.

```r
cptac$group <- rep(c("A", "B"), each = 3)
colData(cptac)
```

### 3. Data Cleaning and Filtering
Filter features based on `rowData` variables (e.g., removing contaminants).

```r
# Filter using formula interface
cptac <- cptac |>
    filterFeatures(~ Reverse == "") |>
    filterFeatures(~ Potential.contaminant == "")

# Select specific rowData columns to keep object lean
cptac <- selectRowData(cptac, c("Sequence", "Proteins"))
```

### 4. Managing Missing Values
Handle zeros and NAs before analysis.

```r
# Convert 0 to NA (common in MaxQuant output)
cptac <- zeroIsNA(cptac, i = "peptides")

# Assess missingness
nNA(cptac, i = "peptides")

# Filter rows based on percentage of missing values (pNA = 0 removes all NAs)
cptac <- filterNA(cptac, i = "peptides", pNA = 0)

# Imputation (MAR/MCAR vs MNAR)
cptac <- impute(cptac, i = "peptides", method = "knn")
```

### 5. Transformation and Normalization
Apply operations to specific assays and store results as new assays.

```r
# Log transformation
cptac <- logTransform(cptac, i = "peptides", name = "peptides_log")

# Normalization (e.g., median centering)
cptac <- normalize(cptac, i = "peptides_log", name = "peptides_norm", method = "center.median")
```

### 6. Feature Aggregation
Aggregate lower-level features (peptides) into higher-level features (proteins).

```r
# fcol is the grouping variable in rowData
cptac <- aggregateFeatures(cptac, 
                           i = "peptides_norm", 
                           fcol = "Proteins", 
                           name = "proteins", 
                           fun = MsCoreUtils::robustSummary)
```

## Visualization and Exploration

### Hierarchy Visualization
View the relationship between assays.
```r
plot(cptac)
```

### Data Extraction
Convert to long format for `ggplot2`.
```r
# Extract specific variables and assays
lf <- longForm(cptac[, , "proteins"], rowvars = "Proteins")
```

### Interactive Exploration
Use the Shiny-based display tool.
```r
display(cptac)
```

## Tips for Success
- **Assay Indexing**: You can refer to assays by name (`"peptides"`) or index (`1`).
- **Subsetting**: Subsetting a `QFeatures` object by a protein ID automatically subsets all parent features (peptides and PSMs) linked to that protein.
- **RowData Persistence**: When aggregating, `QFeatures` tracks the number of features aggregated into the new row in a `.n` column.

## Reference documentation
- [Processing quantitative proteomics data with QFeatures](./references/Processing.md)
- [Quantitative features for mass spectrometry data](./references/QFeatures.md)
- [Data visualization from a QFeatures object](./references/Visualization.md)