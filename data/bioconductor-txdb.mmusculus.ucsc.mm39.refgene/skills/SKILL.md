---
name: bioconductor-txdb.mmusculus.ucsc.mm39.refgene
description: This package provides a transcript database for the mouse mm39 genome build based on UCSC refGene annotations. Use when user asks to extract genomic features like exons or transcripts, group features by gene, or perform genomic annotation for mouse data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmusculus.UCSC.mm39.refGene.html
---

# bioconductor-txdb.mmusculus.ucsc.mm39.refgene

## Overview
This package is a "Transcript Database" (TxDb) resource for the mouse (Mus musculus) genome, specifically the mm39 build. It serves as an R interface to a prefabricated SQLite database containing gene model annotations from the UCSC refGene track. It is primarily used in conjunction with the `GenomicFeatures` and `GenomicRanges` packages to perform genomic arithmetic and annotation.

## Usage and Workflows

### Loading the Annotation
To use the database, you must load the library. The package automatically creates an object with the same name as the package.

```r
library(TxDb.Mmusculus.UCSC.mm39.refGene)

# Assign to a shorter alias for convenience
txdb <- TxDb.Mmusculus.UCSC.mm39.refGene
txdb
```

### Inspecting the Database
You can check the supported chromosomes, coordinate systems, and metadata.

```r
# View genome and organism info
genome(txdb)
organism(txdb)

# List all chromosome names
seqlevels(txdb)
```

### Extracting Genomic Features
The most common use case is extracting GRanges objects for specific feature types using functions from the `GenomicFeatures` package.

```r
library(GenomicFeatures)

# Get all transcripts
all_tx <- transcripts(txdb)

# Get all exons
all_exons <- exons(txdb)

# Get all coding sequences (CDS)
all_cds <- cds(txdb)

# Get all genes (represented by their entrie genomic extent)
all_genes <- genes(txdb)
```

### Grouping Features
Use the `*By` family of functions to get features grouped by a parent feature (e.g., exons grouped by gene).

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Filtering and Selecting
You can use the `select`, `keys`, and `columns` methods (from the `AnnotationDbi` framework) to query specific identifiers.

```r
# List available columns
columns(txdb)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific info for a set of gene IDs
keys_to_query <- c("12345", "67890") # Example Entrez IDs
select(txdb, keys = keys_to_query, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips
- **Coordinate System**: This package uses the UCSC chromosome naming convention (e.g., "chr1", "chrX"). If your data uses Ensembl names ("1", "X"), use `seqlevelsStyle(txdb) <- "Ensembl"` to convert them.
- **Integration**: This TxDb object is often used as an input for `summarizeOverlaps` (GenomicAlignments) or for annotating peaks in ChIP-seq analysis (ChIPseeker).
- **Memory**: The object is a reference to an on-disk SQLite database, making it memory-efficient even though it contains whole-genome annotations.

## Reference documentation
- [TxDb.Mmusculus.UCSC.mm39.refGene](./references/reference_manual.md)