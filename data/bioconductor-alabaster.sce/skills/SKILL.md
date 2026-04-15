---
name: bioconductor-alabaster.sce
description: This tool saves and loads SingleCellExperiment objects to and from file artifacts using the alabaster framework. Use when user asks to save SingleCellExperiment objects to disk, load SCE artifacts into an R session, or persist single-cell data in a language-agnostic format.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.sce.html
---

# bioconductor-alabaster.sce

name: bioconductor-alabaster.sce
description: Save and load SingleCellExperiment (SCE) objects to and from file artifacts using the alabaster framework. Use this skill when you need to persist SCE objects (including assays, colData, rowData, reducedDims, and altExps) to disk in a language-agnostic format or reload them into an R session.

# bioconductor-alabaster.sce

## Overview

The `alabaster.sce` package is part of the **alabaster** framework, designed to provide a robust, file-based representation of Bioconductor objects. It specifically handles the `SingleCellExperiment` class, ensuring that all components—such as reduced dimensions (PCA, t-SNE) and alternative experiments (e.g., antibody-derived tags or CRISPR data)—are correctly serialized and reconstructed.

## Core Workflow

### Saving a SingleCellExperiment

To save an SCE object, use the `saveObject()` function. This creates a directory containing the object's data and metadata.

```r
library(SingleCellExperiment)
library(alabaster.sce)

# Assuming 'sce' is your SingleCellExperiment object
destination <- "path/to/save_directory"
saveObject(sce, destination)
```

The resulting directory will contain:
- `OBJECT`: A file identifying the object type.
- `assays/`: HDF5 files containing the primary count matrices.
- `reduced_dimensions/`: Files containing PCA, UMAP, or t-SNE coordinates.
- `alternative_experiments/`: Nested directories for any `altExps`.
- `column_data/` and `row_data/`: Metadata for cells and features.

### Loading a SingleCellExperiment

To reload a saved object back into R, use the `readObject()` function.

```r
library(alabaster.sce)

# Load the object from the directory
sce_reloaded <- readObject("path/to/save_directory")
```

## Key Considerations

- **Framework Integration**: `alabaster.sce` builds upon `alabaster.se` (for SummarizedExperiments) and `alabaster.base`. It handles the specific slots of the `SingleCellExperiment` class that are not present in standard `SummarizedExperiment` objects.
- **Data Integrity**: The `readObject()` function automatically reconstructs the complex relationships within the SCE, such as links between the main experiment and alternative experiments.
- **Portability**: The underlying storage uses standard formats like HDF5 and JSON, making the saved artifacts accessible to other languages (like Python via `bioc---`) that implement the alabaster specification.

## Reference documentation

- [Saving SingleCellExperiments to artifacts and back again](./references/userguide.md)