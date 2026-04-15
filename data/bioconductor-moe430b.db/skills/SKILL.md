---
name: bioconductor-moe430b.db
description: This package provides comprehensive annotation data for mapping Affymetrix Mouse Expression 430B platform probe identifiers to biological metadata. Use when user asks to map probe IDs to gene symbols, retrieve Entrez or Ensembl identifiers, or associate mouse genomic data with GO terms and KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/moe430b.db.html
---

# bioconductor-moe430b.db

name: bioconductor-moe430b.db
description: Comprehensive annotation data for the Affymetrix Mouse Expression 430B (moe430b) platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Gene Symbols, Entrez IDs, Ensembl IDs, GO terms, and KEGG pathways for mouse genomic data.

# bioconductor-moe430b.db

## Overview

The `moe430b.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Expression 430B platform. It provides a SQLite-based infrastructure to map manufacturer-specific probe identifiers to various biological identifiers and annotations. The primary interface for data retrieval is the `select()` function from the `AnnotationDbi` package, though legacy "Bimap" objects are also available.

## Core Workflows

### 1. Exploring Available Data
Before querying, identify what types of data (columns) and what types of identifiers (keytypes) are available within the package.

```r
library(moe430b.db)

# List available annotation types
columns(moe430b.db)

# List possible identifier types to use as input
keytypes(moe430b.db)

# Get a sample of probe IDs (keys)
head(keys(moe430b.db, keytype="PROBEID"))
```

### 2. Using the select() Interface
The `select()` function is the recommended method for retrieving data. It requires the database object, the input keys, the columns to retrieve, and the keytype of the input.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1415670_at", "1415671_at", "1415672_at")
results <- select(moe430b.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### 3. Mapping to Gene Ontology (GO)
Mapping to GO terms provides the GO ID, the ontology category (BP, CC, MF), and the evidence code.

```r
# Get GO annotations for specific probes
go_annotations <- select(moe430b.db, 
                         keys = probes, 
                         columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                         keytype = "PROBEID")
```

### 4. Legacy Bimap Interface
While `select()` is preferred, you can interact with specific mapping objects directly. This is useful for quick lookups or converting entire maps to lists.

```r
# Convert a specific map to a list (e.g., Probe to Symbol)
symbol_map <- as.list(moe430bSYMBOL)

# Get symbols for specific probes
symbols <- symbol_map[probes]

# Find probes associated with a specific Alias
alias_probes <- as.list(moe430bALIAS2PROBE)[["Gata1"]]
```

### 5. Database Connection and Schema
For advanced users, you can access the underlying SQLite database directly.

```r
# Get the database connection
conn <- moe430b_dbconn()

# View the database schema
moe430b_dbschema()

# Get the path to the SQLite file
moe430b_dbfile()
```

## Key Mapping Objects
- `moe430bSYMBOL`: Official Gene Symbols.
- `moe430bENTREZID`: Entrez Gene identifiers.
- `moe430bENSEMBL`: Ensembl gene accession numbers.
- `moe430bGENENAME`: Full gene names.
- `moe430bPATH`: KEGG pathway identifiers.
- `moe430bGO`: Gene Ontology identifiers and evidence.
- `moe430bCHR`: Chromosome assignments.
- `moe430bREFSEQ`: RefSeq identifiers.
- `moe430bACCNUM`: GenBank accession numbers.

## Tips for AI Agents
- **Mouse Specificity**: Ensure the research context involves *Mus musculus*, as this package is specific to the mouse 430B array.
- **One-to-Many Mappings**: Be aware that one probe ID can sometimes map to multiple Entrez IDs or GO terms. The `select()` function returns a data.frame that will expand to accommodate these relationships.
- **Package Dependencies**: Always ensure `AnnotationDbi` is available, as `moe430b.db` relies on its classes and methods.

## Reference documentation
- [moe430b.db Reference Manual](./references/reference_manual.md)