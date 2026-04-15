---
name: bioconductor-txdb.rnorvegicus.ucsc.rn6.refgene
description: This package provides a transcript database object for the Rattus norvegicus rn6 genome assembly using UCSC refGene annotations. Use when user asks to retrieve rat genomic coordinates, extract gene features like exons or transcripts, or perform range-based genomic analyses in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Rnorvegicus.UCSC.rn6.refGene.html
---

# bioconductor-txdb.rnorvegicus.ucsc.rn6.refgene

name: bioconductor-txdb.rnorvegicus.ucsc.rn6.refgene
description: Provides the TxDb annotation object for Rattus norvegicus (Rat) based on the UCSC rn6 genome build and refGene track. Use this skill when an AI agent needs to retrieve genomic coordinates for rat genes, transcripts, exons, or CDS regions, or when performing genomic overlaps and range-based analyses in R.

# bioconductor-txdb.rnorvegicus.ucsc.rn6.refgene

## Overview
This skill facilitates the use of the Bioconductor annotation package `TxDb.Rnorvegicus.UCSC.rn6.refGene`. This package contains a `TxDb` (Transcript Database) object which serves as an R interface to a prefabricated database of rat genomic features. It is specifically based on the UCSC `rn6` genome assembly and the `refGene` annotation track.

## Loading and Inspection
To use the package, it must be loaded into the R session. The primary object has the same name as the package.

```r
# Load the package
library(TxDb.Rnorvegicus.UCSC.rn6.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Rnorvegicus.UCSC.rn6.refGene

# Inspect the object metadata
txdb
```

## Common Workflows

### Extracting Genomic Features
The `GenomicFeatures` package (a dependency) provides the functions to interact with this TxDb object.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons <- exons(txdb)

# Get all genes (returns GRanges with start/end of the gene body)
genes <- genes(txdb)

# Get CDS (Coding Sequences)
cds <- cds(txdb)
```

### Grouping Features
Often, features need to be grouped by their parent relationship (e.g., exons grouped by gene or transcript).

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")
```

### Filtering by Chromosome
To limit results to specific chromosomes (e.g., only chromosome 1):

```r
seqlevels(txdb) <- "chr1"
tx_chr1 <- transcripts(txdb)
# Reset to all chromosomes
restoreSeqlevels(txdb)
```

## Tips for Success
- **Coordinate System**: This package uses UCSC chromosome naming conventions (e.g., "chr1", "chrM"). If your data uses NCBI/Ensembl naming (e.g., "1", "MT"), use `seqlevelsStyle(txdb) <- "NCBI"` to harmonize them.
- **Object Type**: The object `TxDb.Rnorvegicus.UCSC.rn6.refGene` is a `TxDb` object. Functions from `GenomicFeatures` and `AnnotationDbi` are the primary tools for extraction.
- **Data Version**: This specific package is tied to the `rn6` assembly. Ensure your experimental data (BAM files, BED files) was aligned to `rn6` before using these annotations.

## Reference documentation
- [TxDb.Rnorvegicus.UCSC.rn6.refGene Reference Manual](./references/reference_manual.md)