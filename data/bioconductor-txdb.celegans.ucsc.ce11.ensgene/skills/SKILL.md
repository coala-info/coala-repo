---
name: bioconductor-txdb.celegans.ucsc.ce11.ensgene
description: This package provides genomic annotation data for Caenorhabditis elegans based on the UCSC ce11 genome build and Ensembl gene track. Use when user asks to retrieve transcript, exon, CDS, or promoter coordinates for C. elegans genes or extract genomic features using the GenomicFeatures framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Celegans.UCSC.ce11.ensGene.html
---

# bioconductor-txdb.celegans.ucsc.ce11.ensgene

name: bioconductor-txdb.celegans.ucsc.ce11.ensgene
description: Provides genomic annotation data for Caenorhabditis elegans (C. elegans) based on the UCSC ce11 genome build and Ensembl gene (ensGene) track. Use this skill when you need to retrieve transcript, exon, CDS, or promoter coordinates for C. elegans genes using the GenomicFeatures framework in R.

# bioconductor-txdb.celegans.ucsc.ce11.ensgene

## Overview

This package is a "TxDb" (Transcript Database) annotation object for *C. elegans*. It serves as an R interface to a prefabricated SQLite database containing genomic locations for gene models. It is specifically built using the UCSC `ce11` genome assembly and the Ensembl `ensGene` track (data snapshot from April 2022).

## Usage

### Loading the Database
To use the annotation data, you must load the library and reference the object by its package name.

```r
library(TxDb.Celegans.UCSC.ce11.ensGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Celegans.UCSC.ce11.ensGene
txdb
```

### Core Data Extraction
Use functions from the `GenomicFeatures` and `GenomicRanges` packages to interact with this object.

**1. Extracting Genomic Features:**
```r
# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons <- exons(txdb)

# Get all Coding Sequences (CDS)
cds <- cds(txdb)

# Get all genes (returns a GRanges object of gene boundaries)
genes <- genes(txdb)
```

**2. Grouping Features:**
Use `transcriptsBy`, `exonsBy`, or `cdsBy` to group features by gene or transcript.

```r
# Get all exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get all transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")
```

**3. Extracting Promoter Regions:**
```r
# Get 2000bp upstream and 200bp downstream of TSS
promoters_gr <- promoters(txdb, upstream = 2000, downstream = 200)
```

### Integration with Other Packages
*   **AnnotationDbi:** Use `select()`, `keys()`, and `columns()` to map Ensembl IDs to other identifiers or to retrieve specific metadata.
*   **Gviz:** Use the TxDb object to create a `GeneRegionTrack` for visualizing *C. elegans* gene models.
*   **bsgenome:** Combine with `BSgenome.Celegans.UCSC.ce11` to extract DNA sequences for specific genomic features.

## Tips
*   **Coordinate System:** This package uses 1-based coordinates (standard for Bioconductor/R).
*   **Naming:** The object name `TxDb.Celegans.UCSC.ce11.ensGene` is long; always check for typos or assign it to a shorter alias like `txdb`.
*   **Metadata:** Run `metadata(txdb)` to see the exact source URLs and creation timestamps for the underlying data.

## Reference documentation
- [TxDb.Celegans.UCSC.ce11.ensGene Reference Manual](./references/reference_manual.md)