---
name: r-scimpute
description: scImpute identifies and imputes dropout values in single-cell RNA-seq data while preserving biological zeros. Use when user asks to impute missing values in scRNA-seq counts, handle dropout events, or improve gene expression matrices for downstream analysis.
homepage: https://cran.r-project.org/web/packages/scimpute/index.html
---


# r-scimpute

## Overview
The `scImpute` package is designed to identify and impute dropout values in scRNA-seq data while preserving actual biological zeros. It utilizes a mixture model to estimate the probability of dropout for each gene in each cell and imputes values by leveraging information from similar cells.

## Installation
To install the package from GitHub (as it is not currently on CRAN):

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("Vivianstats/scImpute")
```

## Core Workflow
The primary interface for the package is the `scimpute` function. It processes a raw count matrix and saves the imputed version to a specified directory.

### Basic Usage
```R
library(scImpute)

scimpute(
  count_path = "path/to/raw_counts.csv", 
  infile = "csv",           # Options: "csv", "txt", "rds"
  outfile = "csv",          # Options: "csv", "txt", "rds"
  out_dir = "./output/",    # Directory for results
  labeled = FALSE,          # Set TRUE if cell type labels are known
  drop_thre = 0.5,          # Threshold for dropout probability
  Kcluster = 2,             # Estimated number of cell subpopulations
  ncores = 4                # Parallel processing cores
)
```

### Key Parameters
- `count_path`: Path to the input file. Rows should be genes, columns should be cells.
- `Kcluster`: An integer specifying the expected number of clusters. This is used to identify similar cells for imputation.
- `drop_thre`: A number between 0 and 1. Genes with a dropout probability higher than this threshold will be imputed.
- `labeled`: If `TRUE`, you must provide a column of labels. If `FALSE`, the tool uses spectral clustering to identify cell types.
- `ncores`: Number of CPU cores to use for parallel computation.

## Tips for Success
- **Whole-Genome Input**: Apply `scImpute` to the whole-genome count matrix rather than a highly filtered subset. While some gene filtering is okay, keeping most genes ensures more robust identification of cell subpopulations.
- **Output Files**: The function creates `scimpute_count.csv` (or .rds/.txt) in the `out_dir`. It also returns the column indices of detected outlier cells.
- **Downstream Integration**: Use the resulting imputed matrix for Seurat, Monocle, or other scRNA-seq analysis suites to improve cluster separation and DE gene detection.

## Reference documentation
- [scImpute: accurate and robust imputation of scRNA-seq data](./references/README.md)
- [scImpute README Source](./references/README.Rmd.md)
- [GitHub Articles and Resources](./references/articles.md)
- [Project Home Page](./references/home_page.md)