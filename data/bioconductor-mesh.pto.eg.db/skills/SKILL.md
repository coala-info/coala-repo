---
name: bioconductor-mesh.pto.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Populus trichocarpa. Use when user asks to perform functional annotation, conduct MeSH enrichment analysis, or map genes to medical subject headings for Black Cottonwood.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Pto.eg.db.html
---

# bioconductor-mesh.pto.eg.db

name: bioconductor-mesh.pto.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Populus trichocarpa (Black Cottonwood). Use this skill when performing functional annotation, enrichment analysis, or gene-to-phenotype mapping for Populus trichocarpa using the MeSH hierarchy.

# bioconductor-mesh.pto.eg.db

## Overview

The `MeSH.Pto.eg.db` package is a Bioconductor annotation database that facilitates the correspondence between MeSH terms and Entrez Gene IDs for the species *Populus trichocarpa*. It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using a standardized interface.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Pto.eg.db")
library(MeSH.Pto.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface using four main methods: `columns`, `keytypes`, `keys`, and `select`.

### 1. Exploring the Database
Check what types of data and identifiers are available within the object.

```R
# View available columns (data types to return)
columns(MeSH.Pto.eg.db)

# View available keytypes (identifiers to search by)
keytypes(MeSH.Pto.eg.db)
```

### 2. Retrieving Keys
Extract specific identifiers to use for queries.

```R
# Get the first 6 MeSH IDs
mesh_keys <- head(keys(MeSH.Pto.eg.db, keytype="MESHID"))
```

### 3. Mapping Identifiers
Use the `select` function to map between Entrez Gene IDs and MeSH terms.

```R
# Map specific MeSH IDs to Entrez Gene IDs and Categories
res <- select(MeSH.Pto.eg.db, 
              keys = mesh_keys, 
              columns = c("GENEID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "MESHID")
head(res)
```

## Database Metadata

You can retrieve administrative information about the database using the following utility functions:

- `species(MeSH.Pto.eg.db)`: Confirms the target organism (*Populus trichocarpa*).
- `dbInfo(MeSH.Pto.eg.db)`: Displays metadata about the data sources and versions.
- `dbfile(MeSH.Pto.eg.db)`: Shows the file path to the underlying SQLite database.
- `dbschema(MeSH.Pto.eg.db)`: Displays the database table structure.

## Usage Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., Diseases, Chemicals and Drugs). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
- **Integration**: This package is often used in conjunction with `meshr` for MeSH enrichment analysis.
- **Entrez IDs**: Ensure your input gene list uses Entrez Gene IDs (numeric strings) when querying with `keytype="GENEID"`.

## Reference documentation

- [MeSH.Pto.eg.db Reference Manual](./references/reference_manual.md)