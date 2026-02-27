---
name: bioconductor-txdb.cfamiliaris.ucsc.canfam4.refgene
description: This Bioconductor package provides genomic coordinates and gene model annotations for the dog genome based on the UCSC canFam4 assembly and refGene track. Use when user asks to retrieve transcripts, exons, or coding sequences for Canis familiaris, group genomic features by gene, or query specific gene identifiers using the canFam4 reference.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Cfamiliaris.UCSC.canFam4.refGene.html
---


# bioconductor-txdb.cfamiliaris.ucsc.canfam4.refgene

name: bioconductor-txdb.cfamiliaris.ucsc.canfam4.refgene
description: Provides instructions for using the Bioconductor annotation package TxDb.Cfamiliaris.UCSC.canFam4.refGene. Use this skill when you need to retrieve genomic coordinates for Canis familiaris (dog) gene models, transcripts, exons, or CDS based on the UCSC canFam4 genome build and the refGene track.

## Overview

The `TxDb.Cfamiliaris.UCSC.canFam4.refGene` package is a Bioconductor Transcript Database (TxDb) object. It serves as an R interface to a prefabricated SQLite database containing gene model annotations for the dog (*Canis familiaris*) genome. It is specifically based on the UCSC `canFam4` assembly and the `refGene` annotation track.

## Basic Usage

### Loading the Package
To access the annotation object, load the library:

```r
library(TxDb.Cfamiliaris.UCSC.canFam4.refGene)
```

### Accessing the TxDb Object
The package exposes a single object with the same name as the package:

```r
txdb <- TxDb.Cfamiliaris.UCSC.canFam4.refGene
txdb
```

### Inspecting Metadata
You can check the genome build, organism, and data source:

```r
metadata(txdb)
genome(txdb)
```

## Common Workflows

### Extracting Genomic Features
Use standard `GenomicFeatures` accessor functions to extract GRanges objects:

```r
# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
ex <- exons(txdb)

# Get all coding sequences
cds <- cds(txdb)

# Get all genes (represented by their entrie genomic extent)
gn <- genes(txdb)
```

### Grouping Features
To get features grouped by a parent feature (e.g., exons per gene), use the `By` family of functions:

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")
```

### Selecting Specific Data
Use the `select`, `keys`, and `columns` methods to query specific identifiers:

```r
# List available columns
columns(txdb)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific transcript names for a set of Gene IDs
select(txdb, keys = c("123", "456"), columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips
- **Coordinate System**: This package uses 1-based coordinates (standard for Bioconductor/R).
- **Integration**: This object is designed to work seamlessly with `GenomicRanges`, `Gviz` (for visualization), and `VariantAnnotation`.
- **Filtering**: Use `activeSeqlevels()` to restrict the object to specific chromosomes (e.g., only autosomes) to speed up processing.

## Reference documentation
- [TxDb.Cfamiliaris.UCSC.canFam4.refGene](./references/reference_manual.md)