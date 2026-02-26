---
name: bioconductor-hugene21stprobeset.db
description: This package provides annotation data for mapping Affymetrix Human Gene 2.1 ST probe sets to biological identifiers and genomic metadata. Use when user asks to map probe IDs to gene symbols, retrieve Entrez Gene identifiers, find chromosomal locations, or associate probe sets with GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene21stprobeset.db.html
---


# bioconductor-hugene21stprobeset.db

name: bioconductor-hugene21stprobeset.db
description: Provides annotation data for the Affymetrix Human Gene 2.1 ST probe sets. Use this skill when you need to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, Ensembl, GO, KEGG, etc.) or chromosomal locations for the hugene21stprobeset platform.

# bioconductor-hugene21stprobeset.db

## Overview

The `hugene21stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Human Gene 2.1 ST array. It provides a SQLite-based interface to map probe set IDs to genomic metadata. The primary way to interact with this package is through the `select()` interface from the `AnnotationDbi` package, though older "Bimap" objects are also available.

## Core Workflows

### Loading the Package
```R
library(hugene21stprobeset.db)
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```R
# 1. List available columns
columns(hugene21stprobeset.db)

# 2. List available keytypes
keytypes(hugene21stprobeset.db)

# 3. Perform a lookup (e.g., map probe IDs to Gene Symbols and Entrez IDs)
probes <- c("16737474", "16906321")
select(hugene21stprobeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

- **Gene Symbols**: Map probe IDs to official gene symbols using the `SYMBOL` column.
- **Entrez IDs**: Map to NCBI Entrez Gene identifiers using the `ENTREZID` column.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the chromosome and start/end base pair positions.
- **Gene Ontology (GO)**: Retrieve GO terms and evidence codes using the `GO` column.
- **Pathways**: Map to KEGG pathway identifiers using the `PATH` column.
- **External IDs**: Map to `ENSEMBL`, `UNIPROT`, or `REFSEQ` identifiers.

### Using Bimap Objects (Legacy Interface)
While `select()` is preferred, specific mappings can be accessed via Bimap objects for quick list-based lookups.

```R
# Map probe IDs to Gene Symbols
x <- hugene21stprobesetSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes][1:5])

# Reverse mapping (e.g., Symbols to Probes)
rev_x <- revmap(hugene21stprobesetSYMBOL)
```

### Database Connection and Metadata
You can inspect the underlying database schema or connection information:
```R
# Get database metadata
hugene21stprobeset_dbInfo()

# Get the organism name
hugene21stprobesetORGANISM
```

## Tips for Success
- **Multiple Mappings**: One probe ID may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **NA Values**: If a probe ID cannot be mapped to a specific column, `NA` is returned.
- **Package Dependencies**: Ensure `AnnotationDbi` is loaded to use `select()`, `keys()`, and `columns()`.

## Reference documentation
- [hugene21stprobeset.db Reference Manual](./references/reference_manual.md)