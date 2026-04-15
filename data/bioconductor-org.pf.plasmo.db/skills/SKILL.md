---
name: bioconductor-org.pf.plasmo.db
description: This package provides genome-wide annotations and identifier mapping for *Plasmodium falciparum*. Use when user asks to map ORF identifiers to gene symbols, retrieve Gene Ontology terms, or perform functional annotation for malaria research data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/org.Pf.plasmo.db.html
---

# bioconductor-org.pf.plasmo.db

## Overview

The `org.Pf.plasmo.db` package is an organism-specific annotation package for *Plasmodium falciparum*. It provides a central hub for mapping various biological identifiers to the Open Reading Frame (ORF) identifiers used in PlasmoDB. It is primarily used for functional annotation, enrichment analysis, and identifier conversion in malaria research.

## Core Workflows

### Loading the Package
```r
library(org.Pf.plasmo.db)
```

### Using the select() Interface
The recommended way to interact with the database is using `keys()`, `columns()`, and `select()`.

```r
# List available columns (data types)
columns(org.Pf.plasmo.db)

# List available key types (usually the same as columns)
keytypes(org.Pf.plasmo.db)

# Retrieve specific annotations for a list of ORF IDs
genes <- c("PF3D7_0100100", "PF3D7_0100200")
select(org.Pf.plasmo.db, 
       keys = genes, 
       columns = c("SYMBOL", "GENENAME", "GO"), 
       keytype = "ORF")
```

### Common Identifier Mappings

1.  **ORF to Symbol/Name**:
    - Use `SYMBOL` for official abbreviations.
    - Use `GENENAME` for full descriptive names.
    - Use `ALIAS` to map common literature names back to ORF IDs.

2.  **Functional Annotations**:
    - **GO**: Returns Gene Ontology IDs, Evidence codes, and Ontologies (BP, CC, MF).
    - **PATH**: Returns KEGG pathway identifiers.
    - **ENZYME**: Returns Enzyme Commission (EC) numbers.

3.  **GO Subtree Mapping**:
    - `org.Pf.plasmoGO2ALLORFS` is used to find all genes associated with a GO term including its children in the ontology hierarchy.

### Database Metadata and Connection
To inspect the underlying SQLite database or check versioning:
```r
# Get database metadata
org.Pf.plasmo_dbInfo()

# Get the number of mapped keys for all tables
org.Pf.plasmoMAPCOUNTS

# Direct SQL queries (for advanced users)
dbGetQuery(org.Pf.plasmo_dbconn(), "SELECT * FROM genes LIMIT 5")
```

## Tips and Best Practices
- **Primary Identifiers**: Always use ORF IDs (e.g., PF3D7_...) as primary identifiers. Gene symbols in *Plasmodium* can be redundant or inconsistently assigned in literature.
- **Bimap Interface**: While "old style" Bimaps (e.g., `as.list(org.Pf.plasmoSYMBOL)`) still work, the `select()` interface is more robust and preferred for modern Bioconductor workflows.
- **Evidence Codes**: When working with GO terms, pay attention to the `EVIDENCE` column to distinguish between experimentally validated annotations (e.g., IDA, IMP) and electronic projections (IEA).

## Reference documentation
- [org.Pf.plasmo.db Reference Manual](./references/reference_manual.md)