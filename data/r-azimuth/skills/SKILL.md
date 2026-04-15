---
name: r-azimuth
description: This tool performs automated cell type annotation and mapping of single-cell RNA-seq or ATAC-seq data onto curated reference datasets using the Azimuth R package. Use when user asks to map single-cell query datasets, perform automated cell type annotation, project data onto a reference UMAP, or launch the Azimuth Shiny application.
homepage: https://cran.r-project.org/web/packages/azimuth/index.html
---

# r-azimuth

name: r-azimuth
description: Use when Claude needs to perform single-cell RNA-seq or ATAC-seq data mapping, automated cell type annotation, and projection onto reference datasets using the Azimuth R package. This skill is ideal for workflows involving Seurat v4/v5 objects, reference-based mapping, and utilizing pre-built references for human or mouse tissues.

## Overview
Azimuth is an R package and Shiny app designed for the rapid mapping of single-cell query datasets onto curated reference datasets. It utilizes the Seurat v4/v5 reference-based mapping framework to perform cell type annotation, UMAP projection, and data imputation. It is particularly effective for standardizing annotations across experiments using high-quality, multi-modal references.

## Installation
To install the Azimuth package from GitHub:
```R
if (!requireNamespace('remotes', quietly = TRUE)) {
  install.packages('remotes')
}
remotes::install_github('satijalab/azimuth', ref = 'master')
```

## Main Functions and Workflows

### Automated Mapping with RunAzimuth
The primary entry point for R users is the `RunAzimuth` function, which automates the entire mapping pipeline (normalization, finding anchors, and transferring data).

```R
library(Azimuth)
library(Seurat)

# Load your query Seurat object
query <- readRDS("query_data.rds")

# Run mapping against a specific reference (e.g., "pbmcref")
# References can be names of built-in references or paths to reference directories
query <- RunAzimuth(query, reference = "pbmcref")

# The results (predicted IDs and scores) are added to the object metadata
head(query@meta.data)
```

### Launching the Shiny App
Azimuth provides an interactive web interface for users who prefer a GUI for mapping and visualization.

```R
# Launch with default web-hosted references
Azimuth::AzimuthApp()

# Launch using a local reference directory
Azimuth::AzimuthApp(reference = "/path/to/reference_dir")
```

### Working with Reference Files
A valid Azimuth reference directory must contain:
- `ref.Rds`: The Seurat object containing the reference data.
- `idx.annoy`: The Annoy index for fast nearest-neighbor searching.

### Configuration and Options
You can customize the behavior of the mapping or the app using global options:

```R
# Set maximum cells for the app
options(Azimuth.app.max_cells = 100000)

# Enable bridge integration for ATAC-seq workflows
options(Azimuth.app.do_bridge = TRUE)
```

## Tips for Success
- **Gene Names**: Ensure query gene names match the reference (usually symbols). Azimuth handles some basic mapping, but pre-cleaning helps.
- **Seurat Version**: Azimuth is built on Seurat v4/v5. Ensure your query object is compatible.
- **Memory**: Mapping large datasets can be memory-intensive; use `max_cells` options if running in a resource-constrained environment.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)