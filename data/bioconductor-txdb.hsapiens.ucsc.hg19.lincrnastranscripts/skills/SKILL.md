---
name: bioconductor-txdb.hsapiens.ucsc.hg19.lincrnastranscripts
description: This package provides a transcript database for human lincRNA transcripts based on the UCSC hg19 genome assembly. Use when user asks to extract genomic ranges for lincRNAs, retrieve exons grouped by transcript, or annotate experimental data with hg19 lincRNA coordinates.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Hsapiens.UCSC.hg19.lincRNAsTranscripts.html
---

# bioconductor-txdb.hsapiens.ucsc.hg19.lincrnastranscripts

## Overview

This skill provides guidance on using the `TxDb.Hsapiens.UCSC.hg19.lincRNAsTranscripts` package. This package is a "Transcript Database" (TxDb) object that serves as an R interface to a prefabricated database of human lincRNA transcripts. It is specifically based on the UCSC `lincRNAsTranscripts` table for the `hg19` (GRCh37) assembly.

## Basic Usage

### Loading the Package
To use the database, you must first load the library. The TxDb object itself shares the same name as the package.

```r
library(TxDb.Hsapiens.UCSC.hg19.lincRNAsTranscripts)

# Assign to a shorter variable for convenience
txdb <- TxDb.Hsapiens.UCSC.hg19.lincRNAsTranscripts
txdb
```

### Inspecting the Database
You can check the metadata and supported seqlevels (chromosomes) to ensure compatibility with your genomic data.

```r
# View metadata
metadata(txdb)

# List chromosomes/sequences
seqlevels(txdb)

# Check the genome build
genome(txdb)
```

## Common Workflows

### Extracting Genomic Features
The primary use of this package is to extract genomic ranges for lincRNAs using standard `GenomicFeatures` functions.

```r
library(GenomicFeatures)

# Get all lincRNA transcripts as a GRanges object
all_tx <- transcripts(txdb)

# Get all exons
all_exons <- exons(txdb)

# Get promoters (e.g., 2kb upstream of TSS)
linc_promoters <- promoters(txdb, upstream=2000, downstream=200)
```

### Grouping Features
You can retrieve features grouped by their relationship (e.g., exons grouped by transcript).

```r
# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by="tx")

# Get transcripts grouped by gene (lincRNA ID)
tx_by_gene <- transcriptsBy(txdb, by="gene")
```

### Overlapping with Experimental Data
Use this TxDb object to annotate your own experimental results (like RNA-seq or ChIP-seq peaks) that are mapped to hg19.

```r
# Example: Find which of your peaks overlap with known lincRNAs
# peaks_gr is your GRanges object
library(IRanges)
overlaps <- findOverlaps(peaks_gr, all_tx)
```

## Tips
- **Genome Version**: Ensure your data is mapped to **hg19**. If your data is in hg38, you must use a different TxDb package or lift over your coordinates.
- **Naming Convention**: This package specifically targets the `lincRNAsTranscripts` track from UCSC, which may differ from the standard `knownGene` track.
- **Filtering**: Use the `columns` and `keytypes` functions to see what identifiers are available for filtering via the `select()` or `transcripts()` functions.

## Reference documentation
- [TxDb.Hsapiens.UCSC.hg19.lincRNAsTranscripts Reference Manual](./references/reference_manual.md)