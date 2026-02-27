---
name: bioconductor-txdb.scerevisiae.ucsc.saccer3.sgdgene
description: This package provides a Bioconductor TxDb object for Saccharomyces cerevisiae genomic annotations based on the UCSC sacCer3 genome build. Use when user asks to retrieve transcript, exon, or CDS coordinates for yeast, group genomic features by gene or transcript, or work with Saccharomyces cerevisiae genomic annotations in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Scerevisiae.UCSC.sacCer3.sgdGene.html
---


# bioconductor-txdb.scerevisiae.ucsc.saccer3.sgdgene

name: bioconductor-txdb.scerevisiae.ucsc.saccer3.sgdgene
description: Use this skill when working with Saccharomyces cerevisiae (Yeast) genomic annotations in R. It provides access to the TxDb object for the UCSC sacCer3 genome build based on the SGD (Saccharomyces Genome Database) gene track. Use it for retrieving transcript, exon, and CDS coordinates, or for mapping genomic features in yeast.

# bioconductor-txdb.scerevisiae.ucsc.saccer3.sgdgene

## Overview

The `TxDb.Scerevisiae.UCSC.sacCer3.sgdGene` package is a Bioconductor annotation hub containing a prefabricated `TxDb` (Transcript Database) object for *Saccharomyces cerevisiae*. It is based on the UCSC `sacCer3` genome assembly and uses the `sgdGene` track. This package is essential for genomic workflows involving yeast, such as RNA-seq, ChIP-seq, or any analysis requiring precise genomic coordinates for genes, transcripts, and exons.

## Basic Usage

### Loading the Package and Object

To use the database, load the library. The TxDb object is automatically instantiated with the same name as the package.

```r
library(TxDb.Scerevisiae.UCSC.sacCer3.sgdGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Scerevisiae.UCSC.sacCer3.sgdGene
txdb
```

### Inspecting the Database

Check the metadata and supported seqlevels (chromosomes):

```r
# View metadata
metadata(txdb)

# View chromosome names and lengths
seqlevels(txdb)
seqlengths(txdb)
```

## Common Workflows

### Extracting Genomic Features

Use standard `GenomicFeatures` functions to extract GRanges objects:

```r
library(GenomicFeatures)

# Get all transcripts
all_tx <- transcripts(txdb)

# Get all exons
all_exons <- exons(txdb)

# Get all CDS (Coding Sequences)
all_cds <- cds(txdb)

# Get all genes (represented as the range from the start of the first 
# transcript to the end of the last)
all_genes <- genes(txdb)
```

### Grouping Features

Often you need features grouped by their parent gene or transcript:

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")
```

### Filtering by Chromosome

If working with specific yeast chromosomes (e.g., Chromosome IV):

```r
# Keep only chrIV
seqlevels(txdb) <- "chrIV"
chr4_genes <- genes(txdb)

# Restore all chromosomes
restoreSeqlevels(txdb)
```

## Tips for Yeast Analysis

1.  **Naming Convention**: This package uses UCSC chromosome naming (e.g., "chrI", "chrII", "chrM"). If your data uses Roman numerals without the "chr" prefix, use `seqlevelsStyle(txdb) <- "Ensembl"` to convert.
2.  **Gene IDs**: The gene identifiers in this package are typically Systematic Names from the Saccharomyces Genome Database (SGD), such as YAL001C.
3.  **Coordinate System**: Like all TxDb objects, coordinates are 1-based and inclusive.

## Reference documentation

- [TxDb.Scerevisiae.UCSC.sacCer3.sgdGene Reference Manual](./references/reference_manual.md)