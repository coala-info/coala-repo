---
name: bioconductor-ensdb.mmusculus.v75
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EnsDb.Mmusculus.v75.html
---

# bioconductor-ensdb.mmusculus.v75

name: bioconductor-ensdb.mmusculus.v75
description: Provides Ensembl-based genome annotations for Mus musculus (mouse) from Ensembl version 75. Use this skill when an AI agent needs to retrieve genomic features (genes, transcripts, exons), map genomic coordinates, or perform functional annotation for mouse data using the ensembldb framework in R.

## Overview

The `EnsDb.Mmusculus.v75` package is an annotation database (EnsDb) containing Ensembl version 75 data for the mouse genome. It is designed to work seamlessly with the `ensembldb` package, providing a structured SQL-backed interface to genomic features. This specific version corresponds to the GRCm38 assembly.

## Core Usage

### Loading the Database
To use the annotations, load the library and access the automatically created `EnsDb` object.

```r
library(EnsDb.Mmusculus.v75)

# The database object is named after the package
edb <- EnsDb.Mmusculus.v75
print(edb)
```

### Retrieving Genomic Features
Use standard `ensembldb` functions to extract data. These functions return `GRanges` or `data.frame` objects.

```r
# Get all genes
gns <- genes(edb)

# Get all transcripts
txs <- transcripts(edb)

# Get exons for a specific gene
exs <- exons(edb, filter = GeneNameFilter("Brca1"))
```

### Filtering Data
Filtering is the primary way to query specific subsets of the database.

```r
# Filter by chromosome and biotype
filters <- ~ seq_name == "X" & gene_biotype == "lincRNA"
lincRNAs_X <- genes(edb, filter = filters)

# Common filters:
# GeneNameFilter(), GeneIdFilter(), SeqNameFilter(), 
# TxBiotypeFilter(), EntrezFilter()
```

### Mapping and Conversion
The package supports mapping between different genomic identifiers and coordinates.

```r
# Map protein IDs to genome coordinates
# (Requires ensembldb functions)
prot_coords <- proteinToGenome("ENSMUSP00000012345", edb)

# Get a mapping table between Gene IDs and Entrez IDs
mapping <- select(edb, keys = "Brca1", keytype = "GENENAME", 
                  columns = c("GENEID", "ENTREZID"))
```

## Workflow Tips

1.  **Dependency**: This package is a data container. Most functional logic (like `genes()`, `transcripts()`, or `select()`) is defined in the `ensembldb` package. Ensure `library(ensembldb)` is called if specific methods are not dispatched.
2.  **Genome Build**: Version 75 corresponds to the GRCm38/mm10 assembly. Ensure your experimental data (e.g., BAM files or peak calls) uses the same coordinate system.
3.  **Performance**: For large-scale queries, use `columns` in the `genes()` or `transcripts()` functions to return only the metadata needed, which reduces memory overhead.
4.  **Discovery**: Use `listColumns(edb)` to see all available metadata fields (e.g., "gene_name", "description", "seq_name").

## Reference documentation

- [EnsDb.Mmusculus.v75 Reference Manual](./references/reference_manual.md)