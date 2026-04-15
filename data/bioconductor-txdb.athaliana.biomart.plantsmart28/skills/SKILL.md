---
name: bioconductor-txdb.athaliana.biomart.plantsmart28
description: This package provides a Transcript Database object for Arabidopsis thaliana based on the Ensembl Plants 28 release. Use when user asks to retrieve genomic coordinates for genes, transcripts, exons, or CDS, extract promoters, or group genomic features by gene or transcript for Arabidopsis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Athaliana.BioMart.plantsmart28.html
---

# bioconductor-txdb.athaliana.biomart.plantsmart28

name: bioconductor-txdb.athaliana.biomart.plantsmart28
description: Access and utilize Arabidopsis thaliana genomic annotations (Ensembl Plants 28) via a TxDb object. Use when needing to retrieve genomic coordinates for genes, transcripts, exons, or CDS for Arabidopsis in R.

## Overview
This package provides a specialized `TxDb` (Transcript Database) object for *Arabidopsis thaliana*. It serves as a static annotation resource containing genomic locations for various genetic features based on the Ensembl Plants 28 release (BioMart snapshot from October 2015).

## Usage

### Loading the Annotation
Load the package to make the `TxDb` object available in the global environment.

library(TxDb.Athaliana.BioMart.plantsmart28)
txdb <- TxDb.Athaliana.BioMart.plantsmart28

### Inspecting the Database
Examine the metadata and sequence information to understand the coordinate system and data source.

# View object summary
txdb

# List chromosome/sequence levels
seqlevels(txdb)

# Check genome build information
genome(txdb)

### Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract data as `GRanges` or `GRangesList` objects.

# Get all gene boundaries
ath_genes <- genes(txdb)

# Get all transcripts
ath_tx <- transcripts(txdb)

# Get all exons
ath_exons <- exons(txdb)

# Get promoters (default 2000bp upstream, 200bp downstream)
ath_promoters <- promoters(txdb, upstream=2000, downstream=200)

### Grouping Features
Retrieve features grouped by their parent relationships.

# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by="gene")

# CDS grouped by transcript
cds_by_tx <- cdsBy(txdb, by="tx")

### Filtering and Selection
Use the `select`, `keys`, and `columns` interface for targeted queries.

# List available columns
columns(txdb)

# List available key types
keytypes(txdb)

# Retrieve specific transcript info for a list of gene IDs
select(txdb, 
       keys = c("AT1G01010", "AT1G01020"), 
       columns = c("TXNAME", "TXSTRAND", "TXSTART"), 
       keytype = "GENEID")

## Workflow Tips
- **Compatibility**: This object is fully compatible with the `GenomicFeatures`, `GenomicRanges`, and `iranges` packages.
- **Coordinate System**: Ensure your experimental data (e.g., BAM files or peak calls) uses the same chromosome naming convention as `seqlevels(txdb)`.
- **Version Note**: This package is based on Ensembl Plants 28. If you require the latest TAIR or Ensembl versions, verify if this specific release meets your research requirements.

## Reference documentation
- [TxDb.Athaliana.BioMart.plantsmart28 Reference Manual](./references/reference_manual.md)