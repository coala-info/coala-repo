---
name: bioconductor-biochubsshiny
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocHubsShiny.html
---

# bioconductor-biochubsshiny

name: bioconductor-biochubsshiny
description: Interactive exploration and retrieval of Bioconductor Hub resources (AnnotationHub and ExperimentHub) using a Shiny interface. Use this skill to guide users on how to launch the interactive browser, filter for specific biological resources (e.g., by species or genome build), and generate reproducible R code for importing selected data into their session.

# bioconductor-biochubsshiny

## Overview

`BiocHubsShiny` provides a graphical user interface (GUI) for browsing the vast collections of genomic data available in Bioconductor's `AnnotationHub` and `ExperimentHub`. Instead of searching these hubs via command-line queries, users can use a searchable, sortable table to identify resources and automatically generate the R code required to load those resources into their environment.

## Installation and Loading

To install the package:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BiocHubsShiny")
```

To load the package:

```r
library(BiocHubsShiny)
```

## Core Workflow

### Launching the Interface

The primary function launches a local Shiny application in the default web browser:

```r
BiocHubsShiny()
```

### Interactive Exploration

Once the app is running, users can perform the following actions:

1.  **Search and Filter**: Use the global search box or column-specific filters to narrow down resources. Common filters include:
    *   `Species`: e.g., "Mus musculus" or "Homo sapiens".
    *   `Genome`: e.g., "hg38" or "mm10".
    *   `SourceType`: e.g., "FASTA", "GTF", "BED".
2.  **Selection**: Click on one or more rows in the table to select specific resources. Selected rows will be highlighted.
3.  **Code Generation**: The application dynamically generates R code at the bottom of the interface based on the current selection. This code typically uses the `AnnotationHub` or `ExperimentHub` packages to fetch the data by its unique identifier (e.g., `AH12345`).

## Reproducible Data Import

While the Shiny app is used for discovery, the actual data import should be done in an R script for reproducibility. A typical workflow involves:

1.  Identifying the resource ID (e.g., `AH107007`) via `BiocHubsShiny()`.
2.  Using the generated code in a script:

```r
library(AnnotationHub)
ah <- AnnotationHub()
res <- ah[["AH107007"]]
```

## Reference documentation

- [BiocHubsShiny: Interactive Display of Hub Resources](./references/BiocHubsShiny.md)