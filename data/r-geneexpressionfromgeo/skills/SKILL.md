---
name: r-geneexpressionfromgeo
description: This tool retrieves gene expression data and gene symbols from the NCBI Gene Expression Omnibus and converts them into R data frames. Use when user asks to download GEO datasets, map probeset IDs to gene symbols, or fetch gene expression data using accession codes.
homepage: https://cran.r-project.org/web/packages/geneexpressionfromgeo/index.html
---


# r-geneexpressionfromgeo

name: r-geneexpressionfromgeo
description: Facilitates the retrieval of gene expression data and gene symbols from the NCBI Gene Expression Omnibus (GEO) using accession codes. Use this skill when you need to download GEO datasets, map probesets to gene symbols, and convert GEO data into a standard R data frame for analysis.

## Overview

The `geneExpressionFromGEO` package provides a streamlined, beginner-friendly interface for downloading gene expression data from the NCBI Gene Expression Omnibus (GEO). Its primary function, `getGeneExpressionFromGEO()`, automates the process of fetching data from the NCBI FTP servers, handling Bioconductor dependencies, and optionally mapping platform-specific probeset IDs to official gene symbols.

Supported platforms include common Affymetrix and Illumina arrays such as GPL96 (HG-U133A), GPL570 (HG-U133_Plus_2), GPL6244 (HuGene-1.0-ST), and many others (GPL80, GPL8300, GPL571, GPL20115, GPL1293, GPL6102, GPL6104, GPL6883, GPL6884, GPL13497, GPL14550, GPL17077, GPL6480, GPL11532, GPL23126).

## Installation

To install the package from CRAN and its required Bioconductor dependencies:

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("Biobase", "annotate", "GEOquery"))

install.packages("geneExpressionFromGEO")
library(geneExpressionFromGEO)
```

## Main Function and Workflow

The core workflow revolves around a single function call that returns a clean data frame.

### getGeneExpressionFromGEO()

This function retrieves the dataset and formats it.

**Arguments:**
- `geoAccessionCode`: A string representing the GEO series ID (e.g., "GSE3268").
- `associateSymbolsToGenes`: Boolean. If `TRUE`, the function attempts to map probeset IDs to gene symbols based on the platform.
- `verbose`: Boolean. If `TRUE`, prints status messages during the download and processing steps.

### Example Usage

```R
library(geneExpressionFromGEO)

# Define parameters
gse_id <- "GSE3268"
map_symbols <- TRUE
show_messages <- TRUE

# Retrieve data
geneExpressionDF <- getGeneExpressionFromGEO(gse_id, map_symbols, show_messages)

# Inspect the resulting data frame
head(geneExpressionDF)
```

## Tips for Success

1. **Platform Compatibility**: Ensure the GEO dataset belongs to one of the supported GPL platforms listed in the overview. If the platform is not supported for symbol mapping, set `associateSymbolsToGenes = FALSE`.
2. **Data Structure**: The returned object is a standard R `data.frame`. The first column typically contains the Gene Symbols (if requested) or Probeset IDs, followed by columns for each sample in the dataset.
3. **Internet Connection**: Since the package downloads data directly from NCBI FTP servers (`https://ftp.ncbi.nlm.nih.gov/geo/series/`), a stable internet connection is required.
4. **Memory Management**: Large GEO series (GSE) files can consume significant RAM. For very large datasets, ensure your R environment has sufficient memory allocated.

## Reference documentation

- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)