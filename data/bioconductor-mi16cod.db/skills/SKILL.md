---
name: bioconductor-mi16cod.db
description: This package provides SQLite-based annotation mappings for the mi16cod platform to facilitate mouse genomic data analysis. Use when user asks to map manufacturer probe identifiers to Entrez Gene IDs, gene symbols, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mi16cod.db.html
---


# bioconductor-mi16cod.db

name: bioconductor-mi16cod.db
description: Annotation data for the mi16cod platform. Use when mapping manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, Gene Symbols, GO terms, KEGG pathways, and chromosomal locations for mouse genomic data analysis.

# bioconductor-mi16cod.db

## Overview

The `mi16cod.db` package is a Bioconductor annotation data package for the mi16cod platform (primarily used for mouse genomic studies). It provides SQLite-based mappings between manufacturer probe identifiers and various gene-centric identifiers.

## Core Workflows

### Loading and Exploration

To begin using the package, load the library and list available mapping objects:

```r
library(mi16cod.db)
# List all available mapping objects
ls("package:mi16cod.db")
```

### Basic Mapping Pattern

Most objects in this package follow a standard mapping interface. To extract data:

1.  Assign the map to a variable.
2.  Identify mapped keys.
3.  Convert to a list or data frame.

```r
# Example: Mapping probes to Entrez Gene IDs
x <- mi16codENTREZID
mapped_probes <- mappedkeys(x)
# Convert to a list for the first 5 probes
as.list(x[mapped_probes[1:5]])
```

### Common Annotation Tasks

#### Gene Symbols and Names
Map manufacturer IDs to official gene symbols or descriptive names:

```r
# Get Gene Symbols
symbols <- as.list(mi16codSYMBOL)
# Get Full Gene Names
names <- as.list(mi16codGENENAME)
```

#### Gene Ontology (GO)
Retrieve GO identifiers, including ontology category (BP, CC, MF) and evidence codes (e.g., IDA, IEA, TAS):

```r
# Map probes to GO terms
go_mapping <- as.list(mi16codGO)
# Access specific details for a probe
probe_go <- go_mapping[[1]]
probe_go[[1]][["GOID"]]
probe_go[[1]][["Ontology"]]
probe_go[[1]][["Evidence"]]
```

#### KEGG Pathways
Map probes to KEGG pathway identifiers for functional analysis:

```r
# Probes to Pathways
pathways <- as.list(mi16codPATH)
# Pathways to Probes (Reverse Map)
path_to_probes <- as.list(mi16codPATH2PROBE)
```

#### Chromosomal Locations
Find the chromosome and specific base pair start/end positions:

```r
# Chromosome assignment
chroms <- as.list(mi16codCHR)
# Chromosomal start position
locs <- as.list(mi16codCHRLOC)
```

### Database Utilities

For advanced users, you can access the underlying SQLite database directly:

```r
# Get a connection object
conn <- mi16cod_dbconn()
# Show database schema
mi16cod_dbschema()
# Execute custom SQL
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips for Efficient Usage

- **Reverse Mappings**: Many objects have built-in reverse maps (e.g., `mi16codSYMBOL2PROBE`). If one isn't explicitly named, use `revmap(mi16codSYMBOL)`.
- **Map Counts**: Use `mi16codMAPCOUNTS` to quickly check the number of mapped keys for every object in the package.
- **Filtering**: Always use `mappedkeys()` to filter out probes that do not have an associated annotation before converting to a list to save memory and processing time.

## Reference documentation

- [mi16cod.db Reference Manual](./references/reference_manual.md)