---
name: bioconductor-scatac.explorer
description: scATAC.Explorer provides a standardized interface to discover and download curated publicly available single-cell ATAC-seq datasets as SingleCellExperiment objects. Use when user asks to search for chromatin accessibility data by metadata, download scATAC-seq datasets by accession or tissue, or export data to Matrix Market format for external analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/scATAC.Explorer.html
---

# bioconductor-scatac.explorer

## Overview

`scATAC.Explorer` is a curated repository of publicly available scATAC-seq datasets. It provides a standardized interface to discover and download chromatin accessibility data across various organisms, tissues, and diseases. Data is returned as `SingleCellExperiment` objects, making it compatible with standard Bioconductor analysis workflows (e.g., ArchR, Signac, or Cicada).

## Core Workflow

### 1. Exploring Metadata
Before downloading large datasets, use `queryATAC` with `metadata_only = TRUE` to browse available studies.

```r
library(scATAC.Explorer)

# Get all available metadata
meta <- queryATAC(metadata_only = TRUE)[[1]]

# Search for specific criteria (e.g., Leukemia datasets)
leukemia_meta <- queryATAC(disease = "leukemia", metadata_only = TRUE)[[1]]
```

### 2. Search Parameters
The `queryATAC` function supports several filters:
- `accession`: GEO/ID (e.g., "GSE129785")
- `has_cell_types`: Logical (TRUE/FALSE)
- `organism`: e.g., "Mus musculus", "Homo sapiens"
- `genome_build`: e.g., "hg19", "mm10"
- `year`: Supports ranges ("2015-2018") or comparisons ("<2015", ">2018")
- `tissue_cell_type`: e.g., "PBMC", "glia"

### 3. Downloading Datasets
Datasets are returned as a list of `SingleCellExperiment` objects.

```r
# Download a specific dataset by accession
res <- queryATAC(accession = "GSE89362")
sce <- res[[1]]

# Access counts (chromatin accessibility)
atac_counts <- counts(sce)

# Access cell metadata (clusters/cell types if available)
cell_info <- colData(sce)

# Access study-level metadata
study_meta <- metadata(sce)
```

### 4. Exporting Data
To use the data outside of R (e.g., in Python or command-line tools), use `saveATAC`. This exports the data into Matrix Market format.

```r
# Save to a new directory
saveATAC(sce, "path/to/output_folder")
```

## Usage Tips
- **Memory Management**: Downloading multiple datasets (e.g., `has_cell_type = TRUE` without other filters) can exceed 16GB of RAM. Always filter your queries or check metadata size first.
- **List Indexing**: `queryATAC` always returns a list, even for a single result. Use `[[1]]` to extract the object.
- **Sparse Matrices**: Use the `sparse = TRUE` argument in `queryATAC` to minimize memory footprint for large count matrices.

## Reference documentation
- [scATAC.Explorer](./references/scATAC.Explorer.md)