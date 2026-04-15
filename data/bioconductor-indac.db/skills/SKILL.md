---
name: bioconductor-indac.db
description: bioconductor-indac.db provides annotation mappings between manufacturer probe identifiers and biological database identifiers for the indac Drosophila melanogaster platform. Use when user asks to map probe IDs to gene symbols, perform functional enrichment analysis, or retrieve genomic locations for Drosophila microarray data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/indac.db.html
---

# bioconductor-indac.db

## Overview

The `indac.db` package is a Bioconductor annotation data package for the indac platform. It provides comprehensive mappings between manufacturer-specific probe identifiers and various biological database identifiers. This package is primarily used for annotating microarray results or performing functional enrichment analysis for Drosophila melanogaster studies.

## Core Workflows

### Loading the Package
```r
library(indac.db)
```

### Using the select() Interface (Recommended)
The modern way to interact with this package is via the `AnnotationDbi` interface. This allows you to query multiple types of data simultaneously.

```r
# View available columns
columns(indac.db)

# View available key types (usually PROBEID)
keytypes(indac.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10001_at", "10002_at") # Example probe IDs
select(indac.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Using the Bimap Interface (Legacy)
While `select()` is preferred, specific mappings can be accessed directly as Bimap objects.

*   **Gene Identification**: `indacSYMBOL`, `indacENTREZID`, `indacGENENAME`, `indacENSEMBL`.
*   **Functional Annotation**: `indacGO` (Gene Ontology), `indacPATH` (KEGG Pathways), `indacENZYME` (EC numbers).
*   **Physical Location**: `indacCHR` (Chromosomes), `indacCHRLOC` (Start position), `indacMAP` (Cytobands).
*   **Literature**: `indacPMID` (PubMed identifiers).

```r
# Convert a mapping to a list
sym_list <- as.list(indacSYMBOL)

# Get symbols for specific probes
probes <- c("10001_at", "10002_at")
sym_list[probes]

# Reverse mapping (e.g., Symbols to Probes)
# Note: Use the specific '2PROBE' object if available
alias_to_probe <- as.list(indacALIAS2PROBE)
```

### Working with Gene Ontology (GO)
The `indacGO` mapping provides detailed lists including Evidence codes and Ontologies (BP, CC, MF).

```r
# Get GO annotations for a probe
go_annots <- as.list(indacGO[["10001_at"]])
# Access the first GO ID's evidence code
go_annots[[1]][["Evidence"]]
```

## Database Information
To inspect the underlying SQLite database metadata:

```r
indac_dbconn()    # Get DB connection object
indac_dbfile()    # Get path to SQLite file
indac_dbschema()  # Print database schema
indac_dbInfo()    # Print package metadata
```

## Tips
*   **Drosophila Specific**: This package uses FlyBase identifiers (`indacFLYBASE`, `indacFLYBASECG`) which are critical for Drosophila research.
*   **NA Values**: Not every probe maps to every metadata type; always check for `NA` in your results.
*   **Version Consistency**: Mappings are based on specific snapshots (e.g., Entrez Gene, Ensembl). Use `indac_dbInfo()` to check the data source dates if versioning is a concern for your analysis.

## Reference documentation
- [indac.db Reference Manual](./references/reference_manual.md)