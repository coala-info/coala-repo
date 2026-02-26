---
name: bioconductor-ahmeshdbs
description: This tool provides access to MeSHDb SQLite files from AnnotationHub for species-specific gene mapping and functional annotation. Use when user asks to find MeSH databases, download MeSHDb records via AnnotationHub, or prepare MeSH data for enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AHMeSHDbs.html
---


# bioconductor-ahmeshdbs

name: bioconductor-ahmeshdbs
description: Access and retrieve MeSHDb (Medical Subject Headings Database) SQLite files from AnnotationHub for use in MeSH enrichment analysis and functional annotation. Use this skill when you need to find species-specific MeSH databases, download them via AnnotationHub, or prepare them for use with packages like MeSHDbi and meshr.

## Overview

The `AHMeSHDbs` package provides metadata for `MeSHDb` SQLite databases stored in `AnnotationHub`. These databases contain correspondence tables between Gene IDs and MeSH terms, as well as MeSH hierarchical structures. This skill guides you through querying `AnnotationHub` to find the correct database for a specific organism and loading it for downstream analysis.

## Installation

To install the package and its primary dependency:

```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AHMeSHDbs")
BiocManager::install("AnnotationHub")
```

## Workflow: Fetching MeSHDb Databases

The primary workflow involves using the `AnnotationHub` interface to search for and download the SQLite files.

### 1. Initialize AnnotationHub
First, load the library and create an AnnotationHub object to access the Bioconductor S3 bucket.

```r
library(AnnotationHub)
ah <- AnnotationHub()
```

### 2. Query for MeSHDb Records
You can list all available MeSHDb entries or filter by species.

```r
# List all MeSHDb entries
all_mesh <- query(ah, "MeSHDb")

# Query for a specific species (e.g., Mouse)
qr <- query(ah, c("MeSHDb", "Mus musculus"))
```

### 3. Inspect Metadata
Use `mcols()` to view detailed information such as taxonomy ID, data provider, and versioning.

```r
mcols(qr)
```

### 4. Retrieve the Database
Retrieve the SQLite file by its AnnotationHub ID (e.g., "AH91572") or by indexing the query result.

```r
# Retrieve the first match
mesh_db_file <- qr[[1]]

# The result is a local path to the SQLite file
print(mesh_db_file)
```

## Downstream Usage

The retrieved file path is intended for use with other MeSH-related packages:

*   **MeSHDbi**: Use the path with `MeSHDbi::MeSHDb(mesh_db_file)` to create a database object for querying.
*   **RSQLite**: Connect directly using `RSQLite::dbConnect(RSQLite::SQLite(), mesh_db_file)`.
*   **meshr**: Pass the file path or the MeSHDb object to `meshr` for MeSH enrichment analysis.

## Tips
*   **Snapshot Date**: Use `snapshotDate(ah)` to check the version of the metadata you are accessing.
*   **Search Terms**: When querying, you can use common names (e.g., "Honey bee") or scientific names (e.g., "Apis mellifera").
*   **MeSH.db**: Some records (like `AH116677`) provide general MeSH hierarchies (MeSH.db, MeSH.AOR.db) rather than species-specific gene mappings.

## Reference documentation

- [Provide MeSHDb databases for AnnotationHub](./references/creating-MeSHDbs.md)
- [Provide MeSHDb databases for AnnotationHub (Rmd)](./references/creating-MeSHDbs.Rmd)