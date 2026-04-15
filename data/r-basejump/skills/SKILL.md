---
name: r-basejump
description: The r-basejump package provides utility functions for bioinformatics data manipulation and R package development. Use when user asks to manipulate genomic data, convert Bioconductor S4 objects, map gene identifiers, or streamline R package development workflows.
homepage: https://cran.r-project.org/web/packages/basejump/index.html
---

# r-basejump

name: r-basejump
description: Specialized R package for bioinformatics and package development. Use this skill when performing genomic data manipulation, working with Bioconductor-style objects (SummarizedExperiment, GRanges), or streamlining R package development workflows.

## Overview

The `basejump` package provides a robust foundation of utility functions designed for bioinformatics analysis and R package development. It bridges gaps between base R and Bioconductor, offering streamlined methods for handling genomic metadata, file I/O, and object conversions. It is particularly useful for managing "Acid Genomics" style data structures and ensuring consistent data validation across bioinformatics pipelines.

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "basejump",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

## Main Functions and Workflows

### Data Manipulation and Conversion
- **`as.data.frame()` / `as.DataTable()`**: Enhanced methods for converting Bioconductor S4 objects (like GRanges or SummarizedExperiment) into standard data frames or DataTables while preserving metadata.
- **`camelCase()` / `snakeCase()`**: Utilities for consistent naming conventions in data frames and package code.
- **`collapse()`**: Efficiently collapse multiple values into a single string, often used for gene symbol mapping.

### Bioinformatics Utilities
- **`makeGRangesFromEnsembl()`**: Streamlines the creation of GenomicRanges objects directly from Ensembl identifiers.
- **`mapGenes()`**: High-level function to map identifiers across different database versions or formats.
- **`sampleData()`**: Standardized extractor for sample-level metadata from complex genomic experiments.

### Package Development
- **`checkArgs()`**: Defensive programming utility to validate function arguments.
- **`initPackage()`**: Scaffolding tools for setting up new R packages following Acid Genomics standards.
- **`matchArgs()`**: Improved argument matching with better error reporting than base `match.arg()`.

### File I/O
- **`import()` / `export()`**: Unified interface for reading and writing various bioinformatics file formats (CSV, TSV, Excel, RDS) with automatic compression handling.

## Tips for Success
- **S4 Object Handling**: When working with Bioconductor objects, use `basejump` functions to extract `mcols` (metadata columns) into clean data frames for visualization with `ggplot2`.
- **Consistency**: Use the package's naming convention utilities to ensure that column names in large genomic datasets remain programmatic and easy to subset.
- **Validation**: Incorporate `basejump` validation checks at the beginning of custom functions to provide clear error messages when genomic inputs (like chromosome names) are malformed.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)