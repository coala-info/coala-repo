---
name: bioconductor-cellxgenedp
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cellxgenedp.html
---

# bioconductor-cellxgenedp

name: bioconductor-cellxgenedp
description: Specialized R-based interface for the CELLxGENE data portal. Use this skill to discover, filter, and retrieve single-cell RNA sequencing datasets and metadata. It supports programmatic access to collections, datasets, and files, as well as downloading H5AD files for conversion into Bioconductor objects like SingleCellExperiment.

# bioconductor-cellxgenedp

## Overview
The `cellxgenedp` package provides an R interface to the CELLxGENE data portal. It allows users to programmatically navigate the hierarchy of "collections" (studies), "datasets" (specific data matrices), and "files" (downloadable assets). It is particularly useful for filtering large-scale single-cell data based on ontology terms (assay, disease, ethnicity, etc.) and integrating these datasets into Bioconductor workflows.

## Core Workflow

### 1. Database Initialization
Retrieve the latest metadata from the portal to start your session.
```r
library(cellxgenedp)
library(dplyr)

db <- db()
db # Displays summary of collections, datasets, and files
```

### 2. Data Discovery
Navigate the three main tables using `collections()`, `datasets()`, and `files()`. Use `dplyr` joins to link them.

```r
# Find the collection with the most datasets
top_collection <- datasets(db) |>
    count(collection_id, sort = TRUE) |>
    slice(1)

# Get details for that collection
left_join(top_collection, collections(db), by = "collection_id")
```

### 3. Filtering with Facets
CELLxGENE uses controlled ontologies. Use `facets()` to see available levels and `facets_filter()` to subset datasets.

```r
# Explore available assays
facets(db, "assay")

# Filter for specific criteria (e.g., 10x 3' v3, Female, African American)
selected_datasets <- datasets(db) |>
    filter(
        facets_filter(assay, "ontology_term_id", "EFO:0009922"),
        facets_filter(sex, "label", "female"),
        facets_filter(self_reported_ethnicity, "label", "African American")
    )
```

### 4. Visualization and Download
You can open the CELLxGENE explorer in a browser or download files (typically H5AD) for local analysis.

```r
# Visualize a specific dataset in the browser
selected_datasets |> slice(1) |> datasets_visualize()

# Download H5AD file
local_path <- selected_datasets |>
    slice(1) |>
    left_join(files(db), by = "dataset_id") |>
    filter(filetype == "H5AD") |>
    files_download(dry.run = FALSE)
```

### 5. Integration with Bioconductor
Use `zellkonverter` to read the downloaded H5AD file into a `SingleCellExperiment` object.

```r
library(zellkonverter)
sce <- readH5AD(local_path, use_hdf5 = TRUE)
sce
```

## Advanced Queries

### Author-based Search
Since authors are linked to collections, join `authors()` with `datasets()` to find data by specific researchers.

```r
author_data <- left_join(authors(db), datasets(db), by = "collection_id")
author_data |> filter(family == "Teichmann")
```

### External Metadata
Access DOIs, publisher info, and external links (e.g., to raw FASTQ files on GEO/SRA).

```r
publisher_metadata(db)
links(db) |> filter(link_type == "RAW_DATA")
```

## Tips and Best Practices
- **Caching**: Files are downloaded to a local cache. Use `cellxgenedp:::.cellxgenedb_cache_path()` to find the location.
- **H5AD vs RDS**: Prefer H5AD files. RDS files (Seurat) often have version compatibility issues across different R environments.
- **Interactive App**: Use `cxg()` to launch a Shiny gadget for a GUI-based discovery and download experience.
- **Deduplication**: When working with `authors()`, use `distinct()` as some author names may be duplicated in the source metadata.

## Reference documentation
- [Discovery and retrieval](./references/a_using_cellxgenedp.md)
- [Case studies](./references/b_case_studies.md)
- [Discover and download datasets and files from the cellxgene data portal](./references/using_cellxgenedp.Rmd)