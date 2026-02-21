---
name: bioconductor-htrat230pm.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/htrat230pm.db.html
---

# bioconductor-htrat230pm.db

name: bioconductor-htrat230pm.db
description: Provides annotation data for the Affymetrix Rat Genome 230 PM array. Use when mapping manufacturer probe identifiers to biological metadata (Gene Symbols, Entrez IDs, GO terms, etc.) or vice versa for rat genomic studies.

# bioconductor-htrat230pm.db

## Overview

The `htrat230pm.db` package is a Bioconductor annotation data package for the Affymetrix Rat Genome 230 PM (Perfect Match) platform. It provides comprehensive mappings between manufacturer probe identifiers and various gene-centric identifiers such as Entrez Gene IDs, Gene Symbols, RefSeq accessions, and functional annotations like Gene Ontology (GO) and KEGG pathways.

## Core Workflows

### Loading the Package and Exploring Columns

To use the package, load it into your R session and use the `columns()` function to see available annotation types.

```r
library(htrat230pm.db)

# List available annotation types
columns(htrat230pm.db)

# List available key types (usually PROBEID)
keytypes(htrat230pm.db)
```

### Using the select() Interface

The recommended way to retrieve data is using the `select()` function from the `AnnotationDbi` package.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1367452_at", "1367453_at", "1367454_at")
results <- select(htrat230pm.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping to Functional Annotations

You can map probes to GO terms or KEGG pathways for functional analysis.

```r
# Map probes to GO terms with evidence codes
go_mappings <- select(htrat230pm.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Map probes to KEGG pathways
path_mappings <- select(htrat230pm.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Legacy Bimap Interface

While `select()` is preferred, you can still use the older Bimap interface for specific mappings.

```r
# Get all probe IDs mapped to a Gene Symbol
x <- htrat230pmSYMBOL
mapped_probes <- mappedkeys(x)
# Convert to a list
symbol_list <- as.list(x[mapped_probes][1:5])

# Reverse mapping: Find probes for a specific alias
alias_map <- as.list(htrat230pmALIAS2PROBE)
probes_for_gene <- alias_map[["Abc1"]]
```

## Database Information

To get metadata about the database, such as the organism or the data source timestamps:

```r
# Get organism name
htrat230pmORGANISM

# Get database schema and connection info
htrat230pm_dbschema()
htrat230pm_dbInfo()
```

## Tips

- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Official Symbols**: Use `htrat230pmSYMBOL` for official gene symbols and `htrat230pmALIAS2PROBE` for common aliases or synonyms.
- **Chromosomal Locations**: `htrat230pmCHRLOC` provides the start position, while `htrat230pmCHRLOCEND` provides the end position. Negative values indicate the antisense strand.

## Reference documentation

- [htrat230pm.db Reference Manual](./references/reference_manual.md)