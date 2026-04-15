---
name: bioconductor-porcine.db
description: This package provides comprehensive annotation data and identifier mappings for the Sus scrofa genome. Use when user asks to map porcine probe IDs to gene symbols, retrieve Entrez or Ensembl identifiers, find chromosomal locations, or identify Gene Ontology terms and KEGG pathways for pig genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/porcine.db.html
---

# bioconductor-porcine.db

name: bioconductor-porcine.db
description: Provides annotation data for the Sus scrofa (pig) genome. Use this skill when you need to map between different porcine gene identifiers (Entrez, GenBank, RefSeq, Ensembl, UniProt), find chromosomal locations, retrieve Gene Ontology (GO) terms, or identify KEGG pathways for porcine probes and genes.

# bioconductor-porcine.db

## Overview

The `porcine.db` package is a Bioconductor annotation data package for the porcine (pig) genome. It provides a comprehensive set of SQLite-based mappings between manufacturer identifiers (probes) and various biological databases. This skill guides you through querying these mappings using the modern `AnnotationDbi` interface.

## Core Workflows

### Loading the Package
```R
library(porcine.db)
```

### Exploring Available Data
To see what types of data (columns) can be retrieved and what keys can be used for filtering:
```R
# List available columns (e.g., SYMBOL, ENTREZID, GO, PATH)
columns(porcine.db)

# List available key types (usually the same as columns)
keytypes(porcine.db)

# Preview the first few manufacturer probe IDs
head(keys(porcine.db))
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. It requires the database object, the keys you are searching for, the columns you want to retrieve, and the keytype of your input.

```R
# Map specific probe IDs to Gene Symbols and Entrez IDs
probes <- c("Ssc.100.1.S1_at", "Ssc.1000.1.A1_at")
select(porcine.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Mapping to Biological Pathways and Functions
You can retrieve Gene Ontology (GO) terms or KEGG pathway IDs for specific probes.

```R
# Get GO terms for a set of probes
select(porcine.db, 
       keys = probes, 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")

# Get KEGG pathway IDs
select(porcine.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Reverse Mappings
You can search using identifiers other than probe IDs by changing the `keytype`.

```R
# Find all probes associated with a specific Gene Symbol
select(porcine.db, 
       keys = "ALB", 
       columns = "PROBEID", 
       keytype = "SYMBOL")
```

## Legacy Bimap Interface
While `select()` is preferred, you can still use the older Bimap interface for specific list-based operations.

```R
# Convert a map to a list
symbol_list <- as.list(porcineSYMBOL)
# Access a specific probe
symbol_list[["Ssc.100.1.S1_at"]]
```

## Database Information
To check the metadata or the underlying database schema:
```R
# Get organism information
porcineORGANISM
porcineORGPKG

# Get database connection details
porcine_dbconn()
porcine_dbschema()
```

## Tips for Success
- **NAs**: Many probes may not map to a specific database (e.g., no known GO term). `select()` will return `NA` for these entries.
- **One-to-Many**: Note that one probe can map to multiple GO terms or pathways. This will result in a data frame with more rows than the number of input keys.
- **Evidence Codes**: When retrieving GO data, use the `EVIDENCE` column to filter by the quality of the annotation (e.g., "IDA" for direct assay, "IEA" for electronic annotation).

## Reference documentation
- [reference_manual.md](./references/reference_manual.md)