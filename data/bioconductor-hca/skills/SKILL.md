---
name: bioconductor-hca
description: the package allows the user to page through large result sets, and to flexibly query the 'list-of-lists' structure representing query responses.
homepage: https://bioconductor.org/packages/release/bioc/html/hca.html
---

# bioconductor-hca

name: bioconductor-hca
description: Use this skill when working with the Human Cell Atlas (HCA) data in R. It provides specialized functions for querying, filtering, and retrieving single-cell data from the HCA Data Storage System (DSS) and Azul indexer. Use this skill to navigate large result sets, handle complex 'list-of-lists' query responses, and download HCA projects, samples, or files for downstream analysis.

# bioconductor-hca

## Overview
The `hca` package provides an R interface to the Human Cell Atlas (HCA) API. It allows users to search for single-cell datasets based on specific metadata (e.g., organ, cell type, donor characteristics) and retrieve data in various formats. The package is designed to handle the large-scale nature of HCA data by providing pagination and efficient filtering mechanisms.

## Core Workflow

### 1. Initialization and Exploration
Load the library and explore available resources.
```r
library(hca)

# List available projects
projects <- projects()

# List available samples
samples <- samples()

# List available files
files <- files()
```

### 2. Querying and Filtering
The `hca` package uses a fluent interface for filtering. You can filter by various metadata fields.
```r
# Filter projects by specific organ
brain_projects <- projects() |> 
    filter(organ == "brain")

# Filter by multiple criteria
complex_query <- projects() |>
    filter(organ == "pancreas", genusSpecies == "Homo sapiens")
```

### 3. Handling Results
Results are returned as tibbles, but the underlying data can be complex.
```r
# View the first few results
head(brain_projects)

# Access nested list-of-lists structure if necessary
# (The package usually flattens common fields automatically)
```

### 4. Pagination
For large result sets, use the `next_results()` function to page through data.
```r
# Get the first page
res <- projects(size = 10)

# Get the next page
res_next <- next_results(res)
```

### 5. Downloading Data
Once specific files or projects are identified, they can be downloaded.
```r
# Download a specific file by its UUID
# Note: Ensure you have the file UUID from the files() tibble
download_hca_file(file_uuid = "your-uuid-here", destfile = "data.h5ad")
```

## Tips for Efficient Usage
- **Size Parameter**: Use the `size` argument in `projects()`, `samples()`, or `files()` to limit the number of results per page (default is 100).
- **Metadata Fields**: Use `filters()` to see available fields that can be used in the `filter()` function.
- **Tidyverse Integration**: The package is designed to work seamlessly with `dplyr` verbs like `filter()`, `select()`, and `mutate()`.

## Reference documentation
- [hca Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/hca.html)