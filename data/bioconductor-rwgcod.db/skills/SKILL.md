---
name: bioconductor-rwgcod.db
description: This package provides SQLite-based annotation mappings between manufacturer probe identifiers and biological metadata for the rwgcod rat genome platform. Use when user asks to map probe IDs to Entrez Gene IDs, symbols, GO terms, KEGG pathways, or chromosomal locations for rat genomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rwgcod.db.html
---


# bioconductor-rwgcod.db

name: bioconductor-rwgcod.db
description: Annotation data package for the rwgcod platform (Rattus norvegicus). Use when mapping manufacturer probe identifiers to biological metadata such as Entrez Gene IDs, symbols, GO terms, KEGG pathways, and chromosomal locations for rat genomic data.

# bioconductor-rwgcod.db

## Overview

The `rwgcod.db` package is a Bioconductor annotation data package specifically for the rwgcod platform (typically associated with rat genome arrays). It provides SQLite-based mappings between manufacturer probe identifiers and various biological databases.

## Core Workflows

### Loading the Package
```r
library(rwgcod.db)
# List all available mapping objects
ls("package:rwgcod.db")
```

### Basic Identifier Mapping
To map manufacturer IDs to common identifiers like Gene Symbols or Entrez IDs:

```r
# Map to Gene Symbols
mapped_probes <- mappedkeys(rwgcodSYMBOL)
symbol_list <- as.list(rwgcodSYMBOL[mapped_probes])

# Map to Entrez Gene IDs
entrez_list <- as.list(rwgcodENTREZID[mapped_probes])
```

### Functional Annotation (GO and KEGG)
Retrieve Gene Ontology (GO) terms or KEGG pathway information for specific probes:

```r
# Get GO annotations for the first 5 probes
go_annos <- as.list(rwgcodGO[1:5])

# Get KEGG pathway IDs
pathway_annos <- as.list(rwgcodPATH[1:5])
```

### Genomic Location
Find where probes are located on the rat genome:

```r
# Chromosome assignment
chroms <- as.list(rwgcodCHR[1:5])

# Chromosomal start positions
starts <- as.list(rwgcodCHRLOC[1:5])
```

### Reverse Mappings
Many objects have reverse maps (e.g., finding probes associated with a specific Gene Symbol or GO term):

```r
# Find probes for a specific alias/symbol
probes_by_alias <- as.list(rwgcodALIAS2PROBE)

# Find all probes associated with a GO ID
probes_by_go <- as.list(rwgcodGO2ALLPROBES[["GO:0008150"]])
```

## Database Information
To inspect the underlying database schema or connection:

```r
rwgcod_dbconn()    # Get the DBI connection object
rwgcod_dbschema()  # View the SQL schema
rwgcod_dbInfo()    # View metadata about the data sources
```

## Tips
- Use `mappedkeys()` to filter for identifiers that actually have a mapping to avoid `NA` values.
- For large-scale lookups, `as.list()` on the entire object can be memory-intensive; subset the object first using `[` before converting to a list.
- The `rwgcodGO2ALLPROBES` map is generally preferred over `rwgcodGO2PROBE` for functional analysis as it includes child terms in the GO hierarchy.

## Reference documentation
- [rwgcod.db Reference Manual](./references/reference_manual.md)