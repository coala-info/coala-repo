---
name: bioconductor-gwascatdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/gwascatData.html
---

# bioconductor-gwascatdata

## Overview

The `gwascatData` package provides a specific, static snapshot of the EBI/EMBL GWAS catalog (dated March 30, 2021) as an `AnnotationHub` resource. This is primarily used for reproducible research or analyses requiring this specific historical version of the catalog. While the data is provided as a character-based table, it is designed to be used in conjunction with the `gwascat` package for transformation into genomic ranges (`GRanges`).

## Loading and Accessing Data

The data is not loaded via a standard `data()` call but is instead retrieved through the `AnnotationHub` interface.

### Basic Workflow

1.  **Initialize AnnotationHub**: Create a hub instance to browse available resources.
2.  **Query for gwascatData**: Search the hub for the specific package resource.
3.  **Retrieve the Record**: Use the unique identifier (e.g., "AH91571") to download the data.

```r
library(AnnotationHub)
library(gwascatData)

# Initialize the hub
ahub <- AnnotationHub()

# Query for the gwascatData resource
mymeta <- query(ahub, "gwascatData")
print(mymeta)

# Extract the specific tag/ID
tag <- names(mymeta)[1]

# Retrieve the actual data (this may trigger a download)
gwas_data <- ahub[[tag]]

# Inspect the first few columns and rows
head(gwas_data[, 1:6])
```

## Data Structure

The retrieved object is typically a data frame or character matrix containing standard GWAS catalog fields:
*   `DATE ADDED TO CATALOG`
*   `PUBMEDID`
*   `FIRST AUTHOR`
*   `DATE` (Publication date)
*   `JOURNAL`
*   `LINK`

## Integration with gwascat

To perform genomic overlaps or range-based filtering, you should use the `gwascat` package to convert this raw data into a `GRanges` object.

```r
# Assuming gwascat is installed
# library(gwascat)
# gwas_gr <- makeCurrentGwasCat(gwas_data) # Conceptual workflow
```

## Tips

*   **Caching**: `AnnotationHub` caches data locally. Subsequent calls to `ahub[[tag]]` will be much faster as they won't require a re-download.
*   **Genome Build**: This specific snapshot is mapped to the **GRCh38** genome build. Ensure your other genomic data (e.g., BAM files or other GRanges) are using the same coordinate system.
*   **Snapshot Date**: This package represents a fixed point in time (March 2021). For the most up-to-date GWAS catalog data, use the `gwascat` package's live retrieval functions instead.

## Reference documentation

- [gwascatData -- a snapshot of the EBI/EMBL GWAS catalog](./references/gwascatData.Rmd)
- [gwascatData -- a snapshot of the EBI/EMBL GWAS catalog (Markdown)](./references/gwascatData.md)