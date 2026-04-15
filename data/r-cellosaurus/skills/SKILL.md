---
name: r-cellosaurus
description: The r-cellosaurus package provides an R interface to the Cellosaurus database for importing cell line metadata and standardizing identifiers. Use when user asks to import the Cellosaurus database, map cell line names to RRIDs or CVCL accessions, and filter out contaminated or problematic cell lines.
homepage: https://cran.r-project.org/web/packages/cellosaurus/index.html
---

# r-cellosaurus

## Overview

The `cellosaurus` package is an R interface to the [Cellosaurus](https://www.cellosaurus.org/) database, a knowledge resource on cell lines. It provides tools to import the full Cellosaurus database as a structured S4 `DFrame` and offers specialized functions for mapping inconsistent cell line names to standardized Research Resource Identifiers (RRIDs).

## Installation

To install the package from the Acid Genomics repository:

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "Cellosaurus",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

## Core Workflow

### 1. Loading the Database
The `Cellosaurus()` function downloads and imports the latest annotations from the ExPASy FTP server.

```r
library(Cellosaurus)

# Import the full database
object <- Cellosaurus()

# View summary (rows = cell lines, columns = metadata)
print(object)

# List available metadata columns (e.g., depmapId, atccId, diseases, msiStatus)
colnames(object)
```

### 2. Mapping Cell Lines
Use `mapCells()` to convert various identifiers (names, ATCC IDs, DepMap IDs) into standardized Cellosaurus accessions (CVCL IDs).

```r
# Supports mixed input types
cells_to_map <- c("ACH-000551", "CCL-240", "Duadi", "THP1", "RAW 264.7")
ids <- mapCells(object, cells = cells_to_map)

# Result is a named character vector of CVCL accessions
print(ids)

# Use these IDs to subset the main object for metadata
metadata <- as.data.frame(object[ids, ])
```

### 3. Filtering Problematic Lines
Cellosaurus tracks cell lines that are contaminated or otherwise problematic. It is best practice to exclude these before analysis.

```r
# Exclude both contaminated and problematic lines
clean_cells <- excludeProblematicCells(object)

# Exclude only contaminated lines (keeps other problematic lines)
non_contaminated <- excludeContaminatedCells(object)
```

## Tips for Usage
- **Memory Efficiency**: The package uses Run-Length Encoding (`Rle`) for columns with repetitive data to minimize memory usage.
- **Data Access**: Since the object extends `DFrame`, you can use standard Bioconductor/S4Vectors subsetting: `object[rows, columns]`.
- **Conversion**: To use with `tidyverse` or standard R functions, convert the object or a subset using `as.data.frame(object)`.

## Reference documentation
- [Cellosaurus Vignette](./references/Cellosaurus.html.md)
- [Package Home Page](./references/home_page.md)