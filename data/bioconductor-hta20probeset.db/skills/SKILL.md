---
name: bioconductor-hta20probeset.db
description: This package provides annotation data for mapping Affymetrix Human Transcriptome Array 2.0 probeset identifiers to biological and functional metadata. Use when user asks to map probeset IDs to gene symbols, Entrez IDs, GO terms, KEGG pathways, or genomic locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hta20probeset.db.html
---


# bioconductor-hta20probeset.db

name: bioconductor-hta20probeset.db
description: Annotation data for the Affymetrix HTA-2.0 (Human Transcriptome Array 2.0) probeset identifiers. Use this skill to map manufacturer probeset IDs to biological identifiers like Entrez Gene IDs, Symbols, GO terms, KEGG pathways, and genomic locations.

## Overview

The `hta20probeset.db` package is a Bioconductor annotation data package for the Affymetrix Human Transcriptome Array 2.0. It provides an SQLite-based interface to map probeset identifiers to various genomic and functional annotations. The primary method for interaction is the `select()` interface from the `AnnotationDbi` package, though legacy Bimap objects are also available.

## Core Workflows

### Loading the Package
```r
library(hta20probeset.db)
```

### Exploring Available Annotations
To see which types of data (columns) can be retrieved:
```r
columns(hta20probeset.db)
```

To see the types of identifiers you can use as input (keys):
```r
keytypes(hta20probeset.db)
```

### Mapping Probeset IDs to Gene Symbols and Entrez IDs
The most common task is converting manufacturer IDs to standard gene identifiers.
```r
probes <- c("17114406", "17114407", "17114408")
select(hta20probeset.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Functional Annotation (GO and KEGG)
Map probesets to Gene Ontology (GO) terms or KEGG pathways for enrichment analysis.
```r
# Get GO terms for specific probes
select(hta20probeset.db, 
       keys = probes, 
       columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
       keytype = "PROBEID")

# Get KEGG pathways
select(hta20probeset.db, 
       keys = probes, 
       columns = "PATH", 
       keytype = "PROBEID")
```

### Genomic Location
Retrieve chromosome and start/end positions.
```r
select(hta20probeset.db, 
       keys = probes, 
       columns = c("CHR", "CHRLOC", "CHRLOCEND"), 
       keytype = "PROBEID")
```

## Legacy Bimap Interface
While `select()` is preferred, you can use the older Bimap objects for specific mappings:
- `hta20probesetSYMBOL`: Probeset to Gene Symbol
- `hta20probesetENTREZID`: Probeset to Entrez Gene ID
- `hta20probesetGO2PROBE`: GO ID to Probeset IDs
- `hta20probesetALIAS2PROBE`: Gene Alias to Probeset IDs

Example of Bimap usage:
```r
# Convert a mapping to a list
sym_list <- as.list(hta20probesetSYMBOL[1:10])
```

## Database Connection Information
To inspect the underlying SQLite database:
```r
hta20probeset_dbconn()   # Returns the DBI connection
hta20probeset_dbschema() # Prints the database schema
hta20probeset_dbInfo()   # Prints package metadata
```

## Tips
- **One-to-Many Mappings**: Note that a single probeset ID might map to multiple Entrez IDs or GO terms. The `select()` function will return a data frame with one row per mapping.
- **Reverse Mappings**: To map from Symbols back to Probesets using `select()`, simply change the `keytype` to `"SYMBOL"`.
- **Package Dependencies**: Ensure `AnnotationDbi` is installed, as it provides the generic methods used to query this data.

## Reference documentation
- [hta20probeset.db Reference Manual](./references/reference_manual.md)