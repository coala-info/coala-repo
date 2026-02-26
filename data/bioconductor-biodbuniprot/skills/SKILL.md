---
name: bioconductor-biodbuniprot
description: The bioconductor-biodbuniprot package provides a connector to the UniProt database for programmatic data retrieval, searching, and identifier mapping within the biodb framework. Use when user asks to retrieve UniProt entries by accession number, search the UniProt web service using complex queries, or map gene symbols to UniProt IDs.
homepage: https://bioconductor.org/packages/release/bioc/html/biodbUniprot.html
---


# bioconductor-biodbuniprot

## Overview

The `biodbUniprot` package is an extension of the `biodb` framework, providing a dedicated connector to the UniProt database. It allows users to programmatically interact with UniProt's search web services, retrieve detailed entry information, and perform identifier mapping (specifically gene symbols to UniProt IDs) while benefiting from `biodb`'s built-in caching and data frame conversion utilities.

## Workflow and Key Functions

### 1. Initialization
Every session must start by creating a `BiodbMain` instance and then generating a UniProt-specific connector via the factory.

```r
# Initialize biodb
mybiodb <- biodb::newInst()

# Create the UniProt connector
conn <- mybiodb$getFactory()$createConn('uniprot')
```

### 2. Retrieving Specific Entries
Use `getEntry()` to fetch full records using UniProt accession numbers (e.g., P01011).

```r
# Fetch entries
entries <- conn$getEntry(c('P01011', 'P09237'))

# Convert entries to a readable data frame
df <- mybiodb$entriesToDataframe(entries)
```

### 3. Searching the UniProt Web Service
The `wsSearch()` method allows for complex queries using UniProt's query syntax.

*   **Query Syntax**: Use UniProt API fields (e.g., `reviewed:true`, `organism_id:9606`).
*   **Return Formats (`retfmt`)**:
    *   `'parsed'`: Returns a data frame of results.
    *   `'ids'`: Returns a character vector of UniProt accessions.
    *   `'plain'`: Returns the raw text response from the server.
    *   `'request'`: Returns the URL that would be sent to UniProt.

```r
# Search for human reviewed entries, returning a data frame
results <- conn$wsSearch(query='reviewed:true AND organism_id:9606', 
                         fields=c('accession', 'id', 'gene_names'),
                         size=5, 
                         retfmt='parsed')
```

### 4. Gene Symbol Mapping
The package provides a specialized method to find UniProt IDs associated with specific gene symbols.

```r
# Basic mapping
ids <- conn$geneSymbolToUniprotIds('G-CSF')

# Advanced mapping with fuzzy matching
ids_fuzzy <- conn$geneSymbolToUniprotIds('G-CSF', 
                                         ignore.nonalphanum=TRUE, 
                                         partial.match=TRUE)

# Convert the resulting IDs to a data frame for inspection
mybiodb$entryIdsToDataframe(ids[['G-CSF']], 'uniprot', fields=c('accession', 'gene.symbol'))
```

### 5. Resource Management
Always terminate the `biodb` instance to release system resources and close connections.

```r
mybiodb$terminate()
```

## Tips and Best Practices
*   **Caching**: `biodb` automatically caches downloaded entries. Subsequent calls for the same IDs will be significantly faster.
*   **Rate Limiting**: UniProt has a frequency limit (approx. 3 requests per second). `geneSymbolToUniprotIds` may take time if it needs to download many new entries to verify symbols.
*   **Field Names**: When using `wsSearch`, ensure the `fields` requested match UniProt's supported API field names (e.g., `accession`, `id`, `gene_names`).

## Reference documentation

- [An introduction to biodbUniprot](./references/biodbUniprot.Rmd)