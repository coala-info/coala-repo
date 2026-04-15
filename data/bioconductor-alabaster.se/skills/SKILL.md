---
name: bioconductor-alabaster.se
description: This package serializes and restores SummarizedExperiment and RangedSummarizedExperiment objects for structured file-based storage. Use when user asks to save SummarizedExperiment objects to disk, load serialized experiments from a directory, or preserve genomic metadata and assays in a portable format.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.se.html
---

# bioconductor-alabaster.se

## Overview

The `alabaster.se` package is a specialized component of the **alabaster** framework designed for the serialization of `SummarizedExperiment` (SE) and `RangedSummarizedExperiment` (RSE) objects. It ensures that all components of these complex data structures—including assays (matrices), row metadata, column metadata, and genomic ranges—are preserved in a structured, file-based format (typically using HDF5 and JSON). This allows for robust data storage and cross-language compatibility.

## Core Workflow

### Saving Objects

To save a `SummarizedExperiment` or `RangedSummarizedExperiment` to disk, use the `saveObject()` function. This creates a directory containing the serialized components.

```r
library(alabaster.se)
library(SummarizedExperiment)

# Assuming 'se' is your SummarizedExperiment object
output_dir <- "path/to/save_directory"
saveObject(se, output_dir)
```

The resulting directory will contain:
- `OBJECT`: A file identifying the object type.
- `assays/`: Serialized matrix data (often in HDF5).
- `column_data/`: Metadata for samples.
- `row_data/`: Metadata for features.
- `row_ranges/`: (For RSE) Genomic coordinates and sequence information.

### Loading Objects

To restore an object from a previously saved directory, use `readObject()`. The function automatically detects that the directory contains a `SummarizedExperiment` and reconstructs the appropriate R object.

```r
library(alabaster.se)

input_dir <- "path/to/save_directory"
restored_se <- readObject(input_dir)

# The restored object is a fully functional SummarizedExperiment
assay(restored_se)
colData(restored_se)
```

## Usage Tips

- **Framework Integration**: `alabaster.se` relies on `alabaster.base` for core dispatch logic and `alabaster.matrix` for handling the underlying assay data.
- **Portability**: The saved artifacts are designed to be portable. You can move the directory to different systems, and as long as the `alabaster` suite is available, the object can be reconstructed.
- **Ranged vs. Non-Ranged**: The package handles both `SummarizedExperiment` and `RangedSummarizedExperiment` seamlessly. If the input has `rowRanges`, they are automatically serialized and restored.
- **Temporary Storage**: When testing workflows, use `tempfile()` to create transient staging directories for `saveObject()`.

## Reference documentation

- [Saving SummarizedExperiments to artifacts and back again](./references/userguide.md)