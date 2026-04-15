---
name: r-remapenrich
description: This tool performs statistical enrichment analysis of genomic regions using ReMap catalogues or custom peak sets to identify transcription factor binding sites. Use when user asks to identify transcription factor enrichment, perform overlap analysis between genomic intervals, or visualize enrichment results from ReMap data.
homepage: https://cran.r-project.org/web/packages/remapenrich/index.html
---

# r-remapenrich

name: r-remapenrich
description: Statistical enrichment analysis of genomic regions using ReMap catalogues or custom peak sets. Use this skill when you need to identify transcription factor binding site (TFBS) enrichment, work with ReMap genomic data, or perform overlap analysis between genomic intervals in R.

## Overview

The `remapenrich` package is designed to identify significantly enriched genomic regions within the ReMap catalogue or user-defined peak sets. It facilitates the interpretation of functional genomics and epigenomics data by automating the process of importing catalogues, computing enrichment statistics, and visualizing results through specialized plotting functions.

## Installation

To install the package from GitHub using `devtools`:

```R
# install.packages("devtools")
devtools::install_github("remap-cisreg/ReMapEnrich")
```

## Core Workflow

### 1. Data Import
Convert BED files or genomic intervals into `GenomicRanges` objects, which are the standard input for the package.

```R
library(ReMapEnrich)

# Load query regions (e.g., your experimental peaks)
query <- bedToGranges(system.file("extdata", "ReMap_nrPeaks_public_chr22_SOX2.bed", package = "ReMapEnrich"))

# Download or load a ReMap catalogue
# demo.dir <- "~/ReMapEnrich_demo"
# catalog_file <- downloadRemapCatalog(demo.dir)
# remapCatalog <- bedToGranges(catalog_file)
```

### 2. Computing Enrichment
The `enrichment()` function compares the query against the catalogue. It supports shuffling and universe definitions for statistical rigor.

```R
# Basic enrichment (byChrom = TRUE is useful for single-chromosome tests)
enrichment.df <- enrichment(query, remapCatalog, byChrom = TRUE)

# Advanced enrichment with a specific universe
# enrichment.df <- enrichment(query, remapCatalog, universe = my_universe_granges)
```

### 3. Visualization
The package provides built-in functions to visualize the top enriched transcription factors or regions.

```R
# Generate a dot plot of enriched TFs
enrichmentDotPlot(enrichment.df)
```

## Key Functions

- `bedToGranges()`: Converts BED-formatted files into `GRanges` objects.
- `downloadRemapCatalog()`: Utility to fetch the latest ReMap catalogues (e.g., hg38, mm10) from official sources.
- `enrichment()`: The main engine for calculating p-values and fold-enrichment. Parameters include `nfrac` (overlap fraction) and `shuffling` options.
- `enrichmentDotPlot()`: Creates a ggplot2-based visualization of enrichment results, typically plotting -log10(p-value) vs. fold enrichment.

## Tips for Success

- **Universe Selection**: For more accurate p-values, define a "universe" (background) that represents all possible regions where your query peaks could have appeared (e.g., all open chromatin regions in your cell type).
- **Memory Management**: ReMap catalogues can be large. Ensure your R session has sufficient memory when loading full-genome catalogues.
- **Chromosome Consistency**: Ensure that your query and catalogue use the same genome build (e.g., hg38) and chromosome naming conventions (e.g., "chr1" vs "1").

## Reference documentation

- [README.md](./references/README.md)
- [Advanced Use](./references/advanced_use.md)
- [Articles](./references/articles.md)
- [Basic Use](./references/basic_use.md)
- [Home Page](./references/home_page.md)