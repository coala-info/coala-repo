---
name: r-sigqc
description: R package sigqc (documentation from project home).
homepage: https://cran.r-project.org/web/packages/sigqc/index.html
---

# r-sigqc

name: r-sigqc
description: Quality control of gene expression signatures. Use this skill to evaluate the applicability of gene signatures to specific datasets using the sigQC R package. It helps in generating metrics for signature coherence, platform bias, and sample-specific quality scores.

## Overview
The `sigQC` package provides a suite of quality control metrics for gene expression signatures. It enables researchers to determine if a signature (a set of genes) is robust and applicable to a given dataset by analyzing properties like gene correlation, dynamic range, and presence across different platforms.

## Installation
Since `sigQC` and its dependency `biclust` may be archived on CRAN, installation from the CRAN archive or GitHub is often required:

```r
# Install dependencies first
install.packages("biclust") 

# Install sigQC
install.packages("sigQC")
# Or from archive if necessary:
# install.packages("https://cran.r-project.org/src/contrib/Archive/sigQC/sigQC_1.1.0.tar.gz", repos=NULL, type="source")
```

## Main Functions
- `make_all_plots()`: The primary wrapper function that runs the full QC pipeline and generates a standardized report.
- `sigQC_example_data()`: Loads internal example datasets for testing.
- `calculate_metrics()`: Computes the underlying QC metrics without generating plots.

## Workflow: Standard QC Analysis
The package requires two main inputs: a list of gene signatures and a list of expression datasets.

### 1. Prepare Input Data
Data should be in a named list format. Expression matrices should have genes as rows and samples as columns.

```r
library(sigQC)

# Define signatures as a list of gene symbol vectors
my_signatures <- list(
  "Hypoxia" = c("ADM", "ALDOA", "ENO1", "LDHA", "PDK1"),
  "Proliferation" = c("MKI67", "PCNA", "TOP2A")
)

# Define datasets as a list of matrices
my_datasets <- list(
  "Dataset1" = matrix(rnorm(1000), nrow = 100, dimnames = list(paste0("Gene", 1:100), paste0("S", 1:10))),
  "Dataset2" = matrix(rnorm(1000), nrow = 100, dimnames = list(paste0("Gene", 1:100), paste0("S", 1:10)))
)
```

### 2. Run the QC Pipeline
Use `make_all_plots` to generate a comprehensive set of PDF plots and metrics.

```r
make_all_plots(
  gene_sigs = my_signatures,
  dataset_list = my_datasets,
  out_dir = "sigQC_results",
  make_plots = TRUE,
  fast_run = FALSE
)
```

## Key Metrics Explained
- **Cohesion**: Measures how well the genes in a signature correlate with each other in the target dataset.
- **Discordance**: Identifies if certain genes in the signature behave differently than the rest.
- **Dynamic Range**: Checks if the signature genes have sufficient variation in expression to be useful for stratification.

## Tips for Success
- **Gene Identifiers**: Ensure that the gene names in your signature list exactly match the row names of your expression matrices (e.g., both use HGNC symbols or both use Entrez IDs).
- **Normalization**: Input data should be normalized (e.g., TPM, FPKM, or Log2-transformed) before running `sigQC`.
- **Output**: The package creates a directory structure. Check the `summary_plots` subfolder for the most important high-level visualizations.

## Reference documentation
- [sigQC Home Page](./references/home_page.md)