---
name: bioconductor-txdb.mmusculus.ucsc.mm9.knowngene
description: This package provides UCSC mm9 mouse gene annotations as a TxDb object for genomic analysis in R. Use when user asks to retrieve transcripts, exons, CDS, or promoters for the mm9 mouse genome assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmusculus.UCSC.mm9.knownGene.html
---


# bioconductor-txdb.mmusculus.ucsc.mm9.knowngene

name: bioconductor-txdb.mmusculus.ucsc.mm9.knowngene
description: Provides the UCSC mm9 (Mus musculus) gene annotations as a TxDb object. Use this skill when performing genomic analysis in R that requires mouse genome coordinates (build mm9), including retrieving transcripts, exons, CDS, and promoters based on the UCSC knownGene track.

# bioconductor-txdb.mmusculus.ucsc.mm9.knowngene

## Overview
The `TxDb.Mmusculus.UCSC.mm9.knownGene` package is a standard Bioconductor annotation data package. It contains a `TxDb` object which serves as an interface to a prefabricated database of Mus musculus (mouse) gene models. These models are derived from the UCSC mm9 genome assembly and the "knownGene" track. It is primarily used in conjunction with the `GenomicFeatures` and `GenomicRanges` packages to map genomic features to coordinates.

## Usage and Workflows

### Loading the Annotation Data
To use the database, load the library and reference the object by its package name.

```r
library(TxDb.Mmusculus.UCSC.mm9.knownGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Mmusculus.UCSC.mm9.knownGene
txdb
```

### Extracting Genomic Features
Use functions from the `GenomicFeatures` package to extract specific features from the TxDb object.

*   **Extract all transcripts:** `transcripts(txdb)`
*   **Extract all exons:** `exons(txdb)`
*   **Extract all CDS (coding sequences):** `cds(txdb)`
*   **Extract genes:** `genes(txdb)`

### Grouping Features
You can retrieve features grouped by their relationship to other features (e.g., exons grouped by gene).

```r
# Get all exons grouped by gene ID
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get all transcripts grouped by gene ID
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get all exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Retrieving Promoter Regions
Generate promoter sequences (default is 2000bp upstream and 200bp downstream of the TSS).

```r
mouse_promoters <- promoters(txdb, upstream = 2000, downstream = 200)
```

### Coordinate Discovery
To check the chromosome names and lengths associated with this build:

```r
seqlevels(txdb)
seqlengths(txdb)
genome(txdb) # Should return "mm9"
```

## Tips
*   **Identifier Matching:** This package uses Entrez Gene IDs as the primary gene identifier. If you have Ensembl IDs or Gene Symbols, use the `org.Mm.eg.db` package to map them to Entrez IDs before querying this TxDb.
*   **Package Dependency:** Ensure `GenomicFeatures` is loaded to access the extractor functions like `transcripts()` and `exonsBy()`.
*   **Legacy Build:** Note that mm9 is an older assembly (NCBI37). For the more recent mouse assembly, use `TxDb.Mmusculus.UCSC.mm10.knownGene` or `mm39` equivalents unless your data is specifically aligned to mm9.

## Reference documentation
- [TxDb.Mmusculus.UCSC.mm9.knownGene Reference Manual](./references/reference_manual.md)