---
name: bioconductor-hgu95a.db
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95a.db.html
---

# bioconductor-hgu95a.db

name: bioconductor-hgu95a.db
description: Provides annotation data for the Affymetrix Human Genome U95 Set (hgu95a). Use this skill to map manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, RefSeq, GO terms, and KEGG pathways, or to retrieve genomic locations and chromosome metadata for the hgu95a platform.

## Overview

The hgu95a.db package is a Bioconductor annotation data package for the Affymetrix Human Genome U95 Set. It provides an SQLite-based interface to map manufacturer probe identifiers to various genomic and functional annotations. The primary way to interact with this data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### 1. Exploring Available Data
Before querying, identify what types of data (columns) and identifiers (keys) are available.

```r
library(hgu95a.db)

# List all available annotation types
columns(hgu95a.db)

# List available key types (usually PROBEID)
keytypes(hgu95a.db)

# Get a sample of probe identifiers
head(keys(hgu95a.db, keytype="PROBEID"))
```

### 2. Mapping Probes to Gene Symbols and Entrez IDs
Use the `select()` function for a tabular output of mappings.

```r
probes <- c("1000_at", "1001_at", "1002_f_at")

# Map probes to Symbols and Entrez IDs
results <- select(hgu95a.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
print(results)
```

### 3. Functional Annotation (GO and KEGG)
Retrieve Gene Ontology (GO) terms or KEGG pathway identifiers associated with specific probes.

```r
# Get GO terms with evidence codes and ontology categories
go_mappings <- select(hgu95a.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Get KEGG pathway IDs
path_mappings <- select(hgu95a.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### 4. Genomic Location and Metadata
Retrieve chromosome information and physical locations.

```r
# Map probes to chromosomes and cytobands
loc_data <- select(hgu95a.db, 
                   keys = probes, 
                   columns = c("CHR", "MAP"), 
                   keytype = "PROBEID")

# Get chromosome lengths (returns a named vector)
chr_lengths <- hgu95aCHRLENGTHS
chr_lengths["1"]
```

### 5. Using the Bimap Interface (Legacy)
While `select()` is preferred, the "Bimap" interface is useful for converting entire maps to lists.

```r
# Convert Probe-to-Symbol map to a list
symbol_list <- as.list(hgu95aSYMBOL)

# Access specific probe
symbol_list[["1000_at"]]

# Get all probes that have an assigned symbol
mapped_probes <- mappedkeys(hgu95aSYMBOL)
```

## Database Connection and Schema
For advanced users needing direct SQL access:

```r
# Get the SQLite connection object
conn <- hgu95a_dbconn()

# Show the database schema
hgu95a_dbschema()

# Execute a custom SQL query
library(DBI)
dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")
```

## Tips and Best Practices
- **Prefer select()**: The `select()` function is more robust and handles 1:many mappings more cleanly than the legacy Bimap interface.
- **Handle NAs**: Not every probe maps to every annotation type; always check for `NA` values in your results.
- **Reverse Mappings**: To map from a Symbol back to Probes, use `select()` with `keytype="SYMBOL"` or use the `hgu95aALIAS2PROBE` object.
- **Version Consistency**: Ensure your `hgu95a.db` version matches your Bioconductor release to maintain data integrity.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)