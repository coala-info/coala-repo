---
name: bioconductor-txdb.celegans.ucsc.ce11.refgene
description: This package provides a transcript database for Caenorhabditis elegans based on the UCSC ce11 genome build and refGene annotations. Use when user asks to retrieve genomic coordinates for transcripts, exons, or coding sequences, group genomic features by gene, or perform gene-centric analyses in C. elegans.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Celegans.UCSC.ce11.refGene.html
---


# bioconductor-txdb.celegans.ucsc.ce11.refgene

name: bioconductor-txdb.celegans.ucsc.ce11.refgene
description: Provides the TxDb annotation object for Caenorhabditis elegans (C. elegans) based on the UCSC ce11 (WS235) genome build and the refGene track. Use this skill when you need to retrieve genomic coordinates for transcripts, exons, CDS, or promoters in C. elegans, or when performing genomic overlaps and gene-centric analyses using Bioconductor's GenomicFeatures framework.

# bioconductor-txdb.celegans.ucsc.ce11.refgene

## Overview

The `TxDb.Celegans.UCSC.ce11.refGene` package is a dedicated annotation database (TxDb) for the *C. elegans* genome. It provides a structured R interface to the RefSeq gene annotations provided by UCSC for the ce11 assembly. This package is essential for bioinformatics workflows involving C. elegans where genomic features (like gene boundaries or splice sites) need to be mapped to coordinates.

## Usage and Workflows

### Loading the Database
To use the annotation object, you must load the library. The object name matches the package name.

```r
library(TxDb.Celegans.UCSC.ce11.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Celegans.UCSC.ce11.refGene
txdb
```

### Extracting Genomic Features
The primary use of a TxDb object is to extract GRanges or GRangesList objects representing different genomic components.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons <- exons(txdb)

# Get all coding sequences (CDS)
cds <- cds(txdb)

# Get promoters (default 2000bp upstream, 200bp downstream)
proms <- promoters(txdb, upstream=2000, downstream=200)
```

### Grouping Features by Gene or Transcript
Often, you need to know which exons belong to which gene. Use the `By` family of functions:

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by="tx")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by="gene")
```

### Filtering and Selecting Data
You can use `select`, `keys`, and `columns` to query specific information from the database.

```r
# List available columns
columns(txdb)

# List available key types (usually GENEID or TXNAME)
keytypes(txdb)

# Retrieve specific transcript names for a set of Gene IDs
select(txdb, 
       keys = c("171494", "171495"), 
       columns = c("TXNAME", "TXSTRAND"), 
       keytype = "GENEID")
```

## Tips for C. elegans Analysis
- **Genome Build**: Ensure your experimental data (e.g., BAM or BED files) is aligned to **ce11** (WS235). Using this package with ce10 or WBcel235 data may result in coordinate mismatches.
- **Coordinate System**: UCSC tracks use "chr" prefixes (e.g., "chrI", "chrX"). If your data uses numeric or Roman numerals without "chr", use `seqlevelsStyle(txdb) <- "NCBI"` or `seqlevelsStyle(txdb) <- "Ensembl"` to harmonize them.
- **Integration**: This package is designed to work seamlessly with `GenomicRanges`, `SummarizedExperiment`, and `Gviz`.

## Reference documentation

- [TxDb.Celegans.UCSC.ce11.refGene](./references/reference_manual.md)