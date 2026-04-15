---
name: bioconductor-txdb.hsapiens.biomart.igis
description: This package provides a TxDb object containing Homo sapiens genome annotations from the IGIS 2.3 and Ensembl 67 releases. Use when user asks to retrieve genomic coordinates for human genes, transcripts, or exons, perform transcript metadata lookups, or analyze gene models using the IGIS 2.3 annotation set.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Hsapiens.BioMart.igis.html
---

# bioconductor-txdb.hsapiens.biomart.igis

name: bioconductor-txdb.hsapiens.biomart.igis
description: Use this skill when working with the Bioconductor annotation package TxDb.Hsapiens.BioMart.igis. This package provides a TxDb object containing Homo sapiens genome annotations (IGIS 2.3 / Ensembl Genes 67) sourced from BioMart. Use it for genomic coordinate lookups, transcript metadata, and gene model analysis in R.

# bioconductor-txdb.hsapiens.biomart.igis

## Overview
The `TxDb.Hsapiens.BioMart.igis` package is a specialized Bioconductor AnnotationData package. It contains a pre-built `TxDb` (Transcript Database) object that serves as an R interface to genomic annotations for *Homo sapiens*. The data is based on the IGIS 2.3 release (corresponding to Ensembl Genes 67), which was generated from BioMart resources.

## Loading and Inspecting the Database
To use the package, load the library and reference the object by its name.

```r
# Load the package
library(TxDb.Hsapiens.BioMart.igis)

# The primary object is named the same as the package
txdb <- TxDb.Hsapiens.BioMart.igis

# Inspect the object metadata
txdb
```

## Common Workflows

### Extracting Genomic Features
Since this is a standard `TxDb` object, use the `GenomicFeatures` API to extract coordinates for genes, transcripts, exons, and CDS.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(TxDb.Hsapiens.BioMart.igis)

# Get all exons
exons <- exons(TxDb.Hsapiens.BioMart.igis)

# Get all genes
genes <- genes(TxDb.Hsapiens.BioMart.igis)
```

### Grouping Features
You can retrieve features grouped by their parent relationships (e.g., exons grouped by transcript or gene).

```r
# Get exons grouped by transcript
ex_by_tx <- exonsBy(TxDb.Hsapiens.BioMart.igis, by = "tx")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(TxDb.Hsapiens.BioMart.igis, by = "gene")
```

### Selecting Specific Data
Use the `select`, `keys`, `columns`, and `keytypes` methods to query specific identifiers.

```r
# List available columns
columns(TxDb.Hsapiens.BioMart.igis)

# List available keytypes
keytypes(TxDb.Hsapiens.BioMart.igis)

# Query specific gene info
keys_list <- head(keys(TxDb.Hsapiens.BioMart.igis, keytype = "GENEID"))
select(TxDb.Hsapiens.BioMart.igis, 
       keys = keys_list, 
       columns = c("TXNAME", "TXSTRAND"), 
       keytype = "GENEID")
```

## Usage Tips
- **Data Version**: This package is based on Ensembl 67 (IGIS 2.3). If your analysis requires a more recent Ensembl release (e.g., Ensembl 110+), consider using `GenomicFeatures::makeTxDbFromBiomart()` to generate a fresh object.
- **Coordinate System**: Ensure your other genomic data (like BAM or BED files) uses the same chromosome naming convention and genome build as this TxDb object to avoid mapping errors.
- **Memory**: The object is loaded into memory upon calling the library. Use `ls('package:TxDb.Hsapiens.BioMart.igis')` to verify the object name if you encounter "object not found" errors.

## Reference documentation
- [TxDb.Hsapiens.BioMart.igis Reference Manual](./references/reference_manual.md)