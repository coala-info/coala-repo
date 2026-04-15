---
name: bioconductor-cancer
description: This tool provides an interface to the MSKCC Cancer Genomics Data Server for exploring, modeling, and visualizing multi-omics cancer data. Use when user asks to access clinical and genomic profiles, perform phenotype association testing, conduct gene set enrichment analysis, or build classification models for cancer datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/canceR.html
---

# bioconductor-cancer

name: bioconductor-cancer
description: Expert guidance for the Bioconductor package 'canceR' to explore, compare, and model cancer genomics data from MSKCC. Use this skill when you need to access clinical data, gene mutations, methylation, expression, and copy number alterations, or when performing GSEA, survival analysis, and multi-omics visualization (Circos) using the canceR R package.

# bioconductor-cancer

## Overview
The `canceR` package provides a comprehensive interface to the Cancer Genomics Data Server (CGDS) hosted by MSKCC. It integrates multiple Bioconductor packages (like `cgdsr`, `phenoTest`, `GSEAlm`, and `geNetClassifier`) to allow for complex modeling of cancer data. While it includes a Tcl/Tk graphical user interface, the underlying R functions enable programmatic access to clinical and genomic profiles, association testing between phenotypes and expression, and advanced visualization.

## Core Workflow

### 1. Initialization and Data Selection
To begin, you must connect to the MSKCC server and identify the studies of interest.

```r
library(canceR)

# Launch the GUI (optional)
# canceR()

# Programmatic access typically involves the cgdsr backend
library(cgdsr)
mycgds <- CGDS("http://www.cbioportal.org/")
test_studies <- getCancerStudies(mycgds)
```

### 2. Retrieving Clinical and Genetic Data
Data retrieval requires specifying a "Case List" (samples) and a "Genetic Profile" (data type).

- **Clinical Data**: Use `getClinicalData` to retrieve attributes like Overall Survival (OS) and Disease Free Survival (DFS).
- **Mutations**: Select "All Tumor Samples" and the "Mutations" genetic profile.
- **Profiles**: Retrieve mRNA expression (Z-scores or RSEM), Copy Number Alterations (CNA), or Methylation data.

### 3. Phenotype Association (PhenoTest)
Use the `phenoTest` integration to associate gene expression with clinical variables.
- **Survival**: Cox proportional hazards model.
- **Categorical/Ordinal**: Linear models (limma) to find differences between groups (e.g., Tumor Stage).
- **Continuous**: Correlation with numeric variables (e.g., Serum PSA levels).

### 4. Gene Set Enrichment Analysis (GSEA)
The package supports both standard GSEA and Linear Modeling of GSEA (`GSEAlm`).
- **Preprocessing**: Use `getGCT_CLS` to generate the required `.gct` (expression) and `.cls` (phenotype) files.
- **MSigDB**: Requires `.gmt` files from the Broad Institute.
- **GSEAlm**: Provides a faster, linear model-based inference for gene set enrichment, useful for comparing phenotypes within a disease or comparing two different diseases.

### 5. Classification and Regression
- **Inter-disease**: Use `geNetClassifier` to find genes that differentiate one cancer type from others using posterior probabilities.
- **Intra-disease**: Use `rpart` to build decision trees that predict clinical outcomes (e.g., Living vs. Deceased) based on gene expression thresholds.

### 6. Visualization
- **Correlation Plots**: Use `cna_mrna_mut` skin to plot mRNA expression against CNA or Methylation, colored by mutation status.
- **Survival Plots**: Generate Kaplan-Meier curves or Cox residuals.
- **Circos Plots**: Use `getCircos` to integrate multi-omics data (mRNA, CNA, Met, Mut) across multiple cancer studies in a circular layout.

## Implementation Tips
- **Workspace**: Always set a workspace directory using the GUI or `setwd()` as the package generates many intermediate files (GCT, CLS, Results).
- **Gene Symbols**: Use HUGO Gene Symbols in text files (.txt), one per line.
- **Data Cleaning**: GSEA functions automatically handle negative values (by shifting the matrix) and missing phenotype data, but ensure your clinical variables have at least two classes for comparison.
- **Performance**: For `GSEAlm`, reduce permutations to 100 (from 1000) if working with large gene lists to save time.

## Reference documentation
- [canceR: A Graphical User Interface for accessing and modeling the Cancer Genomics Data of MSKCC](./references/canceR.Rmd)
- [canceR Vignette (Markdown)](./references/canceR.md)