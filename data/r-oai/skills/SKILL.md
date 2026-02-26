---
name: r-oai
description: The r-oai package provides a client for the OAI-PMH protocol to harvest metadata from various repositories. Use when user asks to identify repository capabilities, list metadata formats, harvest identifiers, or retrieve full records from OAI-PMH compliant services.
homepage: https://cloud.r-project.org/web/packages/oai/index.html
---


# r-oai

## Overview
The `oai` package is a general-purpose client for the OAI-PMH protocol. It allows R users to interact with any service that implements this protocol to harvest metadata. The package maps directly to the six OAI-PMH "verbs": GetRecord, Identify, ListIdentifiers, ListMetadataFormats, ListRecords, and ListSets.

## Installation
```r
install.packages("oai")
library(oai)
```

## Core Workflows

### 1. Repository Discovery
Before harvesting, identify the repository's capabilities and structure.
```r
# Identify repository details (admin email, compression, etc.)
id("https://oai.datacite.org/oai")

# List available sets (collections)
sets <- list_sets("http://api.gbif.org/v1/oai-pmh/registry")

# List supported metadata formats (e.g., oai_dc, eml)
list_metadataformats(url = "https://oai.datacite.org/oai")
```

### 2. Harvesting Identifiers
Use `list_identifiers` to get a list of record headers without the full metadata content. This is useful for scoping a harvest.
```r
# Get identifiers within a date range
ids <- list_identifiers(
  url = "http://api.gbif.org/v1/oai-pmh/registry",
  from = '2023-01-01T', 
  until = '2023-01-02T'
)

# Count how many identifiers exist for a query
count_identifiers(url = "http://api.gbif.org/v1/oai-pmh/registry")
```

### 3. Harvesting Full Records
Use `list_records` for bulk harvesting or `get_records` for specific items.
```r
# Bulk harvest records
records <- list_records(
  url = "http://api.gbif.org/v1/oai-pmh/registry",
  from = '2023-05-01T', 
  until = '2023-05-15T'
)

# Get specific records by ID
specific_records <- get_records(
  ids = c("oai:biodiversitylibrary.org:item/7", "oai:biodiversitylibrary.org:item/9"),
  url = "http://www.biodiversitylibrary.org/oai"
)
```

## Tips and Best Practices
- **Date Formats**: OAI-PMH typically requires ISO8601 format (e.g., `YYYY-MM-DD` or `YYYY-MM-DDThh:mm:ssZ`). Check the `granularity` field in the `id()` output.
- **Resumption Tokens**: The `oai` package handles pagination (resumption tokens) automatically for `list_` functions, returning a single combined data frame/list.
- **Metadata Prefixes**: The default is usually `oai_dc` (Dublin Core). If you need richer metadata (like `eml` or `mods`), specify the `metadataPrefix` argument if the repository supports it.
- **Data Structure**: `list_records` and `list_identifiers` return tibbles, making them easy to pipe into `dplyr` workflows. `get_records` returns a named list where each element contains a `header` and `metadata` tibble.

## Reference documentation
- [oai introduction](./references/oai.Rmd)