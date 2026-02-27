---
name: bioconductor-operonhumanv3.db
description: This package provides functional and genomic annotations for manufacturer identifiers from the Operon Human V3 microarray platform. Use when user asks to map Operon Human V3 probe IDs to Gene Symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/OperonHumanV3.db.html
---


# bioconductor-operonhumanv3.db

name: bioconductor-operonhumanv3.db
description: Use this skill to annotate manufacturer identifiers from the Operon Human V3 platform. This package provides mappings to Entrez Gene IDs, Gene Symbols, RefSeq, Ensembl, GO terms, and KEGG pathways. Use when working with microarray data from the Operon Human V3 chip to translate probe IDs into biological metadata.

# bioconductor-operonhumanv3.db

## Overview

The OperonHumanV3.db package is a Bioconductor annotation data package for the Operon Human V3 platform. It provides an SQLite-based interface to map manufacturer probe identifiers to various genomic and functional annotations. While it supports legacy Bimap objects, the recommended way to interact with the data is through the standard AnnotationDbi interface (select, columns, keys, and keytypes).

## R Usage and Workflows

### Loading the Package
To begin using the annotation data, load the library:
```r
library(OperonHumanV3.db)
```

### Exploring Available Data
Use the standard AnnotationDbi methods to see what identifiers and data types are available:
```r
# List all available annotation types (columns)
columns(OperonHumanV3.db)

# List valid key types that can be used for querying
keytypes(OperonHumanV3.db)

# Get a sample of probe identifiers (keys)
head(keys(OperonHumanV3.db, keytype = "PROBEID"))
```

### Mapping Identifiers using select()
The `select()` function is the primary method for retrieving data. It returns a data frame mapping your input keys to the requested columns.

```r
# Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1", "10", "100") # Replace with actual Operon IDs
annotations <- select(OperonHumanV3.db, 
                      keys = probes, 
                      columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
                      keytype = "PROBEID")
```

### Functional and Pathway Annotation
You can retrieve Gene Ontology (GO) terms or KEGG pathway identifiers:

```r
# Get GO terms for specific probes
go_annots <- select(OperonHumanV3.db, 
                    keys = probes, 
                    columns = c("GO", "ONTOLOGY", "EVIDENCE"), 
                    keytype = "PROBEID")

# Get KEGG pathway IDs
pathway_annots <- select(OperonHumanV3.db, 
                         keys = probes, 
                         columns = "PATH", 
                         keytype = "PROBEID")
```

### Chromosomal Information
Retrieve chromosomal locations and lengths:

```r
# Get chromosome and starting position
loc_data <- select(OperonHumanV3.db, 
                   keys = probes, 
                   columns = c("CHR", "CHRLOC"), 
                   keytype = "PROBEID")

# Get chromosome lengths (returns a named vector)
chr_lengths <- OperonHumanV3CHRLENGTHS
chr_lengths["1"]
```

### Legacy Bimap Interface
If working with older scripts, you may encounter the Bimap interface. These objects can be converted to lists or accessed using `mappedkeys()`.

```r
# Convert Symbol map to a list
symbol_list <- as.list(OperonHumanV3SYMBOL)

# Get probe IDs mapped to Accession Numbers
mapped_probes <- mappedkeys(OperonHumanV3ACCNUM)
```

### Database Connection Details
To query the underlying SQLite database directly or check metadata:
```r
# Get database schema
OperonHumanV3_dbschema()

# Get database metadata
OperonHumanV3_dbInfo()
```

## Reference documentation

- [OperonHumanV3.db Reference Manual](./references/reference_manual.md)