---
name: bioconductor-txdb.athaliana.biomart.plantsmart22
description: This package provides a genomic annotation database for Arabidopsis thaliana based on the Ensembl Plants release 22 BioMart data. Use when user asks to retrieve genomic coordinates for transcripts, exons, or coding sequences, group features by gene, or perform genomic analyses in R using the plantsmart22 data version.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Athaliana.BioMart.plantsmart22.html
---

# bioconductor-txdb.athaliana.biomart.plantsmart22

name: bioconductor-txdb.athaliana.biomart.plantsmart22
description: Provides an GenomicFeatures TxDb annotation object for Arabidopsis thaliana based on BioMart Ensembl Plants release 22. Use this skill when performing genomic analyses in R that require transcript, exon, or CDS coordinates for Arabidopsis thaliana (thale cress), specifically using the plantsmart22 data version.

# bioconductor-txdb.athaliana.biomart.plantsmart22

## Overview

This package is a "Transcript Database" (TxDb) object containing the gene models for *Arabidopsis thaliana*. It serves as an R interface to a prefabricated database generated from BioMart (Ensembl Plants 22). It is primarily used with the `GenomicFeatures` and `GenomicRanges` frameworks to retrieve genomic coordinates for transcripts, exons, and coding sequences (CDS).

## Loading and Inspection

To use the database, load the library and reference the object by its package name.

```r
# Load the package
library(TxDb.Athaliana.BioMart.plantsmart22)

# Assign to a shorter alias for convenience
txdb <- TxDb.Athaliana.BioMart.plantsmart22

# Inspect the object metadata
txdb
```

## Common Workflows

### 1. Extracting Genomic Features
The most common use case is extracting GRanges objects for specific feature types.

```r
library(GenomicFeatures)

# Get all transcripts
all_tx <- transcripts(txdb)

# Get all exons
all_exons <- exons(txdb)

# Get all CDS (coding sequences)
all_cds <- cds(txdb)

# Get all genes (represented as single ranges)
all_genes <- genes(txdb)
```

### 2. Grouping Features
Use the `By` family of functions to get features grouped by a parent container (e.g., exons grouped by gene).

```r
# Get exons grouped by gene (returns a GRangesList)
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### 3. Filtering by Chromosome or Sequence
You can restrict the output to specific chromosomes (e.g., the 5 nuclear chromosomes of Arabidopsis).

```r
# View available sequences
seqlevels(txdb)

# Keep only standard nuclear chromosomes (1-5)
seqlevels(txdb) <- c("1", "2", "3", "4", "5")
genes_nuclear <- genes(txdb)
```

## Tips for Usage

- **Coordinate System**: This package uses 1-based coordinates, consistent with standard Bioconductor `GenomicRanges` objects.
- **Integration**: This TxDb object is designed to work seamlessly with `Gviz` for visualization or `summarizeOverlaps` (from `GenomicAlignments`) for RNA-seq quantification.
- **Identifier Mapping**: The gene IDs in this package are typically Ensembl identifiers. To map these to other symbols (like TAIR IDs or common names), use the `org.At.tair.db` package.

## Reference documentation

- [TxDb.Athaliana.BioMart.plantsmart22 Reference Manual](./references/reference_manual.md)