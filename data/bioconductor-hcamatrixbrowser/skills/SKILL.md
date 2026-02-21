---
name: bioconductor-hcamatrixbrowser
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.12/bioc/html/HCAMatrixBrowser.html
---

# bioconductor-hcamatrixbrowser

name: bioconductor-hcamatrixbrowser
description: Access and query the Human Cell Atlas (HCA) Matrix Service to retrieve gene expression matrices. Use this skill when you need to download HCA data in Loom, MTX, or CSV formats, apply metadata filters to HCA datasets, or explore available HCA matrix features and fields using R.

## Overview

The `HCAMatrixBrowser` package provides an R interface to the Human Cell Atlas (HCA) Matrix Service. It allows users to query the HCA database for expression matrices using tidyverse-style filtering and retrieve data directly into Bioconductor-standard objects like `LoomExperiment` or `SingleCellExperiment`.

## Core Workflow

### 1. Initialize the API Object
Start by creating an HCA Matrix API object. This object tracks your filters and interacts with the service.

```r
library(HCAMatrixBrowser)
hca <- HCAMatrix()
```

### 2. Explore Available Metadata and Filters
Before querying, identify which fields are available for filtering or which formats are supported.

```r
# List all available filter fields (e.g., project title, genus, organ)
available_filters(hca)

# Get details about a specific filter (min/max for numeric, etc.)
filter_detail(hca, "genes_detected")

# Check supported output formats ("loom", "mtx", "csv")
available_formats(hca)

# Check available features ("gene", "transcript")
available_features(hca)
```

### 3. Apply Filters
Use the `filter()` function to narrow down the data. You can combine multiple conditions using `&` (AND) or `|` (OR).

```r
# Filter by project name and a numeric threshold
hca_filtered <- filter(hca, 
    project.project_core.project_short_name == "Single cell transcriptome analysis of human pancreas" & 
    genes_detected >= 300
)

# View the active filter structure
filters(hca_filtered)
```

### 4. Download and Load Data
The `loadHCAMatrix()` function sends the request and returns the data. The object type returned depends on the `format` argument.

*   **Loom (Default):** Returns a `LoomExperiment` object.
*   **MTX:** Returns a `SingleCellExperiment` object.
*   **CSV:** Returns a list of `tibble` data frames (expression, cells, and genes).

```r
# Download as Loom (Bioconductor default)
loom_data <- loadHCAMatrix(hca_filtered, format = "loom")

# Download as MTX (SingleCellExperiment)
sce_data <- loadHCAMatrix(hca_filtered, format = "mtx")
```

## Legacy/Direct Bundle Access (v0)
If you already have specific `bundle_fqids` (Full Query Identifiers), you can bypass the filter system:

```r
bundle_ids <- c("uuid.version1", "uuid.version2")
lex <- loadHCAMatrix(hca, bundle_fqids = bundle_ids, format = "loom")
```

## Tips
*   **Caching:** The package automatically caches downloaded matrices. The first request for a large dataset may take time, but subsequent loads will be faster.
*   **HCABrowser Integration:** For complex discovery of bundle IDs, use the `HCABrowser` package to find bundles, then pass the IDs to `HCAMatrixBrowser`.
*   **Feature Selection:** Use `feature = "gene"` or `feature = "transcript"` in `loadHCAMatrix()` to specify the genomic level of the matrix.

## Reference documentation
- [Generating HCAMatrix queries with the API](./references/HCAMatrix.md)
- [HCAMatrixBrowser Quick Start](./references/HCAMatrixBrowser.md)