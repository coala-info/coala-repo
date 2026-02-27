---
name: bioconductor-txdb.sscrofa.ucsc.susscr11.refgene
description: This package provides a Bioconductor TxDb object for the Sus scrofa (pig) susScr11 genome assembly based on UCSC refGene annotations. Use when user asks to retrieve genomic coordinates for pig genes, extract transcript models, or group exons and coding sequences by gene for the susScr11 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Sscrofa.UCSC.susScr11.refGene.html
---


# bioconductor-txdb.sscrofa.ucsc.susscr11.refgene

name: bioconductor-txdb.sscrofa.ucsc.susscr11.refgene
description: Provides an R interface to the UCSC susScr11 (Pig/Sscrofa) genome annotation based on the refGene track. Use this skill when you need to retrieve genomic coordinates for transcripts, exons, CDS, or genes for Sus scrofa (susScr11) within R using Bioconductor's TxDb framework.

# bioconductor-txdb.sscrofa.ucsc.susscr11.refgene

## Overview

This skill facilitates the use of the `TxDb.Sscrofa.UCSC.susScr11.refGene` Bioconductor annotation package. This package provides a `TxDb` object (Transcript Database) containing the gene models for the *Sus scrofa* (pig) genome, specifically the `susScr11` assembly, sourced from the UCSC Genome Browser's `refGene` track. It is primarily used for genomic range operations, such as finding the locations of genes or transcripts relative to sequencing data.

## Basic Usage

### Loading the Package and Object

To use the database, load the library and reference the object by its package name:

```r
library(TxDb.Sscrofa.UCSC.susScr11.refGene)

# The main object is named the same as the package
txdb <- TxDb.Sscrofa.UCSC.susScr11.refGene
txdb
```

### Inspecting the Database

You can check the metadata and supported chromosomes:

```r
# View metadata
metadata(txdb)

# List chromosomes/sequences
seqlevels(txdb)

# Check the genome build
genome(txdb)
```

## Common Workflows

### Extracting Genomic Features

Use standard `GenomicFeatures` functions to extract GRanges objects:

```r
library(GenomicFeatures)

# Get all genes
pig_genes <- genes(txdb)

# Get all transcripts
pig_tx <- transcripts(txdb)

# Get all exons
pig_exons <- exons(txdb)

# Get Coding Sequences (CDS)
pig_cds <- cds(txdb)
```

### Grouping Features

Often, you need features grouped by their parent element (e.g., exons per gene):

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx", use.names = TRUE)
```

### Retrieving Promoter Regions

```r
# Get 2kb upstream of all transcription start sites
pig_promoters <- promoters(txdb, upstream = 2000, downstream = 200)
```

## Tips for Success

- **Coordinate System**: This package uses 1-based coordinates (standard for Bioconductor/R) even though the underlying UCSC data is 0-based.
- **Naming Convention**: The gene IDs in this specific package typically follow RefSeq accessions (e.g., NM_ or NR_ prefixes) because it is based on the `refGene` track.
- **Integration**: This `TxDb` object is compatible with other Bioconductor tools like `Gviz` for visualization or `summarizeOverlaps` for RNA-seq quantification.
- **Filtering**: Use `seqlevelsStyle(txdb) <- "Ensembl"` or `seqlevelsStyle(txdb) <- "UCSC"` to toggle between chromosome naming conventions (e.g., "1" vs "chr1") if your other data uses a different style.

## Reference documentation

- [TxDb.Sscrofa.UCSC.susScr11.refGene](./references/reference_manual.md)