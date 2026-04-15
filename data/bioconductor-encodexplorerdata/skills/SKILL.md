---
name: bioconductor-encodexplorerdata
description: This package provides a structured, offline compilation of ENCODE metadata for fast local searching and filtering of functional genomic elements. Use when user asks to access ENCODE metadata, filter for specific genomic experiments, or find file accessions for assays like ChIP-seq.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ENCODExplorerData.html
---

# bioconductor-encodexplorerdata

## Overview

The `ENCODExplorerData` package provides a comprehensive, offline compilation of metadata from the ENCODE (Encyclopedia of DNA Elements) Consortium. Instead of querying the ENCODE Portal API repeatedly, this package provides the metadata in a structured `data.table` format. It serves as the data backend for the `ENCODExplorer` package, allowing users to perform fast, local searches for functional genomic elements, regulatory elements, and protein/RNA level metadata.

## Typical Workflow

### 1. Loading the Metadata
The package provides pre-compiled metadata objects. Once the library is loaded, you can access the main metadata tables.

```r
library(ENCODExplorerData)

# Load the main metadata table
# Note: The specific object name usually corresponds to the version/date
# Common objects include 'encode_df' or specific versions like 'encode_df_lite'
data(encode_df)
```

### 2. Exploring the Data Structure
The metadata is stored as a `data.frame` or `data.table`. You can inspect the available columns to understand the filtering options (e.g., biosample, assay, target, organism, file format).

```r
# Check columns
colnames(encode_df)

# View unique assay types
unique(encode_df$assay)

# View unique organisms
unique(encode_df$organism)
```

### 3. Filtering for Specific Files
Use standard R filtering (or `dplyr`/`data.table` syntax) to find file accessions for a specific experiment.

```r
# Example: Find ChIP-seq files for the 'HCG' cell line in Human
human_chip_seq <- encode_df[
  encode_df$organism == "Homo sapiens" & 
  encode_df$assay == "ChIP-seq" & 
  encode_df$biosample_term_name == "K562", 
]

# View the file accessions
head(human_chip_seq$file_accession)
```

### 4. Integration with ENCODExplorer
While `ENCODExplorerData` provides the raw tables, the `ENCODExplorer` package is typically used to perform the actual searching and downloading.

```r
# Use the data from this package with ENCODExplorer functions
# library(ENCODExplorer)
# results <- queryEncode(df = encode_df, assay = "ChIP-seq", organism = "Homo sapiens")
```

## Tips and Best Practices
- **Memory Management**: The metadata tables can be quite large. If you are only interested in a subset (e.g., only "released" files or specific organisms), filter the object early in your script.
- **Updating Data**: The metadata is a snapshot. To generate a more recent version of the metadata tables, you can run the script located at `inst/scripts/make-data.R` within the package installation directory.
- **Accessions**: Always keep track of the `file_accession` and `experiment_accession` columns, as these are the primary keys used to download data from the ENCODE portal.

## Reference documentation
- [DataUpdate.Rmd](./references/DataUpdate.Rmd)
- [DataUpdate.md](./references/DataUpdate.md)