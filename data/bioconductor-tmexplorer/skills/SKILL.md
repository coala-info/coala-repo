---
name: bioconductor-tmexplorer
description: "TMExplorer provides a curated collection of single-cell RNA sequencing datasets specifically focused on the tumour microenvironment. Use when user asks to search for tumour microenvironment datasets, download scRNAseq data by cancer type or GEO accession, or export single-cell data to CSV files."
homepage: https://bioconductor.org/packages/release/data/experiment/html/TMExplorer.html
---


# bioconductor-tmexplorer

## Overview
TMExplorer (Tumour Microenvironment Explorer) is a Bioconductor package providing a curated collection of scRNAseq datasets specifically focused on tumours. It simplifies the process of finding and importing high-quality TME data into R for downstream analysis, algorithm validation, or meta-analysis. All datasets are returned as `SingleCellExperiment` objects, ensuring compatibility with standard Bioconductor workflows.

## Core Workflow

### 1. Exploring Metadata
Before downloading large datasets, use `queryTME` with `metadata_only = TRUE` to browse available studies.

```r
library(TMExplorer)

# View all available datasets
all_metadata <- queryTME(metadata_only = TRUE)[[1]]

# Search for specific tumour types (e.g., Breast cancer)
breast_meta <- queryTME(tumour_type = 'Breast cancer', metadata_only = TRUE)[[1]]
```

### 2. Searching with Parameters
The `queryTME` function supports several filters to narrow down datasets:

| Parameter | Description | Examples |
|-----------|-------------|----------|
| `geo_accession` | GEO ID | "GSE72056" |
| `tumour_type` | Cancer type | "Melanoma", "Breast cancer" |
| `has_truth` | Has cell-type labels | TRUE, FALSE |
| `has_signatures` | Has gene signatures | TRUE, FALSE |
| `organism` | Source species | "Human", "Mice" |
| `year` | Publication year | "<2015", "2013-2015", ">2018" |

### 3. Downloading Datasets
To retrieve the actual data, call `queryTME` without the metadata flag. Note that the function always returns a **list** of objects.

```r
# Download a specific dataset by GEO ID
res <- queryTME(geo_accession = "GSE81861")
sce <- res[[1]] # Extract the SingleCellExperiment object
```

### 4. Accessing Data and Metadata
Once you have the `SingleCellExperiment` object:

*   **Expression Data:** Use `counts(sce)` or `assay(sce)`.
*   **Cell Labels:** If `has_truth = TRUE`, labels are in `colData(sce)`.
*   **Signatures:** If `has_signatures = TRUE`, gene sets are in `metadata(sce)$signatures`.
*   **Study Info:** Access PMID, technology, and author via `metadata(sce)`.

```r
# View cell type labels
head(colData(sce))

# Access gene signatures for cell types
sigs <- metadata(sce)$signatures
```

### 5. Exporting Data
To use the data outside of R, `saveTME` exports the expression, metadata, and cell labels as CSV files.

```r
# Save to a new directory
saveTME(sce, 'path/to/output_folder')
```

## Tips and Best Practices
*   **List Return Type:** `queryTME` always returns a list. Even if searching for a single GEO ID, you must index the result (e.g., `[[1]]`) to get the `SingleCellExperiment` object.
*   **Sparse Matrices:** If memory is a concern, use `sparse = TRUE` in `queryTME` to return expression data as sparse matrices.
*   **Year Filtering:** Use strings like `"2015>"` (before or in 2015) or `"2015<"` (in or after 2015) for flexible temporal searches.

## Reference documentation
- [TMExplorer Vignette (Rmd)](./references/TMExplorer.Rmd)
- [TMExplorer Documentation (MD)](./references/TMExplorer.md)