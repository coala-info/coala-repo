---
name: bioconductor-txdb.rnorvegicus.biomart.igis
description: This package provides a transcript database for Rattus norvegicus based on IGIS 2.3 data from BioMart. Use when user asks to retrieve genomic coordinates for rat transcripts, extract gene models, or perform genomic annotations for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Rnorvegicus.BioMart.igis.html
---


# bioconductor-txdb.rnorvegicus.biomart.igis

name: bioconductor-txdb.rnorvegicus.biomart.igis
description: Use this skill when working with the Bioconductor R package TxDb.Rnorvegicus.BioMart.igis. This package provides a Transcript Database (TxDb) object for Rattus norvegicus (Rat) based on IGIS 2.3 (Ensembl Genes 67) data from BioMart. Use it to retrieve genomic coordinates for transcripts, exons, and CDS, or to perform genomic overlaps and annotations for rat genomic data.

# bioconductor-txdb.rnorvegicus.biomart.igis

## Overview
The `TxDb.Rnorvegicus.BioMart.igis` package is an annotation resource containing a prefabricated `TxDb` object. It serves as an R interface to genomic locations for the rat genome (Rnorvegicus), specifically sourced from BioMart/IGIS 2.3 (Ensembl 67). This package is essential for workflows involving `GenomicFeatures`, such as RNA-seq annotation, peak annotation, or extracting gene models.

## Usage and Workflows

### Loading the Package
To use the database, you must first load the library. The primary object has the same name as the package.

```r
library(TxDb.Rnorvegicus.BioMart.igis)

# Inspect the object
txdb <- TxDb.Rnorvegicus.BioMart.igis
txdb
```

### Basic Data Extraction
Use standard `GenomicFeatures` methods to extract genomic ranges:

```r
# Extract all transcripts
tx <- transcripts(TxDb.Rnorvegicus.BioMart.igis)

# Extract all exons
exons <- exons(TxDb.Rnorvegicus.BioMart.igis)

# Extract all Coding Sequences (CDS)
cds <- cds(TxDb.Rnorvegicus.BioMart.igis)

# Extract genes
genes <- genes(TxDb.Rnorvegicus.BioMart.igis)
```

### Grouped Extractions
Commonly used to get all features associated with a specific parent feature (e.g., all exons per gene):

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(TxDb.Rnorvegicus.BioMart.igis, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(TxDb.Rnorvegicus.BioMart.igis, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(TxDb.Rnorvegicus.BioMart.igis, by = "tx")
```

### Filtering and Selecting
You can use `select`, `keys`, and `columns` to query specific metadata:

```r
# List available columns
columns(TxDb.Rnorvegicus.BioMart.igis)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(TxDb.Rnorvegicus.BioMart.igis)

# Query specific gene information
res <- select(TxDb.Rnorvegicus.BioMart.igis, 
              keys = c("100360123"), 
              columns = c("TXNAME", "TXSTRAND", "TXSTART"), 
              keytype = "GENEID")
```

## Tips
- **Coordinate System**: Ensure your experimental data uses the same genome build (IGIS 2.3 / Ensembl 67) to avoid coordinate mismatches.
- **Integration**: This object is fully compatible with the `GenomicRanges` and `GenomicFeatures` ecosystems. You can use it directly in functions like `locateVariants()` or `summarizeOverlaps()`.
- **Object Name**: The main object is `TxDb.Rnorvegicus.BioMart.igis`. If you need to reference it in a loop or function, you can assign it to a shorter variable name like `txdb`.

## Reference documentation
- [TxDb.Rnorvegicus.BioMart.igis Reference Manual](./references/reference_manual.md)