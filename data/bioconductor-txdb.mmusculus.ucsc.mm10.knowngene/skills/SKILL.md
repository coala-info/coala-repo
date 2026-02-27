---
name: bioconductor-txdb.mmusculus.ucsc.mm10.knowngene
description: This package provides UCSC mm10 mouse gene annotations as a TxDb object for genomic analysis in R. Use when user asks to extract mouse gene coordinates, retrieve transcript structures, or annotate genomic intervals for the mm10 genome build.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmusculus.UCSC.mm10.knownGene.html
---


# bioconductor-txdb.mmusculus.ucsc.mm10.knowngene

name: bioconductor-txdb.mmusculus.ucsc.mm10.knowngene
description: Provides the UCSC mm10 (Mouse) gene annotations as a TxDb object. Use this skill when performing genomic analyses in R that require mouse (Mus musculus) transcript metadata, such as identifying gene coordinates, transcript structures, exons, or introns for the mm10 genome build.

# bioconductor-txdb.mmusculus.ucsc.mm10.knowngene

## Overview
The `TxDb.Mmusculus.UCSC.mm10.knownGene` package is a standard Bioconductor annotation data package. It contains a `TxDb` (Transcript Database) object that serves as an R interface to the UCSC `knownGene` track for the mouse genome build mm10 (GRCm38). This package is essential for workflows involving genomic interval operations, RNA-seq annotation, and peak annotation in mouse studies.

## Usage and Workflows

### Loading the Annotation
To use the database, load the library and reference the object by its package name.

```r
library(TxDb.Mmusculus.UCSC.mm10.knownGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene
txdb
```

### Extracting Genomic Features
The primary use of this skill is to extract `GRanges` or `GRangesList` objects representing different genomic features.

*   **Transcripts:** `transcripts(txdb)`
*   **Exons:** `exons(txdb)`
*   **CDS (Coding Sequences):** `cds(txdb)`
*   **Genes:** `genes(txdb)`

### Grouped Features
Use `transcriptsBy`, `exonsBy`, or `intronsByTranscript` to get features grouped by a parent element.

```r
# Get all exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get all transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get five-prime UTRs grouped by transcript
five_utrs <- fiveUTRsByTranscript(txdb)
```

### Coordinate Queries
Since the object is a `TxDb`, it integrates seamlessly with `GenomicFeatures` and `GenomicRanges`.

```r
library(GenomicFeatures)

# Select specific columns (e.g., chromosome and strand) for specific gene IDs
select(txdb, 
       keys = c("12345", "67890"), 
       columns = c("TXNAME", "TXSTRAND", "TXCHROM"), 
       keytype = "GENEID")
```

## Tips and Best Practices
*   **Genome Build:** Ensure your experimental data (e.g., BAM files or BED files) is aligned to **mm10**. Using this with mm9 or mm39 data will result in incorrect coordinates.
*   **Identifier Mapping:** This package uses Entrez Gene IDs as the primary gene identifier. To map these to Gene Symbols or Ensembl IDs, use the `org.Mm.eg.db` package.
*   **Seqlevels Style:** If your data uses "1" instead of "chr1", use `seqlevelsStyle(txdb) <- "NCBI"` to match styles.

## Reference documentation
- [TxDb.Mmusculus.UCSC.mm10.knownGene](./references/reference_manual.md)