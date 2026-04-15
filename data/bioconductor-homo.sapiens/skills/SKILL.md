---
name: bioconductor-homo.sapiens
description: This tool provides integrated genomic annotations for human data by combining gene metadata, genomic coordinates, and functional annotations into a single interface. Use when user asks to map between database identifiers, retrieve genomic coordinates for genes or exons, or link gene-level data with GO terms.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Homo.sapiens.html
---

# bioconductor-homo.sapiens

name: bioconductor-homo.sapiens
description: Use the Homo.sapiens Bioconductor package to perform integrated genomic annotations for human data. This skill is essential for mapping between different database identifiers (Entrez, Gene Symbol, Ensembl), retrieving genomic coordinates (Exons, Genes, Transcripts), and linking gene-level data with functional annotations (GO terms). Use this when you need a unified interface to OrgDb, TxDb, and GO.db objects for Homo sapiens.

## Overview

The `Homo.sapiens` package is an `OrganismDb` object that acts as a "super-annotation" bundle. It integrates several underlying Bioconductor annotation packages (like `org.Hs.eg.db` and `TxDb.Hsapiens.UCSC.hg19.knownGene`) into a single object. This allows users to query across different data types—such as gene metadata and genomic coordinates—using a consistent set of methods without manually joining tables.

## Core Workflow

The package follows the standard `AnnotationDbi` interface using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Discovery
Before querying, identify what data is available and what identifiers you can use as input.

```r
library(Homo.sapiens)

# See all available data types (e.g., SYMBOL, TXNAME, GO, CHR)
cols <- columns(Homo.sapiens)

# See which columns can be used as input keys
kts <- keytypes(Homo.sapiens)
```

### 2. Data Retrieval
Use `select()` to map identifiers or extract specific genomic information.

```r
# Example: Map Gene Symbols to Entrez IDs and Chromosomes
my_genes <- c("TP53", "BRCA1", "APOE")
res <- select(Homo.sapiens, 
              keys = my_genes, 
              columns = c("ENTREZID", "CHR", "GENENAME"), 
              keytype = "SYMBOL")

# Example: Get GO terms associated with specific Entrez IDs
go_info <- select(Homo.sapiens, 
                  keys = c("1", "2"), 
                  columns = c("GO", "ONTOLOGY"), 
                  keytype = "ENTREZID")
```

### 3. Genomic Coordinates
Since `Homo.sapiens` contains a `TxDb` object, you can use specialized extractors from the `GenomicFeatures` package.

```r
# Extract all genes as a GRanges object
human_genes <- genes(Homo.sapiens)

# Extract exons grouped by gene
human_exons <- exonsBy(Homo.sapiens, by = "gene")
```

## Usage Tips

- **Ambiguous Keys**: When mapping between identifiers (e.g., SYMBOL to ENSEMBL), one key might map to multiple values. Always check the dimensions of your output `data.frame`.
- **Coordinate Systems**: By default, `Homo.sapiens` typically points to a specific UCSC genome build (often hg19). Verify the metadata if your analysis requires hg38.
- **Filtering GO Terms**: When selecting "GO" columns, the result will include Evidence Codes. You may need to filter these (e.g., removing 'IEA' - Inferred from Electronic Annotation) for higher stringency.
- **Performance**: For very large queries, it is often faster to use `keys()` to get all valid identifiers before running a `select()` operation.

## Reference documentation

- [Homo.sapiens Reference Manual](./references/reference_manual.md)