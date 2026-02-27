---
name: bioconductor-mesh.cpo.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for Cavia porcellus. Use when user asks to map Guinea pig gene IDs to Medical Subject Headings, perform functional annotation, or conduct gene set enrichment analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Cpo.eg.db.html
---


# bioconductor-mesh.cpo.eg.db

name: bioconductor-mesh.cpo.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Cavia porcellus (Guinea pig). Use this skill when performing functional annotation, gene set enrichment analysis, or biological data integration involving Guinea pig genomic data and MeSH terms.

## Overview

The `MeSH.Cpo.eg.db` package is a Bioconductor annotation data package. It serves as a bridge between Entrez Gene identifiers and MeSH terms specifically for *Cavia porcellus*. It is built upon the `MeSHDbi` framework, allowing users to query biological metadata using standard AnnotationDbi methods.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.Cpo.eg.db")
library(MeSH.Cpo.eg.db)
```

## Core Workflows

The package follows the standard `AnnotationDbi` interface. Use the following four methods to explore and extract data.

### 1. Discovery (Columns and Keytypes)
Identify what data types are available for querying and what data can be returned.

```r
# List available data columns
columns(MeSH.Cpo.eg.db)

# List available keytypes (fields that can be used as input keys)
keytypes(MeSH.Cpo.eg.db)
```

### 2. Retrieving Keys
Extract specific identifiers (e.g., all Entrez Gene IDs or all MeSH IDs) present in the database.

```r
# Get the first 6 Entrez Gene IDs
ks <- head(keys(MeSH.Cpo.eg.db, keytype="GENEID"))
```

### 3. Data Mapping (Select)
Map identifiers from one type to another. This is the primary method for annotation.

```r
# Map Entrez Gene IDs to MeSH IDs and Categories
res <- select(MeSH.Cpo.eg.db, 
              keys = ks, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

## Database Metadata

To inspect the underlying database structure and versioning information:

```r
# Get species information
species(MeSH.Cpo.eg.db)

# Get database metadata/info
dbInfo(MeSH.Cpo.eg.db)

# Get the SQLite connection or file path
dbconn(MeSH.Cpo.eg.db)
dbfile(MeSH.Cpo.eg.db)
```

## Usage Tips
- **MeSH Categories**: MeSH terms are organized into categories (e.g., D for Drugs and Chemicals, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results to specific biological domains.
- **Entrez IDs**: Ensure your input keys are character vectors, as `AnnotationDbi` methods expect string inputs for keys.
- **Integration**: This package is often used in conjunction with `MeSHSim` for similarity measures or `meshr` for enrichment analysis.

## Reference documentation
- [MeSH.Cpo.eg.db Reference Manual](./references/reference_manual.md)