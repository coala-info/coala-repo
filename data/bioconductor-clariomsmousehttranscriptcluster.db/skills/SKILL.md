---
name: bioconductor-clariomsmousehttranscriptcluster.db
description: This package provides annotation data for the Clariom S Mouse HT Transcript Cluster array by mapping manufacturer probe identifiers to various biological identifiers. Use when user asks to map probe IDs to gene symbols, retrieve Entrez or Ensembl identifiers, or perform Gene Ontology and KEGG pathway lookups for mouse transcriptomic data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/clariomsmousehttranscriptcluster.db.html
---

# bioconductor-clariomsmousehttranscriptcluster.db

name: bioconductor-clariomsmousehttranscriptcluster.db
description: Annotation data for the Clariom S Mouse HT Transcript Cluster array. Use when mapping manufacturer probe identifiers to biological identifiers (Entrez, Symbol, Ensembl, GO, etc.) for mouse transcriptomic data analysis.

## Overview
The `clariomsmousehttranscriptcluster.db` package is a Bioconductor annotation data package for the Clariom S Mouse HT Transcript Cluster platform. It provides a comprehensive set of mappings between manufacturer probe IDs and various gene-centric identifiers. The package uses an SQLite database backend and is primarily accessed via the `AnnotationDbi` interface.

## Installation and Loading
To use this skill, the package must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("clariomsmousehttranscriptcluster.db")

library(clariomsmousehttranscriptcluster.db)
```

## Core Workflows

### Using the select() Interface
The recommended way to interact with this package is using the `select()`, `keys()`, `columns()`, and `keytypes()` functions.

```r
# 1. List available columns (data types)
columns(clariomsmousehttranscriptcluster.db)

# 2. List available keytypes (usually same as columns)
keytypes(clariomsmousehttranscriptcluster.db)

# 3. Retrieve specific mappings for a set of probe IDs
probes <- head(keys(clariomsmousehttranscriptcluster.db))
results <- select(clariomsmousehttranscriptcluster.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Common Annotation Mappings
- **SYMBOL**: Official Gene Symbols.
- **ENTREZID**: Entrez Gene Identifiers.
- **ENSEMBL**: Ensembl Gene Accession Numbers.
- **GENENAME**: Full Gene Name.
- **GO**: Gene Ontology Identifiers (includes Evidence and Ontology category).
- **PATH**: KEGG Pathway Identifiers.
- **MGI**: Mouse Genome Informatics Accession Numbers.

### Reverse Mapping (Alias to Probe)
To find probe IDs associated with a specific gene symbol or alias:

```r
select(clariomsmousehttranscriptcluster.db, 
       keys = "Tp53", 
       columns = "PROBEID", 
       keytype = "ALIAS")
```

### Chromosomal Locations
You can retrieve the chromosome and starting position for probes:

```r
select(clariomsmousehttranscriptcluster.db, 
       keys = probes, 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "PROBEID")
```

## Legacy Bimap Interface
While `select()` is preferred, the package supports older Bimap objects for specific lookups:

```r
# Get a list of probe to Entrez ID mappings
x <- clariomsmousehttranscriptclusterENTREZID
mapped_probes <- mappedkeys(x)
as.list(x[mapped_probes][1:5])
```

## Database Connection Information
For advanced users needing direct SQL access, use the connection functions:

```r
# Get the SQLite database file path
clariomsmousehttranscriptcluster_dbfile()

# Get the database schema
clariomsmousehttranscriptcluster_dbschema()

# Direct SQL query example
conn <- clariomsmousehttranscriptcluster_dbconn()
DBI::dbGetQuery(conn, "SELECT * FROM probes LIMIT 5")
```

## Reference documentation
- [Reference Manual](./references/reference_manual.md)