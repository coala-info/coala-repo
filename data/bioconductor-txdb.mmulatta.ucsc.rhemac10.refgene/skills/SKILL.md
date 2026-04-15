---
name: bioconductor-txdb.mmulatta.ucsc.rhemac10.refgene
description: This package provides a Transcript Database object for the Rhesus macaque rheMac10 genome assembly using UCSC refGene annotations. Use when user asks to retrieve genomic coordinates for transcripts, exons, or genes, group features by gene or transcript, or perform range-based analysis for Macaca mulatta.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmulatta.UCSC.rheMac10.refGene.html
---

# bioconductor-txdb.mmulatta.ucsc.rhemac10.refgene

name: bioconductor-txdb.mmulatta.ucsc.rhemac10.refgene
description: Provides an R interface to the UCSC rheMac10 (Macaca mulatta) refGene annotation database. Use this skill when working with R to retrieve genomic coordinates for transcripts, exons, and genes for the Rhesus macaque genome assembly rheMac10.

# bioconductor-txdb.mmulatta.ucsc.rhemac10.refgene

## Overview

This skill facilitates the use of the `TxDb.Mmulatta.UCSC.rheMac10.refGene` Bioconductor package. This package is a "Transcript Database" (TxDb) object containing gene models for the Rhesus macaque (Macaca mulatta) based on the UCSC rheMac10 genome assembly and the refGene track. It is primarily used for genomic range-based analysis, such as identifying the locations of genes, transcripts, exons, and coding sequences (CDS).

## Basic Usage

### Loading the Package
To use the database, you must first load the library:

```r
library(TxDb.Mmulatta.UCSC.rheMac10.refGene)
```

### Accessing the TxDb Object
The package automatically creates an object named `TxDb.Mmulatta.UCSC.rheMac10.refGene`. You can inspect its metadata and genome information by simply typing the object name:

```r
txdb <- TxDb.Mmulatta.UCSC.rheMac10.refGene
txdb
```

## Common Workflows

### Extracting Genomic Features
Use the standard `GenomicFeatures` accessor functions to extract GRanges objects:

```r
# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
ex <- exons(txdb)

# Get all genes
gn <- genes(txdb)

# Get all coding sequences
cds <- cds(txdb)
```

### Grouping Features
To retrieve features grouped by a parent element (e.g., all exons belonging to a specific gene), use the `transcriptsBy`, `exonsBy`, or `cdsBy` functions:

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Filtering and Selection
You can use the `select`, `keys`, and `columns` methods from the `AnnotationDbi` framework to query specific information:

```r
# List available columns
columns(txdb)

# List available key types
keytypes(txdb)

# Query specific gene information
select(txdb, keys = "100124692", columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips
- **Coordinate System**: This package uses the rheMac10 assembly coordinates. Ensure your other genomic data (e.g., BAM files, BED files) are aligned to the same assembly.
- **Integration**: This TxDb object is designed to work seamlessly with the `GenomicRanges` and `GenomicFeatures` ecosystems.
- **Naming**: The "refGene" suffix indicates that these annotations are derived from the NCBI RefSeq gene track at UCSC.

## Reference documentation

- [TxDb.Mmulatta.UCSC.rheMac10.refGene](./references/reference_manual.md)