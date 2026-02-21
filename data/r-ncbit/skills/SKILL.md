---
name: r-ncbit
description: "Makes NCBI taxonomic data locally available and         searchable as an R object.</p>"
homepage: https://cloud.r-project.org/web/packages/ncbit/index.html
---

# r-ncbit

name: r-ncbit
description: Retrieve, build, and search NCBI taxonomic data locally using the ncbit R package. Use this skill when you need to download the NCBI taxonomy database, map scientific names to TaxIDs, retrieve names from IDs, or subset taxonomic trees for specific clades within R.

## Overview
The `ncbit` package provides tools to make NCBI taxonomic data locally available and searchable as an R object. It automates the process of downloading taxonomy files from NCBI and provides efficient lookup functions for taxonomic identifiers and names, which is particularly useful for phylogenetic and comparative genomic workflows.

## Installation
To install the package from CRAN:
```R
install.packages("ncbit")
```

## Core Functions

### Database Management
- `ncbit(update = FALSE)`: The primary function to retrieve and build the local NCBI taxonomy database. If `update = TRUE`, it downloads the latest data from NCBI. It returns an environment containing the taxonomic nodes and names.

### Searching and Mapping
- `get_taxid_it(names)`: Retrieves NCBI TaxIDs for a character vector of scientific names.
- `get_names_it(ids)`: Retrieves scientific names for a numeric vector of NCBI TaxIDs.

### Subsetting
- `subset_ncbit(nodes, tree)`: Subsets the taxonomic data based on a set of target nodes. This is useful for isolating specific lineages or clades from the global NCBI tree.

## Workflows

### Initializing the Local Database
Before performing searches, you must build or load the local database.
```R
library(ncbit)

# Build/Load the taxonomy (this may take time on first run)
ncbi_tax <- ncbit()
```

### Mapping Names to IDs
```R
species <- c("Homo sapiens", "Mus musculus", "Drosophila melanogaster")
tax_ids <- get_taxid_it(species)
print(tax_ids)
```

### Retrieving Lineage Information
Once you have TaxIDs, you can use them to explore the hierarchy or subset the data.
```R
# Get names for specific IDs
ids <- c(9606, 10090)
scientific_names <- get_names_it(ids)

# Subset the tree for a specific group
# Note: 'ncbi_tax' is the object returned by ncbit()
human_subset <- subset_ncbit(nodes = 9606, tree = ncbi_tax)
```

## Tips
- **Memory Usage**: The full NCBI taxonomy is large. Ensure your R session has sufficient RAM when calling `ncbit()` for the first time.
- **Offline Use**: Once `ncbit()` has been run and the data is cached locally, you can perform taxonomic lookups without an active internet connection.
- **Case Sensitivity**: Ensure scientific names are correctly capitalized (e.g., "Homo sapiens" rather than "homo sapiens") for accurate matching.

## Reference documentation
- [ncbit CRAN Home Page](./references/home_page.md)