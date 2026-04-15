---
name: bioconductor-txdb.rnorvegicus.ucsc.rn4.ensgene
description: This package provides a transcript database object for the Rattus norvegicus rn4 genome assembly using Ensembl gene annotations. Use when user asks to retrieve gene models, extract transcript coordinates, or identify exon and promoter locations for the rn4 rat assembly in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Rnorvegicus.UCSC.rn4.ensGene.html
---

# bioconductor-txdb.rnorvegicus.ucsc.rn4.ensgene

name: bioconductor-txdb.rnorvegicus.ucsc.rn4.ensgene
description: Provides the TxDb annotation object for Rattus norvegicus (Rat) based on the UCSC rn4 genome build and the ensGene (Ensembl) track. Use this skill when performing genomic analyses in R that require gene models, transcript coordinates, exon locations, or promoter regions for the rn4 rat assembly.

# bioconductor-txdb.rnorvegicus.ucsc.rn4.ensgene

## Overview

This skill facilitates the use of the `TxDb.Rnorvegicus.UCSC.rn4.ensGene` Bioconductor package. This package is a "Transcript Database" (TxDb) object, which serves as a standardized R interface to genomic annotations. It specifically contains gene, transcript, exon, and CDS (coding sequence) information for the Rat (Rattus norvegicus) genome assembly `rn4`, sourced from the UCSC Genome Browser's Ensembl gene track (`ensGene`).

## Basic Usage

### Loading the Package
To access the annotation object, load the library:

```r
library(TxDb.Rnorvegicus.UCSC.rn4.ensGene)
```

### Accessing the TxDb Object
The package exposes a single primary object named exactly like the package:

```r
txdb <- TxDb.Rnorvegicus.UCSC.rn4.ensGene
txdb
```

### Inspecting Metadata
To check the genome build, data source, and creation date:

```r
metadata(txdb)
genome(txdb)
```

## Common Workflows

### Extracting Genomic Features
Use the standard `GenomicFeatures` accessor functions to retrieve GRanges objects:

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons <- exons(txdb)

# Get all genes (represented by their genomic extent)
genes <- genes(txdb)

# Get promoters (e.g., 2kb upstream of TSS)
proms <- promoters(txdb, upstream=2000, downstream=200)
```

### Grouping Features
To understand the relationship between features (e.g., which exons belong to which transcript), use the `By` functions:

```r
# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by="tx")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by="gene")

# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")
```

### Filtering by Chromosome
You can restrict the TxDb object to specific chromosomes to speed up processing:

```r
seqlevels(txdb) <- "chr1"
# Subsequent calls like genes(txdb) will only return features on chr1
# Reset to all chromosomes:
restoreSeqlevels(txdb)
```

## Tips for Success
- **Coordinate System**: This package uses the `rn4` assembly. Ensure your experimental data (e.g., BAM files or peak calls) is aligned to `rn4` and not a newer version like `rn6` or `rn7`.
- **Identifier Types**: The gene identifiers in this package are typically Ensembl IDs, as it is based on the `ensGene` track.
- **Integration**: This object is designed to work seamlessly with the `GenomicRanges`, `GenomicFeatures`, and `AnnotationDbi` frameworks.

## Reference documentation
- [TxDb.Rnorvegicus.UCSC.rn4.ensGene](./references/reference_manual.md)