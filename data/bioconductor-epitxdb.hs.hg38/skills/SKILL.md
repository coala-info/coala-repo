---
name: bioconductor-epitxdb.hs.hg38
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EpiTxDb.Hs.hg38.html
---

# bioconductor-epitxdb.hs.hg38

## Overview

The `EpiTxDb.Hs.hg38` package is an annotation hub for RNA modification data mapped to the human genome assembly hg38. It provides structured `EpiTxDb` objects containing modifications for tRNAs, snoRNAs, and other transcripts. It also includes specialized chain files to handle the complex coordinate mapping of ribosomal RNA (rRNA) across different genome versions.

## Core Workflows

### Loading Modification Databases

The package provides three primary constructor functions to access different data sources. Each returns an `EpiTxDb` object.

```r
library(EpiTxDb.Hs.hg38)

# Load tRNA modifications from tRNAdb
etdb_trna <- EpiTxDb.Hs.hg38.tRNAdb()

# Load snoRNA modifications from snoRNAdb
etdb_sno <- EpiTxDb.Hs.hg38.snoRNAdb()

# Load general RNA modifications from RMBase v2.0
etdb_rmbase <- EpiTxDb.Hs.hg38.RMBase()
```

### Extracting Modification Data

Once a database object is loaded, use the standard `EpiTxDb` interface (from the `EpiTxDb` package) to extract information. The most common method is `modifications()`, which returns a `GRanges` object.

```r
library(EpiTxDb)

# Get all modifications
mods <- modifications(etdb_trna)

# Inspect metadata (mod_id, mod_type, mod_name)
head(mcols(mods))
```

### rRNA Coordinate Liftover

Because rRNA annotations are frequently updated, data often exists in hg19 coordinates. This package provides specific chain files for `liftOver` to move between hg19 and hg38 for 5.8S, 18S, and 28S rRNA.

```r
library(rtracklayer)

# Load the chain file for hg19 to hg38
cf <- chain.rRNA.hg19Tohg38()

# Perform liftover on a GRanges object (e.g., 'mod_hg19')
# mod_hg19 should have seqnames like "18S", "28S", or "5.8S"
mod_hg38 <- unlist(liftOver(mod_hg19, cf))
```

### Integrating with Modstrings

You can combine the retrieved modification coordinates with sequence data to create `ModRNAStringSet` objects for sequence analysis.

```r
library(Modstrings)

# Example: Update a sequence with new modification information
# 'rna' is a DNAStringSet/RNAStringSet of the target sequences
# 'mod_new' is the GRanges object containing modification positions
seq_modified <- combineIntoModstrings(rna, mod_new)
```

## Usage Tips

- **Coordinate Systems**: Note that `EpiTxDb` objects often store coordinates "per Transcript". Always check the `Coordinates` field when printing the `etdb` object to ensure your analysis matches the expected reference frame.
- **Caching**: The package uses `AnnotationHub` and `BiocFileCache`. The first call to a constructor will download the data; subsequent calls will load from the local cache.
- **Sequence Names**: When using rRNA chain files, ensure your `seqnames` match the names in the chain object (typically "5.8S", "18S", "28S").

## Reference documentation

- [EpiTxDb.Hs.hg38: Annotation package for EpiTxDb objects](./references/EpiTxDb.Hs.hg38.md)