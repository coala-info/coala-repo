---
name: bioconductor-txdb.rnorvegicus.ucsc.rn6.ncbirefseq
description: This package provides a TxDb object containing Rattus norvegicus gene models and transcript annotations based on the UCSC rn6 assembly and NCBI RefSeq track. Use when user asks to retrieve gene models, extract transcript coordinates, get exon or CDS regions, or group genomic features by gene for the rat genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Rnorvegicus.UCSC.rn6.ncbiRefSeq.html
---


# bioconductor-txdb.rnorvegicus.ucsc.rn6.ncbirefseq

name: bioconductor-txdb.rnorvegicus.ucsc.rn6.ncbirefseq
description: Provides access to the UCSC rn6 ncbiRefSeq transcript database for Rattus norvegicus (Rat). Use this skill when performing genomic analysis in R that requires gene models, transcript coordinates, exon locations, or CDS regions for the rat genome (rn6) based on NCBI RefSeq annotations.

# bioconductor-txdb.rnorvegicus.ucsc.rn6.ncbirefseq

## Overview
This package provides a `TxDb` object containing the gene models for *Rattus norvegicus* based on the UCSC rn6 genome assembly and the `ncbiRefSeq` track. It is a standardized annotation container used within the Bioconductor ecosystem to facilitate genomic range operations.

## Basic Usage

### Loading the Database
To use the annotation data, load the library and reference the object:

```r
library(TxDb.Rnorvegicus.UCSC.rn6.ncbiRefSeq)

# Assign to a shorter variable for convenience
txdb <- TxDb.Rnorvegicus.UCSC.rn6.ncbiRefSeq
txdb
```

### Extracting Genomic Features
Use functions from the `GenomicFeatures` package to extract specific features as `GRanges` objects:

```r
# Get all genes
gn <- genes(txdb)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
ex <- exons(txdb)

# Get coding sequences
cds_regions <- cds(txdb)
```

### Grouping Features
To get features grouped by a parent feature (e.g., all exons belonging to a specific gene), use the "By" family of functions:

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Querying the Database
Use `select`, `keys`, and `columns` to retrieve specific metadata or map identifiers:

```r
# List available columns
columns(txdb)

# List available key types (usually GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific transcript info for a set of Gene IDs
keys_list <- head(keys(txdb, "GENEID"))
select(txdb, keys = keys_list, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Typical Workflows

### Overlapping with Experimental Data
If you have a `GRanges` object of experimental peaks (e.g., ChIP-seq), you can find which genes they overlap:

```r
library(GenomicRanges)
# Assuming 'my_peaks' is your GRanges object
overlaps <- findOverlaps(my_peaks, genes(txdb))
```

### Extracting Promoter Regions
```r
# Get 2kb upstream of all transcription start sites
proms <- promoters(txdb, upstream = 2000, downstream = 200)
```

## Tips
- **Coordinate System**: This package uses UCSC chromosome naming (e.g., "chr1", "chr2"). Ensure your experimental data uses the same naming convention or use `seqlevelsStyle()` to harmonize them.
- **Package Dependency**: Most functions used to interact with this object (like `genes()`, `exons()`) are defined in the `GenomicFeatures` package.
- **Genome Build**: This is specifically for **rn6**. Do not use this for rn7 or older builds like rn5.

## Reference documentation
- [TxDb.Rnorvegicus.UCSC.rn6.ncbiRefSeq](./references/reference_manual.md)