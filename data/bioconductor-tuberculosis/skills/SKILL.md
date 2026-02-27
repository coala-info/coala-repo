---
name: bioconductor-tuberculosis
description: This package provides access to a standardized collection of over 10,000 human tuberculosis gene expression samples from GEO. Use when user asks to search for TB datasets, download SummarizedExperiment objects for specific GEO accessions, or perform transcriptomic analysis on tuberculosis studies.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tuberculosis.html
---


# bioconductor-tuberculosis

name: bioconductor-tuberculosis
description: Access and analyze standardized tuberculosis gene expression data from over 10,000 human samples (microarray and sequencing). Use this skill to search for GEO datasets, download SummarizedExperiment objects, and perform transcriptomic analysis of TB studies.

# bioconductor-tuberculosis

## Overview

The `tuberculosis` package provides access to a massive, hyper-standardized collection of human tuberculosis (TB) gene expression data. It includes over 10,000 samples from GEO, processed through a reproducible pipeline (limma for microarrays, nf-core/rnaseq for sequencing). All data uses HGNC-approved GRCh38 gene names.

## Core Workflow

### 1. Search for Datasets
Use the `tuberculosis()` function with a regular expression to find available resources. Resources are named using the format `YYYY-MM-DD.GSEXXXXX`.

```r
library(tuberculosis)

# List all available datasets
all_data <- tuberculosis(".", dryrun = TRUE)

# Search for a specific GEO accession
tuberculosis("GSE103147")
```

### 2. Download Data
Set `dryrun = FALSE` to download the data as a list of `SummarizedExperiment` objects.

```r
# Download a specific dataset
data_list <- tuberculosis("GSE103147", dryrun = FALSE)

# Access the SummarizedExperiment object
se <- data_list[["2021-09-15.GSE103147"]]
```

### 3. Inspect the Data
The objects contain a single assay named `exprs`. 
- **Microarray data**: Column names start with `GSE`.
- **Sequencing data**: Column names start with `SRR`.
- **Note**: Currently, `colData` (sample metadata) is being curated and may be empty. Analysis is primarily limited to unsupervised methods (e.g., UMAP, PCA) until labels are released.

```r
# Check dimensions and assay names
dim(se)
assayNames(se)

# View expression matrix
head(assay(se, "exprs"))
```

## Analysis Example: Dimension Reduction

Since metadata is limited, use `scater` for unsupervised visualization.

```r
library(scater)
library(magrittr)
library(ggplot2)

# Extract a specific dataset
zak_se <- tuberculosis("GSE103147", dryrun = FALSE)[[1]]

# Calculate UMAP
# Note: exprs_values must be set to "exprs"
umap_res <- calculateUMAP(zak_se, exprs_values = "exprs")

# Plot
as.data.frame(umap_res) %>%
  ggplot(aes(x = V1, y = V2)) +
  geom_point() +
  labs(title = "UMAP of GSE103147", x = "UMAP1", y = "UMAP2")
```

## Tips and Best Practices
- **Memory Management**: The package contains over 10,000 samples. Avoid downloading all data (`"."`) with `dryrun = FALSE` unless you have significant RAM.
- **Gene Names**: All features are HGNC-approved symbols. No further ID conversion is typically required for downstream pathway analysis.
- **Multiple Platforms**: Some GEO series (e.g., GSE10799) contain multiple platforms. `tuberculosis()` will return a list containing one element for each platform/sub-study.

## Reference documentation
- [tuberculosis](./references/tuberculosis.md)