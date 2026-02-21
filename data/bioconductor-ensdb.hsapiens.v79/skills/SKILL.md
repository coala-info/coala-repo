---
name: bioconductor-ensdb.hsapiens.v79
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EnsDb.Hsapiens.v79.html
---

# bioconductor-ensdb.hsapiens.v79

name: bioconductor-ensdb.hsapiens.v79
description: Provides Ensembl-based genome annotations for Homo sapiens (human) based on Ensembl release 79. Use this skill when you need to retrieve gene, transcript, exon, or protein annotations, genomic coordinates (GRCh38), or map between different biological identifiers using the EnsDb framework in R.

# bioconductor-ensdb.hsapiens.v79

## Overview
The `EnsDb.Hsapiens.v79` package is a Bioconductor annotation data package that provides a local SQL database containing Ensembl annotations (version 79) for *Homo sapiens*. It is built on the `ensembldb` framework, allowing for efficient querying of genomic features such as genes, transcripts, and exons using standard R/Bioconductor objects like `GRanges`.

## Core Usage

### Loading the Database
To use the package, load the library. The database object `EnsDb.Hsapiens.v79` is automatically made available.

```r
library(EnsDb.Hsapiens.v79)
# View database metadata
EnsDb.Hsapiens.v79
```

### Basic Data Retrieval
Use functions from the `ensembldb` package to interact with this object:

*   **Get all genes:** `genes(EnsDb.Hsapiens.v79)`
*   **Get all transcripts:** `transcripts(EnsDb.Hsapiens.v79)`
*   **Get all exons:** `exons(EnsDb.Hsapiens.v79)`

### Filtering Results
Filtering is the most powerful way to use an `EnsDb`. You can filter by gene name, ID, chromosome, or biotype.

```r
# Filter for a specific gene by symbol
genes(EnsDb.Hsapiens.v79, filter = GeneNameFilter("BRCA1"))

# Filter for protein-coding genes on chromosome X
genes(EnsDb.Hsapiens.v79, filter = list(SeqNameFilter("X"), GeneBiotypeFilter("protein_coding")))
```

### Mapping Identifiers
The package allows mapping between different feature levels (e.g., finding all transcripts for a specific gene).

```r
# Get all transcripts for a specific gene ID
transcripts(EnsDb.Hsapiens.v79, filter = GeneIdFilter("ENSG00000139618"))

# Map protein IDs to genome coordinates
# (Requires ensembldb functions)
```

## Typical Workflow: Annotation of Results
If you have a list of Ensembl Gene IDs from a differential expression analysis (like DESeq2), use this package to add symbols and coordinates:

```r
gene_ids <- c("ENSG00000139618", "ENSG00000106462")
gene_info <- select(EnsDb.Hsapiens.v79, 
                    keys = gene_ids, 
                    keytype = "GENEID", 
                    columns = c("SYMBOL", "GENEBIOTYPE", "SEQNAME"))
```

## Tips
*   **Genome Build:** This package (v79) corresponds to the **GRCh38** assembly.
*   **Functionality:** Most actual work is performed using methods defined in the `ensembldb` package. If a function like `genes()` or `select()` isn't working, ensure `library(ensembldb)` is also called.
*   **Performance:** Using `filter` arguments inside the retrieval functions is generally faster than retrieving all features and filtering the resulting `GRanges` object manually.

## Reference documentation
- [EnsDb.Hsapiens.v79 Reference Manual](./references/reference_manual.md)