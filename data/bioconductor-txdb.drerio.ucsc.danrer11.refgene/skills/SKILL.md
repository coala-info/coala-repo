---
name: bioconductor-txdb.drerio.ucsc.danrer11.refgene
description: This package provides a Bioconductor TxDb annotation object for the Danio rerio (Zebrafish) genome based on the UCSC danRer11 refGene track. Use when user asks to retrieve genomic coordinates for zebrafish transcripts, exons, CDS, or promoters, group features by gene or transcript, or perform genomic overlaps using the danRer11 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Drerio.UCSC.danRer11.refGene.html
---

# bioconductor-txdb.drerio.ucsc.danrer11.refgene

name: bioconductor-txdb.drerio.ucsc.danrer11.refgene
description: Provides the TxDb annotation object for Danio rerio (Zebrafish) based on the UCSC danRer11 genome build and the refGene track. Use this skill when you need to retrieve genomic coordinates for transcripts, exons, CDS, or promoters in Zebrafish, or when performing genomic overlaps and gene-centric analyses using Bioconductor's GenomicFeatures framework.

# bioconductor-txdb.drerio.ucsc.danrer11.refgene

## Overview
This package is a standard Bioconductor Transcript Database (TxDb) object. It serves as an R interface to a prefabricated database containing genomic locations for Danio rerio (Zebrafish). The data is derived from the UCSC danRer11 assembly using the `refGene` track. It is primarily used in conjunction with the `GenomicFeatures` and `GenomicRanges` packages to facilitate genomic data science workflows.

## Basic Usage

### Loading the Database
To use the database, load the library and reference the object by its package name.

```r
library(TxDb.Drerio.UCSC.danRer11.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Drerio.UCSC.danRer11.refGene
txdb
```

### Inspecting the Object
You can check the genome build, organism, and chromosome information:

```r
genome(txdb)
seqlevels(txdb)
```

## Common Workflows

### Extracting Genomic Features
Use standard `GenomicFeatures` accessor functions to extract GRanges objects.

```r
library(GenomicFeatures)

# Get all transcripts
all_tx <- transcripts(txdb)

# Get all exons
all_exons <- exons(txdb)

# Get all Coding Sequences (CDS)
all_cds <- cds(txdb)

# Get promoters (default 2000bp upstream, 200bp downstream)
proms <- promoters(txdb, upstream=2000, downstream=200)
```

### Grouping Features by Gene or Transcript
Often, you need features grouped by their parent entity (e.g., all exons belonging to a specific gene).

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by="gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by="tx")
```

### Filtering by Specific Chromosomes
To limit analysis to standard chromosomes (e.g., chr1 to chr25):

```r
# Keep only standard chromosomes
txdb_std <- keepStandardChromosomes(txdb, pruning.mode="tidy")
```

## Tips and Best Practices
- **Coordinate System**: This package uses 1-based closed intervals (standard for Bioconductor/R), whereas UCSC underlying files are often 0-based half-open. The conversion is handled automatically by the package.
- **Naming Convention**: The object name `TxDb.Drerio.UCSC.danRer11.refGene` follows the Bioconductor naming convention: `TxDb.[Organism].[Source].[Build].[Track]`.
- **Integration**: This skill is most powerful when used with `org.Dr.eg.db` to map RefSeq/UCSC IDs to Gene Symbols or Entrez IDs.

## Reference documentation
- [TxDb.Drerio.UCSC.danRer11.refGene Reference Manual](./references/reference_manual.md)