---
name: bioconductor-txdb.celegans.ucsc.ce6.ensgene
description: This package provides an R interface to the UCSC ce6 genome annotation for Caenorhabditis elegans based on the Ensembl gene track. Use when user asks to retrieve C. elegans ce6 genomic coordinates, extract gene models, or group transcripts and exons by gene.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Celegans.UCSC.ce6.ensGene.html
---

# bioconductor-txdb.celegans.ucsc.ce6.ensgene

name: bioconductor-txdb.celegans.ucsc.ce6.ensgene
description: Provides an R interface to the UCSC ce6 genome annotation for Caenorhabditis elegans based on the Ensembl (ensGene) gene track. Use this skill when working with C. elegans genomic coordinates, gene models, transcripts, exons, and introns in R, specifically for the ce6 (WS190) assembly.

# bioconductor-txdb.celegans.ucsc.ce6.ensgene

## Overview

The `TxDb.Celegans.UCSC.ce6.ensGene` package is a Bioconductor annotation package containing a `TxDb` (Transcript Database) object. It provides a structured R interface to the Ensembl gene models for the *C. elegans* ce6 genome assembly. This package is essential for genomic workflows involving feature extraction (e.g., getting all transcript coordinates) or overlapping experimental data (like ChIP-seq or RNA-seq) with known gene structures.

## Usage and Workflows

### Loading the Annotation
To use the database, you must load the library. The `TxDb` object itself has the same name as the package.

```r
library(TxDb.Celegans.UCSC.ce6.ensGene)

# Assign to a shorter alias for convenience
txdb <- TxDb.Celegans.UCSC.ce6.ensGene
txdb
```

### Inspecting the Database
You can check the supported chromosomes, genome build, and available metadata.

```r
seqlevels(txdb)
genome(txdb)
metadata(txdb)
```

### Extracting Genomic Features
The primary use of this skill is to extract `GRanges` or `GRangesList` objects representing different genomic features.

*   **Transcripts:** `transcripts(txdb)`
*   **Exons:** `exons(txdb)`
*   **CDS (Coding Sequences):** `cds(txdb)`
*   **Genes:** `genes(txdb)`

### Grouping Features
Use `transcriptsBy`, `exonsBy`, or `cdsBy` to group features by a parent feature (e.g., all exons belonging to a specific gene).

```r
# Get all exons grouped by gene
exons_by_gene <- exons_by(txdb, by = "gene")

# Get all transcripts grouped by gene
transcripts_by_gene <- transcriptsBy(txdb, by = "gene")
```

### Filtering and Selecting
You can use the `select`, `keys`, and `columns` interface common to AnnotationDbi objects to retrieve specific information.

```r
# List available columns
columns(txdb)

# Retrieve specific transcript names for a set of gene IDs
keys <- c("WBGene00000001", "WBGene00000002")
select(txdb, keys = keys, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips for Success
*   **Coordinate System:** Ensure your experimental data is aligned to the **ce6** assembly. Using this package with ce10 or ce11 data will result in incorrect mappings.
*   **Naming Convention:** This package uses Ensembl identifiers (ensGene track). If you need to map these to WormBase IDs or Gene Symbols, use a complementary package like `org.Ce.eg.db`.
*   **GenomicRanges:** Most outputs are `GRanges` objects. Use the `GenomicRanges` library to perform overlaps, find nearest genes, or calculate distances.

## Reference documentation
- [TxDb.Celegans.UCSC.ce6.ensGene](./references/reference_manual.md)