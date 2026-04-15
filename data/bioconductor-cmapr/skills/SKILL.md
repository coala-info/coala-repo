---
name: bioconductor-cmapr
description: The cmapR package provides tools for interacting with Connectivity Map data by parsing, manipulating, and writing GCT and GCTX files. Use when user asks to parse GCTX files, subset large genomic datasets, annotate data matrices with metadata, or convert GCT objects to long-form data tables.
homepage: https://bioconductor.org/packages/release/bioc/html/cmapR.html
---

# bioconductor-cmapr

## Overview
The `cmapR` package is the core Bioconductor tool for interacting with data from the Connectivity Map (CMap) project. It centers around the `GCT` class, which encapsulates a data matrix alongside row and column metadata. Its primary strength is the ability to handle `.gctx` files—an HDF5-based format that allows for efficient, random-access reading of massive datasets.

## Core Workflows

### 1. Parsing Data
Use `parse_gctx` for both `.gct` (text) and `.gctx` (binary) files.

```r
library(cmapR)

# Parse an entire file
ds <- parse_gctx("path/to/file.gctx")

# Parse a subset (GCTX only) by numeric index
ds_sub <- parse_gctx("path/to/file.gctx", rid = 1:100, cid = 1:10)

# Parse a subset by character IDs
ds_ids <- parse_gctx("path/to/file.gctx", rid = c("gene1", "gene2"), cid = c("sample1"))
```

### 2. Accessing GCT Components
The `GCT` object uses slots, but accessor functions are preferred:
- `mat(ds)`: Access the data matrix.
- `meta(ds, dimension = "row")`: Access row annotations (rdesc).
- `meta(ds, dimension = "column")`: Access column annotations (cdesc).
- `ids(ds, dimension = "row")`: Access row IDs (rid).
- `ids(ds, dimension = "column")`: Access column IDs (cid).

### 3. Metadata Operations
If you have a matrix and separate metadata, use `annotate_gct` to combine them.

```r
# Read metadata only to find indices
col_meta <- read_gctx_meta("path/to/file.gctx", dim = "col")
target_idx <- which(col_meta$pert_iname == "vemurafenib")

# Annotate an existing GCT object
ds_annotated <- annotate_gct(ds, col_meta, dim = "col", keyfield = "id")
```

### 4. Manipulation and Math
- **Subsetting**: `subset_gct(ds, rid = ..., cid = ...)` extracts a portion of a GCT object in memory.
- **Transposing**: `transpose_gct(ds)` swaps rows and columns, including their respective metadata.
- **Ranking**: `rank_gct(ds, dim = "col")` converts matrix values to ranks along the specified dimension.
- **Melting**: `melt_gct(ds)` converts the GCT object into a long-form `data.table`, ideal for `ggplot2`.

### 5. Writing Data
```r
# Write to standard text format
write_gct(ds, "output_file")

# Write to binary HDF5 format (recommended for large data)
write_gctx(ds, "output_file", compression_level = 9)
```

## Tips for Large Datasets
- **Memory Management**: Use `read_gctx_meta` first to inspect the metadata and identify specific `rid` or `cid` values. Then, use `parse_gctx` with those IDs to load only the necessary slice.
- **SummarizedExperiment**: For integration with other Bioconductor workflows, convert the GCT object using `as(ds, "SummarizedExperiment")`.

## Reference documentation
- [cmapR Tutorial](./references/tutorial.md)
- [cmapR Tutorial Source](./references/tutorial.Rmd)