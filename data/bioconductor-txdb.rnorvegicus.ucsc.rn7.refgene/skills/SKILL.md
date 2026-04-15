---
name: bioconductor-txdb.rnorvegicus.ucsc.rn7.refgene
description: This package provides a transcript-centric annotation database for the Rattus norvegicus rn7 genome build based on the UCSC refGene track. Use when user asks to extract genomic features like exons or promoters, group transcripts by gene, or annotate rat genomic coordinates using the rn7 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Rnorvegicus.UCSC.rn7.refGene.html
---

# bioconductor-txdb.rnorvegicus.ucsc.rn7.refgene

name: bioconductor-txdb.rnorvegicus.ucsc.rn7.refgene
description: Provides the TxDb annotation object for Rattus norvegicus (Rat) based on the UCSC rn7 genome build and refGene track. Use this skill when performing genomic analyses in R that require transcript-centric annotations for the rn7 rat genome, such as identifying gene boundaries, exons, introns, and promoter regions.

# bioconductor-txdb.rnorvegicus.ucsc.rn7.refgene

## Overview

This skill guides the use of the `TxDb.Rnorvegicus.UCSC.rn7.refGene` Bioconductor package. This package is a "Transcript Database" (TxDb) object, which serves as an R interface to a prefabricated SQLite database containing genomic coordinates for the Rattus norvegicus (rn7) genome. The data is sourced from the UCSC Genome Browser's `refGene` table.

## Core Usage

### Loading the Package
To access the annotation object, load the library:

```r
library(TxDb.Rnorvegicus.UCSC.rn7.refGene)
```

### Accessing the TxDb Object
The package exposes a single primary object named `TxDb.Rnorvegicus.UCSC.rn7.refGene`. You can inspect its metadata and genome build information by simply calling the object name:

```r
# Display object summary
TxDb.Rnorvegicus.UCSC.rn7.refGene
```

### Common Workflows

The TxDb object is designed to work with the `GenomicFeatures` and `GenomicRanges` frameworks.

#### 1. Extracting Genomic Features
Use standard `GenomicFeatures` accessor functions to extract specific features:

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(TxDb.Rnorvegicus.UCSC.rn7.refGene)

# Get all exons
exons <- exons(TxDb.Rnorvegicus.UCSC.rn7.refGene)

# Get all genes (returns GRanges)
genes <- genes(TxDb.Rnorvegicus.UCSC.rn7.refGene)

# Get promoters (e.g., 2kb upstream of TSS)
promoters <- promoters(TxDb.Rnorvegicus.UCSC.rn7.refGene, upstream=2000, downstream=200)
```

#### 2. Grouping Features
To understand the relationship between features (e.g., which exons belong to which gene), use the `By` family of functions:

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(TxDb.Rnorvegicus.UCSC.rn7.refGene, by="gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(TxDb.Rnorvegicus.UCSC.rn7.refGene, by="gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(TxDb.Rnorvegicus.UCSC.rn7.refGene, by="tx")
```

#### 3. Coordinate Mapping and Overlaps
This object is frequently used with `findOverlaps` to annotate experimental data (like RNA-seq or ChIP-seq peaks) with rat gene models:

```r
# Example: Find which genes overlap with a set of query ranges
# hits <- findOverlaps(query_ranges, genes)
```

## Tips and Best Practices
- **Genome Version**: Ensure your experimental data is aligned to the **rn7** genome build. Using this package with rn6 or other builds will result in incorrect coordinate mapping.
- **Identifier Types**: The `refGene` track typically uses RefSeq identifiers. If you need to map these to Ensembl IDs or Gene Symbols, use the `org.Rn.eg.db` package in conjunction with this TxDb.
- **Package Contents**: You can verify the objects loaded by the package using `ls('package:TxDb.Rnorvegicus.UCSC.rn7.refGene')`.

## Reference documentation
- [TxDb.Rnorvegicus.UCSC.rn7.refGene Reference Manual](./references/reference_manual.md)