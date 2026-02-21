---
name: bioconductor-hthgu133a.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hthgu133a.db.html
---

# bioconductor-hthgu133a.db

name: bioconductor-hthgu133a.db
description: Comprehensive annotation data for the Affymetrix Human Genome U133A (HT-HG-U133A) platform. Use when mapping manufacturer probe identifiers to biological metadata like Entrez Gene IDs, Symbols, GO terms, KEGG pathways, and chromosomal locations in R.

## Overview
The `hthgu133a.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U133A platform. It provides mappings between manufacturer probe identifiers and various gene-centric identifiers, allowing researchers to annotate microarray results with biological context. The package uses an SQLite database backend and is accessed primarily through the `AnnotationDbi` interface.

## Core Usage

### Loading the Package
```R
library(hthgu133a.db)
```

### The select() Interface (Recommended)
The `select()` function is the modern, unified way to query annotation packages.

```R
# View all available types of data (columns)
columns(hthgu133a.db)

# View available key types (usually PROBEID)
keytypes(hthgu133a.db)

# Map specific probe IDs to Symbols and Entrez IDs
probes <- c("1007_s_at", "1053_at", "117_at")
select(hthgu133a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Bimap Interface (Legacy)
While `select()` is preferred, specific mapping objects (Bimaps) are available for direct access or list conversion.

```R
# Convert a mapping to a list
sym_list <- as.list(hthgu133aSYMBOL)
# Access a specific probe
sym_list[["1007_s_at"]]

# Get all mapped probe IDs for a specific map
mapped_probes <- mappedkeys(hthgu133aENTREZID)
```

## Common Annotation Workflows

### Gene Ontology (GO) Analysis
The GO mapping returns a list of lists containing the GO ID, Ontology (BP, CC, MF), and Evidence code.

```R
# Get GO annotations for probes
go_annots <- select(hthgu133a.db, keys = probes, columns = "GO", keytype = "PROBEID")

# Using the Bimap interface for detailed evidence
as.list(hthgu133aGO[["1007_s_at"]])
```

### Pathway Mapping
Map probes to KEGG pathway identifiers.

```R
# Get KEGG IDs
select(hthgu133a.db, keys = probes, columns = "PATH", keytype = "PROBEID")
```

### Reverse Mapping (Symbols to Probes)
To find which probes represent a specific gene:

```R
# Using the ALIAS2PROBE map
alias_map <- as.list(hthgu133aALIAS2PROBE)
alias_map[["GAPDH"]]
```

## Database Inspection
You can access the underlying SQLite connection for complex SQL queries.

```R
# Get the DB connection object
conn <- hthgu133a_dbconn()

# Show database schema
hthgu133a_dbschema()

# Count total probes in the database
library(DBI)
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips
- **Version Consistency**: Mappings are based on specific Entrez Gene snapshots (e.g., April 2021). Check `hthgu133a_dbInfo()` for exact source dates.
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or Symbols. `select()` will return a data frame with one row per mapping.
- **NA Values**: Probes that cannot be mapped to a specific resource will return `NA`.

## Reference documentation
- [hthgu133a.db Reference Manual](./references/reference_manual.md)