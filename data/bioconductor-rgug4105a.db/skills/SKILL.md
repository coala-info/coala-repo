---
name: bioconductor-rgug4105a.db
description: This package provides annotation data for the Agilent Rat Genome 4x44K Microarray (G4105A). Use when user asks to map manufacturer probe identifiers to gene symbols, Entrez IDs, genomic locations, or functional annotations for Rattus norvegicus.
homepage: https://bioconductor.org/packages/release/data/annotation/html/rgug4105a.db.html
---


# bioconductor-rgug4105a.db

name: bioconductor-rgug4105a.db
description: Annotation data for the Agilent Rat Genome 4x44K Microarray (G4105A). Use this skill when you need to map manufacturer probe identifiers to biological identifiers (Entrez Gene, Ensembl, Gene Ontology, KEGG, etc.) or genomic locations for Rattus norvegicus.

# bioconductor-rgug4105a.db

## Overview

The `rgug4105a.db` package is a Bioconductor annotation hub for the Agilent Rat Genome 4x44K Microarray. It provides a SQLite-based interface to map probe IDs to various gene-centric and genomic annotations. The primary way to interact with this package is through the `AnnotationDbi` interface (`select`, `keys`, `columns`).

## Core Workflows

### Loading the Package
```R
library(rgug4105a.db)
```

### Using the select() Interface
The `select()` function is the recommended method for retrieving data.

```R
# View available columns (types of data)
columns(rgug4105a.db)

# View available keytypes (usually PROBEID)
keytypes(rgug4105a.db)

# Retrieve specific annotations for a set of probes
probes <- c("A_44_P10001", "A_44_P10005")
select(rgug4105a.db, 
       keys = probes, 
       columns = c("SYMBOL", "ENTREZID", "GENENAME"), 
       keytype = "PROBEID")
```

### Common Mappings
- **Gene Symbols**: Map probes to official gene symbols using `SYMBOL`.
- **Entrez IDs**: Map probes to NCBI Entrez Gene identifiers using `ENTREZID`.
- **Chromosomal Location**: Use `CHR`, `CHRLOC`, and `CHRLOCEND` to find genomic coordinates.
- **Functional Annotation**: Use `GO` (Gene Ontology) or `PATH` (KEGG Pathways).
- **External IDs**: Map to `ENSEMBL`, `UNIPROT`, or `REFSEQ`.

### Using the Bimap Interface (Legacy)
While `select()` is preferred, you can still use the Bimap interface for specific tasks like extracting all mapped keys.

```R
# Get all probes mapped to Gene Symbols
x <- rgug4105aSYMBOL
mapped_probes <- mappedkeys(x)
# Convert to a list
probe_to_symbol <- as.list(x[mapped_probes])
```

### Accessing Database Metadata
To get information about the underlying database schema or connection:
```R
rgug4105a_dbconn()   # Get the SQLite connection
rgug4105a_dbInfo()   # Get package metadata
rgug4105a_dbschema() # View table structures
```

## Tips and Best Practices
- **Multiple Mappings**: Some probes may map to multiple Entrez IDs or GO terms. `select()` will return a data frame with one row per mapping, which may result in more rows than input keys.
- **GO Evidence Codes**: When retrieving GO terms, the `EVIDENCE` column indicates the type of supporting evidence (e.g., IDA: Inferred from Direct Assay).
- **Organism Info**: Use `rgug4105aORGANISM` to programmatically confirm the species (Rattus norvegicus).
- **Reverse Mappings**: Most objects have a reverse map (e.g., `rgug4105aSYMBOL2PROBE`) to find probes associated with a specific gene symbol.

## Reference documentation
- [rgug4105a.db Reference Manual](./references/reference_manual.md)