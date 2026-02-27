---
name: bioconductor-txdb.dmelanogaster.ucsc.dm6.ensgene
description: This package provides a transcript database object for Drosophila melanogaster based on the UCSC dm6 genome build and Ensembl gene annotations. Use when user asks to retrieve transcript structures, extract exon coordinates, or group genomic features by gene for fruit fly genomic analyses in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Dmelanogaster.UCSC.dm6.ensGene.html
---


# bioconductor-txdb.dmelanogaster.ucsc.dm6.ensgene

name: bioconductor-txdb.dmelanogaster.ucsc.dm6.ensgene
description: Provides the TxDb annotation object for Drosophila melanogaster (fruit fly) based on the UCSC dm6 genome build and Ensembl gene (ensGene) annotations. Use this skill when performing genomic analyses in R that require transcript structures, exon coordinates, or gene models for D. melanogaster dm6.

# bioconductor-txdb.dmelanogaster.ucsc.dm6.ensgene

## Overview

This skill facilitates the use of the `TxDb.Dmelanogaster.UCSC.dm6.ensGene` Bioconductor package. This package is a "Transcript Database" (TxDb) object, which serves as an R interface to a prefabricated SQLite database containing genomic coordinates for transcripts, exons, CDS, and genes for *Drosophila melanogaster*. The data is sourced from the UCSC Genome Browser's `ensGene` track for the `dm6` assembly.

## Core Workflows

### Loading the Annotation
To use the database, you must load the library and reference the object by its package name.

```r
library(TxDb.Dmelanogaster.UCSC.dm6.ensGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Dmelanogaster.UCSC.dm6.ensGene
txdb
```

### Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract data from the TxDb object.

```r
library(GenomicFeatures)

# Get all transcripts
all_tx <- transcripts(txdb)

# Get all exons
all_exons <- exons(txdb)

# Get all genes
all_genes <- genes(txdb)

# Get CDS (Coding Sequences)
all_cds <- cds(txdb)
```

### Grouping Features
Commonly used to group exons or transcripts by their parent gene.

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Filtering and Selection
You can use the `select`, `keys`, and `columns` methods to query specific metadata.

```r
# List available columns
columns(txdb)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific info for a set of Ensembl Gene IDs
gene_ids <- c("FBgn0031208", "FBgn0002121")
select(txdb, keys = gene_ids, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips for Usage
- **Coordinate System**: This package uses 1-based closed coordinates (standard for Bioconductor/IRanges).
- **Genome Build**: Ensure your other data (e.g., BAM files or GRanges) are also based on the `dm6` (BDGP Release 6) assembly to avoid coordinate mismatches.
- **Ensembl IDs**: The primary identifiers in this specific TxDb are Ensembl/FlyBase IDs (e.g., FBgn... for genes).
- **Integration**: This object is compatible with `Gviz` for genomic visualization and `SummarizedExperiment` for RNA-seq quantification workflows.

## Reference documentation

- [TxDb.Dmelanogaster.UCSC.dm6.ensGene Reference Manual](./references/reference_manual.md)