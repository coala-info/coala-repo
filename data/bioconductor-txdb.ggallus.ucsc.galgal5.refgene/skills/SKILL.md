---
name: bioconductor-txdb.ggallus.ucsc.galgal5.refgene
description: This package provides a Bioconductor Transcript Database object for the Gallus gallus genome based on the UCSC galGal5 refGene track. Use when user asks to retrieve chicken transcript coordinates, extract exon or CDS locations, or group genomic features by gene for the galGal5 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Ggallus.UCSC.galGal5.refGene.html
---


# bioconductor-txdb.ggallus.ucsc.galgal5.refgene

name: bioconductor-txdb.ggallus.ucsc.galgal5.refgene
description: Provides genomic annotation data for Gallus gallus (chicken) based on the UCSC galGal5 genome build and the refGene track. Use this skill when you need to retrieve transcript, exon, or CDS coordinates, or perform genomic range operations on chicken gene models in R.

# bioconductor-txdb.ggallus.ucsc.galgal5.refgene

## Overview

The `TxDb.Ggallus.UCSC.galGal5.refGene` package is a Bioconductor annotation package that provides a `TxDb` (Transcript Database) object for the chicken (*Gallus gallus*) genome. It serves as an R interface to the UCSC galGal5 assembly, specifically using the `refGene` track. This package is essential for bioinformatics workflows involving genomic interval analysis, such as RNA-seq, ChIP-seq, or variant annotation in poultry research.

## Usage and Workflows

### Loading the Database

To use the annotation data, you must load the library and access the automatically created object:

```r
library(TxDb.Ggallus.UCSC.galGal5.refGene)

# The main object is named exactly like the package
txdb <- TxDb.Ggallus.UCSC.galGal5.refGene
txdb
```

### Extracting Genomic Features

The package is designed to work with the `GenomicFeatures` framework. You can extract various features as `GRanges` or `GRangesList` objects:

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons <- exons(txdb)

# Get all coding sequences (CDS)
cds <- cds(txdb)

# Get all genes (returns the genomic extent of each gene)
genes <- genes(txdb)
```

### Grouping Features

Often, you need to know which exons or transcripts belong to which gene. Use the `*By` functions:

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Filtering and Selecting

You can use the `select`, `keys`, and `columns` methods to retrieve specific metadata:

```r
# List available columns
columns(txdb)

# List available key types (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific transcript names for a set of Gene IDs
select(txdb, 
       keys = c("12345", "67890"), 
       columns = c("TXNAME", "TXSTRAND"), 
       keytype = "GENEID")
```

## Tips for Success

- **Coordinate System**: This package uses the galGal5 (UCSC) coordinate system. Ensure your other data (like BAM files or BigWig files) are aligned to the same assembly version.
- **Naming Convention**: Chromosome names follow the UCSC convention (e.g., "chr1", "chr2", "chrZ").
- **Integration**: This package is most powerful when used alongside `GenomicRanges` for overlap analysis and `org.Gg.eg.db` for mapping Entrez IDs to Gene Symbols.

## Reference documentation

- [TxDb.Ggallus.UCSC.galGal5.refGene Reference Manual](./references/reference_manual.md)