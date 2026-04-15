---
name: bioconductor-r10kcod.db
description: This Bioconductor package provides annotation data for the r10kcod platform to map manufacturer-specific probe identifiers to various biological nomenclatures. Use when user asks to map probes to gene symbols, Entrez IDs, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/r10kcod.db.html
---

# bioconductor-r10kcod.db

## Overview

The `r10kcod.db` package is a Bioconductor annotation data package for the r10kcod platform. It provides a set of R objects (Bimap objects) that facilitate the translation between manufacturer-specific probe identifiers and standard biological nomenclature.

## Core Workflows

### Loading the Package and Exploring Contents
To begin, load the library and list the available mapping objects:
```R
library(r10kcod.db)
ls("package:r10kcod.db")
```

### Basic Identifier Mapping
Most objects in this package are used by converting them to a list or using the `mget` function.

**Map Probes to Gene Symbols:**
```R
# Get symbols for specific probes
probes <- c("1", "2", "3") # Replace with actual probe IDs
symbols <- mget(probes, r10kcodSYMBOL, ifnotfound=NA)

# Convert the whole map to a list (caution: can be large)
symbol_list <- as.list(r10kcodSYMBOL)
```

**Map Probes to Entrez Gene IDs:**
```R
entrez_ids <- as.list(r10kcodENTREZID)
```

### Functional and Pathway Annotation
**Gene Ontology (GO):**
The `r10kcodGO` object provides mappings to GO terms with associated evidence codes and ontologies (BP, CC, MF).
```R
# Get GO annotations for a probe
probe_go <- as.list(r10kcodGO["1"])
# Access details: ID, Ontology, Evidence
probe_go[[1]][[1]]$GOID
probe_go[[1]][[1]]$Evidence
```

**KEGG Pathways:**
```R
# Map probes to KEGG pathway IDs
pathways <- as.list(r10kcodPATH)

# Reverse map: KEGG IDs to Probes
path_to_probes <- as.list(r10kcodPATH2PROBE)
```

### Genomic Location and Metadata
**Chromosomal Location:**
```R
# Get chromosome for probes
chroms <- as.list(r10kcodCHR)

# Get start positions (base pairs)
starts <- as.list(r10kcodCHRLOC)
```

**Organism Information:**
```R
r10kcodORGANISM
r10kcodORGPKG
```

## Usage Tips
- **Mapped Keys:** Use `mappedkeys(x)` to identify which probe IDs actually have an associated annotation in a specific map.
- **Reverse Mappings:** Many maps have reverse counterparts (e.g., `r10kcodSYMBOL2PROBE` or `r10kcodGO2PROBE`). If not explicitly provided, use `revmap()` from the `AnnotationDbi` package.
- **Database Connection:** Use `r10kcod_dbconn()` to get a DBI connection to the underlying SQLite database for custom SQL queries. Do not call `dbDisconnect()` on this object.
- **Map Counts:** Use `r10kcodMAPCOUNTS` to see the number of mapped keys for every object in the package.

## Reference documentation
- [r10kcod.db Reference Manual](./references/reference_manual.md)