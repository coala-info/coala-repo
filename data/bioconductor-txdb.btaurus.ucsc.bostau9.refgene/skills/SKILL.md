---
name: bioconductor-txdb.btaurus.ucsc.bostau9.refgene
description: This package provides a TxDb object for the Bos taurus bosTau9 genome assembly based on UCSC refGene annotations. Use when user asks to retrieve genomic coordinates for cow transcripts, extract exons or coding sequences for the bosTau9 assembly, or perform range-based genomic analysis in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Btaurus.UCSC.bosTau9.refGene.html
---

# bioconductor-txdb.btaurus.ucsc.bostau9.refgene

name: bioconductor-txdb.btaurus.ucsc.bostau9.refgene
description: Annotation package for Bos taurus (Cow) genome assembly bosTau9. Provides a TxDb object based on UCSC refGene annotations. Use this skill when needing to retrieve genomic coordinates for transcripts, exons, CDS, and genes for B. taurus, or when performing genomic overlaps and range-based biology in R.

# bioconductor-txdb.btaurus.ucsc.bostau9.refgene

## Overview

This skill provides guidance on using the `TxDb.Btaurus.UCSC.bosTau9.refGene` Bioconductor package. This package contains a `TxDb` (Transcript Database) object which serves as an R interface to the UCSC refGene track for the `bosTau9` (April 2018) bovine genome assembly. It is primarily used for genomic annotation, transcript mapping, and extracting genomic features as `GRanges` objects.

## Basic Usage

### Loading the Package
To access the annotation database, load the library in R:

```r
library(TxDb.Btaurus.UCSC.bosTau9.refGene)
# The main object is named the same as the package
txdb <- TxDb.Btaurus.UCSC.bosTau9.refGene
```

### Inspecting the Database
View metadata and available chromosome information:

```r
txdb
seqinfo(txdb)
genes(txdb)
```

## Common Workflows

### Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract specific genomic elements:

*   **Transcripts:** `transcripts(txdb)`
*   **Exons:** `exons(txdb)`
*   **Coding Sequences:** `cds(txdb)`
*   **Promoters:** `promoters(txdb, upstream=2000, downstream=200)`

### Grouping Features
To understand the relationship between genes and their components, use the `By` family of functions:

```r
# Get all transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get all exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# Get all five prime UTRs grouped by transcript
five_utrs <- fiveUTRsByTranscript(txdb)
```

### Selecting Specific Data
Use `select()`, `keys()`, and `columns()` to query the database for specific identifiers:

```r
# List available columns
columns(txdb)

# Query specific gene IDs
keys <- c("100137871", "100137872")
select(txdb, keys = keys, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips for Success
*   **Coordinate System:** Ensure your experimental data (e.g., BAM or BED files) uses the `bosTau9` assembly coordinates to match this package.
*   **Seqlevels Style:** If your data uses "1" instead of "chr1", use `seqlevelsStyle(txdb) <- "NCBI"` to match styles.
*   **Integration:** This package is designed to work seamlessly with `GenomicRanges` and `Gviz` for visualization and overlap analysis.

## Reference documentation

- [TxDb.Btaurus.UCSC.bosTau9.refGene](./references/reference_manual.md)