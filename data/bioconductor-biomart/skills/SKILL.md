---
name: bioconductor-biomart
description: This tool retrieves genomic data and annotations from BioMart databases like Ensembl using the biomaRt R package. Use when user asks to map gene identifiers, retrieve genomic sequences, fetch SNP information, or perform cross-species homology queries.
homepage: https://bioconductor.org/packages/release/bioc/html/biomaRt.html
---

# bioconductor-biomart

name: bioconductor-biomart
description: Retrieval of genomic data and annotations from BioMart databases (Ensembl, Wormbase, Phytozome) using the biomaRt R package. Use this skill when you need to map gene identifiers (e.g., Entrez, Ensembl, HGNC), retrieve genomic sequences (cDNA, peptide, UTR), fetch SNP information, or perform cross-species homology queries without writing SQL.

# bioconductor-biomart

## Overview

The `biomaRt` package provides a uniform R interface to various BioMart databases. It is primarily used for annotating biological identifiers and retrieving sequences. The workflow typically involves selecting a BioMart service (e.g., Ensembl), choosing a specific dataset (e.g., human genes), and then constructing a query using filters (inputs) and attributes (outputs).

## Core Workflow

### 1. Connecting to a Mart
For Ensembl (the most common use case), use `useEnsembl()`. For other marts, use `useMart()`.

```r
library(biomaRt)

# Connect to the latest Ensembl human genes dataset
ensembl <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")

# Connect to a specific Ensembl mirror if the default is slow
ensembl_east <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl", mirror = "useast")

# Connect to an archived version for reproducibility
listEnsemblArchives()
ensembl_95 <- useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl", version = 95)
```

### 2. Exploring Filters and Attributes
*   **Filters**: The input criteria (e.g., a list of gene IDs).
*   **Attributes**: The data you want to retrieve (e.g., gene symbols, chromosome positions).

```r
# List all available options
filters <- listFilters(ensembl)
attributes <- listAttributes(ensembl)

# Search for specific terms
searchFilters(mart = ensembl, pattern = "hgnc")
searchAttributes(mart = ensembl, pattern = "entrez")
```

### 3. Executing Queries with getBM
The `getBM()` function is the primary workhorse.

```r
# Example: Map Affy IDs to Entrez IDs and HGNC Symbols
affyids <- c("202763_at", "209310_s_at")
results <- getBM(attributes = c('affy_hg_u133_plus_2', 'entrezgene_id', 'hgnc_symbol'),
                 filters = 'affy_hg_u133_plus_2',
                 values = affyids,
                 mart = ensembl)
```

## Specialized Queries

### Retrieving Sequences
Use `getSequence()` for genomic, protein, or flanking sequences.

```r
# Get peptide sequences for Entrez IDs
proteins <- getSequence(id = c("673", "837"),
                        type = "entrezgene_id",
                        seqType = "peptide",
                        mart = ensembl)
```

### Cross-Species Homology
Use `getLDS()` to link two different datasets.

```r
human <- useEnsembl("genes", dataset = "hsapiens_gene_ensembl")
mouse <- useEnsembl("genes", dataset = "mmusculus_gene_ensembl")

# Find mouse homologs for human TP53
homologs <- getLDS(attributes = c("hgnc_symbol"),
                   filters = "hgnc_symbol", 
                   values = "TP53", 
                   mart = human,
                   attributesL = c("ensembl_gene_id"), 
                   martL = mouse)
```

## Troubleshooting & Tips

*   **SSL Errors**: If you encounter "SSL certificate problem", run: `httr::set_config(httr::config(ssl_verifypeer = FALSE))`.
*   **Caching**: `biomaRt` caches results. Use `biomartCacheInfo()` to check status and `biomartCacheClear()` to reset if data seems stale.
*   **Ensembl Genomes**: For non-vertebrates (Plants, Fungi, etc.), use `listEnsemblGenomes()` and `useEnsemblGenomes()`.
*   **Select Interface**: `biomaRt` supports the standard Bioconductor `select()` interface: `select(ensembl, keys = ids, columns = c("hgnc_symbol"), keytype = "ensembl_gene_id")`.

## Reference documentation
- [Accessing Ensembl annotation with biomaRt](./references/accessing_ensembl.md)
- [Using a BioMart other than Ensembl](./references/accessing_other_marts.md)