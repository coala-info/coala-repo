---
name: bioconductor-hu35ksubd.db
description: This package provides annotation data for the Affymetrix Human Genome hu35ksubd chip. Use when user asks to map manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hu35ksubd.db.html
---


# bioconductor-hu35ksubd.db

name: bioconductor-hu35ksubd.db
description: Provides annotation data for the Affymetrix Human Genome hu35ksubd chip. Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) and chromosomal locations using the hu35ksubd.db Bioconductor package.

# bioconductor-hu35ksubd.db

## Overview

The `hu35ksubd.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome hu35ksubd platform. It provides a SQLite-based interface to map manufacturer-specific probe IDs to standard biological identifiers and metadata.

## Core Workflows

### Loading the Package
```r
library(hu35ksubd.db)
```

### Using the select() Interface
The recommended way to interact with this package is via the `select()` function from the `AnnotationDbi` package.

```r
# View available columns
columns(hu35ksubd.db)

# View available key types
keytypes(hu35ksubd.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
select(hu35ksubd.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mappings
- **Gene Symbols**: Map probes to official gene abbreviations using `SYMBOL`.
- **Entrez Gene IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **GO Terms**: Map probes to Gene Ontology identifiers and evidence codes using `GO`.
- **KEGG Pathways**: Map probes to metabolic and signaling pathways using `PATH`.
- **Chromosomal Location**: Map probes to chromosomes (`CHR`) or specific base pair starts (`CHRLOC`) and ends (`CHRLOCEND`).

### Using the Bimap Interface (Legacy)
While `select()` is preferred, specific mappings can be accessed via Bimap objects:

```r
# Get all mapped probe IDs for Accession Numbers
x <- hu35ksubdACCNUM
mapped_probes <- mappedkeys(x)
# Convert to list
as.list(x[mapped_probes][1:5])

# Map Gene Aliases to Probes
xx <- as.list(hu35ksubdALIAS2PROBE)
```

### Database Connection Information
To query the underlying SQLite database directly:
```r
# Get DB connection
conn <- hu35ksubd_dbconn()
# Show DB schema
hu35ksubd_dbschema()
```

## Tips
- **Multiple Mappings**: Some probes may map to multiple identifiers (e.g., multiple GO terms). `select()` will return a data frame with one row per mapping.
- **Reverse Mappings**: Many objects have reverse maps (e.g., `hu35ksubdGO2PROBE` or `hu35ksubdPATH2PROBE`) to find probes associated with a specific biological term.
- **Defunct Interfaces**: The Bimap interface for PFAM and PROSITE is defunct; always use the `select()` interface for these identifiers.

## Reference documentation
- [hu35ksubd.db Reference Manual](./references/reference_manual.md)