---
name: bioconductor-epitxdb.mm.mm10
description: This package provides an EpiTxDb object containing RNA modification data for the mouse genome (mm10) sourced from RMBase v2.0 and tRNAdb. Use when user asks to load mouse RNA modification data, retrieve epitranscriptomic annotations as GRanges, or integrate tRNA and RMBase modifications into Bioconductor workflows.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EpiTxDb.Mm.mm10.html
---


# bioconductor-epitxdb.mm.mm10

## Overview

`EpiTxDb.Mm.mm10` is an annotation package that provides an `EpiTxDb` object containing RNA modification data for the mouse genome (mm10). It aggregates data from two primary sources: RMBase v2.0 and tRNAdb. This package allows researchers to integrate epitranscriptomic data with other Bioconductor genomic analysis workflows.

## Core Functions

The package provides two main constructor functions to create `EpiTxDb` objects based on the desired data source:

- `EpiTxDb.Mm.mm10.tRNAdb()`: Loads tRNA modification data from tRNAdb.
- `EpiTxDb.Mm.mm10.RMBase()`: Loads RNA modification data from RMBase v2.0.

## Typical Workflow

### 1. Loading the Database
To begin, load the library and initialize the database object. Note that these functions may download or access cached data via `AnnotationHub`.

```r
library(EpiTxDb.Mm.mm10)

# Load tRNA modifications
etdb_trna <- EpiTxDb.Mm.mm10.tRNAdb()

# Load RMBase modifications
etdb_rmbase <- EpiTxDb.Mm.mm10.RMBase()
```

### 2. Inspecting the Object
Printing the object provides metadata including the organism, genome build (mm10), data source, and the total number of modifications.

```r
etdb_trna
```

### 3. Extracting Modifications
Use the `modifications()` function from the `EpiTxDb` framework to retrieve the data as a `GRanges` object.

```r
mods <- modifications(etdb_trna)

# View the first few entries
head(mods)
```

The resulting `GRanges` object typically contains:
- `seqnames`: The transcript or chromosome identifier.
- `ranges`: The position of the modification.
- `mod_type`: The chemical abbreviation of the modification (e.g., "m2G", "m1A").
- `mod_name`: A unique identifier for the specific modification entry.

### 4. Filtering and Analysis
Since the output is a standard `GRanges` object, you can use `GenomicRanges` functions to filter by modification type or overlap with other genomic features.

```r
# Filter for a specific modification type
m1a_mods <- mods[mods$mod_type == "m1A"]

# Export to a data frame for external use
mods_df <- as.data.frame(mods)
```

## Usage Tips
- **Coordinate Systems**: Pay attention to the "Coordinates" field in the object metadata. tRNAdb data is often relative to the transcript, while other sources might use genomic coordinates.
- **Integration**: This package is designed to work seamlessly with the `EpiTxDb` and `Modstrings` packages. For advanced querying (e.g., by gene or by modification type), refer to the generic methods defined in the `EpiTxDb` package.
- **Genome Build**: Ensure your other genomic data (e.g., TxDb objects) is also based on the `mm10` (GRCm38) assembly to maintain compatibility.

## Reference documentation

- [EpiTxDb.Mm.mm10: Annotation package for EpiTxDb objects](./references/EpiTxDb.Mm.mm10.md)