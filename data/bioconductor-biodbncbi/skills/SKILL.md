---
name: bioconductor-biodbncbi
description: The biodbNcbi package provides specialized connectors to integrate NCBI databases like Gene, CCDS, and PubChem into R workflows using the biodb framework. Use when user asks to search for NCBI entries, retrieve genomic or chemical data by ID, or access Entrez web services like efetch and esearch.
homepage: https://bioconductor.org/packages/release/bioc/html/biodbNcbi.html
---


# bioconductor-biodbncbi

## Overview

The `biodbNcbi` package is an extension of the `biodb` framework, providing specialized connectors to NCBI's most prominent databases. It allows for seamless integration of NCBI data into R workflows by wrapping complex web service calls into standardized `biodb` connector objects.

Supported Databases:
- **NCBI Gene**: `ncbi.gene`
- **CCDS (Consensus Coding Sequence)**: `ncbi.ccds`
- **PubChem Compound**: `ncbi.pubchem.comp`
- **PubChem Substance**: `ncbi.pubchem.subst`

## Core Workflow

### 1. Initialization
Every session must start by creating a `biodb` instance and then creating the specific NCBI connector.

```r
library(biodb)
library(biodbNcbi)

# Create the main biodb instance
mybiodb <- biodb::newInst()

# Create a connector (e.g., for NCBI Gene)
gene_conn <- mybiodb$getFactory()$createConn('ncbi.gene')

# Other connectors:
# ccds_conn <- mybiodb$getFactory()$createConn('ncbi.ccds')
# pc_comp_conn <- mybiodb$getFactory()$createConn('ncbi.pubchem.comp')
```

### 2. Searching and Retrieving Entries
You can search for entries using specific fields or retrieve them directly by ID.

```r
# Search for entries by name
ids <- gene_conn$searchForEntries(fields=list(name='chemokine'), max.results=10)

# Retrieve entry objects
entries <- gene_conn$getEntry(ids)

# Convert entries to a standard R data.frame
df <- mybiodb$entriesToDataframe(entries)
```

### 3. Using Entrez Web Services
For advanced users, the package provides direct access to NCBI Entrez utilities (`efetch`, `esearch`, `einfo`) through the connector.

*   **wsEsearch**: Search for IDs using NCBI query syntax.
*   **wsEfetch**: Retrieve full records in specific formats (XML, text).
*   **wsEinfo**: Get database statistics and field information.

```r
# Example: Fetching a specific Gene entry as XML
entry_xml <- gene_conn$wsEfetch('2833', retmode='xml', retfmt='parsed')

# Example: Direct Esearch for specific gene names
matching_ids <- gene_conn$wsEsearch(term='"BRCA1"[Gene Name]', retmax=5, retfmt='ids')
```

### 4. Resource Management
Always terminate the `biodb` instance to free up system resources and close connections.

```r
mybiodb$terminate()
```

## Tips and Best Practices
- **Caching**: `biodb` handles caching automatically. If you perform the same query twice, the second call will be significantly faster as it retrieves data from the local cache.
- **Parsing XML**: When using `wsEfetch` with `retfmt='parsed'`, the returned object is an `XMLInternalDocument`. Use the `XML` package (e.g., `getNodeSet()`) to extract specific nodes.
- **Rate Limits**: Be mindful of NCBI's web service usage policies. `biodbNcbi` manages basic connection logic, but high-volume requests should be spaced out.

## Reference documentation

- [An introduction to biodbNcbi](./references/biodbNcbi.Rmd)