---
name: bioconductor-mesh.eco.o157.h7.sakai.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the Escherichia coli O157:H7 Sakai strain. Use when user asks to map Gene IDs to MeSH terms, perform functional annotation, or conduct enrichment analysis for this specific strain.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Eco.O157.H7.Sakai.eg.db.html
---

# bioconductor-mesh.eco.o157.h7.sakai.eg.db

name: bioconductor-mesh.eco.o157.h7.sakai.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Escherichia coli O157:H7 Sakai. Use this skill when performing functional annotation, enrichment analysis, or cross-referencing gene data with medical/biological subject headings for this specific strain.

# bioconductor-mesh.eco.o157.h7.sakai.eg.db

## Overview

The `MeSH.Eco.O157.H7.Sakai.eg.db` package is a Bioconductor annotation database that facilitates the correspondence between Entrez Gene IDs and MeSH IDs for the *Escherichia coli* O157:H7 Sakai strain. It is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, allowing users to query biological metadata using a standard set of accessor methods.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Eco.O157.H7.Sakai.eg.db")
library(MeSH.Eco.O157.H7.Sakai.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### 1. Exploring the Database
Check what types of data are available and what keys can be used for searching.

```r
# View available columns (data types to retrieve)
columns(MeSH.Eco.O157.H7.Sakai.eg.db)

# View available keytypes (fields you can search by)
keytypes(MeSH.Eco.O157.H7.Sakai.eg.db)
```

### 2. Retrieving Keys
Extract specific identifiers (e.g., Entrez Gene IDs) to use in a query.

```r
# Get the first 6 Entrez Gene IDs
gene_keys <- head(keys(MeSH.Eco.O157.H7.Sakai.eg.db, keytype="GENEID"))
```

### 3. Mapping Identifiers
Use `select()` to map between MeSH IDs and Gene IDs.

```r
# Map Gene IDs to MeSH IDs and Categories
res <- select(MeSH.Eco.O157.H7.Sakai.eg.db, 
              keys = gene_keys, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata
You can retrieve information about the database's underlying structure and the species it covers:

```r
# Check the target species
species(MeSH.Eco.O157.H7.Sakai.eg.db)

# Database connection and file info
dbconn(MeSH.Eco.O157.H7.Sakai.eg.db)
dbfile(MeSH.Eco.O157.H7.Sakai.eg.db)

# Metadata about the MeSH source
dbInfo(MeSH.Eco.O157.H7.Sakai.eg.db)
```

## Usage Tips
- **MeSH Categories**: MeSH IDs are often grouped into categories (e.g., D for Drugs and Chemicals, G for Biological Sciences). Use the `MESHCATEGORY` column to filter results.
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced enrichment analysis, consider using this database in conjunction with the `meshr` package.
- **Entrez IDs**: Ensure your input keys are character vectors, as `AnnotationDbi` methods expect string input for IDs.

## Reference documentation
- [MeSH.Eco.O157.H7.Sakai.eg.db Reference Manual](./references/reference_manual.md)