---
name: bioconductor-hcabrowser
description: This tool provides an R interface to search, filter, and retrieve single-cell genomic data from the Human Cell Atlas Data Coordination Platform. Use when user asks to query HCA metadata, filter data bundles by organ or species, or download single-cell datasets for analysis.
homepage: https://bioconductor.org/packages/3.9/bioc/html/HCABrowser.html
---

# bioconductor-hcabrowser

name: bioconductor-hcabrowser
description: Interface with the Human Cell Atlas (HCA) Data Coordination Platform (DCP) using the HCABrowser R package. Use this skill to search, filter, and retrieve single-cell genomic data bundles and files from the HCA.

# bioconductor-hcabrowser

## Overview

The `HCABrowser` package provides an R interface to the Human Cell Atlas (HCA) Data Coordination Platform (DCP). It allows users to query HCA metadata using `dplyr`-like syntax (`filter`, `select`) to identify and retrieve specific data bundles or files for single-cell analysis.

## Installation

```r
if (!require("BiocManager")) install.packages("BiocManager")
BiocManager::install("HCABrowser")
library(HCABrowser)
```

## Core Workflow

### 1. Connecting to the HCA
Initialize the browser object to establish a connection.
```r
hca <- HCABrowser()
# To see the current state, query, and results summary:
hca
```

### 2. Exploring Available Metadata
Before filtering, identify which fields exist and what values they contain.
```r
# List all available fields (abbreviated and full names)
hca %>% fields()

# See possible values for specific fields
hca %>% values(c('organ.text', 'library_construction_approach.text'))
```

### 3. Querying and Filtering
Use `filter()` to narrow down results and `select()` to choose which metadata columns to display.
```r
# Filter by organ and taxon ID
hca <- hca %>% 
  filter(organ.text %in% c('Brain', 'brain'),
         'specimen_from_organism_json.biomaterial_core.ncbi_taxon_id' == 10090)

# Select specific metadata columns
hca <- hca %>% select('paired_end', 'organ.ontology')

# Supported operators: ==, !=, %in%, %startsWith%, %endsWith%, %contains%, >, <, >=, <=
```

### 4. Managing the Query State
```r
# Toggle between viewing 'bundles' or 'files'
hca <- hca %>% activate('files')

# Undo the last N query steps
hca <- hca %>% undoEsQuery(n = 1)

# Clear all filters and selections
hca <- hca %>% resetEsQuery()

# Load the next page of results (default is 10 per page)
hca <- nextResults(hca)
```

### 5. Retrieving Results
Once the query is refined, extract the data into a local R object.
```r
# Get a tibble of the first N results
res <- hca %>% results(n = 50)

# Extract specific bundle identifiers
bundle_fqids <- hca %>% pullBundles(n = 5)

# Filter the browser to specific bundle IDs
hca <- hca %>% showBundles(bundle_fqids = bundle_fqids)
```

## Tips for Effective Queries
- **Case Sensitivity**: Metadata values like "Brain" and "brain" may both exist; use `%in% c('Brain', 'brain')` to be comprehensive.
- **Abbreviated Names**: Use the `abbreviated_names` from the `fields()` output for cleaner code, but use full JSON paths for `postSearch()` or complex nested queries.
- **Pagination**: The HCA DCP limits results per page (usually 10). Use `results(n = ...)` to automatically handle multiple page requests for larger datasets.

## Reference documentation
- [HCABrowser](./references/HCABrowser.md)