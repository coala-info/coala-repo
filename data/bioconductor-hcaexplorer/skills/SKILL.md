---
name: bioconductor-hcaexplorer
description: This tool provides an R interface to browse, query, and filter metadata from the Human Cell Atlas Data Coordination Platform. Use when user asks to explore single-cell genomic projects, filter biological data by organ or disease, and generate file manifests for data download.
homepage: https://bioconductor.org/packages/3.10/bioc/html/HCAExplorer.html
---


# bioconductor-hcaexplorer

name: bioconductor-hcaexplorer
description: Access and explore the Human Cell Atlas (HCA) data coordination platform. Use this skill to query biological project metadata, filter by organ, disease, or cell type, and obtain file manifests for downstream analysis of single-cell genomic data.

# bioconductor-hcaexplorer

## Overview

The `HCAExplorer` package provides an R interface to the Human Cell Atlas (HCA) Data Coordination Platform (DCP). It allows users to browse projects, samples, and files using a `dplyr`-like syntax. The primary workflow involves creating an explorer object, querying it to find specific biological data (e.g., "brain cells from healthy donors"), and then generating a manifest of file locations for downloading expression matrices or raw sequencing data.

## Core Workflow

### 1. Initialization
Connect to the HCA azul backend. By default, it connects to the production service.

```r
library(HCAExplorer)
hca <- HCAExplorer()
# View summary of available data (donors, specimens, estimated cells, etc.)
hca
```

### 2. Exploring Fields and Values
Before filtering, identify which metadata fields are available and what values they contain.

```r
# List all queryable fields
fields(hca)

# See possible values and hit counts for a specific field
values(hca, "organ")
values(hca, "disease")
values(hca, "libraryConstructionApproach")
```

### 3. Querying and Filtering
Use `filter()` to narrow down results. Supports `==`, `%in%`, and `&`.

```r
# Filter for specific organs
hca_filtered <- hca %>% filter(organ %in% c("blood", "brain"))

# Combine multiple criteria
hca_filtered <- hca %>% filter(organ == "pancreas" & disease == "normal")

# Undo or reset queries
hca <- undoQuery(hca, n = 1)
hca <- resetQuery(hca)
```

### 4. Navigating Results
The explorer object displays results in a paginated tibble.

```r
# Get the full results table as a tibble
res <- results(hca)

# Change the view (projects, samples, or files)
hca <- hca %>% activate("samples")
hca <- hca %>% activate("projects")

# Pagination
hca <- nextResults(hca)

# Select specific columns for display
hca <- hca %>% select("projects.projectTitle", "samples.organ")
hca <- resetSelect(hca)

# Subset by row index
hca_subset <- hca[1:5, ]
```

### 5. Obtaining Manifests
Once the desired projects/samples are filtered, generate a manifest for data download.

```r
# Check available file formats for the current selection
formats <- getManifestFileFormats(hca)

# Download manifest as a tibble (e.g., for fastq files)
manifest <- getManifest(hca, fileFormat = "fastq")
```

## Tips
- **Network Dependency**: This package requires an active internet connection to query the HCA API.
- **S3 Methods**: The package uses S3 methods; you can use standard `dplyr` pipes (`%>%`) for a fluid workflow.
- **Column Names**: Metadata columns are often nested (e.g., `projects.projectTitle`). Use `results(hca)` to see the full list of available column names in the returned tibble.

## Reference documentation
- [HCAExplorer](./references/HCAExplorer.md)