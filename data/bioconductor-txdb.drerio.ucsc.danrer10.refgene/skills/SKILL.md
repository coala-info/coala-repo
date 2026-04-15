---
name: bioconductor-txdb.drerio.ucsc.danrer10.refgene
description: This package provides a Bioconductor TxDb annotation object for the Danio rerio (Zebrafish) danRer10 genome assembly using the UCSC refGene track. Use when user asks to retrieve zebrafish gene coordinates, extract transcript structures, identify exons or introns, or map genomic ranges to RefSeq gene models.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Drerio.UCSC.danRer10.refGene.html
---

# bioconductor-txdb.drerio.ucsc.danrer10.refgene

name: bioconductor-txdb.drerio.ucsc.danrer10.refgene
description: Provides the TxDb annotation object for Danio rerio (Zebrafish) based on the UCSC danRer10 genome assembly and the refGene track. Use this skill when performing genomic analyses in R that require transcript-centric annotations for Zebrafish, such as identifying gene coordinates, transcript structures, exons, or introns.

# bioconductor-txdb.drerio.ucsc.danrer10.refgene

## Overview

The `TxDb.Drerio.UCSC.danRer10.refGene` package is a Bioconductor annotation resource containing the gene models for *Danio rerio* (Zebrafish). It provides a `TxDb` object which serves as a local interface to a prefabricated database derived from the UCSC danRer10 (GRCz10) genome build using the RefSeq (refGene) gene predictions.

This package is essential for workflows involving:
- Genomic localization of transcripts, exons, and CDS.
- Mapping sequencing reads to genomic features.
- Extracting promoter regions or flanking sequences.
- Overlapping genomic ranges (GRanges) with known gene structures.

## Basic Usage

### Loading the Annotation
To use the database, you must load the library and reference the object by its package name.

```r
library(TxDb.Drerio.UCSC.danRer10.refGene)

# Assign to a shorter alias for convenience
txdb <- TxDb.Drerio.UCSC.danRer10.refGene
txdb
```

### Inspecting the Database
You can check the supported chromosomes and the metadata of the build:

```r
seqlevels(txdb)
genome(txdb)
metadata(txdb)
```

## Common Workflows

### Extracting Genomic Features
The `GenomicFeatures` package provides the standard API for interacting with this TxDb object.

```r
library(GenomicFeatures)

# Get all transcripts
all_tx <- transcripts(txdb)

# Get all exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get all CDS grouped by transcript
cds_by_tx <- cdsBy(txdb, by = "tx")

# Get promoters (e.g., 2kb upstream of TSS)
zebrafish_promoters <- promoters(txdb, upstream = 2000, downstream = 200)
```

### Filtering by Specific Genes or Chromosomes
You can use the `genes()` function to get gene-level coordinates or filter the TxDb object.

```r
# Get all genes
zebrafish_genes <- genes(txdb)

# Filter for a specific chromosome (e.g., chr1)
chr1_features <- genes(txdb, filter = list(tx_chrom = "chr1"))
```

### Coordinate Mapping
This package is often used in conjunction with `BSgenome.Drerio.UCSC.danRer10` to extract sequences for specific transcripts.

```r
# Example: Extracting transcript sequences (requires BSgenome)
# library(BSgenome.Drerio.UCSC.danRer10)
# tx_seqs <- extractTranscriptSeqs(BSgenome.Drerio.UCSC.danRer10, txdb)
```

## Tips
- **Naming Convention**: The object name `TxDb.Drerio.UCSC.danRer10.refGene` follows the Bioconductor standard: `TxDb` (Type) . `Drerio` (Species) . `UCSC` (Source) . `danRer10` (Build) . `refGene` (Track).
- **RefSeq IDs**: Because this is based on the `refGene` track, the identifiers used are typically RefSeq accessions (e.g., NM_ or NR_ prefixes).
- **Coordinate System**: UCSC tracks use 1-based coordinates when imported into R/Bioconductor `GRanges` objects.

## Reference documentation
- [TxDb.Drerio.UCSC.danRer10.refGene](./references/reference_manual.md)