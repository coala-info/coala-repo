---
name: bioconductor-txdb.ptroglodytes.ucsc.pantro4.refgene
description: This package provides a Bioconductor TxDb object containing Chimpanzee (Pan troglodytes) gene models for the UCSC panTro4 assembly. Use when user asks to extract genomic features, retrieve gene models, or perform transcript analysis for the Chimpanzee genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Ptroglodytes.UCSC.panTro4.refGene.html
---


# bioconductor-txdb.ptroglodytes.ucsc.pantro4.refgene

name: bioconductor-txdb.ptroglodytes.ucsc.pantro4.refgene
description: Use this skill when working with the Pan troglodytes (Chimpanzee) genome annotation in R. It provides access to the TxDb object for the UCSC panTro4 assembly based on the refGene track. Use it for genomic coordinate lookups, transcript analysis, and gene model extraction for Chimpanzee.

## Overview

The `TxDb.Ptroglodytes.UCSC.panTro4.refGene` package is a Bioconductor annotation resource that exposes a `TxDb` (Transcript Database) object. This object contains the gene models (exons, introns, transcripts, and coding sequences) for the *Pan troglodytes* (Chimpanzee) genome, specifically the `panTro4` assembly, as defined by the UCSC `refGene` track.

## Basic Usage

### Loading the Package
To use the database, you must first load the library. The TxDb object is automatically instantiated with the same name as the package.

```r
library(TxDb.Ptroglodytes.UCSC.panTro4.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Ptroglodytes.UCSC.panTro4.refGene
txdb
```

### Inspecting the Database
You can check the metadata and supported chromosomes:

```r
# View metadata
metadata(txdb)

# List active chromosomes/sequences
seqlevels(txdb)

# Check the genome build
genome(txdb)
```

## Common Workflows

### Extracting Genomic Features
The primary use of this package is to extract `GRanges` or `GRangesList` objects for various genomic features using the `GenomicFeatures` framework.

```r
library(GenomicFeatures)

# Get all genes
panTro4_genes <- genes(txdb)

# Get all transcripts
panTro4_tx <- transcripts(txdb)

# Get all exons
panTro4_exons <- exons(txdb)

# Get promoters (e.g., 2kb upstream of TSS)
panTro4_promoters <- promoters(txdb, upstream=2000, downstream=200)
```

### Grouping Features
To understand the relationship between genes and their components, use the `*By` functions:

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by="gene")

# Get five-prime UTRs grouped by transcript
five_utrs <- fiveUTRsByTranscript(txdb)
```

### Filtering Data
You can use `AnnotationFilter` to retrieve specific subsets of the data.

```r
library(AnnotationFilter)

# Get features for a specific gene ID
specific_gene <- genes(txdb, filter=list(GeneIdFilter("100610357")))
```

## Tips for Success
- **Coordinate System**: Ensure your experimental data is also based on the `panTro4` assembly. If using `panTro5` or `panTro6`, coordinates will not match.
- **Naming Convention**: UCSC uses the "chr" prefix (e.g., "chr1", "chr2A", "chr2B"). Use `seqlevelsStyle(txdb) <- "Ensembl"` if you need to convert to numeric/Ensembl styles.
- **Integration**: This package is designed to work seamlessly with `GenomicRanges`, `Gviz` (for visualization), and `VariantAnnotation`.

## Reference documentation
- [TxDb.Ptroglodytes.UCSC.panTro4.refGene Reference Manual](./references/reference_manual.md)