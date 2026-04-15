---
name: bioconductor-illuminahumanv2beadid.db
description: This package provides annotation data for mapping Illumina Humanv2 BeadID identifiers to biological features and genomic locations. Use when user asks to map BeadIDs to gene symbols, retrieve functional annotations like GO terms or KEGG pathways, or find chromosomal locations for Illumina Humanv2 platform identifiers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaHumanv2BeadID.db.html
---

# bioconductor-illuminahumanv2beadid.db

name: bioconductor-illuminahumanv2beadid.db
description: Provides annotation data for Illumina Humanv2 BeadID platform. Use this skill to map Illumina manufacturer identifiers (BeadIDs) to various biological annotations such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `illuminaHumanv2BeadID.db` package is a Bioconductor annotation data package specifically designed for the Illumina Humanv2 platform using BeadIDs as the primary keys. Unlike standard probe-based packages, this package maps manufacturer identifiers directly to genomic features. It is essential for downstream analysis of Illumina microarray data where BeadID-to-gene mapping is required.

## Core Workflows

### Loading the Package and Exploring Keys
To begin, load the library and list the available mapping objects:
```R
library(illuminaHumanv2BeadID.db)
# List all available mapping objects
ls("package:illuminaHumanv2BeadID.db")
```

### Basic Identifier Mapping
The most common task is mapping BeadIDs to Gene Symbols or Entrez IDs.
```R
# Map BeadIDs to Gene Symbols
ids <- c("10001", "10002") # Example BeadIDs
symbol_map <- as.list(illuminaHumanv2BeadIDSYMBOL[ids])

# Map BeadIDs to Entrez Gene Identifiers
entrez_map <- as.list(illuminaHumanv2BeadIDENTREZID[ids])
```

### Functional Annotation (GO and KEGG)
Retrieve Gene Ontology (GO) terms or KEGG pathway information for specific identifiers.
```R
# Get GO annotations for a set of probes
go_annots <- as.list(illuminaHumanv2BeadIDGO["10001"])

# Get KEGG pathway IDs
kegg_ids <- as.list(illuminaHumanv2BeadIDPATH["10001"])
```

### Genomic Location and Cytobands
Find where the genes associated with the BeadIDs are located on the genome.
```R
# Get Chromosome
chr_info <- as.list(illuminaHumanv2BeadIDCHR["10001"])

# Get Cytogenetic band
map_info <- as.list(illuminaHumanv2BeadIDMAP["10001"])

# Get specific start positions (base pairs)
loc_info <- as.list(illuminaHumanv2BeadIDCHRLOC["10001"])
```

### Reverse Mappings
Many objects have reverse maps (e.g., finding BeadIDs associated with a specific GO term or Gene Symbol).
```R
# Find BeadIDs for a specific Gene Symbol
alias_to_probe <- as.list(illuminaHumanv2BeadIDALIAS2PROBE["TP53"])

# Find BeadIDs for a specific KEGG pathway
path_to_probe <- as.list(illuminaHumanv2BeadIDPATH2PROBE["04110"])
```

## Database Utilities
For advanced users needing direct SQL access or schema information:
```R
# Get a connection to the underlying SQLite database
conn <- illuminaHumanv2BeadID_dbconn()

# Show the database schema
illuminaHumanv2BeadID_dbschema()

# Get the number of mapped keys for all maps
illuminaHumanv2BeadIDMAPCOUNTS
```

## Tips for Efficient Usage
- **Use `mappedkeys()`**: To filter for only those identifiers that actually have a mapping in a specific object, use `mappedkeys(x)`.
- **Handling Lists**: Most mapping objects return a list where one key can map to multiple values (e.g., one gene having multiple GO terms). Always check the length of the returned list elements.
- **AnnotationDbi**: This package is compatible with the `select()`, `keys()`, and `columns()` interface from the `AnnotationDbi` package for more modern data retrieval.

## Reference documentation
- [illuminaHumanv2BeadID.db Reference Manual](./references/reference_manual.md)