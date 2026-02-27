---
name: bioconductor-txdb.btaurus.ucsc.bostau8.refgene
description: This package provides a TxDb object for Bos taurus genomic annotations based on the UCSC bosTau8 assembly and refGene track. Use when user asks to retrieve cow transcript metadata, extract genomic features like exons or CDS, or perform coordinate lookups for the bosTau8 genome build.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Btaurus.UCSC.bosTau8.refGene.html
---


# bioconductor-txdb.btaurus.ucsc.bostau8.refgene

name: bioconductor-txdb.btaurus.ucsc.bostau8.refgene
description: Use this skill when working with Bos taurus (Cow) genomic annotations in R. It provides access to a TxDb object containing transcript, exon, and CDS metadata based on the UCSC bosTau8 genome build and the refGene track. Use this for genomic coordinate lookups, gene structure analysis, and integrating cow genomic data with other Bioconductor packages like GenomicFeatures or AnnotationDbi.

# bioconductor-txdb.btaurus.ucsc.bostau8.refgene

## Overview

This skill facilitates the use of the `TxDb.Btaurus.UCSC.bosTau8.refGene` R package. This is an annotation package that exposes a `TxDb` (Transcript Database) object. It serves as a local interface to cow (Bos taurus) genomic features including transcripts, exons, and coding sequences (CDS) as defined by the UCSC bosTau8 assembly and the RefSeq (refGene) gene models.

## Basic Usage

### Loading the Package
To use the annotation object, you must first load the library:

```r
library(TxDb.Btaurus.UCSC.bosTau8.refGene)
```

### Accessing the TxDb Object
The package automatically loads an object with the same name as the package. You can inspect its metadata by calling the object directly:

```r
txdb <- TxDb.Btaurus.UCSC.bosTau8.refGene
txdb
```

## Common Workflows

### Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract data from the TxDb object:

```r
library(GenomicFeatures)

# Extract all transcripts
all_tx <- transcripts(txdb)

# Extract all exons
all_exons <- exons(txdb)

# Extract all coding sequences
all_cds <- cds(txdb)

# Extract genes as a GRanges object
all_genes <- genes(txdb)
```

### Grouping Features
You can retrieve features grouped by their parent relationships (e.g., exons grouped by transcript or gene):

```r
# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")
```

### Filtering and Selection
You can use the `select`, `keys`, and `columns` methods from the `AnnotationDbi` framework to query specific information:

```r
# List available columns
columns(txdb)

# List available key types (e.g., GENEID, TXNAME)
keytypes(txdb)

# Query specific gene information
res <- select(txdb, 
              keys = c("100137871"), 
              columns = c("TXNAME", "TXCHROM", "TXSTART", "TXEND"), 
              keytype = "GENEID")
```

## Tips for Success
- **Genome Build**: Ensure your experimental data is aligned to the **bosTau8** (UCSC) assembly. Using this package with data from other builds (like ARS-UCD1.2/bosTau9) will result in coordinate mismatches.
- **Coordinate System**: TxDb objects use 1-based closed coordinates, consistent with standard Bioconductor `GRanges` objects.
- **Integration**: This package is designed to work seamlessly with `GenomicRanges`, `rtracklayer`, and `VariantAnnotation` for tasks like annotating SNPs or calculating coverage over gene regions.

## Reference documentation
- [TxDb.Btaurus.UCSC.bosTau8.refGene](./references/reference_manual.md)