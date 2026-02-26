---
name: bioconductor-biodbhmdb
description: The biodbHmdb package provides a connector to the Human Metabolome Database for programmatic access and high-performance local searching within the biodb framework. Use when user asks to retrieve metabolite entries by accession ID, search for metabolites by name or description, or extract metadata fields from the HMDB database.
homepage: https://bioconductor.org/packages/release/bioc/html/biodbHmdb.html
---


# bioconductor-biodbhmdb

## Overview
The `biodbHmdb` package is a Bioconductor extension for the `biodb` framework. It provides a connector to the Human Metabolome Database (HMDB). Because HMDB does not provide a comprehensive public API for all search types, this package downloads the database locally to allow for programmatic access and high-performance searching on the local machine.

## Installation
Install the package using `BiocManager`:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("biodbHmdb")
```

## Typical Workflow

### 1. Initialization
Every session must start by creating a `biodb` instance and then creating the HMDB connector.

```r
library(biodb)
library(biodbHmdb)

# Create biodb instance
mybiodb <- biodb::newInst()

# Create connector to HMDB metabolites
conn <- mybiodb$getFactory()$createConn('hmdb.metabolites')
```

### 2. Accessing and Retrieving Entries
You can retrieve specific entries using HMDB accession IDs.

```r
# Get total count of entries
conn$getNbEntries()

# Get a list of IDs (e.g., the first 5)
ids <- conn$getEntryIds(5)

# Retrieve entry objects
entries <- conn$getEntry(ids)

# Convert entries to a data frame for analysis
df <- mybiodb$entriesToDataframe(entries)
```

### 3. Searching the Database
The package uses the generic `searchForEntries` method to filter the local HMDB database.

**Search by Name:**
```r
# Search for a specific metabolite by name
id <- conn$searchForEntries(list(name='1-Methylhistidine'), max.results=1)

# Search using multiple keywords (AND logic)
ids <- conn$searchForEntries(list(name=c('propanoic', 'acid')))
```

**Search by Description:**
```r
# Search for metabolites associated with specific terms in their description
ids <- conn$searchForEntries(list(description=c('Parkinson', 'sclerosis')))
```

### 4. Extracting Specific Fields
Once you have an entry ID, you can extract specific metadata fields.

```r
entry <- conn$getEntry(id)
entry_df <- entry$getFieldsAsDataframe(fields=c('accession', 'name', 'description', 'formula', 'monisotopic_molecular_weight'))
```

### 5. Resource Management
Always terminate the `biodb` instance to free up system resources and close file handles.

```r
mybiodb$terminate()
```

## Tips and Best Practices
- **Local Storage**: Be aware that the first time you use the connector in a real environment, it will attempt to download the HMDB database. Ensure you have sufficient disk space.
- **Field Names**: Common `biodb` fields used with HMDB include `accession`, `name`, `description`, `formula`, `cas`, and `smiles`.
- **Filtering**: The `searchForEntries` function accepts a list where keys are field names. Providing a vector of strings for a single field acts as an "AND" search for those terms within that field.

## Reference documentation
- [An introduction to biodbHmdb](./references/biodbHmdb.Rmd)