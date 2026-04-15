---
name: bioconductor-txdb.hsapiens.ucsc.hg18.knowngene
description: This package provides UCSC hg18 human genome annotations as a TxDb object for genomic range operations. Use when user asks to retrieve genomic coordinates for transcripts, exons, or genes, group features by gene or transcript, or query hg18 metadata using the Bioconductor framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Hsapiens.UCSC.hg18.knownGene.html
---

# bioconductor-txdb.hsapiens.ucsc.hg18.knowngene

name: bioconductor-txdb.hsapiens.ucsc.hg18.knowngene
description: Access and query the UCSC hg18 (NCBI Build 36.1) Homo sapiens genome annotations. Use this skill when an AI agent needs to retrieve genomic coordinates for transcripts, exons, coding sequences (CDS), and genes based on the hg18 assembly using the Bioconductor TxDb framework.

# bioconductor-txdb.hsapiens.ucsc.hg18.knowngene

## Overview
This skill provides guidance on using the `TxDb.Hsapiens.UCSC.hg18.knownGene` R package. This is an annotation data package that exposes a `TxDb` object containing the UCSC "Known Gene" track for the human genome assembly hg18. It is primarily used for genomic range operations, such as finding the locations of genes or transcripts, and is compatible with the `GenomicFeatures` and `GenomicRanges` ecosystems.

## Basic Usage

### Loading the Package and Object
The package automatically creates a `TxDb` object named `TxDb.Hsapiens.UCSC.hg18.knownGene` upon loading.

```r
library(TxDb.Hsapiens.UCSC.hg18.knownGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Hsapiens.UCSC.hg18.knownGene
txdb
```

### Inspecting Metadata
To verify the genome build and data source:
```r
metadata(txdb)
genome(txdb)
seqlevels(txdb)
```

## Common Workflows

### Extracting Genomic Features
Use functions from the `GenomicFeatures` package to extract specific features as `GRanges` or `GRangesList` objects.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons_list <- exons(txdb)

# Get all coding sequences
cds_list <- cds(txdb)

# Get all genes (returns GRanges with Entrez IDs)
genes_list <- genes(txdb)
```

### Grouping Features
To understand the relationship between features (e.g., which exons belong to which gene):

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Filtering and Selecting
You can use the `select`, `keys`, and `columns` interface common to Bioconductor annotation packages.

```r
# List available columns
columns(txdb)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific transcript names for a set of Entrez Gene IDs
keys_vec <- c("1", "10") # Example Entrez IDs
select(txdb, keys = keys_vec, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips
- **Genome Build**: Ensure your coordinates are in **hg18**. If your data is in hg19 or hg38, you must use the corresponding TxDb package or perform a liftover.
- **Identifier Types**: This package uses Entrez Gene IDs as the primary gene identifier.
- **Coordinate System**: Like all TxDb objects, coordinates are 1-based and inclusive.

## Reference documentation
- [TxDb.Hsapiens.UCSC.hg18.knownGene Reference Manual](./references/reference_manual.md)