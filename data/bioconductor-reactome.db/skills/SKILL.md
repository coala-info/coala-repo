---
name: bioconductor-reactome.db
description: This tool provides a Bioconductor interface to map between Entrez Gene IDs, Reactome pathway identifiers, pathway names, and Gene Ontology terms within R. Use when user asks to map genes to Reactome pathways, retrieve pathway names from IDs, or perform functional annotation using the Reactome database.
homepage: https://bioconductor.org/packages/release/data/annotation/html/reactome.db.html
---

# bioconductor-reactome.db

name: bioconductor-reactome.db
description: Access and query the Reactome pathway database within R. Use this skill when you need to map between Entrez Gene IDs, Reactome pathway identifiers, pathway names, and Gene Ontology (GO) terms. It is essential for functional annotation, pathway enrichment analysis, and biological interpretation of genomic data using the Reactome knowledgebase.

# bioconductor-reactome.db

## Overview
The `reactome.db` package is a Bioconductor annotation data package that provides a stable, offline interface to the Reactome database. It primarily functions as a set of mapping objects (AnnDbObj) that allow users to translate between different biological identifiers and pathway information.

## Core Mapping Objects
The package uses a specific naming convention: `reactome[SOURCE]2[TARGET]`.

- `reactomeEXTID2PATHID`: Maps Entrez Gene IDs to Reactome Pathway IDs.
- `reactomePATHID2EXTID`: Maps Reactome Pathway IDs to Entrez Gene IDs.
- `reactomePATHID2NAME`: Maps Reactome Pathway IDs to human-readable Pathway Names.
- `reactomePATHNAME2ID`: Maps Pathway Names to Reactome Pathway IDs.
- `reactomeGO2REACTOMEID`: Maps Gene Ontology (GO) IDs to Reactome IDs.
- `reactomeREACTOMEID2GO`: Maps Reactome IDs to Gene Ontology (GO) IDs.

## Typical Workflows

### 1. Basic Mapping
To use these objects, you can convert them to lists or use the `AnnotationDbi` select interface.

```r
library(reactome.db)

# Get pathway IDs for a specific Entrez Gene ID (e.g., '10' for ADH1B)
pathways <- as.list(reactomeEXTID2PATHID[["10"]])

# Get the name of a specific pathway
pathway_name <- as.list(reactomePATHID2NAME[["R-HSA-1971475"]])
```

### 2. Finding Pathways by Name
If you have a keyword or pathway name and need the ID:

```r
# Search for a specific pathway ID by name
pid <- as.list(reactomePATHNAME2ID[["Apoptosis"]])
```

### 3. Batch Retrieval
For multiple identifiers, use `mget` or `select`:

```r
gene_ids <- c("1", "2", "3")
pathway_list <- mget(gene_ids, reactomeEXTID2PATHID, ifnotfound=NA)
```

### 4. Database Inspection
To see all available maps or check the number of entries:

```r
# List all mapping objects
ls("package:reactome.db")

# Check map counts
reactomeMAPCOUNTS
```

## Advanced Usage: SQL Queries
Since the package is backed by an SQLite database, you can perform direct SQL queries for complex joins.

```r
library(RSQLite)
conn <- reactome_dbconn()
# Example: Count rows in the pathway2name table
dbGetQuery(conn, "SELECT COUNT(*) FROM pathway2name")
# View schema
reactome_dbschema()
```

## Tips
- **Entrez IDs**: This package specifically uses Entrez Gene identifiers as the "EXTID". If you have Ensembl IDs or Gene Symbols, map them to Entrez IDs first (using `org.Hs.eg.db`) before using `reactome.db`.
- **Version Consistency**: Reactome IDs can change between releases. This package is updated biannually with Bioconductor releases. Use `reactome_dbInfo()` to check the data source version.
- **Avoid dbDisconnect**: Never call `dbDisconnect()` on the object returned by `reactome_dbconn()`, as it will break the package's internal mapping objects.

## Reference documentation
- [reactome.db Reference Manual](./references/reference_manual.md)