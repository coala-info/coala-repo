---
name: bioconductor-hugene11sttranscriptcluster.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hugene11sttranscriptcluster.db.html
---

# bioconductor-hugene11sttranscriptcluster.db

name: bioconductor-hugene11sttranscriptcluster.db
description: Annotation data for Affymetrix Human Gene 1.1 ST transcript cluster identifiers. Use when mapping manufacturer probe/transcript cluster IDs to biological identifiers like Entrez Gene IDs, Gene Symbols, GO terms, and KEGG pathways, or when retrieving genomic locations for these probes.

# bioconductor-hugene11sttranscriptcluster.db

## Overview

The `hugene11sttranscriptcluster.db` package is a Bioconductor annotation data package for the Affymetrix Human Gene 1.1 ST Array (transcript cluster level). It provides an SQLite-based interface to map manufacturer identifiers to various biological annotations. This package is essential for downstream analysis of microarray data, such as converting probe-level results into gene-level insights.

## Core Workflows

### Loading and Discovery

To use the package, load the library and explore the available fields:

```r
library(hugene11sttranscriptcluster.db)

# List available annotation types (columns)
columns(hugene11sttranscriptcluster.db)

# List available key types (usually PROBEID)
keytypes(hugene11sttranscriptcluster.db)

# Get a sample of manufacturer identifiers
head(keys(hugene11sttranscriptcluster.db, keytype = "PROBEID"))
```

### Using the select() Interface

The `select()` function is the recommended modern method for retrieving annotations.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("7900001", "7900003", "7900005")
res <- select(hugene11sttranscriptcluster.db, 
              keys = probes, 
              columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
              keytype = "PROBEID")
```

### Mapping to Functional Annotations

You can map probes to Gene Ontology (GO) terms or KEGG pathways for enrichment analysis.

```r
# Map to GO terms (includes Evidence and Ontology category)
go_mappings <- select(hugene11sttranscriptcluster.db, 
                      keys = probes, 
                      columns = "GO", 
                      keytype = "PROBEID")

# Map to KEGG Pathways
path_mappings <- select(hugene11sttranscriptcluster.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Legacy Bimap Interface

While `select()` is preferred, many scripts use the older Bimap interface.

```r
# Convert a mapping to a list
sym_list <- as.list(hugene11sttranscriptclusterSYMBOL)

# Get symbols for specific probes
my_symbols <- sym_list[c("7900001", "7900003")]

# Reverse mapping (e.g., Symbol to Probe)
rev_map <- as.list(hugene11sttranscriptclusterSYMBOL2PROBE)
probes_for_gene <- rev_map[["TP53"]]
```

### Genomic Locations

Retrieve chromosomal coordinates for transcript clusters:

```r
# Get chromosome and start position
locs <- select(hugene11sttranscriptcluster.db, 
               keys = probes, 
               columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
               keytype = "PROBEID")
```

## Tips and Best Practices

- **PROBEID vs ENTREZID**: In this package, the primary manufacturer keys are referred to as `PROBEID` in the `select` interface, representing the transcript cluster identifiers.
- **One-to-Many Mappings**: Be aware that one probe might map to multiple GO terms or Entrez IDs. The `select()` function returns a long-format data frame to handle this.
- **Database Connection**: Use `hugene11sttranscriptcluster_dbconn()` to access the underlying DBI connection if you need to perform custom SQL queries, but do not call `dbDisconnect()` on it.
- **Package Updates**: Bioconductor annotation packages are updated biannually. Ensure the version matches your data's era for the most accurate mappings.

## Reference documentation

- [hugene11sttranscriptcluster.db](./references/reference_manual.md)