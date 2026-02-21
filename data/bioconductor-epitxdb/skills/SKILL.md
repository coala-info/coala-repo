---
name: bioconductor-epitxdb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EpiTxDb.html
---

# bioconductor-epitxdb

name: bioconductor-epitxdb
description: Storing, accessing, and manipulating epitranscriptomic information (RNA modifications) using the AnnotationDbi interface. Use this skill when you need to create EpiTxDb objects, query RNA modification data (identity, position, enzymes, references), or shift modification coordinates between genomic and transcriptomic contexts.

# bioconductor-epitxdb

## Overview

The `EpiTxDb` package provides a specialized framework for managing epitranscriptomic data within the Bioconductor ecosystem. It uses an `AnnotationDb` backend to store information about RNA modifications, including their types (e.g., m6A, Am, Pseudouridine), genomic/transcriptomic positions, the enzymes responsible for the modifications (writers), and associated literature references.

## Core Workflows

### 1. Loading and Querying EpiTxDb Objects

Pre-built databases (like `EpiTxDb.Hs.hg38`) can be loaded to access known modification sites from resources like RMBase or snoRNAdb.

```r
library(EpiTxDb)
library(EpiTxDb.Hs.hg38)

# Load a specific database
etdb <- EpiTxDb.Hs.hg38.snoRNAdb()

# Standard AnnotationDbi queries
keytypes(etdb)
columns(etdb)
keys(etdb, "MODTYPE")

# Select specific data
res <- select(etdb, 
              keys = "Um", 
              columns = c("MODNAME", "MODSTART", "RXGENENAME"), 
              keytype = "MODTYPE")
```

### 2. Accessing Modifications as GRanges

The package provides specialized accessors that return `GRanges` or `GRangesList` objects, which are more suitable for genomic analysis than flat tables.

```r
# Get all modifications with specific metadata
mods <- modifications(etdb, columns = c("mod_type", "rx_genename"))

# Get modifications grouped by a specific attribute
mods_by_tx <- modificationsBy(etdb, by = "seqnames") # Group by transcript
mods_by_type <- modificationsBy(etdb, by = "modtype") # Group by modification type
```

### 3. Creating New EpiTxDb Objects

You can create custom databases from `GRanges` objects or external database imports.

```r
# From GRanges
gr <- GRanges(seqnames = "chr1", 
              ranges = IRanges(100, 100), 
              strand = "+",
              mod_id = 1L, mod_type = "m6A", mod_name = "m6A_1")
etdb_custom <- makeEpiTxDbFromGRanges(gr)

# From RMBase (requires internet connection)
etdb_rmbase <- makeEpiTxDbFromRMBase(organism = "yeast", 
                                     genome = "sacCer3", 
                                     modtype = "m1A")
```

### 4. Coordinate Shifting

A common task is converting genomic coordinates of modifications to transcript-relative coordinates (or vice versa), especially when dealing with multiple splice variants.

```r
library(GenomicFeatures)
# Assume 'tx' is a GRangesList of exons by transcript
# Shift genomic modification sites to transcriptomic space
mod_tx <- shiftGenomicToTranscript(mods, tx)

# Note: One genomic site may map to multiple transcriptomic positions 
# if the site overlaps multiple transcript isoforms.
```

## Tips and Best Practices

- **Metadata**: When creating a database, always provide a metadata data frame with `name` and `value` columns to ensure reproducibility.
- **Filtering**: Use the `filter` argument in `modifications()` to limit the data returned, which is more memory-efficient than filtering the resulting `GRanges` object.
- **Prefixes**: In `select()` and `columns()`, the `RX` prefix refers to the reaction enzyme (writer), and the `SPEC` prefix refers to the location specifier (e.g., a snoRNA guide).
- **Coordinate Systems**: Always verify if your input data is 1-based (standard R/Bioconductor) or 0-based (common in some bioinformatics formats) before creating an `EpiTxDb` object.

## Reference documentation

- [EpiTxDb: creating an EpiTxDb object](./references/EpiTxDb-creation.md)
- [EpiTxDb: Storing and accessing epitranscriptomic information using the AnnotationDbi interface](./references/EpiTxDb.md)