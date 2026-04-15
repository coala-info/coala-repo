---
name: bioconductor-ragene10stprobeset.db
description: This Bioconductor package provides SQLite-based annotation data for mapping Affymetrix Rat Gene 1.0 ST Array probeset identifiers to genomic and functional information. Use when user asks to map probe IDs to gene symbols, retrieve Entrez IDs, access Gene Ontology terms, or find chromosomal locations for rat gene expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ragene10stprobeset.db.html
---

# bioconductor-ragene10stprobeset.db

## Overview

The `ragene10stprobeset.db` package is a Bioconductor annotation data package for the Affymetrix Rat Gene 1.0 ST Array, specifically for probeset-level identifiers. It provides a SQLite-based interface to map probe IDs to genomic locations, functional annotations, and cross-database identifiers.

## Core Workflows

### Loading the Package and Exploring Columns

To begin, load the library and inspect the available annotation types (columns).

```r
library(ragene10stprobeset.db)

# List available annotation types
columns(ragene10stprobeset.db)

# List available key types (usually PROBEID)
keytypes(ragene10stprobeset.db)
```

### Using the select() Interface

The `select()` function is the recommended method for retrieving data. It allows you to map a vector of probe IDs to specific annotations.

```r
# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10700001", "10700003", "10700004")
results <- select(ragene10stprobeset.db, 
                  keys = probes, 
                  columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                  keytype = "PROBEID")
```

### Mapping to Functional Annotations (GO and KEGG)

You can map probes to Gene Ontology (GO) terms or KEGG pathways for functional analysis.

```r
# Map probes to GO terms
go_mappings <- select(ragene10stprobeset.db, 
                      keys = probes, 
                      columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                      keytype = "PROBEID")

# Map probes to KEGG Pathways
path_mappings <- select(ragene10stprobeset.db, 
                        keys = probes, 
                        columns = "PATH", 
                        keytype = "PROBEID")
```

### Reverse Mappings (Alias to Probe)

If you have gene symbols (aliases) and need to find the corresponding probes on the array:

```r
# Find probes for specific gene aliases
aliases <- c("Tp53", "Brca1")
probe_ids <- select(ragene10stprobeset.db, 
                    keys = aliases, 
                    columns = "PROBEID", 
                    keytype = "ALIAS")
```

### Accessing Chromosomal Information

Retrieve chromosome names, lengths, and specific gene start/end positions.

```r
# Get chromosome for probes
chr_info <- select(ragene10stprobeset.db, 
                   keys = probes, 
                   columns = "CHR", 
                   keytype = "PROBEID")

# Get chromosome lengths (returns a named vector)
lengths <- ragene10stprobesetCHRLENGTHS
chr1_len <- lengths["1"]
```

## Legacy Bimap Interface

While `select()` is preferred, you can still use the older Bimap interface for specific tasks like converting the entire map to a list.

```r
# Convert Symbol map to a list
symbol_list <- as.list(ragene10stprobesetSYMBOL)

# Get probes that have an assigned Entrez ID
mapped_probes <- mappedkeys(ragene10stprobesetENTREZID)
```

## Database Connection and Metadata

You can inspect the underlying SQLite database metadata or connection.

```r
# Get database schema
ragene10stprobeset_dbschema()

# Get organism information
ragene10stprobesetORGANISM
```

## Reference documentation

- [ragene10stprobeset.db Reference Manual](./references/reference_manual.md)