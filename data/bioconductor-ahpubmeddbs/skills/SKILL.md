---
name: bioconductor-ahpubmeddbs
description: This package provides metadata and access to structured PubMed datasets through AnnotationHub in R. Use when user asks to retrieve PubMed abstracts, query author information, map PMC identifiers, or access MeSH terms in SQLite or data.table formats.
homepage: https://bioconductor.org/packages/release/data/annotation/html/AHPubMedDbs.html
---

# bioconductor-ahpubmeddbs

## Overview

The `AHPubMedDbs` package serves as a metadata provider for `AnnotationHub`, allowing users to easily discover and retrieve large-scale PubMed datasets. These datasets are preprocessed into structured formats—specifically `SQLite`, `Tibble`, and `data.table`—to facilitate efficient data manipulation and querying within the R environment. It covers various aspects of PubMed, including PMIDs, abstracts, author details, PMC mappings, and MeSH (Medical Subject Headings) terms.

## Typical Workflow

### 1. Initialize AnnotationHub
To access the datasets, you must first load the `AnnotationHub` package and initialize a hub object.

```r
library(AnnotationHub)
ah <- AnnotationHub()
```

### 2. Query for PubMed Datasets
Use the `query` function to search for available PubMed resources. You can filter by the "PubMed" keyword or specific data classes.

```r
# List all PubMed-related entries
pm_records <- query(ah, "PubMed")
pm_records

# Filter for specific formats (e.g., PubMedDb tibbles)
qr <- query(ah, c("PubMedDb"))
```

### 3. Inspect Metadata
Before downloading, inspect the metadata to identify the specific resource ID (e.g., "AH91771") and the type of information it contains.

```r
# View detailed metadata table
mcols(query(ah, "PubMed"))
```

### 4. Retrieve Data
Once the desired record ID is identified, retrieve the data using the double-bracket operator. The data will be loaded into your R session in the format specified in the `rdataclass` column (e.g., a `data.table` or a connection to a `SQLite` file).

```r
# Example: Retrieve a specific record by ID
# Replace "AH91771" with the actual ID from your query results
pubmed_data <- ah[["AH91771"]]
```

## Available Data Types
The package typically provides access to:
- **PubMed ID**: Basic identifier mappings.
- **Abstracts**: Textual content of PubMed entries.
- **Author Information**: Correspondence tables for authors.
- **PMC**: Mappings between PubMed and PubMed Central.
- **MeSH**: Descriptors, Qualifiers, and Supplementary Concept Records (SCR).

## Tips
- **Format Selection**: If you are performing heavy filtering or joins, the `SQLite` versions are often more memory-efficient as they stay on disk. For interactive analysis of smaller subsets, `Tibble` or `data.table` formats are preferred.
- **Snapshot Date**: Use `snapshotDate(ah)` to check the version of the metadata you are currently accessing.

## Reference documentation
- [Provide PubMed sqlite/tibble/data.table datasets for AnnotationHub](./references/pubmed.Rmd)
- [Provide PubMed sqlite/tibble/data.table datasets for AnnotationHub](./references/pubmed.md)