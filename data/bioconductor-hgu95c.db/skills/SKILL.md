---
name: bioconductor-hgu95c.db
description: This package provides annotation data for the Affymetrix Human Genome U95c microarray platform. Use when user asks to map probe identifiers to gene symbols, Entrez IDs, Ensembl accessions, GO terms, or KEGG pathways for the hgu95c platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95c.db.html
---

# bioconductor-hgu95c.db

name: bioconductor-hgu95c.db
description: Annotation data for the Affymetrix Human Genome U95c (hgu95c) platform. Use this skill when you need to map manufacturer probe identifiers to biological identifiers like Entrez Gene IDs, Gene Symbols, Ensembl IDs, GO terms, and KEGG pathways, or to retrieve genomic locations and PubMed references for this specific microarray.

# bioconductor-hgu95c.db

## Overview
The `hgu95c.db` package is a Bioconductor annotation data package for the Affymetrix Human Genome U95c platform. It provides a comprehensive set of SQLite-based mappings between manufacturer probe identifiers and various biological databases. While it supports the legacy Bimap interface, the recommended way to interact with the data is through the `select()` interface from the `AnnotationDbi` package.

## Core Workflows

### Loading the Package
```R
library(hgu95c.db)
```

### Using the select() Interface
The `select()` function is the primary method for retrieving data. You need to specify the keys (probe IDs), the columns you want to retrieve, and the keytype.

```R
# View available columns
columns(hgu95c.db)

# View available keytypes
keytypes(hgu95c.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("1000_at", "1001_at", "1002_f_at")
select(hgu95c.db, keys = probes, columns = c("SYMBOL", "ENTREZID"), keytype = "PROBEID")
```

### Common Annotation Mappings
- **Gene Symbols**: Map probes to official gene symbols using `SYMBOL`.
- **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **Ensembl**: Map to Ensembl gene accessions using `ENSEMBL`.
- **Gene Ontology (GO)**: Retrieve GO identifiers, evidence codes, and ontologies (BP, CC, MF) using `GO`.
- **Pathways**: Map probes to KEGG pathway identifiers using `PATH`.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find genomic coordinates.

### Legacy Bimap Interface
For quick lookups or converting entire maps to lists, the Bimap interface is still available:

```R
# Convert a specific map to a list
symbol_list <- as.list(hgu95cSYMBOL)

# Get probes that have a mapped symbol
mapped_probes <- mappedkeys(hgu95cSYMBOL)

# Access specific probe
symbol_list[["1000_at"]]
```

### Database Information and Schema
To inspect the underlying SQLite database:

```R
# Get database connection
conn <- hgu95c_dbconn()

# Show database schema
hgu95c_dbschema()

# Get summary information
hgu95c_dbInfo()
```

## Tips
- **Reverse Mappings**: Many objects have reverse maps (e.g., `hgu95cSYMBOL2PROBE`). When using `select()`, you can simply change the `keytype` to the desired identifier (e.g., `keytype = "SYMBOL"`) to perform a reverse lookup.
- **GO Annotations**: The `hgu95cGO` map only contains direct associations. To include child terms in the GO hierarchy, use `hgu95cGO2ALLPROBES`.
- **Multiple Matches**: Some probes may map to multiple identifiers (e.g., multiple Entrez IDs). `select()` will return a data frame with all possible combinations.

## Reference documentation
- [hgu95c.db Reference Manual](./references/reference_manual.md)