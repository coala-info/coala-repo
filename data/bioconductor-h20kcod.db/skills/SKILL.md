---
name: bioconductor-h20kcod.db
description: This tool provides genomic annotation and mapping for the h20kcod platform using the Bioconductor R package h20kcod.db. Use when user asks to map h20kcod probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, or GO terms, and perform functional annotation or chromosomal localization for this chip.
homepage: https://bioconductor.org/packages/release/data/annotation/html/h20kcod.db.html
---


# bioconductor-h20kcod.db

name: bioconductor-h20kcod.db
description: Use this skill to perform genomic annotation and mapping for the h20kcod platform using the Bioconductor R package h20kcod.db. This skill is essential for converting between manufacturer-specific probe identifiers and various biological identifiers such as Entrez Gene IDs, Gene Symbols, Ensembl IDs, GO terms, and KEGG pathways. Use this when you need to annotate microarray data or perform identifier cross-referencing for the h20kcod chip.

## Overview

The `h20kcod.db` package is a Bioconductor annotation data package that provides comprehensive mappings for the h20kcod platform. It functions as an SQLite-based database that allows users to translate manufacturer probe IDs into standard biological nomenclature and vice versa.

## Core Workflows

### Loading the Package and Exploring Objects
To begin, load the library and list the available mapping objects:
```R
library(h20kcod.db)
ls("package:h20kcod.db")
```

### Basic Identifier Mapping
Most mappings follow a standard pattern: convert the mapping object to a list or use `select()` (from AnnotationDbi) to retrieve data.

**Example: Mapping Probes to Gene Symbols**
```R
# Get symbols for specific probes
probes <- c("1001_at", "1002_at") # Example probe IDs
symbols <- as.list(h20kcodSYMBOL[probes])
```

**Example: Mapping Probes to Entrez IDs**
```R
entrez_ids <- as.list(h20kcodENTREZID)
# Access first 5 mappings
entrez_ids[1:5]
```

### Functional Annotation (GO and KEGG)
The package provides mappings to Gene Ontology (GO) and KEGG pathways.

*   **h20kcodGO**: Maps probes to GO IDs with evidence codes and ontologies (BP, CC, MF).
*   **h20kcodPATH**: Maps probes to KEGG pathway identifiers.
*   **h20kcodGO2ALLPROBES**: Maps a GO ID to all probes associated with it or its children in the GO hierarchy.

```R
# Get GO terms for a probe
go_data <- as.list(h20kcodGO[["1001_at"]])
# Extract the first GO ID
go_data[[1]][["GOID"]]
```

### Chromosomal Information
You can retrieve chromosomal locations and lengths:
*   **h20kcodCHR**: Chromosome assignment.
*   **h20kcodCHRLOC**: Start position (base pairs).
*   **h20kcodCHRLOCEND**: End position.
*   **h20kcodCHRLENGTHS**: Total length of each chromosome.

### Reverse Mappings
Many objects have reverse maps (e.g., mapping from a Gene Symbol back to Probe IDs):
```R
# Map Symbol to Probes
symbol_to_probe <- as.list(h20kcodALIAS2PROBE)
```

## Database Utilities
For advanced users, you can access the underlying SQLite database directly:
```R
# Get database connection
conn <- h20kcod_dbconn()
# Query the database
dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")
# View schema
h20kcod_dbschema()
```

## Tips
*   **mappedkeys()**: Use this function to identify which probe IDs actually have a mapping for a specific attribute.
*   **NAs**: If a probe cannot be mapped to an identifier, it will return `NA`.
*   **Biannual Updates**: This package is updated twice a year; always ensure you are using the latest version for the most accurate annotations.

## Reference documentation
- [h20kcod.db Reference Manual](./references/reference_manual.md)