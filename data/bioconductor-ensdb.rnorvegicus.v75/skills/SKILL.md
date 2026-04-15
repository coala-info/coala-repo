---
name: bioconductor-ensdb.rnorvegicus.v75
description: This package provides Ensembl-based genome annotations for Rattus norvegicus using the Ensembl version 75 database. Use when user asks to retrieve gene, transcript, or exon information, map genomic identifiers, or query coordinate data for the Rnor_5.0 rat assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EnsDb.Rnorvegicus.v75.html
---

# bioconductor-ensdb.rnorvegicus.v75

name: bioconductor-ensdb.rnorvegicus.v75
description: Provides Ensembl-based genome annotations for Rattus norvegicus (Rat) using the EnsDb.Rnorvegicus.v75 Bioconductor package. Use this skill when you need to retrieve gene, transcript, exon, or genomic coordinate information for the Rnor_5.0 (Ensembl version 75) assembly.

# bioconductor-ensdb.rnorvegicus.v75

## Overview
The `EnsDb.Rnorvegicus.v75` package is an annotation database containing Ensembl version 75 data for the Rat (*Rattus norvegicus*) genome. It provides an `EnsDb` object that serves as an interface to an SQLite database. This package is primarily used in conjunction with the `ensembldb` package to query genomic features, map identifiers, and retrieve sequence coordinates.

## Installation and Loading
To use this annotation package, ensure both the data package and the interface package are installed:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("EnsDb.Rnorvegicus.v75")
BiocManager::install("ensembldb")

library(EnsDb.Rnorvegicus.v75)
library(ensembldb)
```

## Typical Workflows

### 1. Accessing the Database Object
The package automatically creates an object named `EnsDb.Rnorvegicus.v75` upon loading.

```r
# View database metadata
EnsDb.Rnorvegicus.v75

# List available information
listColumns(EnsDb.Rnorvegicus.v75)
listTables(EnsDb.Rnorvegicus.v75)
```

### 2. Retrieving Genomic Features
Use functions from the `ensembldb` package to extract data. Common functions include `genes()`, `transcripts()`, `exons()`, and `cds()`.

```r
# Get all genes as a GRanges object
rat_genes <- genes(EnsDb.Rnorvegicus.v75)

# Get transcripts for a specific gene
rat_tx <- transcripts(EnsDb.Rnorvegicus.v75, filter = GeneNameFilter("Bdnf"))
```

### 3. Filtering Data
Filters allow for precise data retrieval. Common filters include `GeneNameFilter`, `GeneIdFilter`, `SeqNameFilter`, and `TxBiotypeFilter`.

```r
# Filter for protein coding genes on chromosome 1
filter_logic <- ~ seq_name == "1" & gene_biotype == "protein_coding"
pc_genes_chr1 <- genes(EnsDb.Rnorvegicus.v75, filter = filter_logic)
```

### 4. Mapping Identifiers
Convert between different genomic identifiers or retrieve coordinates for specific IDs.

```r
# Map Gene Symbols to Ensembl IDs
select(EnsDb.Rnorvegicus.v75, 
       keys = c("Bdnf", "Gfap"), 
       keytype = "GENENAME", 
       columns = c("GENEID", "SEQNAME", "GENEBIOTYPE"))
```

### 5. Coordinate Mapping
Map between genome, transcript, and protein coordinates.

```r
# Example: Get genome coordinates for a specific transcript
tx_coords <- cdsBy(EnsDb.Rnorvegicus.v75, by = "tx", filter = TxIdFilter("ENSRNOT00000000001"))
```

## Tips
- **Version Specificity**: This package is based on Ensembl 75. If your data was aligned to a newer genome assembly (e.g., Rnor_6.0 or mRatBN7.2), use a more recent `EnsDb` package.
- **Backend**: Since this is an `EnsDb` object, you can use standard `AnnotationDbi` methods like `select()`, `keys()`, `columns()`, and `mapIds()`.
- **Performance**: For large-scale queries, using the `filter` argument within `genes()` or `transcripts()` is more efficient than retrieving all features and filtering the resulting GRanges object manually.

## Reference documentation
- [EnsDb.Rnorvegicus.v75 Reference Manual](./references/reference_manual.md)