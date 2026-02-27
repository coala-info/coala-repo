---
name: bioconductor-txdb.cfamiliaris.ucsc.canfam3.refgene
description: This Bioconductor package provides a TxDb annotation object for the dog genome based on the UCSC canFam3 assembly and refGene track. Use when user asks to extract transcript, exon, or CDS coordinates for Canis familiaris, group genomic features by gene, or perform genomic overlaps for the canFam3 build.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Cfamiliaris.UCSC.canFam3.refGene.html
---


# bioconductor-txdb.cfamiliaris.ucsc.canfam3.refgene

name: bioconductor-txdb.cfamiliaris.ucsc.canfam3.refgene
description: Provides the TxDb annotation object for Canis familiaris (Dog) based on the UCSC canFam3 genome build and the refGene track. Use this skill when performing genomic analyses in R that require transcript, exon, or CDS coordinates for the dog genome, specifically for the canFam3 assembly.

## Overview

The `TxDb.Cfamiliaris.UCSC.canFam3.refGene` package is a Bioconductor annotation resource containing a `TxDb` object. This object serves as an R interface to a prefabricated database of gene models (transcripts, exons, and CDS) for *Canis familiaris*. It is based on the UCSC `canFam3` genome assembly and uses the `refGene` track as the source of truth for gene definitions.

## Usage and Workflows

### Loading the Annotation
To use the database, you must load the library and reference the object by its package name.

```R
library(TxDb.Cfamiliaris.UCSC.canFam3.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Cfamiliaris.UCSC.canFam3.refGene
txdb
```

### Extracting Genomic Features
The primary use of this package is to extract genomic coordinates using functions from the `GenomicFeatures` package.

*   **Extract all transcripts:** `transcripts(txdb)`
*   **Extract all exons:** `exons(txdb)`
*   **Extract all coding sequences:** `cds(txdb)`
*   **Extract genes:** `genes(txdb)`

### Grouping Features
You can retrieve features grouped by their relationship to other features (e.g., all exons belonging to a specific gene).

```R
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
transcripts_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx", use.names = TRUE)
```

### Coordinate Overlaps and Annotation
This `TxDb` object is frequently used in conjunction with `summarizeOverlaps` (from `GenomicAlignments`) or for plotting genomic tracks (using `Gviz`).

```R
# Example: Finding which genes overlap a specific genomic range
library(GenomicRanges)
my_region <- GRanges("chr1", IRanges(start=1000000, end=1100000))
subsetByOverlaps(genes(txdb), my_region)
```

## Tips
*   **Naming Convention:** The object name `TxDb.Cfamiliaris.UCSC.canFam3.refGene` follows the standard Bioconductor naming scheme: `TxDb.Species.Source.Build.Table`.
*   **Genome Build:** Ensure your experimental data (e.g., BAM files) is aligned to the `canFam3` assembly. Using this package with `canFam4` or other builds will result in incorrect coordinate mappings.
*   **Metadata:** You can check the metadata of the database (creation date, data source, etc.) by calling `metadata(txdb)`.

## Reference documentation
- [TxDb.Cfamiliaris.UCSC.canFam3.refGene Reference Manual](./references/reference_manual.md)