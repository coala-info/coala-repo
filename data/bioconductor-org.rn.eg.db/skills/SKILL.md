---
name: bioconductor-org.rn.eg.db
description: This package provides genome-wide annotations and identifier mappings for the Rattus norvegicus (Rat) genome. Use when user asks to map between rat gene identifiers, retrieve functional annotations like GO terms or KEGG pathways, or look up chromosomal locations and gene names for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Rn.eg.db.html
---


# bioconductor-org.rn.eg.db

name: bioconductor-org.rn.eg.db
description: Provides genome-wide annotations for Rattus norvegicus (Rat) primarily based on Entrez Gene identifiers. Use this skill when mapping between rat gene identifiers (e.g., Entrez Gene IDs, Symbols, Ensembl IDs, RefSeq), retrieving functional annotations (GO, KEGG), or looking up chromosomal locations and gene names for rat genomic data.

# bioconductor-org.rn.eg.db

## Overview

The `org.Rn.eg.db` package is a genome-wide annotation database for *Rattus norvegicus* (Rat). It is part of the Bioconductor "org" (organism) series and uses Entrez Gene identifiers as the primary central key. This package allows for seamless conversion between various gene naming conventions and provides metadata such as Gene Ontology (GO) terms, KEGG pathways, and chromosomal coordinates.

## Core Workflows

### Loading and Exploration

To use the package, load it into the R session. You can then inspect the available data types.

```r
library(org.Rn.eg.db)

# View available columns (data types) to retrieve
columns(org.Rn.eg.db)

# View available keytypes (identifiers you can use as input)
keytypes(org.Rn.eg.db)

# Get a sample of keys (Entrez Gene IDs)
head(keys(org.Rn.eg.db, keytype = "ENTREZID"))
```

### Mapping Identifiers

The `select()` and `mapIds()` functions from the `AnnotationDbi` package are the preferred interfaces for querying the database.

**Using select()**
Use `select()` when you need a data frame containing multiple columns or when one input key might map to multiple output values.

```r
# Map Gene Symbols to Ensembl IDs and Chromosomes
genes <- c("Tp53", "Brca1", "Apoe")
results <- select(org.Rn.eg.db, 
                  keys = genes, 
                  columns = c("ENSEMBL", "CHR", "GENENAME"), 
                  keytype = "SYMBOL")
```

**Using mapIds()**
Use `mapIds()` for a simpler interface that returns a named vector. This is useful for adding a single new column to an existing dataset.

```r
# Map Entrez IDs to Symbols
entrez_ids <- c("24842", "24234")
symbols <- mapIds(org.Rn.eg.db, 
                  keys = entrez_ids, 
                  column = "SYMBOL", 
                  keytype = "ENTREZID", 
                  multiVals = "first")
```

### Functional Annotation

Retrieve Gene Ontology (GO) or KEGG pathway information for rat genes.

```r
# Get GO terms for a specific gene
go_info <- select(org.Rn.eg.db, 
                  keys = "24842", 
                  columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                  keytype = "ENTREZID")

# Get KEGG pathway IDs
kegg_info <- select(org.Rn.eg.db, 
                    keys = "Tp53", 
                    columns = "PATH", 
                    keytype = "SYMBOL")
```

### Working with Aliases

Gene symbols change over time. Use the `ALIAS` keytype to map older or unofficial symbols to current Entrez Gene IDs.

```r
# Map aliases to Entrez IDs
alias_map <- select(org.Rn.eg.db, 
                    keys = c("Trp53", "Brca"), 
                    columns = c("ENTREZID", "SYMBOL"), 
                    keytype = "ALIAS")
```

## Tips and Best Practices

- **Primary Keys**: Always prefer Entrez Gene IDs (`ENTREZID`) or Ensembl IDs (`ENSEMBL`) over Symbols for programmatic workflows, as Symbols can be ambiguous or redundant.
- **multiVals Argument**: In `mapIds()`, use the `multiVals` parameter (e.g., "first", "list", "CharacterList", or "filter") to control how 1-to-many mappings are handled.
- **Bimap Interface**: While "old style" Bimaps (e.g., `org.Rn.egSYMBOL`) still exist, the `select()` and `mapIds()` interface is more robust and recommended for modern Bioconductor scripts.
- **Database Metadata**: Use `org.Rn.eg_dbInfo()` to check the data source versions and timestamps for the current package version.
- **Chromosomal Locations**: `CHRLOC` provides the start position, while `CHRLOCEND` provides the end position. Negative values indicate the antisense strand.

## Reference documentation

- [org.Rn.eg.db Reference Manual](./references/reference_manual.md)