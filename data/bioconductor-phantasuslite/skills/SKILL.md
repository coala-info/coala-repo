---
name: bioconductor-phantasuslite
description: phantasusLite facilitates loading precomputed RNA-seq counts from remote repositories and managing gene expression data formats. Use when user asks to load counts for GEO datasets from ARCHS4 or DEE2, infer sample conditions from metadata, or read and write GCT files.
homepage: https://bioconductor.org/packages/release/bioc/html/phantasusLite.html
---

# bioconductor-phantasuslite

name: bioconductor-phantasuslite
description: Facilitates working with public gene expression datasets by providing interfaces to precomputed RNA-seq counts (ARCHS4/DEE2), inferring sample groups from metadata, and handling GCT file formats. Use this skill when you need to load gene expression matrices for GEO datasets that lack them, or when preparing data for Phantasus/Morpheus analysis.

## Overview
`phantasusLite` is a lightweight R package designed to bridge the gap between GEO metadata and precomputed expression counts. It specifically targets datasets where the `ExpressionSet` from GEO is missing the actual count matrix. It provides tools to fetch counts from remote HSDS repositories (ARCHS4 and DEE2 projects), automatically infer experimental conditions from sample titles, and export/import data in the GCT format.

## Core Workflows

### 1. Loading Precomputed Counts
When working with GEO datasets (e.g., via `GEOquery`), the expression matrix is often empty. Use `phantasusLite` to populate it from remote HDF5 stores.

```r
library(GEOquery)
library(phantasusLite)

# 1. Load metadata from GEO
gse <- getGEO("GSE53053")[[1]]

# 2. Define the HSDS repository URL
url <- 'https://alserglab.wustl.edu/hsds/?domain=/counts'

# 3. Automatically load the best matching counts (prioritizes ARCHS4)
gse <- loadCountsFromHSDS(gse, url)

# 4. Alternatively, load from a specific file
# Use getHSDSFileList(url) to see available files
file_path <- "dee2/mmusculus_star_matrix_20240409.h5"
gse_dee2 <- loadCountsFromH5FileHSDS(gse, url, file_path)
```

### 2. Inferring Sample Conditions
If the metadata lacks a clear "condition" column but has descriptive sample titles, use `inferCondition` to parse them into `condition` and `replicate` columns.

```r
# Example titles: "Ctrl_1", "Ctrl_2", "Treatment_1"
gse <- inferCondition(gse)

# Access the new phenoData columns
pData(gse)$condition
pData(gse)$replicate
```

### 3. GCT File Operations
GCT files are standard for sharing annotated matrices.

```r
# Save an ExpressionSet to GCT
writeGct(gse, "output_data.gct")

# Load a GCT file back into R as an ExpressionSet
eset <- readGct("output_data.gct")
```

## Tips and Best Practices
- **Priority**: `loadCountsFromHSDS` automatically selects the file with the most quantified samples for your dataset. If multiple sources (ARCHS4 vs DEE2) have the same count, ARCHS4 is preferred by default.
- **Feature Data**: When loading counts from ARCHS4 via this package, gene symbols and ENSEMBL IDs are automatically added to the `fData` of the `ExpressionSet`.
- **Dependencies**: This package is a "lite" version of `phantasus`, meaning it has fewer dependencies and is better suited for programmatic data preparation scripts.

## Reference documentation
- [phantasusLite tutorial (Rmd)](./references/phantasusLite-tutorial.Rmd)
- [phantasusLite tutorial (md)](./references/phantasusLite-tutorial.md)