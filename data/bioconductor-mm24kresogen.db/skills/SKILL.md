---
name: bioconductor-mm24kresogen.db
description: This package provides annotation data for the mm24kresogen platform to map mouse probe identifiers to various biological and genomic metadata. Use when user asks to map manufacturer probe IDs to gene symbols, Entrez Gene IDs, chromosomal locations, GO terms, or KEGG pathways for Mus musculus data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mm24kresogen.db.html
---

# bioconductor-mm24kresogen.db

name: bioconductor-mm24kresogen.db
description: Provides annotation data for the mm24kresogen platform (Mus musculus). Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, GO, KEGG, etc.) and chromosomal locations for mouse genomic data.

# bioconductor-mm24kresogen.db

## Overview

The `mm24kresogen.db` package is a Bioconductor annotation data package for the mm24kresogen platform. It provides SQLite-based mappings between manufacturer-specific probe identifiers and various genomic annotations for *Mus musculus*. This skill guides the retrieval of gene symbols, chromosomal locations, pathway information, and functional annotations using standard Bioconductor `AnnotationDbi` workflows.

## Core Workflows

### Loading the Package
```r
library(mm24kresogen.db)
# List all available mapping objects
ls("package:mm24kresogen.db")
```

### Basic Identifier Mapping
To map manufacturer IDs to specific annotations (e.g., Gene Symbols), use the `as.list()` or `mget()` functions on the mapping objects.

```r
# Map probes to Gene Symbols
probes <- c("1", "10", "100") # Example probe IDs
symbols <- as.list(mm24kresogenSYMBOL[probes])

# Map probes to Entrez Gene IDs
entrez_ids <- as.list(mm24kresogenENTREZID[probes])
```

### Genomic Location and Chromosomes
Retrieve chromosomal assignments and specific base-pair locations.

```r
# Get chromosome for probes
chrs <- as.list(mm24kresogenCHR[probes])

# Get start positions (CHRLOC) and end positions (CHRLOCEND)
locs <- as.list(mm24kresogenCHRLOC[probes])
```

### Functional Annotation (GO and KEGG)
Map probes to Gene Ontology (GO) terms or KEGG pathways.

```r
# Get GO annotations (includes Evidence and Ontology codes)
go_annots <- as.list(mm24kresogenGO[probes])

# Get KEGG pathway IDs
kegg_paths <- as.list(mm24kresogenPATH[probes])

# Reverse map: Find probes associated with a specific KEGG pathway
path_to_probes <- as.list(mm24kresogenPATH2PROBE[["04110"]])
```

### Database Metadata and Connection
Access underlying database information or run direct SQL queries.

```r
# Get database schema
mm24kresogen_dbschema()

# Get number of mapped keys for all maps
mm24kresogenMAPCOUNTS

# Direct SQL query example
conn <- mm24kresogen_dbconn()
dbGetQuery(conn, "SELECT count(*) FROM probes")
```

## Tips for Efficient Usage
- **Mapped Keys**: Use `mappedkeys(x)` to identify which probes actually have annotations for a specific map to avoid `NA` results.
- **Reverse Mappings**: Many objects have reverse maps (e.g., `mm24kresogenSYMBOL2PROBE` or `mm24kresogenGO2PROBE`). If not explicitly provided, use `revmap()`.
- **AnnotationDbi Select**: While the package provides specific objects, you can also use the modern interface: `select(mm24kresogen.db, keys=probes, columns=c("SYMBOL", "GENENAME"), keytype="PROBEID")`.

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)