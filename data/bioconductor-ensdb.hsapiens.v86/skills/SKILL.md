---
name: bioconductor-ensdb.hsapiens.v86
description: This package provides Ensembl release 86 genome annotations for Homo sapiens via a local SQLite database. Use when user asks to retrieve human gene models, fetch genomic coordinates for transcripts or exons, filter annotations by biotype or chromosome, or map coordinates between genome and protein features.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EnsDb.Hsapiens.v86.html
---

# bioconductor-ensdb.hsapiens.v86

name: bioconductor-ensdb.hsapiens.v86
description: Provides Ensembl-based genome annotations for Homo sapiens (human) based on Ensembl release 86. Use this skill when you need to retrieve genomic coordinates, gene models, transcripts, exons, or protein information for human genes using the ensembldb framework.

# bioconductor-ensdb.hsapiens.v86

## Overview
The `EnsDb.Hsapiens.v86` package is a Bioconductor annotation data package that provides an interface to a local SQLite database containing Ensembl release 86 annotations for *Homo sapiens*. It is designed to be used with the `ensembldb` package, which provides the functional API to query the database.

## Usage and Workflows

### Loading the Database
To use the annotations, load the library. The database object itself is named `EnsDb.Hsapiens.v86`.

```r
library(EnsDb.Hsapiens.v86)
# View database metadata
EnsDb.Hsapiens.v86
```

### Basic Data Retrieval
Use functions from the `ensembldb` package to extract data. The most common methods are `genes()`, `transcripts()`, `exons()`, and `promoters()`.

```r
# Get all genes as a GRanges object
gns <- genes(EnsDb.Hsapiens.v86)

# Get transcripts for a specific gene
txs <- transcripts(EnsDb.Hsapiens.v86, filter = GeneNameFilter("BRCA1"))
```

### Filtering Results
Filtering is the primary way to subset data. You can use filter objects or filter expressions.

```r
# Filter by chromosome and gene biotype
filters <- ~ seq_name == "X" & gene_biotype == "lincRNA"
linc_x <- genes(EnsDb.Hsapiens.v86, filter = filters)

# Common filters:
# GeneNameFilter(), GeneIdFilter(), SeqNameFilter(), TxBiotypeFilter()
```

### Mapping Coordinates
The package supports mapping between different genomic features (e.g., genome to transcript, protein to genome).

```r
# Map genome coordinates to transcript coordinates
gn_coords <- GRanges("X", IRanges(start = 635000, end = 635500))
mapToTranscripts(gn_coords, EnsDb.Hsapiens.v86)
```

### Integration with tidyverse/data.frame
If you prefer data frames over GRanges, use the `returnFilter` argument or convert the output.

```r
# Get gene information as a data.frame
gene_df <- genes(EnsDb.Hsapiens.v86, return.type = "data.frame")
```

## Tips
- **Version Consistency**: This package is specific to Ensembl release 86 (GRCh38). Ensure your experimental data (e.g., BAM files) was aligned to the same genome build.
- **Functionality**: Since this is a data-only package, always ensure `library(ensembldb)` is available to access the full suite of query methods.
- **Discovery**: Use `listColumns(EnsDb.Hsapiens.v86)` to see all available annotation columns (e.g., "entrezid", "gene_name", "uniprot_id").

## Reference documentation
- [EnsDb.Hsapiens.v86 Reference Manual](./references/reference_manual.md)