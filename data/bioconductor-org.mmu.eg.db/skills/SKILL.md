---
name: bioconductor-org.mmu.eg.db
description: This package provides genome-wide annotations and identifier mappings for Rhesus macaque (Macaca mulatta). Use when user asks to map between gene identifiers like Entrez, Ensembl, and Symbols, retrieve functional annotations such as GO and KEGG terms, or find chromosomal locations for M. mulatta genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Mmu.eg.db.html
---


# bioconductor-org.mmu.eg.db

name: bioconductor-org.mmu.eg.db
description: Genome-wide annotation for Rhesus macaque (Macaca mulatta). Use this skill when you need to map between different gene identifiers (Entrez, Ensembl, Symbol, RefSeq), find chromosomal locations, or retrieve functional annotations (GO, KEGG) for M. mulatta genes in R.

# bioconductor-org.mmu.eg.db

## Overview
The `org.Mmu.eg.db` package is a Bioconductor annotation hub for *Macaca mulatta* (Rhesus macaque). It primarily uses Entrez Gene identifiers as the central keys to map to various other biological data types. It is built on the `AnnotationDbi` framework, meaning it supports the standard `select()`, `keys()`, `columns()`, and `mapIds()` interface.

## Core Workflows

### 1. Loading the Package
```r
library(org.Mmu.eg.db)
```

### 2. Exploring Available Data
To see what types of data (columns) can be retrieved and what keys are available:
```r
# List all available annotation types
columns(org.Mmu.eg.db)

# List the types of keys that can be used as input
keytypes(org.Mmu.eg.db)

# Get a sample of Entrez IDs (default keys)
head(keys(org.Mmu.eg.db))
```

### 3. Mapping Identifiers using select()
The `select()` function is the most flexible way to retrieve data.
```r
# Map Entrez IDs to Gene Symbols and Ensembl IDs
gene_ids <- c("693354", "693355", "693357")
results <- select(org.Mmu.eg.db, 
                  keys = gene_ids, 
                  columns = c("SYMBOL", "ENSEMBL", "GENENAME"), 
                  keytype = "ENTREZID")
```

### 4. Using mapIds() for 1-to-1 Mapping
If you need a simple named vector and want to control how multi-mapping is handled:
```r
# Get a single Symbol for each Entrez ID
symbols <- mapIds(org.Mmu.eg.db,
                  keys = gene_ids,
                  column = "SYMBOL",
                  keytype = "ENTREZID",
                  multiVals = "first")
```

### 5. Functional Annotation (GO and KEGG)
```r
# Retrieve Gene Ontology (GO) terms for specific genes
go_annots <- select(org.Mmu.eg.db, 
                    keys = gene_ids, 
                    columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                    keytype = "ENTREZID")

# Retrieve KEGG Pathway IDs
kegg_annots <- select(org.Mmu.eg.db, 
                      keys = gene_ids, 
                      columns = "PATH", 
                      keytype = "ENTREZID")
```

### 6. Chromosomal Locations
```r
# Get start positions and chromosomes
locs <- select(org.Mmu.eg.db, 
               keys = gene_ids, 
               columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
               keytype = "ENTREZID")
```

## Tips and Best Practices
- **Gene Symbols:** Avoid using Symbols as primary keys for large-scale mapping because they can be redundant or change over time. Use Entrez IDs or Ensembl IDs for stability.
- **Alias Mapping:** If you have non-official symbols, use `keytype = "ALIAS"` to find the corresponding Entrez IDs.
- **Bimap Interface:** While "old style" Bimaps (e.g., `org.Mmu.egSYMBOL`) still exist, the `select()` interface is preferred for consistency.
- **Database Connection:** You can inspect the underlying SQLite metadata using `org.Mmu.eg_dbInfo()`.

## Reference documentation
- [org.Mmu.eg.db Reference Manual](./references/reference_manual.md)