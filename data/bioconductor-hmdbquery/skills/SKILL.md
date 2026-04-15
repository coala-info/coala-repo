---
name: bioconductor-hmdbquery
description: The bioconductor-hmdbquery package provides an interface to retrieve and manipulate metabolite metadata from the Human Metabolome Database. Use when user asks to query metabolite information by HMDB ID, extract disease or biospecimen associations, and explore protein or gene relationships.
homepage: https://bioconductor.org/packages/release/bioc/html/hmdbQuery.html
---

# bioconductor-hmdbquery

## Overview

The `hmdbQuery` package provides an interface to the Human Metabolome Database (HMDB), allowing users to retrieve and manipulate metadata for over 114,000 metabolites. It supports direct XML-based queries over HTTP and provides S4 objects to manage complex metabolite information, including disease associations, biofluids, and protein/gene relationships.

## Key Workflows

### Querying a Metabolite

To retrieve data for a specific metabolite, use the `HmdbEntry` function with a valid HMDB ID.

```r
library(hmdbQuery)

# Fetch metadata for 1-Methylhistidine
lk1 <- HmdbEntry(prefix = "http://www.hmdb.ca/metabolites/", id = "HMDB0000001")

# View summary
lk1
```

### Extracting Specific Metadata

Once an entry is loaded, use specialized accessor functions to extract categorized information:

*   **Diseases**: `diseases(lk1)` returns a data frame of annotated diseases.
*   **Biospecimens**: `biospecimens(lk1)` returns a character vector of biofluids (e.g., Blood, Urine).
*   **Tissues**: `tissues(lk1)` returns a character vector of tissue locations.
*   **Full Metadata**: `store(lk1)` returns a list containing all 40+ metadata fields parsed from the HMDB XML.

### Exploring Protein and Gene Associations

The `store()` method allows deep access into protein and gene mappings:

```r
st <- store(lk1)

# Get associated protein names
st$protein_assoc["name", ]

# Get associated gene symbols
st$protein_assoc["gene_name", ]
```

### Using Package Snapshots

For large-scale analysis where querying individual IDs is inefficient, the package provides data snapshots (as of Sept 2017) for common associations:

```r
# Load disease association table
data(hmdb_disease)
head(hmdb_disease)

# Other available datasets:
# data(hmdb_gene)
# data(hmdb_protein)
# data(hmdb_omim)
```

## Tips and Best Practices

*   **Memory Management**: HMDB entries are large. Avoid loading thousands of full `HmdbEntry` objects into memory simultaneously. Use the provided `data()` snapshots for bulk filtering.
*   **ID Formatting**: Ensure IDs follow the "HMDBXXXXXXX" format (7 digits).
*   **Internet Access**: `HmdbEntry` requires an active internet connection to fetch XML data from hmdb.ca.
*   **PubMed Integration**: Disease associations often include PubMed IDs. You can use the `annotate` package to fetch abstracts for these references.

## Reference documentation

- [hmdbQuery: working with Human Metabolome Database (hmdb.ca)](./references/hmdbQuery.md)