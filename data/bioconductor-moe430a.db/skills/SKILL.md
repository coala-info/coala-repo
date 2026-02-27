---
name: bioconductor-moe430a.db
description: This package provides annotation data for the Affymetrix Mouse Expression 430A platform. Use when user asks to map manufacturer probe identifiers to biological metadata, retrieve gene symbols, or access functional annotations like GO terms and KEGG pathways for mouse microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moe430a.db.html
---


# bioconductor-moe430a.db

name: bioconductor-moe430a.db
description: Annotation data for the Affymetrix Mouse Expression 430A (moe430a) platform. Use when mapping manufacturer probe identifiers to biological metadata like Entrez Gene IDs, symbols, GO terms, or chromosomal locations for mouse microarray data.

# bioconductor-moe430a.db

## Overview

The `moe430a.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Expression 430A platform. It provides comprehensive mappings between manufacturer probe identifiers and various gene-centric identifiers (e.g., Entrez Gene, MGI, Ensembl) and functional annotations (e.g., GO, KEGG, PubMed).

## Using moe430a.db

### Loading the Package

Load the package into the R environment:

```r
library(moe430a.db)
```

### Modern Interface (select)

The preferred method for interacting with the database is the `select()` interface from the `AnnotationDbi` package.

1.  **Discover available columns and keytypes**:
    ```r
    columns(moe430a.db)
    keytypes(moe430a.db)
    ```

2.  **Retrieve data**:
    Map a vector of probe IDs to specific annotations.
    ```r
    probes <- c("131022_at", "131023_at")
    res <- select(moe430a.db, keys = probes, columns = c("SYMBOL", "ENTREZID", "GENENAME"), keytype = "PROBEID")
    ```

### Legacy Bimap Interface

While `select()` is preferred, the "Bimap" interface is still available for specific mappings.

1.  **Access a specific map**:
    ```r
    # Map probe IDs to Gene Symbols
    x <- moe430aSYMBOL
    # Get mapped keys
    mapped_probes <- mappedkeys(x)
    # Convert to a list
    symbol_list <- as.list(x[mapped_probes][1:5])
    ```

2.  **Common Mappings**:
    - `moe430aACCNUM`: Manufacturer Accession Numbers
    - `moe430aALIAS2PROBE`: Gene Symbols/Aliases to Probe IDs
    - `moe430aENTREZID`: Entrez Gene Identifiers
    - `moe430aMGI`: MGI Gene Accession Numbers
    - `moe430aGO`: Gene Ontology (GO) Identifiers
    - `moe430aPATH`: KEGG Pathway Identifiers

### Chromosomal Information

Retrieve chromosomal locations and lengths:

```r
# Chromosome for each probe
as.list(moe430aCHR["131022_at"])

# Start position on chromosome
as.list(moe430aCHRLOC["131022_at"])

# Chromosome lengths
moe430aCHRLENGTHS
```

### Database Utilities

Access underlying database information:

```r
# Get SQLite connection
conn <- moe430a_dbconn()

# Show database schema
moe430a_dbschema()

# Get path to SQLite file
moe430a_dbfile()
```

## Reference documentation

- [Reference Manual](./references/reference_manual.md)