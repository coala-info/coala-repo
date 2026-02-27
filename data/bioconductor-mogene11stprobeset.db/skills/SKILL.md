---
name: bioconductor-mogene11stprobeset.db
description: This package provides annotation data for the Affymetrix Mouse Gene 1.1 ST Array at the probeset level. Use when user asks to map mouse probe identifiers to gene symbols, Entrez IDs, genomic locations, or functional annotations like GO and KEGG.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mogene11stprobeset.db.html
---


# bioconductor-mogene11stprobeset.db

name: bioconductor-mogene11stprobeset.db
description: Provides annotation data for the Affymetrix Mouse Gene 1.1 ST Array (probeset level). Use this skill to map manufacturer probe identifiers to various biological identifiers (Entrez Gene, Gene Symbol, Ensembl, GO, KEGG, etc.) and genomic locations for Mus musculus.

## Overview

The `mogene11stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Mouse Gene 1.1 ST platform. It provides a SQLite-based interface to map probe identifiers to genomic metadata. While it supports older "Bimap" interfaces, the recommended way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package

```R
library(mogene11stprobeset.db)
```

### Discovering Available Data

To see what types of data (columns) can be retrieved and what keys can be used:

```R
# List available columns
columns(mogene11stprobeset.db)

# List available key types (usually same as columns)
keytypes(mogene11stprobeset.db)

# Get a sample of probe IDs (keys)
head(keys(mogene11stprobeset.db))
```

### Mapping Probes to Gene Symbols and Names

The most common task is converting manufacturer probe IDs to human-readable gene symbols or Entrez IDs.

```R
probe_ids <- c("10338001", "10338002", "10338003")

# Using select() to get Symbols and Entrez IDs
results <- select(mogene11stprobeset.db, 
                  keys = probe_ids, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Functional Annotation (GO and KEGG)

Map probes to Gene Ontology (GO) terms or KEGG pathways for enrichment analysis.

```R
# Get GO terms for specific probes
go_mappings <- select(mogene11stprobeset.db, 
                      keys = probe_ids, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Get KEGG Pathway IDs
path_mappings <- select(mogene11stprobeset.db, 
                        keys = probe_ids, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Genomic Location

Retrieve chromosome and start/end positions.

```R
loc_data <- select(mogene11stprobeset.db, 
                   keys = probe_ids, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

## Legacy Bimap Interface

If working with older code, you may encounter the Bimap interface. Note that `as.list()` on these objects can be memory-intensive.

```R
# Map probes to symbols
x <- mogene11stprobesetSYMBOL
mapped_probes <- mappedkeys(x)
xx <- as.list(x[mapped_probes][1:5])

# Reverse mapping (e.g., Symbols to Probes)
rev_map <- as.list(mogene11stprobesetALIAS2PROBE)
```

## Database Connection Information

To inspect the underlying SQLite database or schema:

```R
# Get database connection
conn <- mogene11stprobeset_dbconn()

# Show database schema
mogene11stprobeset_dbschema()

# Get metadata about the data sources
mogene11stprobeset_dbInfo()
```

## Tips for Success

- **One-to-Many Mappings**: Be aware that `select()` may return more rows than input keys if a probe maps to multiple genes or GO terms.
- **Organism Check**: This package is specific to *Mus musculus*. Use `mogene11stprobesetORGANISM` to verify.
- **Package Updates**: These annotation packages are updated biannually by Bioconductor; ensure your package version matches your data's era.

## Reference documentation

- [mogene11stprobeset.db Reference Manual](./references/reference_manual.md)