---
name: bioconductor-ssrch
description: This tool provides a lightweight search engine for indexing and searching R metadata corpora using hashed environments and interactive interfaces. Use when user asks to search metadata collections, retrieve specific documents by ID, or launch an interactive Shiny app for corpus exploration.
homepage: https://bioconductor.org/packages/release/bioc/html/ssrch.html
---


# bioconductor-ssrch

name: bioconductor-ssrch
description: A lightweight search engine for R metadata corpora. Use this skill to tokenize, index, and search modest-sized collections of metadata (e.g., study attributes, sample annotations) using hashed environments and selectize-based interfaces.

# bioconductor-ssrch

## Overview

The `ssrch` package provides a framework for managing and searching metadata corpora in R. It is particularly useful for heterogeneous datasets (like SRA metadata) where field names and values vary across studies. It works by tokenizing corpus elements, filtering them into hashed environments, and providing both programmatic and interactive (Shiny) search capabilities.

## Core Workflows

### 1. Loading and Inspecting a DocSet
The primary container for metadata in `ssrch` is the `DocSet` class.

```r
library(ssrch)

# Load example cancer metadata corpus
data(docset_cancer68)
docset_cancer68

# Retrieve a specific document by its ID (e.g., study accession)
doc <- retrieve_doc("ERP010142", docset_cancer68)
head(doc)
```

### 2. Programmatic Searching
Use `searchDocs` to find keywords or phrases across the entire corpus. This function supports regular expressions and case-insensitive matching.

```r
# Search for a specific term
hits <- searchDocs("Adjacent", docset_cancer68, ignore.case = TRUE)

# Search using regex for multiple patterns
# Example: Non-Small Cell Lung Cancer or NSCLC
nsc_hits <- searchDocs("Non.Small Cell|NSCLC$", docset_cancer68, ignore.case = TRUE)

# View the hits and associated document IDs
print(nsc_hits)
```

### 3. Accessing Search Results
Once hits are identified, use the document IDs to pull the full metadata tables for inspection.

```r
# Extract unique document IDs from search results
target_docs <- unique(nsc_hits$docs)

# Retrieve the full data frames for these documents
metadata_list <- lapply(target_docs, function(id) retrieve_doc(id, docset_cancer68))
names(metadata_list) <- target_docs
```

### 4. Interactive Search (Shiny)
For an exploratory interface with predictive, autocompleted search (via selectize.js), use the `ctxsearch` function.

```r
# Launch the interactive search application
ctxsearch(docset_cancer68)
```

## Key Functions

- `searchDocs(query, docset, ...)`: Searches the indexed keywords for matches.
- `retrieve_doc(id, docset)`: Extracts the full data frame for a specific document ID.
- `ctxsearch(docset)`: Launches a Shiny app for interactive corpus exploration.
- `docs2kw(docset)`: Accesses the environment mapping documents to keywords.
- `kw2docs(docset)`: Accesses the environment mapping keywords to documents.

## Usage Tips

- **Heterogeneity**: `ssrch` is designed for cases where different documents have different columns. It flattens these into a searchable token space.
- **Memory Efficiency**: The package uses hashed environments (`kw2docs`, `docs2kw`) to keep the search index lightweight and fast for modest-sized corpora.
- **Regex**: Leverage R's regular expression capabilities within `searchDocs` to handle variations in spelling, punctuation, or abbreviations.

## Reference documentation

- [ssrch: selectize-based search engine for corpora of modest size](./references/ssrch.md)