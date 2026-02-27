---
name: bioconductor-curatedatlasqueryr
description: This tool queries and retrieves harmonized single-cell RNA-seq data from the curated CELLxGENE human cell atlas. Use when user asks to explore atlas metadata, filter cells by biological or technical criteria, and download data into SingleCellExperiment or Seurat objects.
homepage: https://bioconductor.org/packages/release/bioc/html/CuratedAtlasQueryR.html
---


# bioconductor-curatedatlasqueryr

name: bioconductor-curatedatlasqueryr
description: Query, filter, and retrieve harmonized single-cell RNA-seq data from the curated CELLxGENE human cell atlas. Use this skill to programmatically explore the atlas metadata, filter by biological or technical criteria (tissue, cell type, assay, ethnicity), and download data directly into SingleCellExperiment or Seurat objects for downstream analysis.

# bioconductor-curatedatlasqueryr

## Overview
`CuratedAtlasQueryR` provides a query interface for the harmonized and re-annotated CELLxGENE single-cell human cell atlas. It allows users to search through millions of cells using a remote metadata database and download only the specific subsets (cells, samples, or genes) required for their analysis. Data is retrieved from the ARDC Nectar Research Cloud, requiring an active internet connection.

## Core Workflow

1.  **Initialize Metadata**: Connect to the remote database to explore available datasets.
2.  **Filter**: Use `dplyr` syntax to narrow down the metadata to specific tissues, cell types, or conditions.
3.  **Retrieve**: Download the counts and associated metadata into R-native objects.

## Key Functions and Usage

### Loading Metadata
The metadata is a remote DuckDB-backed table. It does not load the entire atlas into memory, allowing for efficient searching.

```r
library(CuratedAtlasQueryR)
metadata <- get_metadata()

# Explore available tissues
metadata |> dplyr::distinct(tissue_harmonised)
```

### Filtering and Data Retrieval
Use standard `dplyr` pipes to filter the metadata. Once filtered, pass the object to retrieval functions.

**Retrieve SingleCellExperiment (SCE):**
```r
sce <- metadata |>
  dplyr::filter(tissue == "lung parenchyma" & cell_type_harmonised == "macrophage") |>
  get_single_cell_experiment(assays = "counts")
```

**Retrieve Seurat Object:**
Note: This converts HDF5 data to an in-memory Seurat object. This can be memory-intensive for large queries.
```r
seurat_obj <- metadata |>
  dplyr::filter(ethnicity == "African" & tissue == "liver") |>
  get_seurat()
```

**Subsetting Genes and Assays:**
To save time and bandwidth, request only specific genes or normalized counts (`cpm`).
```r
sce_subset <- metadata |>
  dplyr::filter(tissue == "blood") |>
  get_single_cell_experiment(assays = "cpm", features = c("CD3E", "CD4", "CD8A"))
```

### Handling Unharmonized Metadata
The main metadata table contains harmonized columns. To access dataset-specific columns (e.g., donor IDs, specific clinical variables), use:
```r
harmonised_meta <- metadata |> dplyr::filter(tissue == "kidney")
unharmonised_meta <- get_unharmonised_metadata(harmonised_meta)
```

## Data Storage and Portability

The retrieved `SingleCellExperiment` objects often point to a local HDF5 cache.

*   **Saving as RDS**: `saveRDS(sce, "file.rds")`. Fast and small, but **not portable**. It only stores links to your local cache.
*   **Saving as HDF5**: Use `HDF5Array::saveHDF5SummarizedExperiment()`. This creates a monolithic, **portable** file containing the actual data, but is slower to save and takes more disk space.

## Harmonized Metadata Columns
The package introduces several curated columns for better cross-dataset comparison:
*   `tissue_harmonised`: Coarser tissue names for easier filtering.
*   `cell_type_harmonised`: Consensus cell identity based on original annotations plus Azimuth and SingleR.
*   `confidence_class`: Ordinal scale (1-5) indicating the level of consensus for the harmonized cell type.
*   `age_days`: Standardized age representation.

## Reference documentation
- [Introduction](./references/Introduction.md)
- [Introduction.Rmd](./references/Introduction.Rmd)