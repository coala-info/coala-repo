---
name: bioconductor-scrnaseq
description: This tool provides access to curated single-cell RNA-seq datasets as standardized SingleCellExperiment objects in R. Use when user asks to search for single-cell studies, download public scRNA-seq data, or contribute new datasets to the Bioconductor collection.
homepage: https://bioconductor.org/packages/release/data/experiment/html/scRNAseq.html
---

# bioconductor-scrnaseq

name: bioconductor-scrnaseq
description: Access and download publicly available single-cell RNA-seq datasets as SingleCellExperiment objects. Use when needing to discover, retrieve, or contribute curated scRNA-seq data for analysis in R.

## Overview

The bioconductor-scrnaseq skill provides access to a collection of curated single-cell RNA-seq datasets. It allows users to search for studies based on metadata (species, tissue, cell count) and download them directly into R as standardized SingleCellExperiment objects. This eliminates the need for manual data cleaning and formatting, enabling immediate downstream analysis.

## Finding and Searching Datasets

Use these functions to discover available data:

- List all datasets: Call `surveyDatasets()` to return a DataFrame of all available studies and their metadata.
- Simple search: Use `searchDatasets("keyword")` to find datasets containing specific terms in their title or description (e.g., "pancreas").
- Complex search: Combine `defineTextQuery()` with boolean operators for precise filtering.
    - Example: `searchDatasets(defineTextQuery("GRCm38", field="genome") & defineTextQuery("brain", partial=TRUE))`

## Loading Datasets

Retrieve data using the `fetchDataset()` function:

- Basic retrieval: Provide the dataset name and version string.
    - Example: `sce <- fetchDataset("zeisel-brain-2015", "2023-12-14")`
- Handle sub-datasets: For studies with multiple components (e.g., different species or tissues), use the `path` argument.
    - Example: `sce <- fetchDataset("baron-pancreas-2016", "2023-12-14", path="human")`
- Memory management: By default, assays are loaded as file-backed `DelayedArray` objects. Set `realize.assays = TRUE` to load data into memory as a sparse `dgCMatrix` or ordinary array.
    - Example: `sce <- fetchDataset(..., realize.assays = TRUE)`
- Metadata access: Use `fetchMetadata("name", "version")` to retrieve the full metadata list without downloading the actual expression data.

## Contributing New Datasets

Follow this workflow to add a dataset to the collection:

1. Format data: Ensure the dataset is a `SingleCellExperiment` or `SummarizedExperiment` object.
2. Prepare metadata: Create a list following the Bioconductor metadata schema (including title, description, taxonomy_id, genome, and maintainer details).
3. Stage the data: Use `saveDataset(sce, "path/to/staging", metadata)` to save the object in a language-agnostic format.
4. Validate: Reload the data using `alabaster.base::readObject("path/to/staging")` to ensure it was saved correctly.
5. Upload: After obtaining permissions via a GitHub Pull Request to the scRNAseq repository, use `gypsum::uploadDirectory("path/to/staging", "scRNAseq", "dataset-name", "version")`.

## Reference documentation

- [scRNAseq](./references/scRNAseq.md)