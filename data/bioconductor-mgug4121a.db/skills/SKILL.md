---
name: bioconductor-mgug4121a.db
description: This package provides annotation data for the Agilent Mouse Genome UG 4121a platform. Use when user asks to map Agilent mouse probe identifiers to gene symbols, Entrez IDs, GO terms, or KEGG pathways.
homepage: https://bioconductor.org/packages/release/data/annotation/html/mgug4121a.db.html
---


# bioconductor-mgug4121a.db

name: bioconductor-mgug4121a.db
description: Annotation data for the Agilent Mouse Genome UG 4121a platform. Use this skill to map manufacturer probe identifiers to various biological annotations (Entrez Gene IDs, Symbols, GO terms, KEGG pathways, etc.) for mouse genomic data.

## Overview

The `mgug4121a.db` package is a Bioconductor annotation data package for the Agilent Mouse Genome UG 4121a array. It provides a SQLite-based interface to map probe identifiers to genomic features. The primary way to interact with this package is through the `select()` interface from the `AnnotationDbi` package, though it also supports the older "Bimap" interface.

## Core Workflows

### Loading the Package
```R
library(mgug4121a.db)
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data. It requires four arguments: the database object, the keys (input IDs), the columns (desired information), and the keytype (type of input IDs).

```R
# List available columns
columns(mgug4121a.db)

# List available keytypes
keytypes(mgug4121a.db)

# Example: Map probe IDs to Gene Symbols and Entrez IDs
probes <- c("10001_at", "10002_at") # Replace with actual probe IDs
select(mgug4121a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Annotation Mappings

- **Gene Symbols**: Map probes to official gene abbreviations using `SYMBOL`.
- **Entrez Gene IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find the chromosome and base pair start/end points.
- **Gene Ontology (GO)**: Map probes to GO identifiers and evidence codes using `GO`.
- **Pathways**: Map probes to KEGG pathway identifiers using `PATH`.
- **External IDs**: Map to `ENSEMBL`, `REFSEQ`, `UNIPROT`, or `MGI` (Mouse Genome Informatics) identifiers.

### Using the Bimap Interface (Legacy)
While `select()` is preferred, you can access specific maps directly as objects.

```R
# Convert a map to a list
sym_map <- as.list(mgug4121aSYMBOL)
# Access a specific probe
sym_map[["10001_at"]]

# Get all mapped keys
mapped_probes <- mappedkeys(mgug4121aSYMBOL)
```

### Database Metadata
To get information about the database schema or the organism:
```R
mgug4121aORGANISM  # Returns "Mus musculus"
mgug4121a_dbInfo() # Returns metadata about the data sources
```

## Tips for Success
- **Handling Multiple Matches**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data.frame with one row per match, which may result in more rows than input keys.
- **Alias Mapping**: If you have common gene symbols that aren't "official," use `mgug4121aALIAS2PROBE` to find the corresponding manufacturer identifiers.
- **Evidence Codes**: When working with GO terms, pay attention to the `EVIDENCE` column to understand the quality of the annotation (e.g., IDA = Inferred from Direct Assay, IEA = Inferred from Electronic Annotation).

## Reference documentation
- [mgug4121a.db](./references/reference_manual.md)