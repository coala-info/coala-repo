---
name: bioconductor-ygs98.db
description: This package provides comprehensive functional and genomic annotation data for the Affymetrix Yeast Genome S98 platform. Use when user asks to map ygs98 probe identifiers to gene names, ORFs, GO terms, KEGG pathways, or chromosomal locations for Saccharomyces cerevisiae.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ygs98.db.html
---


# bioconductor-ygs98.db

name: bioconductor-ygs98.db
description: Annotation data for the Yeast Genome S98 (YGS98) platform. Use this skill when you need to map Affymetrix ygs98 probe identifiers to biological metadata for Saccharomyces cerevisiae, including gene names, ORFs, GO terms, KEGG pathways, and chromosomal locations.

## Overview

The `ygs98.db` package is a Bioconductor annotation hub for the Yeast Genome S98 platform. It provides a comprehensive mapping between manufacturer probe IDs and various genomic identifiers and functional annotations for yeast. While it supports older "Bimap" interfaces, the primary and recommended way to interact with the data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(ygs98.db)
```

### Exploring Available Data
To see what types of information (columns) you can retrieve:
```r
columns(ygs98.db)
```
Common columns include:
- `ORF`: Yeast Open Reading Frame identifiers.
- `GENENAME`: The full name of the gene.
- `GO`: Gene Ontology identifiers.
- `PATH`: KEGG pathway identifiers.
- `ENSEMBL`: Ensembl gene accession numbers.

### Using the select() Interface
The `select()` function is the standard way to extract data. It requires the database object, the input keys, the columns you want to retrieve, and the type of key you are providing.

```r
# Example: Map probe IDs to Gene Names and ORFs
probes <- c("10000_at", "10001_at")
select(ygs98.db, 
       keys = probes, 
       columns = c("GENENAME", "ORF"), 
       keytype = "PROBEID")
```

### Mapping to Functional Annotations
You can retrieve Gene Ontology (GO) terms or KEGG pathways for specific probes:

```r
# Get GO terms for probes
select(ygs98.db, keys = probes, columns = "GO", keytype = "PROBEID")

# Get KEGG pathways
select(ygs98.db, keys = probes, columns = "PATH", keytype = "PROBEID")
```

### Chromosomal Locations
To find where a gene starts and ends on a chromosome:
```r
select(ygs98.db, keys = probes, columns = c("CHR", "CHRLOC", "CHRLOCEND"), keytype = "PROBEID")
```

## Specialized Functions

### Database Connection and Metadata
If you need to perform direct SQL queries or check database metadata:
- `ygs98_dbconn()`: Returns the DBI connection object.
- `ygs98_dbfile()`: Returns the path to the SQLite database file.
- `ygs98_dbschema()`: Displays the database schema.
- `ygs98_dbInfo()`: Prints general information about the package and data sources.

### Chromosome Lengths
To get a named vector of chromosome lengths:
```r
ygs98CHRLENGTHS
```

## Tips for Effective Usage
- **One-to-Many Mappings**: Be aware that some probes may map to multiple GO terms or pathways. The `select()` function will return a data frame with one row per mapping, which may result in more rows than input keys.
- **Keytypes**: If you are starting with something other than a probe ID (e.g., an ORF), use `keytypes(ygs98.db)` to see what you can use in the `keytype` argument of `select()`.
- **Bimap Interface**: While `as.list(ygs98ALIAS)` still works for quick lookups, the `select()` interface is more robust and consistent with modern Bioconductor workflows.

## Reference documentation
- [ygs98.db Reference Manual](./references/reference_manual.md)