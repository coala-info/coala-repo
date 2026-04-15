---
name: bioconductor-mu11ksubb.db
description: This package provides annotation data for the Affymetrix Murine 11K Sub B chip to map probe identifiers to biological metadata. Use when user asks to map mouse probe IDs to gene symbols, Entrez IDs, functional annotations like GO and KEGG, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mu11ksubb.db.html
---

# bioconductor-mu11ksubb.db

name: bioconductor-mu11ksubb.db
description: Annotation data for the Affymetrix Murine 11K Sub B chip. Use when mapping manufacturer probe identifiers to biological identifiers (Entrez Gene, MGI, Ensembl, SYMBOL), functional annotations (GO, KEGG), or chromosomal locations for mouse genomic data.

## Overview

The `mu11ksubb.db` package is a Bioconductor annotation hub for the Affymetrix Murine 11K Sub B platform. It provides a SQLite-based infrastructure to map probe set IDs to various genomic and functional metadata. While it supports the legacy Bimap interface, the modern `AnnotationDbi` `select()` interface is the preferred method for data retrieval.

## Core Workflows

### Loading the Package and Exploring Columns

Load the library and inspect available data types (columns) and valid keys.

```R
library(mu11ksubb.db)

# List available annotation types
columns(mu11ksubb.db)

# List available key types (usually PROBEID)
keytypes(mu11ksubb.db)

# View the first few probe IDs
head(keys(mu11ksubb.db, keytype="PROBEID"))
```

### Using the select() Interface

The `select()` function is the primary way to retrieve multiple annotations for a set of probes.

```R
probes <- c("92201_at", "92202_at", "92203_at")

# Map probes to Gene Symbols and Entrez IDs
results <- select(mu11ksubb.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Functional Annotation (GO and KEGG)

Retrieve Gene Ontology (GO) terms or KEGG pathway identifiers associated with specific probes.

```R
# Get GO terms with evidence codes
go_data <- select(mu11ksubb.db, 
                  keys = probes, 
                  columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                  keytype = "PROBEID")

# Get KEGG pathway IDs
path_data <- select(mu11ksubb.db, 
                    keys = probes, 
                    columns = "PATH", 
                    keytype = "PROBEID")
```

### Chromosomal Mapping

Find the chromosomal location and starting/ending positions for genes represented by the probes.

```R
# Map to chromosome and start position
loc_data <- select(mu11ksubb.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
                   keytype = "PROBEID")
```

### Legacy Bimap Interface

For specific mappings, you can use the older Bimap objects. This is useful for quick list conversions.

```R
# Convert probe-to-symbol mapping to a list
symbol_list <- as.list(mu11ksubbSYMBOL)

# Access a specific probe
symbol_list[["92201_at"]]

# Reverse mapping: Find probes for a specific Gene Symbol
alias_map <- as.list(mu11ksubbALIAS2PROBE)
probes_for_gene <- alias_map[["Akt1"]]
```

## Database Information

To inspect the underlying SQLite database schema or connection details:

```R
# Get database connection
conn <- mu11ksubb_dbconn()

# Show database schema
mu11ksubb_dbschema()

# Get row count for the probes table
library(DBI)
dbGetQuery(conn, "SELECT COUNT(*) FROM probes")
```

## Tips and Best Practices

- **Official Symbols**: Use `mu11ksubbSYMBOL` for official gene symbols and `mu11ksubbALIAS2PROBE` for common aliases or historical symbols.
- **Evidence Codes**: When working with GO terms, pay attention to the `EVIDENCE` column to distinguish between experimental data (e.g., IDA) and electronic annotations (IEA).
- **Multiple Mappings**: Note that one probe ID may map to multiple Entrez IDs or GO terms; `select()` will return a long-format data frame containing all matches.
- **Organism Context**: This package is specific to *Mus musculus*. Ensure your input data matches this organism.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)