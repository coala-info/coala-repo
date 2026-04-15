---
name: bioconductor-lumihumanall.db
description: This package provides comprehensive annotation data and identifier mappings for the Illumina HumanAll BeadChip platform. Use when user asks to map Illumina probe identifiers to biological metadata, retrieve Gene Ontology terms or KEGG pathways, and find chromosomal locations for human genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/lumiHumanAll.db.html
---

# bioconductor-lumihumanall.db

name: bioconductor-lumihumanall.db
description: Provides annotation data for the Illumina HumanAll BeadChip platform. Use this skill when you need to map manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and PubMed references for human genomic data.

# bioconductor-lumihumanall.db

## Overview

The `lumiHumanAll.db` package is a Bioconductor annotation data package that provides comprehensive mappings for the Illumina HumanAll platform. It functions as an SQLite-based environment containing multiple R objects (AnnDbObj), each representing a specific mapping between manufacturer probe identifiers and various public database identifiers.

## Installation and Loading

To use this skill, the package must be installed and loaded in your R environment:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("lumiHumanAll.db")
library(lumiHumanAll.db)
```

## Core Workflows

### 1. Exploring Available Mappings
To see all available annotation objects provided by the package:

```R
ls("package:lumiHumanAll.db")
```

### 2. Basic Identifier Mapping
Most objects map manufacturer IDs to a specific attribute. Use `as.list()` to convert the mapping object for easy access.

```R
# Map Probes to Gene Symbols
probes_to_symbol <- as.list(lumiHumanAllSYMBOL)
# Access a specific probe
probes_to_symbol[["10001"]] 

# Map Probes to Entrez Gene IDs
probes_to_entrez <- as.list(lumiHumanAllENTREZID)
```

### 3. Reverse Mappings
Many mappings have built-in reverse objects (e.g., mapping from a Gene Symbol back to Probes).

```R
# Map Gene Aliases to Probes
alias_to_probes <- as.list(lumiHumanAllALIAS2PROBE)

# Map Ensembl IDs to Probes
ensembl_to_probes <- as.list(lumiHumanAllENSEMBL2PROBE)
```

### 4. Functional Annotation (GO and KEGG)
The package provides deep integration with Gene Ontology (GO) and KEGG pathways.

```R
# Get GO annotations for a probe
go_annots <- as.list(lumiHumanAllGO)
# Each entry contains GOID, Ontology (BP, CC, MF), and Evidence code

# Get KEGG pathways for a probe
kegg_paths <- as.list(lumiHumanAllPATH)
```

### 5. Chromosomal Location and Mapping
Retrieve physical location data for probes.

```R
# Get chromosome for probes
probe_chr <- as.list(lumiHumanAllCHR)

# Get start position (base pairs)
probe_start <- as.list(lumiHumanAllCHRLOC)

# Get cytogenetic band
probe_map <- as.list(lumiHumanAllMAP)
```

## Database Utilities

You can query the underlying SQLite database directly for complex joins or metadata:

```R
# Get database connection
conn <- lumiHumanAll_dbconn()

# List tables
dbListTables(conn)

# Get database schema
lumiHumanAll_dbschema()

# Get counts of mapped keys for all objects
lumiHumanAllMAPCOUNTS
```

## Tips for Efficient Usage
- **Filtering**: Use `mappedkeys(x)` to get only the probe identifiers that have a valid mapping in a specific object.
- **Memory**: Converting large objects to lists (`as.list()`) can be memory-intensive. For large-scale lookups, consider using `mget()` or `AnnotationDbi::select()`.
- **Consistency**: Mappings are based on specific snapshots (e.g., Entrez Gene data from 2013). Always check `lumiHumanAll_dbInfo()` for data source timestamps.

## Reference documentation
- [lumiHumanAll.db Reference Manual](./references/reference_manual.md)