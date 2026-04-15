---
name: bioconductor-txdb.scerevisiae.ucsc.saccer2.sgdgene
description: This package provides a Bioconductor Transcript Database object for the Saccharomyces cerevisiae sacCer2 genome build. Use when user asks to retrieve transcript, exon, or CDS locations, map features to the yeast genome, or perform spatial queries using GenomicFeatures.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Scerevisiae.UCSC.sacCer2.sgdGene.html
---

# bioconductor-txdb.scerevisiae.ucsc.saccer2.sgdgene

name: bioconductor-txdb.scerevisiae.ucsc.saccer2.sgdgene
description: Use this skill when working with the Bioconductor annotation package TxDb.Scerevisiae.UCSC.sacCer2.sgdGene. This package provides a TxDb object for Saccharomyces cerevisiae (Yeast) based on the UCSC sacCer2 genome build and the sgdGene track. Use it for genomic coordinate-based tasks such as retrieving transcript, exon, and CDS locations, or mapping features to the yeast genome.

# bioconductor-txdb.scerevisiae.ucsc.saccer2.sgdgene

## Overview

This skill provides guidance on using the `TxDb.Scerevisiae.UCSC.sacCer2.sgdGene` R package. This is a standard Bioconductor Transcript Database (TxDb) package that exposes genomic annotations for *Saccharomyces cerevisiae* (sacCer2). It is primarily used in conjunction with the `GenomicFeatures` and `GenomicRanges` packages to perform spatial queries on the yeast genome.

## Basic Usage

### Loading the Package and Object
The package automatically creates a `TxDb` object named `TxDb.Scerevisiae.UCSC.sacCer2.sgdGene` upon loading.

```r
library(TxDb.Scerevisiae.UCSC.sacCer2.sgdGene)

# Assign to a shorter alias for convenience
txdb <- TxDb.Scerevisiae.UCSC.sacCer2.sgdGene
txdb
```

### Inspecting the Database
Use standard `AnnotationDbi` and `GenomicFeatures` methods to inspect the metadata and available seqlevels.

```r
# Check genome build and data source
metadata(txdb)

# List chromosomes/sequences
seqlevels(txdb)

# Check coordinate system (usually UCSC style: chrI, chrII, etc.)
seqinfo(txdb)
```

## Common Workflows

### Extracting Genomic Features
Extract features as `GRanges` or `GRangesList` objects.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
ex <- exons(txdb)

# Get all CDS (coding sequences)
cds <- cds(txdb)

# Get genes (defined by the extent of their transcripts)
gn <- genes(txdb)
```

### Grouping Features
Retrieve features grouped by parent relationships (e.g., exons per gene).

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Selecting Specific Data
Use the `select`, `keys`, and `columns` interface to retrieve specific annotations.

```r
# List available columns
columns(txdb)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific transcript names for a set of Gene IDs
keys_vec <- head(keys(txdb, keytype="GENEID"))
select(txdb, keys=keys_vec, columns=c("TXNAME", "TXSTRAND"), keytype="GENEID")
```

## Tips and Best Practices

- **Genome Version**: Ensure your experimental data is aligned to **sacCer2**. If using sacCer3, use the corresponding `TxDb.Scerevisiae.UCSC.sacCer3.sgdGene` package instead.
- **Coordinate Styles**: If your data uses "1", "2" instead of "chrI", "chrII", use `seqlevelsStyle(txdb) <- "NCBI"` to harmonize styles.
- **Integration**: This package is designed to work seamlessly with `GenomicAlignments` (for RNA-seq overlaps) and `biomaRt` (for functional annotation).

## Reference documentation

- [TxDb.Scerevisiae.UCSC.sacCer2.sgdGene Reference Manual](./references/reference_manual.md)