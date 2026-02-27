---
name: bioconductor-mgu74a.db
description: This package provides annotation data for the Affymetrix Mouse Genome U74A array. Use when user asks to map probe identifiers to gene symbols, retrieve Gene Ontology terms, find KEGG pathways, or access chromosomal locations for mouse genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgu74a.db.html
---


# bioconductor-mgu74a.db

name: bioconductor-mgu74a.db
description: Provides annotation data for the Affymetrix Mouse Genome U74A (mgu74a) array. Use this skill to map manufacturer probe identifiers to biological identifiers (Entrez Gene, Gene Symbol, Ensembl, MGI), retrieve Gene Ontology (GO) terms, KEGG pathways, and chromosomal locations for mouse genomic data.

## Overview

The `mgu74a.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Genome U74A platform. It provides a comprehensive set of mappings between manufacturer probe IDs and various gene-centric identifiers. While it supports legacy "Bimap" objects, the primary and recommended way to interact with the data is through the `AnnotationDbi` interface (`select`, `columns`, `keys`).

## Installation and Loading

To use this package in R:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mgu74a.db")

library(mgu74a.db)
```

## Core Workflows

### Using the select() Interface

The `select()` function is the standard method for retrieving data.

1. **List available columns**:
   ```R
   columns(mgu74a.db)
   ```

2. **List available keytypes**:
   ```R
   keytypes(mgu74a.db)
   ```

3. **Retrieve specific annotations**:
   ```R
   # Map probe IDs to Gene Symbols and Entrez IDs
   probes <- c("100001_at", "100002_at", "100003_at")
   select(mgu74a.db, 
          keys = probes, 
          columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
          keytype = "PROBEID")
   ```

### Mapping to Gene Ontology (GO)

To retrieve GO terms for specific probes:

```R
select(mgu74a.db, 
       keys = "100001_at", 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")
```

### Mapping to KEGG Pathways

To find which pathways a probe is involved in:

```R
select(mgu74a.db, 
       keys = "100001_at", 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Legacy Bimap Interface

For quick lookups or converting entire maps to lists:

```R
# Convert Symbol map to a list
symbol_list <- as.list(mgu74aSYMBOL)

# Get probes mapped to a specific symbol
probes_for_symbol <- mgu74aALIAS2PROBE$"Gpx1"

# Get chromosome information
chr_info <- as.list(mgu74aCHR)
```

## Database Information

To inspect the underlying SQLite database:

```R
# Get database connection
conn <- mgu74a_dbconn()

# Show database schema
mgu74a_dbschema()

# Get path to the SQLite file
mgu74a_dbfile()
```

## Tips and Best Practices

- **Mus musculus**: This package is specific to the mouse genome. Ensure your input identifiers are from the mgu74a platform.
- **One-to-Many Mappings**: Be aware that a single probe ID can sometimes map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping.
- **Official Symbols**: Use the `SYMBOL` map for official gene symbols and `ALIAS2PROBE` if you are searching for common gene aliases.
- **Chromosomal Locations**: `CHRLOC` provides the start position, while `CHRLOCEND` provides the end position. Negative values indicate the antisense strand.

## Reference documentation

- [mgu74a.db Reference Manual](./references/reference_manual.md)