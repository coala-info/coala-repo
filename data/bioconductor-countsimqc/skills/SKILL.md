---
name: bioconductor-countsimqc
description: This package compares characteristic features across multiple count data sets and generates comprehensive quality control reports. Use when user asks to compare synthetic data to a gold standard, perform exploratory data analysis of count matrices, or generate reports on gene expression distributions and mean-variance relationships.
homepage: https://bioconductor.org/packages/release/bioc/html/countsimQC.html
---


# bioconductor-countsimqc

## Overview

The `countsimQC` package is designed to compare characteristic features across multiple count data sets. It is primarily used to validate synthetic data generation by comparing it against a "gold standard" or original data set, but it can also be used for general exploratory data analysis of any collection of count matrices. The package generates comprehensive HTML or PDF reports containing visualizations of library sizes, gene expression distributions, mean-variance relationships, and sample correlations.

## Core Workflow

### 1. Data Preparation
The package expects a named list of count data sets. Each element in the list can be:
- A `DESeqDataSet` object (recommended, as it includes experimental design).
- A `matrix`.
- A `data.frame`.

If using a `matrix` or `data.frame`, the package assumes all samples are replicates (design `~1`).

```r
library(countsimQC)
library(DESeq2)

# Example: Creating a list of datasets
# dds1 and dds2 are DESeqDataSet objects
ddsList <- list(
  Original = dds1,
  Synthetic = dds2
)
```

### 2. Generating the Report
The primary function is `countsimQCReport()`. It processes the list and generates a standalone document.

```r
countsimQCReport(
  ddsList = ddsList,
  outputFile = "comparison_report.html",
  outputDir = "./results",
  outputFormat = "html_document",
  calculateStatistics = TRUE,
  description = "Comparison of original RNA-seq data vs synthetic generation v1"
)
```

### 3. Configuration Modes
Adjust the depth of analysis based on time and requirements:
- **Visual Only**: Set `calculateStatistics = FALSE`. This is the fastest mode.
- **Statistical Comparison**: Set `calculateStatistics = TRUE`. Performs Kolmogorov-Smirnov and Wald-Wolfowitz runs tests to compare distributions.
- **Permutation Testing**: Set `permutationPvalues = TRUE` and specify `nPermutations`. This evaluates the significance of differences but is computationally intensive.

### 4. Extracting Individual Plots
If you need to customize or export specific figures from the report, set `savePlots = TRUE` in the report function. This creates an `.rds` file.

```r
# Generate individual PDF files for every plot in the report
ggplots <- readRDS("./results/comparison_report_ggplots.rds")
generateIndividualPlots(
  ggplots, 
  device = "pdf", 
  nDatasets = 2, 
  outputDir = "./results/figures"
)
```

## Key Parameters for countsimQCReport
- `subsampleSize`: Number of genes to use for statistical tests (default is 250; lower this for faster previews).
- `maxNForCorr`: Maximum number of samples to use for correlation plots.
- `forceOverwrite`: Set to `TRUE` to overwrite existing reports in the output directory.
- `showCode`: Set to `FALSE` to hide R code chunks in the final HTML/PDF report.

## Reference documentation

- [countsimQC - Comparing characteristic features across count data sets](./references/countsimQC.md)