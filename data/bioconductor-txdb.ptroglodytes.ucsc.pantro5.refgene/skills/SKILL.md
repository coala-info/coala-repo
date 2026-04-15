---
name: bioconductor-txdb.ptroglodytes.ucsc.pantro5.refgene
description: This package provides genomic annotation data for the Pan troglodytes panTro5 assembly using the UCSC refGene track. Use when user asks to access gene models, extract coordinates for transcripts or exons, and perform range-based analysis on the chimpanzee genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Ptroglodytes.UCSC.panTro5.refGene.html
---

# bioconductor-txdb.ptroglodytes.ucsc.pantro5.refgene

name: bioconductor-txdb.ptroglodytes.ucsc.pantro5.refgene
description: Provides genomic annotation data for the Chimpanzee (Pan troglodytes) genome assembly panTro5. Use this skill when you need to access gene models, transcripts, exons, and CDS regions based on the UCSC refGene track for Pan troglodytes.

# bioconductor-txdb.ptroglodytes.ucsc.pantro5.refgene

## Overview

This skill facilitates the use of the `TxDb.Ptroglodytes.UCSC.panTro5.refGene` Bioconductor package. This package is a "TxDb" (Transcript Database) object that serves as an R interface to prefabricated genomic annotations for the *Pan troglodytes* (Chimpanzee) genome, specifically the panTro5 assembly using the UCSC refGene track. It is primarily used for genomic range-based analysis, such as identifying the coordinates of genes, transcripts, and exons.

## Basic Usage

### Loading the Package
To use the annotation object, you must first load the library:

```r
library(TxDb.Ptroglodytes.UCSC.panTro5.refGene)
# The main object is named the same as the package
txdb <- TxDb.Ptroglodytes.UCSC.panTro5.refGene
```

### Inspecting the Database
You can view metadata and the structure of the database:

```r
# Display summary information
txdb

# List the chromosomes/sequences included
seqlevels(txdb)

# Check the genome build
genome(txdb)
```

## Common Workflows

### Extracting Genomic Features
The package is designed to work with the `GenomicFeatures` framework. You can extract various features as `GRanges` or `GRangesList` objects.

```r
library(GenomicFeatures)

# Get all genes
panTro5_genes <- genes(txdb)

# Get all transcripts
panTro5_tx <- transcripts(txdb)

# Get all exons
panTro5_exons <- exons(txdb)

# Get CDS (Coding Sequences)
panTro5_cds <- cds(txdb)
```

### Grouping Features
Often, you need to know which exons or transcripts belong to which gene. Use the `By` functions:

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get five-prime UTRs grouped by transcript
fp_utrs <- fiveUTRsByTranscript(txdb)
```

### Coordinate Overlaps
Use this TxDb object with `GenomicRanges` to find features overlapping specific regions:

```r
library(GenomicRanges)
query_region <- GRanges(seqnames = "chr1", ranges = IRanges(start = 1000000, end = 2000000))
overlaps <- subsetByOverlaps(genes(txdb), query_region)
```

## Tips
- **Package Name Logic**: The name `TxDb.Ptroglodytes.UCSC.panTro5.refGene` indicates:
    - `TxDb`: Transcript Database object.
    - `Ptroglodytes`: Species (*Pan troglodytes*).
    - `UCSC`: Data source.
    - `panTro5`: Genome assembly version.
    - `refGene`: The specific UCSC track used for the annotations.
- **Coordinate System**: UCSC tracks typically use 1-based coordinates when imported into R via Bioconductor TxDb objects.
- **Integration**: This package is frequently used in conjunction with `GenomicFeatures`, `GenomicRanges`, and `AnnotationDbi`.

## Reference documentation
- [TxDb.Ptroglodytes.UCSC.panTro5.refGene Reference Manual](./references/reference_manual.md)