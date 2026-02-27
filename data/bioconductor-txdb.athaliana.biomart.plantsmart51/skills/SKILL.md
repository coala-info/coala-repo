---
name: bioconductor-txdb.athaliana.biomart.plantsmart51
description: This package provides a transcript-centric annotation database for Arabidopsis thaliana based on Ensembl Plants version 51. Use when user asks to retrieve gene models, extract transcript structures, or access exon and CDS coordinates for Arabidopsis thaliana genomic analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Athaliana.BioMart.plantsmart51.html
---


# bioconductor-txdb.athaliana.biomart.plantsmart51

name: bioconductor-txdb.athaliana.biomart.plantsmart51
description: Provides genomic annotation data for Arabidopsis thaliana based on Ensembl Plants Genes 51 via BioMart. Use this skill when you need to access transcript-centric annotations (TxDb objects) for Arabidopsis thaliana, including gene models, transcript structures, exon coordinates, and CDS regions for genomic analysis in R.

# bioconductor-txdb.athaliana.biomart.plantsmart51

## Overview
This skill facilitates the use of the `TxDb.Athaliana.BioMart.plantsmart51` R package. This is an annotation package that exposes a `TxDb` (Transcript Database) object containing genomic coordinates for *Arabidopsis thaliana*. The data was generated from Ensembl Plants (version 51) via BioMart. It is primarily used with the `GenomicFeatures` framework to retrieve gene models and genomic features.

## Basic Usage

### Loading the Package and Object
To use the annotation data, load the library and reference the primary object:

```r
library(TxDb.Athaliana.BioMart.plantsmart51)

# The main TxDb object has the same name as the package
txdb <- TxDb.Athaliana.BioMart.plantsmart51
txdb
```

### Inspecting the Database
You can check the metadata and supported chromosomes:

```r
# View metadata (genome build, data source, etc.)
metadata(txdb)

# List active chromosomes/sequences
seqlevels(txdb)

# Check the genome build
genome(txdb)
```

## Common Workflows

### Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract specific feature types as `GRanges` or `GRangesList` objects:

```r
library(GenomicFeatures)

# Get all genes
ath_genes <- genes(txdb)

# Get all transcripts
ath_tx <- transcripts(txdb)

# Get all exons
ath_exons <- exons(txdb)

# Get all CDS (Coding Sequences)
ath_cds <- cds(txdb)
```

### Grouping Features
To understand the relationship between features (e.g., which exons belong to which gene), use the `By` functions:

```r
# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# CDS grouped by transcript
cds_by_tx <- cdsBy(txdb, by = "tx")
```

### Selecting Specific Data
Use the `select`, `keys`, and `columns` interface for tabular data retrieval:

```r
# List available columns
columns(txdb)

# List available key types (usually GENEID, TXID, TXNAME)
keytypes(txdb)

# Retrieve specific annotations for a set of gene IDs
gene_ids <- c("AT1G01010", "AT1G01020")
select(txdb, keys = gene_ids, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips for Success
- **Coordinate System**: Ensure your other genomic data (like BAM or BED files) uses the same chromosome naming convention (e.g., "1", "2", "3", "4", "5", "M", "C"). Use `seqlevelsStyle()` to harmonize if necessary.
- **Package Dependency**: This package requires `GenomicFeatures` to be installed and loaded to perform most operations on the `TxDb` object.
- **Filtering**: You can use `keepStandardChromosomes(txdb)` to focus only on the main nuclear chromosomes if the database contains scaffolds or organelle DNA you wish to ignore.

## Reference documentation
- [TxDb.Athaliana.BioMart.plantsmart51 Reference Manual](./references/reference_manual.md)