---
name: bioconductor-hs25kresogen.db
description: This package provides SQLite-based annotation maps for translating hs25kresogen platform probe IDs into biological identifiers and functional metadata. Use when user asks to map probe IDs to gene symbols, Entrez IDs, GO terms, or KEGG pathways, and when retrieving genomic locations or cytoband information for human genomic research.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hs25kresogen.db.html
---


# bioconductor-hs25kresogen.db

## Overview

The `hs25kresogen.db` package is a Bioconductor annotation data package for the hs25kresogen platform. It provides a set of SQLite-based maps that allow users to translate manufacturer-specific probe IDs into standard biological identifiers and functional annotations for human genomic research.

## Core Workflows

### Loading the Package and Exploring Maps
To begin, load the library and list all available mapping objects:
```r
library(hs25kresogen.db)
# List all available maps in the package
ls("package:hs25kresogen.db")
```

### Basic Identifier Mapping
Most maps are used by converting the map object to a list or using the `select()` interface from `AnnotationDbi`.

**Example: Mapping Probes to Gene Symbols**
```r
# Get the mapping object
x <- hs25kresogenSYMBOL
# Get probe IDs that have a mapped symbol
mapped_probes <- mappedkeys(x)
# Convert to a list for specific probes
symbols <- as.list(x[mapped_probes[1:5]])
```

**Example: Mapping Probes to Entrez IDs**
```r
entrez_ids <- as.list(hs25kresogenENTREZID)
# Access a specific probe
entrez_ids[["your_probe_id"]]
```

### Functional and Pathway Annotation
The package includes mappings to Gene Ontology (GO) and KEGG pathways.

*   **GO Annotation:** `hs25kresogenGO` provides GO IDs, Evidence codes, and Ontologies (BP, CC, MF).
*   **Pathway Annotation:** `hs25kresogenPATH` maps probes to KEGG pathway identifiers.
*   **Reverse Mappings:** Use `hs25kresogenGO2PROBE` or `hs25kresogenPATH2PROBE` to find all probes associated with a specific term or pathway.

### Genomic Location and Chromosomes
Retrieve physical location data for probes:
*   **Chromosome:** `hs25kresogenCHR`
*   **Chromosomal Location:** `hs25kresogenCHRLOC` (start) and `hs25kresogenCHRLOCEND` (end).
*   **Cytoband:** `hs25kresogenMAP`

### Database Metadata and Connectivity
To inspect the underlying database schema or counts:
```r
# Get number of mapped keys for all maps
hs25kresogenMAPCOUNTS

# Get database metadata
hs25kresogen_dbInfo()

# Access the SQLite connection directly
conn <- hs25kresogen_dbconn()
dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")
```

## Usage Tips
*   **Handling Multiple Mappings:** Some probes map to multiple identifiers (e.g., multiple GO terms). These are returned as lists of vectors or lists of lists.
*   **Official vs. Alias:** Use `hs25kresogenSYMBOL` for official gene symbols and `hs25kresogenALIAS2PROBE` to map common aliases back to manufacturer IDs.
*   **AnnotationDbi Interface:** While the package provides specific map objects, you can also use the standard `select()`, `keys()`, `columns()`, and `mapIds()` functions from the `AnnotationDbi` package for a more modern workflow.

## Reference documentation
- [hs25kresogen.db Reference Manual](./references/reference_manual.md)