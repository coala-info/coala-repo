---
name: bioconductor-biodblipidmaps
description: This package provides a connector to the LIPID MAPS Structure Database for retrieving lipid structures, metadata, and identifiers within the biodb framework. Use when user asks to retrieve lipid entries by ID, search the LIPID MAPS database by name, or convert lipid metadata into data frames for lipidomics workflows.
homepage: https://bioconductor.org/packages/3.14/bioc/html/biodbLipidmaps.html
---


# bioconductor-biodblipidmaps

## Overview
The `biodbLipidmaps` package is a Bioconductor extension that provides a connector to the LIPID MAPS Structure Database (LMSD). It operates within the `biodb` framework, allowing users to programmatically retrieve lipid structures, metadata, and identifiers. It is particularly useful for metabolomics and lipidomics workflows where lipid identification and annotation are required.

## Core Workflow

### 1. Initialization
To use the package, you must first initialize a `biodb` instance and then create a connector specifically for Lipidmaps.

```r
library(biodb)
library(biodbLipidmaps)

# Create the main biodb instance
mybiodb <- biodb::newInst()

# Create the connector to Lipidmaps Structure
conn <- mybiodb$getFactory()$createConn('lipidmaps.structure')
```

### 2. Accessing Entries by ID
If you have specific LIPID MAPS accession numbers (e.g., "LMFA00000001"), you can retrieve the full entry objects.

```r
# Get a few example IDs from the database
ids <- conn$getEntryIds(n = 5)

# Retrieve entry objects
entries <- conn$getEntry(ids)

# Convert entries to a standard R data frame
lipid_df <- mybiodb$entriesToDataframe(entries)
```

### 3. Searching the Database (LMSDSearch)
The package provides access to the `LMSDSearch` web service. You can search by name or other parameters supported by the API.

```r
# Search for lipids by name
# mode='ProcessStrSearch' is commonly used for string-based searches
search_ids <- conn$wsLmsdSearch(mode='ProcessStrSearch', name="fatty", retfmt="ids")

# Retrieve and process the results
search_entries <- conn$getEntry(search_ids)
search_df <- mybiodb$entriesToDataframe(search_entries)
```

### 4. Cleanup
Always terminate the `biodb` instance to release resources and close connections.

```r
mybiodb$terminate()
```

## Key Functions and Methods
- `biodb::newInst()`: Initializes the framework.
- `conn$getNbEntries()`: Returns the number of entries (may return NA if the remote database doesn't provide a count).
- `conn$getEntryIds(n)`: Retrieves the first `n` IDs from the database.
- `conn$getEntry(ids)`: Fetches detailed entry objects for the provided IDs.
- `conn$wsLmsdSearch(...)`: Directly queries the LIPID MAPS web service.
- `mybiodb$entriesToDataframe(entries)`: Flattens complex entry objects into a tabular format containing fields like InChIKey, formula, mass, and common names.

## Tips
- **Caching**: `biodb` uses a local cache system by default. Subsequent requests for the same IDs will be significantly faster.
- **Data Integration**: The data frames produced include cross-references to other databases like ChEBI, PubChem, and KEGG where available, facilitating multi-database integration.
- **Search Modes**: When using `wsLmsdSearch`, ensure the `mode` parameter matches the LIPID MAPS API specifications (e.g., `ProcessStrSearch` for text).

## Reference documentation
- [An introduction to biodbLipidmaps](./references/biodbLipidmaps.md)
- [An introduction to biodbLipidmaps (Rmd source)](./references/biodbLipidmaps.Rmd)