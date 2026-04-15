---
name: bioconductor-txdb.cfamiliaris.ucsc.canfam5.refgene
description: This package provides a Bioconductor TxDb object for the Canis familiaris (dog) UCSC canFam5 genome assembly using refGene annotations. Use when user asks to extract genomic features like genes or exons, map transcripts to genomic coordinates, or perform gene structure analysis for dog research.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Cfamiliaris.UCSC.canFam5.refGene.html
---

# bioconductor-txdb.cfamiliaris.ucsc.canfam5.refgene

name: bioconductor-txdb.cfamiliaris.ucsc.canfam5.refgene
description: Use this skill when working with Canis familiaris (dog) genome annotations in R. It provides access to the TxDb object for the UCSC canFam5 genome build based on the refGene track. Use it for genomic coordinate lookups, transcript mapping, and gene structure analysis for dog research.

## Overview

The `TxDb.Cfamiliaris.UCSC.canFam5.refGene` package is a Bioconductor annotation package that provides a `TxDb` (Transcript Database) object for the dog (*Canis familiaris*) genome. It specifically uses the UCSC `canFam5` assembly and the `refGene` annotation track. This package is essential for bioinformatics workflows involving dog genomic data, such as RNA-Seq, ChIP-Seq, or variant annotation, where mapping between genes, transcripts, exons, and genomic coordinates is required.

## Usage and Workflows

### Loading the Package
To use the annotation database, you must first load the library. The package automatically creates an object with the same name as the package.

```r
library(TxDb.Cfamiliaris.UCSC.canFam5.refGene)
txdb <- TxDb.Cfamiliaris.UCSC.canFam5.refGene
```

### Inspecting the Database
You can view metadata and basic statistics about the database by calling the object directly or using metadata functions.

```r
# View summary
txdb

# Check genome and organism
genome(txdb)
organism(txdb)
```

### Extracting Genomic Features
The primary use of this skill is to extract genomic ranges for various features using the `GenomicFeatures` framework.

*   **Extract all transcripts:** `transcripts(txdb)`
*   **Extract all exons:** `exons(txdb)`
*   **Extract all genes:** `genes(txdb)`
*   **Extract promoters:** `promoters(txdb, upstream=2000, downstream=200)`

### Grouping Features
Often, you need features grouped by a parent element (e.g., all exons belonging to a specific gene).

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")

# Transcripts grouped by gene
transcripts_by_gene <- transcriptsBy(txdb, by="gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by="tx")
```

### Coordinate Mapping and Annotation
This package is frequently used with `GenomicRanges` to annotate experimental data.

```r
library(GenomicRanges)
# Example: Find which genes overlap with a specific genomic region
my_region <- GRanges(seqnames="chr1", ranges=IRanges(start=1000000, end=1050000))
overlaps <- findOverlaps(my_region, genes(txdb))
```

## Tips
*   **Coordinate System:** Ensure your experimental data uses the `canFam5` assembly coordinates. Using this package with `canFam3` or `canFam4` data will result in incorrect mappings.
*   **Naming Convention:** Chromosome names in this package follow the UCSC convention (e.g., "chr1", "chrX"). If your data uses different naming (e.g., "1", "X"), use `seqlevelsStyle(txdb) <- "Ensembl"` or similar to harmonize.
*   **Dependency:** This package works best in conjunction with the `GenomicFeatures` and `AnnotationDbi` packages.

## Reference documentation
- [TxDb.Cfamiliaris.UCSC.canFam5.refGene](./references/reference_manual.md)