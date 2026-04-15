---
name: bioconductor-ensdb.rnorvegicus.v79
description: This package provides Ensembl-based genome annotations for Rattus norvegicus based on Ensembl version 79. Use when user asks to retrieve gene, transcript, or exon information, map genomic coordinates, or filter rat genomic features by attributes like biotype or chromosome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EnsDb.Rnorvegicus.v79.html
---

# bioconductor-ensdb.rnorvegicus.v79

name: bioconductor-ensdb.rnorvegicus.v79
description: Provides Ensembl-based genome annotations for Rattus norvegicus (Rat) using the Ensembl version 79 database. Use this skill when you need to retrieve gene, transcript, exon, or genomic coordinate information for the rat genome (Rnor_6.0) within an R environment.

## Overview

The `EnsDb.Rnorvegicus.v79` package is an annotation database (EnsDb) containing genomic information for *Rattus norvegicus* based on Ensembl release 79. It is designed to be used with the `ensembldb` framework, allowing for efficient querying of genomic features, mapping between different identifier types (e.g., Gene IDs to Gene Names), and fetching sequences or coordinates.

## Basic Usage

### Loading the Database
To use the package, load the library. This automatically creates an `EnsDb` object named `EnsDb.Rnorvegicus.v79`.

```r
library(EnsDb.Rnorvegicus.v79)
# View database metadata
EnsDb.Rnorvegicus.v79
```

### Querying Genomic Features
The primary way to interact with this package is through functions provided by the `ensembldb` package.

```r
library(ensembldb)

# Get all genes
gns <- genes(EnsDb.Rnorvegicus.v79)

# Get all transcripts
txs <- transcripts(EnsDb.Rnorvegicus.v79)

# Get exons for a specific gene
exs <- exons(EnsDb.Rnorvegicus.v79, filter = GeneIdFilter("ENSRNOG00000000001"))
```

### Filtering Results
Use filters to narrow down results by chromosome, gene name, or biotype.

```r
# Find genes on chromosome 1 with a specific biotype
filters <- ~ seq_name == "1" & gene_biotype == "protein_coding"
res <- genes(EnsDb.Rnorvegicus.v79, filter = filters)
```

### Mapping Identifiers
You can use the `select` method to map between different attributes.

```r
# Map Ensembl Gene IDs to Gene Names and Symbols
keys <- c("ENSRNOG00000000001", "ENSRNOG00000000002")
select(EnsDb.Rnorvegicus.v79, keys = keys, columns = c("GENENAME", "SYMBOL"), keytype = "GENEID")
```

## Common Workflows

1. **Extracting Promoter Regions**: Use `promoters()` on the `EnsDb` object to get upstream sequences for transcripts.
2. **Coordinate Conversion**: Use `genomeToTranscript()` or `transcriptToGenome()` to map between genomic locations and transcript-relative positions.
3. **Integration with Bioconductor**: The objects returned (like `GRanges`) are compatible with `GenomicRanges`, `Gviz`, and `AnnotationDbi`.

## Tips
- **Version Consistency**: This package is specific to Ensembl release 79. Ensure your experimental data (e.g., FASTQ alignment) was mapped against the corresponding genome build (Rnor_6.0) to avoid coordinate mismatches.
- **Functionality**: Since this is a data-only package, always ensure `library(ensembldb)` is loaded to access the methods for querying the `EnsDb` object.

## Reference documentation
- [EnsDb.Rnorvegicus.v79 Reference Manual](./references/reference_manual.md)