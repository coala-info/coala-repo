---
name: bioconductor-ahlrbasedbs
description: This tool retrieves and manages species-specific ligand-receptor interaction databases from AnnotationHub for use in cell-cell communication analysis. Use when user asks to find, download, or prepare LRBaseDb SQLite databases for ligand-receptor analysis with packages like scTensor or LRBaseDbi.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AHLRBaseDbs.html
---

# bioconductor-ahlrbasedbs

name: bioconductor-ahlrbasedbs
description: Access and retrieve LRBaseDb SQLite databases from AnnotationHub for ligand-receptor interaction analysis. Use this skill when you need to find, download, and prepare species-specific ligand-receptor databases for use with packages like scTensor, LRBaseDbi, or RSQLite.

## Overview

The `AHLRBaseDbs` package serves as a metadata provider for `LRBaseDb` objects stored in Bioconductor's `AnnotationHub`. These databases contain correspondence tables for ligand-receptor pairs across hundreds of species. This skill guides you through querying the hub, filtering by species, and retrieving the SQLite file paths required for downstream cell-cell interaction analysis.

## Installation

```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AHLRBaseDbs")
```

## Workflow: Fetching LRBaseDb Databases

### 1. Initialize AnnotationHub
Load the `AnnotationHub` package and initialize the hub object to access the latest resource metadata.

```r
library(AnnotationHub)
ah <- AnnotationHub()
```

### 2. Query for LRBaseDb Resources
Search the hub for all available `LRBaseDb` entries.

```r
# List all available LRBaseDb records
lr_resources <- query(ah, "LRBaseDb")
print(lr_resources)

# View detailed metadata (species, taxonomy ID, data provider, etc.)
mcols(lr_resources)
```

### 3. Filter by Species
Narrow down the search to a specific organism (e.g., *Mus musculus*).

```r
# Query for mouse-specific ligand-receptor databases
qr <- query(ah, c("LRBaseDb", "Mus musculus"))
print(qr)
```

### 4. Retrieve the Database
Select the desired record (usually the latest version) and download the SQLite file.

```r
# Retrieve the first match as a local file path or SQLite object
# Replace "AH91646" with the specific ID from your query results
db_file <- ah[["AH91646"]]
```

## Integration with Other Packages

The retrieved database file path or object is designed to be used with:
- **LRBaseDbi**: For querying the database using standard Bioconductor annotation methods.
- **scTensor**: As a required argument for detecting cell-cell interactions in single-cell RNA-seq data.
- **RSQLite**: To connect directly via `dbConnect(RSQLite::SQLite(), db_file)`.

## Tips
- Use `snapshotDate(ah)` to check the version of the metadata you are accessing.
- If multiple versions exist for a species (e.g., v001, v007), check the `title` or `rdatadateadded` column in `mcols()` to select the most recent one.

## Reference documentation
- [Provide LRBaseDb databases for AnnotationHub](./references/creating-LRBaseDbs.md)