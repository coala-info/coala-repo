---
name: bioconductor-illuminahumanv2.db
description: This package provides annotation data and identifier mappings for the Illumina Humanv2 BeadChip platform. Use when user asks to map Illumina probe IDs to biological identifiers like Gene Symbols or Entrez IDs, filter probes by quality, or perform functional annotation using GO and KEGG.
homepage: https://bioconductor.org/packages/release/data/annotation/html/illuminaHumanv2.db.html
---

# bioconductor-illuminahumanv2.db

name: bioconductor-illuminahumanv2.db
description: Provides annotation data for the Illumina Humanv2 BeadChip. Use this skill to map Illumina manufacturer identifiers (probes) to various biological identifiers (Entrez Gene, Gene Symbol, RefSeq, Ensembl, GO, KEGG) and to access probe-specific quality and sequence information.

## Overview

The `illuminaHumanv2.db` package is a Bioconductor annotation data package for the Illumina Humanv2 platform. It provides SQLite-based mappings between manufacturer probe IDs and standard biological identifiers. A unique feature of this package is the inclusion of custom re-annotation data (e.g., probe quality, genomic matches, and nuIDs) which allows for more rigorous filtering of expression data based on probe performance.

## Core Workflows

### Loading the Package and Exploring Objects
To begin, load the library and list the available mapping objects:
```R
library(illuminaHumanv2.db)
ls("package:illuminaHumanv2.db")
```

### Basic Identifier Mapping
Most objects in this package are used to map probe IDs to other identifiers. Use `as.list()` or `mget()` for retrieval.

```R
# Map probes to Gene Symbols
probes <- c("ILMN_1720131", "ILMN_1804039")
symbols <- mget(probes, illuminaHumanv2SYMBOL)

# Map probes to Entrez Gene IDs
entrez_ids <- mget(probes, illuminaHumanv2ENTREZID)

# Map probes to Ensembl IDs
ensembl_ids <- mget(probes, illuminaHumanv2ENSEMBL)
```

### Using Custom Re-annotation Data
This package provides enhanced probe-level metadata. It is highly recommended to filter probes by quality (e.g., "Perfect" or "Good").

```R
# List available custom mappings
illuminaHumanv2listNewMappings()

# Check probe quality for specific probes
qualities <- mget(probes, illuminaHumanv2PROBEQUALITY)

# Get all re-annotation data as a matrix
full_anno <- illuminaHumanv2fullReannotation()
```

### Functional Annotation (GO and KEGG)
Map probes to Gene Ontology (GO) terms or KEGG pathways for enrichment analysis.

```R
# Map to GO terms (includes Evidence and Ontology category)
go_mapping <- mget(probes, illuminaHumanv2GO)

# Map to KEGG Pathways
path_mapping <- mget(probes, illuminaHumanv2PATH)
```

### Reverse Mappings
To find which probes correspond to a specific gene or pathway, use `revmap()` or the specific reverse mapping objects provided.

```R
# Find probes for a specific Gene Symbol
probes_for_symbol <- mget("GAPDH", illuminaHumanv2ALIAS2PROBE)

# Find probes for a specific KEGG pathway
probes_in_pathway <- mget("04110", illuminaHumanv2PATH2PROBE)
```

## Database Utilities
Access the underlying SQLite database directly for complex queries.

```R
# Get database connection
conn <- illuminaHumanv2_dbconn()

# Count total probes in the database
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")

# View database schema
illuminaHumanv2_dbschema()
```

## Tips and Best Practices
- **Probe Quality Filtering**: Use `illuminaHumanv2PROBEQUALITY` to remove "Bad" or "No match" probes before downstream analysis to improve data reliability.
- **nuIDs**: Use `illuminaHumanv2NUID` for a universal naming scheme for oligonucleotides that is consistent across different Illumina platforms.
- **Map Counts**: Use `illuminaHumanv2MAPCOUNTS` to quickly check the number of mapped keys for any specific annotation object.

## Reference documentation
- [illuminaHumanv2.db Reference Manual](./references/reference_manual.md)