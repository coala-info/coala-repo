---
name: bioconductor-txdb.ggallus.ucsc.galgal4.refgene
description: This package provides a TxDb annotation object for the Gallus gallus galGal4 genome build based on UCSC refGene data. Use when user asks to extract transcript, exon, or gene coordinates for chicken, group genomic features by gene or transcript, or retrieve promoter regions for the galGal4 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Ggallus.UCSC.galGal4.refGene.html
---


# bioconductor-txdb.ggallus.ucsc.galgal4.refgene

## Overview

This package is a Genomic Features annotation package containing a `TxDb` object for *Gallus gallus* (Chicken). It specifically provides metadata and coordinates for the UCSC `galGal4` genome build using the `refGene` track. It allows users to programmatically access transcript, exon, and CDS locations using the standard Bioconductor `GenomicFeatures` framework.

## Usage and Workflows

### Loading the Annotation
To use the database, load the library and reference the object by its package name.

```r
library(TxDb.Ggallus.UCSC.galGal4.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Ggallus.UCSC.galGal4.refGene
txdb
```

### Extracting Genomic Features
The primary use of this package is to extract GRanges objects for various genomic elements.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons <- exons(txdb)

# Get all genes (represented by the extent of their transcripts)
genes <- genes(txdb)

# Get promoters (e.g., 2kb upstream of TSS)
promoters <- promoters(txdb, upstream=2000, downstream=400)
```

### Grouping Features
Use the `By` family of functions to return a `GRangesList` grouped by a specific parent feature.

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by="gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by="tx")
```

### Filtering and Selection
You can use the `columns` and `keytypes` functions to see what data can be retrieved, and `select` to join specific annotations.

```r
# List available columns
columns(txdb)

# Example: Retrieve transcript names for specific gene IDs
select(txdb, 
       keys = c("100857150", "416915"), 
       columns = c("TXNAME", "TXSTRAND"), 
       keytype = "GENEID")
```

## Tips
- **Coordinate System**: This package uses 1-based coordinates (standard for Bioconductor/R) even though the underlying UCSC data is 0-based.
- **Genome Build**: Ensure your sequence data (BAM/FASTA) is aligned to `galGal4` before using these annotations.
- **Integration**: This object is compatible with `Gviz` for visualization and `summarizeOverlaps` for RNA-seq quantification.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)