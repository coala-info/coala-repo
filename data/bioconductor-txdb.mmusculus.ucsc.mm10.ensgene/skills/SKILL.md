---
name: bioconductor-txdb.mmusculus.ucsc.mm10.ensgene
description: This tool provides a TxDb annotation object for Mus musculus based on the UCSC mm10 genome build and Ensembl gene annotations. Use when user asks to retrieve genomic coordinates for mouse genes, extract transcripts or exons, or perform range-based analyses using the mm10 genome build.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmusculus.UCSC.mm10.ensGene.html
---


# bioconductor-txdb.mmusculus.ucsc.mm10.ensgene

name: bioconductor-txdb.mmusculus.ucsc.mm10.ensgene
description: Provides the TxDb annotation object for Mus musculus (mouse) based on the UCSC mm10 genome build and Ensembl gene annotations (ensGene). Use this skill when you need to retrieve genomic coordinates for mouse genes, transcripts, exons, or CDS regions, or when performing genomic overlaps and range-based analyses in R using Bioconductor.

# bioconductor-txdb.mmusculus.ucsc.mm10.ensgene

## Overview

This package provides a `TxDb` (Transcript Database) object containing the genomic locations of features for *Mus musculus*. It is based on the UCSC mm10 (GRCm38) genome assembly using the Ensembl gene track (`ensGene`). It is a primary resource for coordinate-based operations in mouse genomics, such as identifying gene boundaries, promoter regions, or mapping sequencing reads to known transcript structures.

## Key Workflows

### Loading the Database
To use the database, load the library and reference the object by its package name.

```r
library(TxDb.Mmusculus.UCSC.mm10.ensGene)
txdb <- TxDb.Mmusculus.UCSC.mm10.ensGene
```

### Inspecting the Object
Check the metadata to confirm the genome build, organism, and data source.

```r
txdb
metadata(txdb)
seqlevels(txdb) # List chromosomes/scaffolds
```

### Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract `GRanges` or `GRangesList` objects.

*   **Extract all genes:** `genes(txdb)`
*   **Extract all transcripts:** `transcripts(txdb)`
*   **Extract all exons:** `exons(txdb)`
*   **Extract CDS regions:** `cds(txdb)`
*   **Extract promoters:** `promoters(txdb, upstream=2000, downstream=400)`

### Grouping Features
To understand the relationship between features (e.g., which exons belong to which gene), use the `By` functions.

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
transcripts_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Filtering and Selecting
You can use the `select`, `keys`, and `columns` methods to retrieve specific information.

```r
# See available columns
columns(txdb)

# Retrieve specific transcript names for a set of Ensembl Gene IDs
keys <- c("ENSMUSG00000000001", "ENSMUSG00000000003")
select(txdb, keys = keys, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips
*   **Coordinate System:** This package uses UCSC chromosome naming conventions (e.g., "chr1", "chrX"). If your data uses Ensembl naming (e.g., "1", "X"), use `seqlevelsStyle(txdb) <- "Ensembl"` to convert them.
*   **Integration:** This object is designed to work seamlessly with the `GenomicRanges` and `GenomicFeatures` packages for overlaps and annotation.
*   **Ensembl IDs:** Since this is based on the `ensGene` track, the primary identifiers are Ensembl IDs.

## Reference documentation

- [TxDb.Mmusculus.UCSC.mm10.ensGene](./references/reference_manual.md)