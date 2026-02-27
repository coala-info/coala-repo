---
name: bioconductor-txdb.hsapiens.ucsc.hg38.knowngene
description: This tool provides a transcript database for the human hg38 genome build based on UCSC knownGene annotations. Use when user asks to retrieve genomic coordinates for human transcripts, exons, or genes, group genomic features by gene or transcript, or perform range-based analyses using Bioconductor.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Hsapiens.UCSC.hg38.knownGene.html
---


# bioconductor-txdb.hsapiens.ucsc.hg38.knowngene

name: bioconductor-txdb.hsapiens.ucsc.hg38.knowngene
description: Provides the TxDb annotation object for Homo sapiens (human) based on the UCSC hg38 genome build and the knownGene track. Use this skill when you need to retrieve genomic coordinates for transcripts, exons, CDS, and genes, or when performing genomic overlaps and range-based analyses in R using Bioconductor.

# bioconductor-txdb.hsapiens.ucsc.hg38.knowngene

## Overview
This skill facilitates the use of the `TxDb.Hsapiens.UCSC.hg38.knownGene` R package. This package is a "Transcript Database" (TxDb) object, which serves as a curated SQLite-backed annotation resource. It provides a standardized interface to human genome annotations (hg38/GRCh38), specifically focusing on gene models defined by the UCSC "knownGene" track. It is primarily used in conjunction with the `GenomicFeatures` and `GenomicRanges` packages.

## Core Workflows

### Loading the Annotation
To use the database, you must load the library. The object itself shares the name of the package.

```r
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
```

### Extracting Genomic Features
Use standard `GenomicFeatures` accessor functions to extract GRanges objects:

*   **Transcripts:** `transcripts(txdb)`
*   **Exons:** `exons(txdb)`
*   **Coding Sequences:** `cds(txdb)`
*   **Genes:** `genes(txdb)`
*   **Promoters:** `promoters(txdb, upstream=2000, downstream=400)`

### Grouping Features
To understand the relationship between features (e.g., which exons belong to which transcript), use the `By` family of functions:

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Filtering and Selecting
You can use the `select`, `keys`, and `columns` methods to query specific metadata:

```r
# List available columns
columns(txdb)

# List available key types (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific info for a set of Entrez IDs
select(txdb, keys = c("1", "2"), columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips for Usage
*   **Genome Build:** Ensure your experimental data (e.g., BAM files or peak calls) is aligned to **hg38**. Using this with hg19 data will result in incorrect coordinates.
*   **Identifier Type:** The `GENEID` in this specific TxDb object refers to **Entrez Gene IDs**. If you have Ensembl IDs or Gene Symbols, you may need an `org.Hs.eg.db` object to map them first.
*   **Coordinate System:** UCSC uses 1-based inclusive coordinates within the Bioconductor framework (standard `GRanges` behavior).

## Reference documentation
- [TxDb.Hsapiens.UCSC.hg38.knownGene Reference Manual](./references/reference_manual.md)