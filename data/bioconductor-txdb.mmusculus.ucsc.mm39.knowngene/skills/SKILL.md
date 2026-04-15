---
name: bioconductor-txdb.mmusculus.ucsc.mm39.knowngene
description: This package provides a Bioconductor TxDb object containing UCSC mm39 mouse genome annotations for genes, transcripts, and exons. Use when user asks to retrieve mouse genomic coordinates, extract transcript structures for the mm39 assembly, or group genomic features by gene or transcript in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmusculus.UCSC.mm39.knownGene.html
---

# bioconductor-txdb.mmusculus.ucsc.mm39.knowngene

name: bioconductor-txdb.mmusculus.ucsc.mm39.knowngene
description: Provides access to the UCSC mm39 (mouse) genome annotations (knownGene track) as a TxDb object. Use this skill when working with mouse genomic coordinates, gene models, transcript structures, or performing genomic overlaps and annotations for the mm39 assembly in R.

# bioconductor-txdb.mmusculus.ucsc.mm39.knowngene

## Overview
This package is a Bioconductor annotation resource that exposes a `TxDb` (Transcript Database) object for *Mus musculus* (mouse). It is based on the UCSC mm39 genome assembly and the `knownGene` track. It allows users to programmatically retrieve genomic coordinates for genes, transcripts, exons, and coding sequences (CDS) using standard Bioconductor methods.

## Getting Started
To use the database, load the library and reference the object:

```r
library(TxDb.Mmusculus.UCSC.mm39.knownGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Mmusculus.UCSC.mm39.knownGene
txdb
```

## Common Workflows

### Extracting Genomic Features
Use functions from the `GenomicFeatures` package to extract GRanges objects:

```r
library(GenomicFeatures)

# Get all genes
mouse_genes <- genes(txdb)

# Get all transcripts
mouse_tx <- transcripts(txdb)

# Get all exons
mouse_exons <- exons(txdb)

# Get all CDS
mouse_cds <- cds(txdb)
```

### Grouping Features
Retrieve features grouped by a parent feature (e.g., exons grouped by gene or transcript):

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# CDS grouped by transcript
cds_by_tx <- cdsBy(txdb, by = "tx")
```

### Querying the Database
Use `select`, `keys`, and `columns` to perform specific queries:

```r
# List available columns
columns(txdb)

# List available key types (usually GENEID, TXID, TXNAME)
keytypes(txdb)

# Retrieve specific transcript info for a set of Entrez Gene IDs
gene_ids <- c("12345", "67890")
select(txdb, keys = gene_ids, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips
* **Coordinate System**: This package uses UCSC chromosome naming (e.g., "chr1", "chrX"). If your data uses Ensembl naming (e.g., "1", "X"), use `seqlevelsStyle(txdb) <- "Ensembl"` to convert.
* **Genome Version**: Ensure your experimental data (BAMs, BEDs) was aligned to **mm39**. For mm10, use the `TxDb.Mmusculus.UCSC.mm10.knownGene` package instead.
* **Dependencies**: Most functional operations on this object require the `GenomicFeatures` and `AnnotationDbi` packages.

## Reference documentation
- [TxDb.Mmusculus.UCSC.mm39.knownGene](./references/reference_manual.md)