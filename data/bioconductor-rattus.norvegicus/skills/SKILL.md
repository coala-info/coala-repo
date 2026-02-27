---
name: bioconductor-rattus.norvegicus
description: This package provides a unified annotation resource for Rattus norvegicus by integrating multiple genomic databases into a single interface. Use when user asks to map rat gene identifiers, retrieve gene-centric information, or query genomic coordinates for rat models.
homepage: https://bioconductor.org/packages/release/data/annotation/html/Rattus.norvegicus.html
---


# bioconductor-rattus.norvegicus

name: bioconductor-rattus.norvegicus
description: Annotation resource for Rattus norvegicus (Rat). Use this skill when performing genomic data annotation, mapping between different identifier types (e.g., Entrez, Ensembl, Symbol), or retrieving gene-centric information for rat models using the OrganismDbi interface.

# bioconductor-rattus.norvegicus

## Overview
The `Rattus.norvegicus` package is an `OrganismDb` object that collates multiple Bioconductor annotation resources (such as GO, KEGG, and Ensembl) into a single, unified interface. It allows users to query rat-specific genomic information using a consistent set of methods inherited from the `AnnotationDbi` framework.

## Core Workflow

To use this package, load the library and use the four standard accessor methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Discovery
Check what data types are available and what identifiers can be used as input.

```r
library(Rattus.norvegicus)

# View available data columns (e.g., SYMBOL, GO, ENSEMBL)
columns(Rattus.norvegicus)

# View valid key types for searching (e.g., ENTREZID, REFSEQ)
keytypes(Rattus.norvegicus)
```

### 2. Data Retrieval
Use the `select()` function to map identifiers to specific annotation data.

```r
# Get the first few keys of a specific type
kt <- "ENTREZID"
ks <- head(keys(Rattus.norvegicus, keytype = kt))

# Select specific columns for those keys
cols <- c("SYMBOL", "GENENAME", "ENSEMBL")
res <- select(Rattus.norvegicus, keys = ks, columns = cols, keytype = kt)

# View results
head(res)
```

## Usage Tips
- **Object Name**: The package loads a central object also named `Rattus.norvegicus`. All functions should be called on this object.
- **OrganismDbi**: Since this is an `OrganismDb` object, it integrates both gene-level annotations (like `org.Rn.eg.db`) and genomic coordinates (like `TxDb.Rnorvegicus.UCSC.rn6.refGene`).
- **Filtering**: When using `keys()`, you can provide a `pattern` or use `column` arguments to filter the returned identifiers.
- **One-to-Many Mappings**: Be aware that `select()` may return more rows than the input `keys` if there are multiple mappings (e.g., one gene mapping to multiple GO terms).

## Reference documentation
- [Rattus.norvegicus Reference Manual](./references/reference_manual.md)