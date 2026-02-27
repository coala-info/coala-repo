---
name: bioconductor-yeast2.db
description: This package provides annotation data for the Affymetrix Yeast Genome 2.0 Array. Use when user asks to map yeast probe identifiers to gene names, ORF identifiers, GO terms, KEGG pathways, or chromosomal locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/yeast2.db.html
---


# bioconductor-yeast2.db

name: bioconductor-yeast2.db
description: Provides annotation data for the Yeast Genome 2.0 Array (Affymetrix). Use this skill when you need to map yeast probe identifiers to biological metadata such as gene names, ORF identifiers, GO terms, KEGG pathways, chromosomal locations, and PubMed IDs.

## Overview

The `yeast2.db` package is a Bioconductor annotation data package for the Yeast Genome 2.0 Array. It provides a comprehensive set of mappings between manufacturer probe identifiers and various forms of biological information. While it supports the older "Bimap" interface, the recommended way to interact with the data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```r
library(yeast2.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```r
# View available columns
columns(yeast2.db)

# View available keytypes
keytypes(yeast2.db)

# Example: Map probe IDs to Gene Names and ORF identifiers
probes <- c("1769308_at", "1769309_at")
select(yeast2.db, keys = probes, columns = c("GENENAME", "ORF", "SYMBOL"), keytype = "PROBEID")
```

### Common Annotation Mappings

- **Gene Symbols and Names**: Map probes to primary gene names (`GENENAME`) or symbols (`SYMBOL`).
- **ORF Identifiers**: Map probes to Open Reading Frame identifiers (`ORF`).
- **Chromosomal Location**: Find the chromosome (`CHR`) and base pair start/end positions (`CHRLOC`, `CHRLOCEND`).
- **Functional Annotation**: Retrieve Gene Ontology (`GO`) terms or KEGG pathway identifiers (`PATH`).
- **External IDs**: Map to Ensembl gene accessions (`ENSEMBL`) or Enzyme Commission numbers (`ENZYME`).

### Working with Chromosome Lengths
To get the lengths of yeast chromosomes in base pairs:
```r
# Returns a named vector of chromosome lengths
lengths <- yeast2CHRLENGTHS
lengths["1"] # Length of chromosome 1
```

### Database Connection and Metadata
For advanced users needing direct SQL access or package metadata:
```r
# Get the SQLite connection
conn <- yeast2_dbconn()

# View the database schema
yeast2_dbschema()

# View package information
yeast2_dbInfo()
```

## Tips and Best Practices

- **Vectorized Queries**: Always pass a vector of keys to `select()` rather than looping for better performance.
- **Handling 1-to-Many Mappings**: Some probes may map to multiple GO terms or pathways. The `select()` function will return a data frame with multiple rows for a single input key in these cases.
- **Bimap Interface**: If you encounter legacy code using `as.list(yeast2GO)`, it is converting a Bimap object to a list. While functional, `select()` is more robust for modern workflows.
- **Reverse Mappings**: To map from a gene-centric ID back to probes (e.g., ENSEMBL to PROBE), use `select()` with the appropriate `keytype`.

## Reference documentation

- [reference_manual.md](./references/reference_manual.md)