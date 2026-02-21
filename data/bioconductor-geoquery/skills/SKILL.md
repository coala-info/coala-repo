---
name: bioconductor-geoquery
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GEOquery.html
---

# bioconductor-geoquery

name: bioconductor-geoquery
description: Access and parse data from the NCBI Gene Expression Omnibus (GEO). Use this skill when you need to: (1) Download and import GEO datasets (GDS), series (GSE), samples (GSM), or platforms (GPL) into R, (2) Convert GEO data into Bioconductor objects like ExpressionSet or SummarizedExperiment, (3) Retrieve pre-computed RNA-seq count matrices for human and mouse studies, or (4) Download supplemental files (e.g., CEL or BED files) associated with GEO records.

# bioconductor-geoquery

## Overview
GEOquery acts as a bridge between the NCBI Gene Expression Omnibus (GEO) and the Bioconductor ecosystem. It automates the process of downloading and parsing GEO data into standard R data structures, significantly reducing the manual effort required to format public genomic data for analysis.

## Core Workflow

### 1. Importing Data with getGEO
The primary function is `getGEO()`. It can download data directly from NCBI or parse local files.

```r
library(GEOquery)

# Download and parse a GEO Series (GSE)
# By default, returns a list of ExpressionSet objects
gse <- getGEO("GSE12345", GSEMatrix = TRUE)
eset <- gse[[1]]

# Download and parse a GEO Dataset (GDS)
gds <- getGEO("GDS505")

# Download and parse a GEO Sample (GSM) or Platform (GPL)
gsm <- getGEO("GSM1137")
gpl <- getGEO("GPL96")
```

### 2. Converting Data Structures
GEO Datasets (GDS) often need to be converted to Bioconductor-standard objects for downstream analysis (like `limma`).

```r
# Convert GDS to ExpressionSet
eset <- GDS2eSet(gds, do.log2 = TRUE)

# Convert GDS to limma MAList
ma <- GDS2MA(gds)
```

### 3. Working with RNA-seq Data
For human and mouse datasets, GEO provides pre-computed raw counts.

```r
# Check if RNA-seq quantifications are available
has_counts <- hasRNASeqQuantifications("GSE164073")

# Download RNA-seq data as a SummarizedExperiment
se <- getRNASeqData("GSE164073")

# Access counts and metadata
counts_matrix <- assay(se)
sample_metadata <- colData(se)
gene_metadata <- rowData(se)
```

### 4. Managing Supplemental Files
Use these functions when you need the raw data files (e.g., .CEL, .txt.gz) rather than the processed SOFT files.

```r
# Download all supplemental files for an accession
getGEOSuppFiles("GSE12345")

# List supplemental files without downloading
files_list <- getGEOSuppFiles("GSE12345", fetch_files = FALSE)

# Get specific file listing for a Series
file_info <- getGEOSeriesFileListing("GSE288770")
```

### 5. Searching GEO
You can search the GEO database directly from R.

```r
# Find possible search fields
fields <- searchFieldsGEO()

# Perform a search (returns a data.frame)
results <- searchGEO("diabetes[ALL] AND Homo sapiens[ORGN] AND GSE[ETYP]")
```

## Tips and Best Practices
- **Caching**: Use the `destdir` argument in `getGEO()` to save downloaded files locally. This prevents re-downloading large files in future sessions.
- **Memory Management**: For very large Series (GSE), set `GSEMatrix = TRUE` (default) for faster parsing. If you only need a subset of samples, use the `GSElimits` argument.
- **Annotation**: Set `AnnotGPL = TRUE` in `getGEO()` to use NCBI's up-to-date gene annotations (remapped to Entrez Gene) instead of the author-submitted platform information.
- **Browser Access**: Use `browseGEOAccession("GSE12345")` to quickly open the GEO web page for a specific record to inspect metadata manually.

## Reference documentation
- [GEOquery Reference Manual](./references/reference_manual.md)