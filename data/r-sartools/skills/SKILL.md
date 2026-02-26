---
name: r-sartools
description: "SARTools performs comprehensive differential expression analysis of RNA-Seq data using DESeq2 or edgeR wrappers. Use when user asks to perform end-to-end RNA-Seq workflows, generate quality control visualizations, conduct statistical testing for differential expression, or create automated HTML analysis reports."
homepage: https://cran.r-project.org/web/packages/sartools/index.html
---


# r-sartools

name: r-sartools
description: Statistical Analysis of RNA-Seq Tools (SARTools) for differential expression analysis using DESeq2 or edgeR. Use this skill when you need to perform end-to-end RNA-Seq workflows in R, including data preprocessing, quality control (QC) visualization, differential analysis, and HTML report generation.

## Overview

SARTools is an R package designed to streamline the differential analysis of RNA-Seq data. It acts as a wrapper and environment for the DESeq2 and edgeR packages, providing standardized workflows for generating diagnostic plots (PCA, SERE, clustering), performing statistical tests, and exporting results into readable tab-delimited files and comprehensive HTML reports.

## Installation

To install the SARTools package and its core dependencies:

```R
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("PF2-pasteur-fr/SARTools", build_opts="--no-resave-data")
```

Note: Requires R (>= 3.3.0), DESeq2 (>= 1.12.0), and edgeR (>= 3.12.0).

## Main Functions and Workflow

The package is built around two primary workflows: one for DESeq2 and one for edgeR.

### 1. Data Preparation
SARTools requires a target file (metadata) and raw count files.
- **Target file**: A tab-delimited file with columns: `label`, `files`, `group`, and any batch effects.
- **Loading data**: Use `loadRawCounts()` to import data based on the target file.

### 2. Quality Control and Normalization
Generate diagnostic plots to assess data quality:
- `checkParameters()`: Validates input parameters.
- `exploreCounts()`: Produces QC plots (density, boxplots, PCA, cluster dendrograms).
- `summarizeResults()`: Aggregates statistics on the analysis.

### 3. Differential Analysis
The package provides high-level wrappers for the statistical engines:
- **DESeq2 Workflow**: Uses `run.DESeq2()` to perform normalization, dispersion estimation, and testing.
- **edgeR Workflow**: Uses `run.edgeR()` for the equivalent pipeline in the edgeR framework.

### 4. Exporting Results
- `writeResults.DESeq2()` or `writeResults.edgeR()`: Exports results to text files.
- `makeReport.DESeq2()` or `makeReport.edgeR()`: Generates a complete HTML report using knitr.

## Workflow Tips

- **Template Scripts**: Always prefer using the provided templates (`template_script_DESeq2.r` or `template_script_edgeR.r`) found in the package installation directory to ensure all necessary steps are followed for report generation.
- **Batch Effects**: If your target file contains a "batch" column, ensure it is specified in the `varInt` or `batch` parameters of the run functions to account for technical variation.
- **Project Structure**: Maintain a consistent directory structure with a `data/` folder for counts and a `results/` folder for output to avoid pathing issues during report generation.

## Reference documentation

- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)