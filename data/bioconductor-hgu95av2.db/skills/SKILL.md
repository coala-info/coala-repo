---
name: bioconductor-hgu95av2.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95av2.db.html
---

# bioconductor-hgu95av2.db

name: bioconductor-hgu95av2.db
description: Use this skill to perform gene annotation and mapping for the Affymetrix Human Genome U95 Set (hgu95av2) platform. This includes mapping manufacturer probe identifiers to Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and Ensembl identifiers. Use this when you need to annotate microarray data or translate between different biological database identifiers for this specific platform.

# bioconductor-hgu95av2.db

## Overview
The `hgu95av2.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U95 Set. It provides an SQLite-based interface to map manufacturer probe identifiers to various biological metadata. While it supports older "Bimap" interfaces, the modern recommended approach is using the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(hgu95av2.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```r
# List available columns
columns(hgu95av2.db)

# List available keytypes
keytypes(hgu95av2.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
select(hgu95av2.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mapping Tasks

#### Mapping to Gene Ontology (GO)
To get GO terms associated with probes, including evidence codes and ontologies (BP, CC, MF):
```r
select(hgu95av2.db, keys = probes, columns = "GO", keytype = "PROBEID")
```

#### Mapping to KEGG Pathways
To identify biological pathways associated with specific probes:
```r
select(hgu95av2.db, keys = probes, columns = "PATH", keytype = "PROBEID")
```

#### Chromosomal Locations
To find the start and end positions of genes on chromosomes:
```r
select(hgu95av2.db, keys = probes, columns = c("CHR", "CHRLOC", "CHRLOCEND"), keytype = "PROBEID")
```

### Database Connection and Metadata
You can inspect the underlying database schema or connection information if needed for custom SQL queries:
```r
# Get database connection
conn <- hgu95av2_dbconn()

# Show database schema
hgu95av2_dbschema()

# Get number of rows in the probes table via SQL
library(DBI)
dbGetQuery(hgu95av2_dbconn(), "SELECT COUNT(*) FROM probes")
```

## Tips and Best Practices
- **Bimap vs Select**: While you may see older code using `as.list(hgu95av2SYMBOL)`, the `select()` interface is more robust and consistent across Bioconductor.
- **Handling NAs**: Not every probe identifier maps to every metadata type. `select()` will return `NA` for missing mappings.
- **One-to-Many Mappings**: Be aware that one probe can map to multiple GO terms or pathways. This will result in a data frame with more rows than the number of input keys.
- **Alias Mapping**: If you have common gene symbols and want to find the corresponding manufacturer probes, use the `ALIAS2PROBE` mapping.

## Reference documentation
- [hgu95av2.db Reference Manual](./references/reference_manual.md)