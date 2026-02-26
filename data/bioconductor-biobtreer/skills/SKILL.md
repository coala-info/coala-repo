---
name: bioconductor-biobtreer
description: This tool provides an R interface to the biobtree utility for high-performance mapping and filtering of bioinformatics datasets using identifiers, keywords, and genomic coordinates. Use when user asks to perform chain mapping between biological databases, filter genomic features by attributes, or execute genomic range queries like overlaps and within.
homepage: https://bioconductor.org/packages/release/bioc/html/biobtreeR.html
---


# bioconductor-biobtreer

name: bioconductor-biobtreer
description: Interface to the biobtree tool for mapping bioinformatics datasets via identifiers and keywords. Use this skill when you need to perform chain mapping between biological databases (Ensembl, UniProt, HGNC, GO, etc.), filter genomic features by attributes, or perform genomic range queries (overlaps, within, covers) within R.

# bioconductor-biobtreer

## Overview
The `biobtreeR` package provides a high-performance interface for mapping and filtering bioinformatics datasets. It uses a local database and a background server to allow complex "chain queries" (e.g., Gene -> Transcript -> Exon -> Genomic Region) across multiple integrated datasets including Ensembl, UniProt, HGNC, GO, and more.

## Core Workflow

### 1. Initialization and Database Setup
Before querying, you must set an output directory and ensure a database is available.

```r
library(biobtreeR)

# Set directory for database and config files
bbUseOutDir(tempdir())

# Option A: Use pre-built database (approx. 6GB, covers common organisms)
bbBuiltInDB()

# Option B: Build custom database for specific taxonomy IDs
bbBuildCustomDB(taxonomyIDs = "1408103,206403")
```

### 2. Server Management
Queries require a background server process.

```r
# Start the server
bbStart()

# ... perform queries ...

# Stop the server when finished
bbStop()
```

### 3. Basic Searching
Use `bbSearch` for simple identifier or keyword lookups.

```r
# Search across all datasets
bbSearch("tpi1,vav_human,ENST00000297261")

# Search within a specific dataset
bbSearch("tpi1", source = "ensembl")

# Get external URLs for results
bbSearch("tpi1", showURL = TRUE)
```

### 4. Chain Mapping and Filtering
The `bbMapping` function uses a specific syntax: `map(dataset).filter(expression)`.

*   **Basic Mapping:** `bbMapping("AT5G3_HUMAN", 'map(go)')`
*   **Filtering by Attributes:** `bbMapping("AT5G3_HUMAN", 'map(go).filter(go.type=="biological_process")', attrs = "type")`
*   **Chain Mapping:** `bbMapping("ATP5MC3", 'map(transcript).map(exon)', attrs = "seq_region")`

### 5. Genomic Range Queries
Special functions `overlaps`, `within`, and `covers` are available for datasets with coordinates (ensembl, transcript, exon, cds).

```r
# Find genes overlapping a specific range in Human (Taxonomy 9606)
bbMapping("9606", 'map(ensembl).filter(ensembl.overlaps(114129278, 114129328))', attrs = "name")
```

## Utility Functions
*   `bbListDatasets()`: List all available datasets in the current database.
*   `bbListAttrs("dataset_id")`: List attributes available for filtering or retrieval for a specific dataset (e.g., "uniprot", "hgnc").

## Tips for AI Agents
*   **Attribute Syntax:** When filtering, prefix the attribute with the dataset name (e.g., `ensembl.biotype`).
*   **Input Identifiers:** Multiple identifiers can be passed as a single comma-separated string.
*   **Taxonomy IDs:** Use taxonomy IDs (e.g., "9606" for human) as the starting point for genome-wide filters.
*   **Attribute Retrieval:** Use the `attrs` parameter in `bbMapping` to return specific data columns; use `$` for nested attributes like `sequence$mass`.

## Reference documentation
- [The biobtreeR users guide](./references/biobtreeR.md)
- [The biobtreeR users guide (RMarkdown)](./references/biobtreeR.Rmd)