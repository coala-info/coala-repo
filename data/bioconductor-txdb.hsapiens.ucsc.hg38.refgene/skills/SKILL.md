---
name: bioconductor-txdb.hsapiens.ucsc.hg38.refgene
description: This package provides genomic annotation data for the human genome assembly hg38 based on the UCSC refGene track. Use when user asks to retrieve transcript, exon, or gene coordinates, extract coding sequences, or group genomic features by gene or transcript for the hg38 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Hsapiens.UCSC.hg38.refGene.html
---

# bioconductor-txdb.hsapiens.ucsc.hg38.refgene

name: bioconductor-txdb.hsapiens.ucsc.hg38.refgene
description: Provides genomic annotation data for Homo sapiens (hg38) based on the UCSC refGene track. Use this skill when an AI agent needs to retrieve transcript, exon, or gene coordinates, map genomic features, or perform overlap analysis using the TxDb.Hsapiens.UCSC.hg38.refGene Bioconductor package in R.

# bioconductor-txdb.hsapiens.ucsc.hg38.refgene

## Overview
The `TxDb.Hsapiens.UCSC.hg38.refGene` package is a standard Bioconductor annotation resource. It contains a `TxDb` (Transcript Database) object that provides a structured R interface to the UCSC `refGene` table for the hg38 (GRCh38) human genome assembly. It is primarily used for genomic range operations, such as identifying the locations of genes, transcripts, exons, and CDS regions.

## Usage Guidelines

### Loading the Package
To use the database, load the library. The package automatically instantiates a `TxDb` object with the same name as the package.

```r
library(TxDb.Hsapiens.UCSC.hg38.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Hsapiens.UCSC.hg38.refGene
```

### Inspecting the Database
You can view metadata and the chromosome information (seqlevels) to ensure compatibility with your genomic data.

```r
# View summary information
txdb

# Check chromosome names and lengths
seqlevels(txdb)
seqlengths(txdb)
```

### Extracting Genomic Features
Use the standard `GenomicFeatures` accessor functions to extract data as `GRanges` or `GRangesList` objects.

```r
# Extract all genes
human_genes <- genes(txdb)

# Extract all transcripts
human_tx <- transcripts(txdb)

# Extract all exons
human_exons <- exons(txdb)

# Extract CDS (Coding Sequences)
human_cds <- cds(txdb)
```

### Grouping Features
To understand the relationship between features (e.g., which exons belong to which transcript), use the `By` family of functions.

```r
# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get five-prime UTRs grouped by transcript
five_utrs <- fiveUTRsByTranscript(txdb)
```

### Common Workflows

#### 1. Finding Features in a Specific Region
Combine this skill with `GenomicRanges` to find genes in a specific genomic interval.

```r
library(GenomicRanges)
roi <- GRanges("chr1", IRanges(start = 1000000, end = 2000000))
overlaps <- subsetByOverlaps(genes(txdb), roi)
```

#### 2. Mapping Identifiers
The `refGene` table typically uses Entrez Gene IDs or RefSeq accessions. If you need to map these to Gene Symbols, use this package in conjunction with `org.Hs.eg.db`.

```r
# Example: Get gene IDs from the TxDb
gene_ids <- names(genes(txdb))
```

## Tips and Best Practices
- **Genome Version**: Ensure your input data is aligned to **hg38/GRCh38**. Using this package with hg19 data will result in incorrect coordinates.
- **Naming Convention**: UCSC uses the "chr" prefix (e.g., "chr1"). If your data uses "1", use `seqlevelsStyle(txdb) <- "NCBI"` to harmonize styles.
- **Memory**: The object is a wrapper around a SQLite database; it is memory-efficient as data is fetched on demand.

## Reference documentation
- [TxDb.Hsapiens.UCSC.hg38.refGene Reference Manual](./references/reference_manual.md)