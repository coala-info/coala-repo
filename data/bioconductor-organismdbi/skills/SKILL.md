---
name: bioconductor-organismdbi
description: OrganismDbi provides a unified interface to integrate and query multiple Bioconductor annotation resources as a single object. Use when user asks to map identifiers across different databases, retrieve genomic ranges with associated gene metadata, or create custom organism-level annotation packages.
homepage: https://bioconductor.org/packages/release/bioc/html/OrganismDbi.html
---

# bioconductor-organismdbi

## Overview

`OrganismDbi` is a meta-framework that provides a seamless interface to multiple Bioconductor annotation resources. It allows users to treat disparate packages (like `org.Hs.eg.db` for gene metadata and `TxDb.Hsapiens.UCSC.hg19.knownGene` for genomic coordinates) as a single object. This eliminates the need for manual merging of data frames when mapping between different identifier types and genomic ranges.

## Core Workflows

### 1. Exploring the Organism Object
Standard `AnnotationDbi` methods are used to explore the available data within an `OrganismDb` object (e.g., `Homo.sapiens`).

```r
library(Homo.sapiens)

# List all available data types (columns) across all linked packages
columns(Homo.sapiens)

# List types of data that can be used as input filters
keytypes(Homo.sapiens)

# Retrieve specific keys for a given keytype
head(keys(Homo.sapiens, keytype = "SYMBOL"))
```

### 2. Unified Data Retrieval with select()
The `select()` function performs joins across the underlying databases automatically.

```r
# Map Entrez IDs to Gene Symbols and UCSC Transcript Names
genes <- c("1", "2", "9")
select(Homo.sapiens, 
       keys = genes, 
       columns = c("SYMBOL", "TXNAME"), 
       keytype = "ENTREZID")
```

### 3. Range-based Queries
`OrganismDbi` extends `GenomicFeatures` methods to return `GRanges` or `GRangesList` objects populated with metadata from the `OrgDb` part of the object.

```r
# Get all transcripts with gene symbols attached
tx_ranges <- transcripts(Homo.sapiens, columns = c("TXNAME", "SYMBOL"))

# Get exons grouped by gene with specific metadata
exons_by_gene <- exonsBy(Homo.sapiens, by = "gene", columns = c("SYMBOL", "ENSEMBL"))
```

### 4. Creating Custom Organism Packages
You can build your own meta-package by defining the relationships (foreign keys) between an `OrgDb`, a `TxDb`, and `GO.db`.

```r
# 1. Define the join graph
# Names of vectors are package names; values are the shared keys (columns)
gd <- list(
  join1 = c(GO.db = "GOID", org.Hs.eg.db = "GO"),
  join2 = c(org.Hs.eg.db = "ENTREZID", TxDb.Hsapiens.UCSC.hg19.knownGene = "GENEID")
)

# 2. Generate the package
destination <- tempdir()
makeOrganismPackage(
  pkgname = "Custom.Organism.db",
  graphData = gd,
  organism = "Homo sapiens",
  version = "1.0.0",
  maintainer = "User <user@example.com>",
  author = "User",
  destDir = destination,
  license = "Artistic-2.0"
)
```

## Usage Tips
- **Unique Columns**: When creating a custom package, all column names across the constituent packages must be unique.
- **Consistency**: Ensure that the `TxDb` and `OrgDb` packages used in a join refer to the same genome build and organism to avoid biological inconsistencies.
- **Memory Efficiency**: `OrganismDbi` packages are "lightweight"—they do not duplicate the data but rather point to the existing installed annotation packages.

## Reference documentation
- [OrganismDbi: A meta framework for Annotation Packages](./references/OrganismDbi.md)