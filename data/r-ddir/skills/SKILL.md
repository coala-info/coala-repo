---
name: r-ddir
description: This tool accesses and retrieves multi-omics dataset metadata from the Omics Discovery Index using the ddiR R package. Use when user asks to search for datasets by keywords, retrieve specific dataset details, or find similar datasets based on metadata scores.
homepage: https://cran.r-project.org/web/packages/ddir/index.html
---


# r-ddir

name: r-ddir
description: Access and retrieve data from the Omics Discovery Index (OmicsDI) API. Use this skill when you need to search for multi-omics datasets, retrieve specific dataset metadata (proteomics, genomics, etc.), or find similar datasets based on metadata scores using the ddiR R package.

## Overview

The `ddiR` package provides a client to interact with the Omics Discovery Index (OmicsDI) RESTful Web Services. It allows users to search for datasets across various databases (like PRIDE), retrieve detailed metadata for specific accessions, and explore related publications or similar datasets.

## Installation

To install the package from CRAN:

```R
install.packages("ddiR")
library(ddiR)
```

Note: For the development version, use `devtools::install_github("enriquea/ddiR")`.

## Main Functions and Workflows

### Searching for Datasets
Use `search.DatasetsSummary` to find datasets based on keywords, genes, or tissues.

```R
# Search for datasets related to a specific gene
datasets <- search.DatasetsSummary(query = "NOTCH1")

# Access the count of results
total_found <- datasets@count

# Iterate through results (default size is 20)
for(ds in datasets@datasets) {
  print(paste(ds@dataset.id, ds@database))
}
```

### Retrieving Dataset Details
Use `get.DatasetDetail` to fetch full metadata for a specific dataset using its accession ID and database name.

```R
# Retrieve details for a PRIDE dataset
dataset <- get.DatasetDetail(accession = "PXD000210", database = "pride")

# Extract specific metadata using getter functions
name <- get.dataset.name(dataset)
omics_type <- get.dataset.omics(dataset)
link <- get.dataset.link(dataset)
tissues <- get.dataset.tissues(dataset)
```

### Finding Similar Datasets
OmicsDI provides metadata similarity scores. Use `get.MetadataSimilars` to find related studies.

```R
similars <- get.MetadataSimilars(accession = "PXD000210", database = "pride")

for(s_ds in similars@datasets) {
  print(paste("Similar ID:", s_ds@dataset.id, "Score:", s_ds@score))
}
```

### Pagination
When dealing with large result sets, use the `start` and `size` parameters in `search.DatasetsSummary`.

```R
# Get the second page of results (100 items per page)
datasets_p2 <- search.DatasetsSummary(query = "Cancer", start = 100, size = 100)
```

## Tips
- **Query Syntax**: The API supports boolean operators like `AND` (e.g., `"Cancer AND Genomics"`).
- **S4 Objects**: Most return values are S4 objects. Use `@` to access slots or the provided `get.dataset.*` helper functions for cleaner code.
- **Database IDs**: Common database identifiers include `pride`, `ega`, `metabolights`, and `geo`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)