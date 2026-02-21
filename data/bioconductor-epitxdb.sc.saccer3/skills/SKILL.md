---
name: bioconductor-epitxdb.sc.saccer3
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EpiTxDb.Sc.sacCer3.html
---

# bioconductor-epitxdb.sc.saccer3

## Overview

`EpiTxDb.Sc.sacCer3` is a specialized Bioconductor annotation package that provides `EpiTxDb` objects containing RNA modification data for *Saccharomyces cerevisiae* (genome build sacCer3). It serves as a structured database for epitranscriptomic data, specifically aggregating information from RMBase v2.0 and tRNAdb.

## Loading and Accessing Data

The package provides two primary constructor functions to create `EpiTxDb` objects from different data sources.

### 1. Accessing tRNAdb Data
To load modifications specifically curated from the tRNAdb:

```r
library(EpiTxDb.Sc.sacCer3)
etdb_trna <- EpiTxDb.Sc.sacCer3.tRNAdb()
```

### 2. Accessing RMBase v2.0 Data
To load modifications from RMBase v2.0 (which includes various RNA types and modification classes):

```r
etdb_rmbase <- EpiTxDb.Sc.sacCer3.RMBase()
```

## Working with EpiTxDb Objects

Once the database object is loaded, use standard functions from the `EpiTxDb` and `GenomicRanges` packages to query the data.

### Extracting Modifications
The `modifications()` function returns a `GRanges` object containing the locations and types of modifications.

```r
# Get all modifications
mods <- modifications(etdb_trna)

# View metadata columns (mod_id, mod_type, mod_name)
mcols(mods)
```

### Common Workflows
*   **Filter by Type**: Subset the `GRanges` object to find specific modifications like Pseudouridine (Y) or Dihydrouridine (D).
*   **Coordinate Systems**: Note that these objects typically use "per Transcript" coordinates.
*   **Integration**: Use these ranges to intersect with your own sequencing data or to extract underlying sequences using `BSgenome.Scerevisiae.UCSC.sacCer3`.

## Tips
*   **Caching**: The first time you call the constructor functions, the data may be downloaded and cached via `AnnotationHub` or `BiocFileCache`. Subsequent calls will load from the local cache.
*   **EpiTxDb API**: For advanced queries (like filtering by specific transcripts or genomic features), refer to the general `EpiTxDb` package documentation, as `EpiTxDb.Sc.sacCer3` is a data provider for that class.

## Reference documentation

- [EpiTxDb.Sc.sacCer3](./references/EpiTxDb.Sc.sacCer3.md)