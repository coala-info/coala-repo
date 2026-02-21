---
name: bioconductor-arrayexpress
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ArrayExpress.html
---

# bioconductor-arrayexpress

name: bioconductor-arrayexpress
description: Access and import transcriptomics data from the ArrayExpress (BioStudies) database into R. Use this skill when you need to query experiments by keywords or species, download raw or processed MAGE-TAB files, and convert them into Bioconductor objects like AffyBatch, ExpressionSet, or NChannelSet for downstream analysis.

# bioconductor-arrayexpress

## Overview

The `ArrayExpress` package provides an interface to the ArrayExpress Archive, a major repository for functional genomics data. It automates the retrieval of MAGE-TAB files (IDF, SDRF, ADF, and data files) and converts them directly into standard Bioconductor data structures.

## Querying the Database

Use `queryAE` to search for datasets before downloading.

```r
library(ArrayExpress)

# Search by keywords and species (use '+' for spaces)
sets <- queryAE(keywords = "pneumonia", species = "homo+sapiens")

# The result is a dataframe containing Accession numbers, titles, and file counts
head(sets)
```

## Importing Data Directly

The `ArrayExpress()` function is the primary high-level tool. It downloads files to a local directory and builds an R object automatically.

```r
# Download and build object (e.g., AffyBatch for Affymetrix, ExpressionSet for others)
ae_obj <- ArrayExpress("E-MEXP-21")

# To keep the downloaded files locally
ae_obj <- ArrayExpress("E-MEXP-21", save = TRUE, path = "my_data_dir")
```

### Handling Custom Columns
If the scanner type is not recognized, you must specify the data columns manually using the `dataCols` argument.

- **One-color:** `dataCols = "ColumnName"`
- **Two-color:** `dataCols = list(R="RedSignal", G="GreenSignal", Rb="RedBack", Gb="GreenBack")`

## Manual Download and Conversion

If `ArrayExpress()` fails or if you need more control, use the multi-step approach.

### 1. Download Files
```r
# type can be "raw", "processed", or "full"
mexp_files <- getAE("E-MEXP-21", type = "full")
```

### 2. Build from Raw Local Files
```r
# Converts local MAGE-TAB files to Bioconductor objects
raw_set <- ae_2bioc(mageFiles = mexp_files)
```

### 3. Build from Processed Data
Processed data requires identifying the correct column first.
```r
# List available columns in processed files
cols <- getcolproc(mexp_files)

# Create ExpressionSet using a specific column
proc_set <- procset(mexp_files, procol = cols[2])
```

## Typical Workflow: From Import to Analysis

A standard pipeline involves importing, normalizing, and differential expression analysis.

```r
# 1. Import
raw_data <- ArrayExpress("E-MEXP-1416")

# 2. Normalize (example for Affymetrix using 'affy' package)
library(affy)
norm_data <- rma(raw_data)

# 3. Metadata Access
# Sample annotations are stored in phenoData
sample_info <- pData(norm_data)

# 4. Differential Expression (using 'limma')
library(limma)
# Define design based on Factor Values in sample_info
# ... standard limma workflow (lmFit, contrasts.fit, eBayes) ...
```

## Tips and Troubleshooting

- **Internet Connection:** An active connection is required for `queryAE`, `getAE`, and `ArrayExpress`.
- **Object Types:** 
    - Affymetrix data -> `AffyBatch`
    - One-color non-Affy -> `ExpressionSet`
    - Two-color -> `NChannelSet`
- **Metadata:** The `phenoData` slot is populated from the SDRF file, `featureData` from the ADF file, and `experimentData` from the IDF file.
- **Column Mismatch:** If you receive an error about unrecognized columns, use `getcolproc()` on a downloaded object to see valid column names for the `dataCols` or `procol` arguments.

## Reference documentation

- [Building R objects from ArrayExpress datasets](./references/ArrayExpress.md)