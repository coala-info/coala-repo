---
name: bioconductor-mesh.pfa.3d7.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Plasmodium falciparum 3D7. Use when user asks to perform functional annotation, conduct enrichment analysis, or convert identifiers for P. falciparum genomic data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Pfa.3D7.eg.db.html
---

# bioconductor-mesh.pfa.3d7.eg.db

name: bioconductor-mesh.pfa.3d7.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Plasmodium falciparum 3D7. Use this skill when performing functional annotation, enrichment analysis, or identifier conversion for P. falciparum genomic data within the Bioconductor ecosystem.

# bioconductor-mesh.pfa.3d7.eg.db

## Overview

`MeSH.Pfa.3D7.eg.db` is a specialized Bioconductor annotation package for *Plasmodium falciparum 3D7*. It serves as a bridge between the MeSH classification system and Entrez Gene identifiers. The package is built on the `AnnotationDbi` framework, allowing users to query biological metadata using a standardized interface.

## Core Workflows

### Loading the Annotation Object
To use the package, load the library. The primary object is named identically to the package.

```r
library(MeSH.pfa.3D7.eg.db)
# Display basic information about the database
MeSH.pfa.3D7.eg.db
```

### Exploring the Database Structure
Before querying, identify what types of data (columns) are available and what identifiers (keytypes) can be used as input.

```r
# List available data columns
columns(MeSH.pfa.3D7.eg.db)

# List available keytypes for searching
keytypes(MeSH.pfa.3D7.eg.db)
```

### Querying Data
Use the `select` function to map identifiers. Common keytypes include `MESHID` and `GENEID`.

```r
# Get the first few keys of a specific type
ks <- head(keys(MeSH.pfa.3D7.eg.db, keytype="MESHID"))

# Map MeSH IDs to Entrez Gene IDs and other columns
res <- select(MeSH.pfa.3D7.eg.db, 
              keys = ks, 
              columns = c("GENEID", "MESHCATEGORY", "SOURCEID"), 
              keytype = "MESHID")
head(res)
```

### Database Metadata
Access underlying database information for reproducibility and provenance.

```r
species(MeSH.pfa.3D7.eg.db)  # Confirm species (Plasmodium falciparum 3D7)
dbInfo(MeSH.pfa.3D7.eg.db)   # Get package metadata and source versions
dbfile(MeSH.pfa.3D7.eg.db)   # Locate the SQLite database file
```

## Usage Tips
- **MeSH Categories**: When querying, the `MESHCATEGORY` column helps distinguish between different branches of the MeSH hierarchy (e.g., Diseases, Chemicals and Drugs).
- **Integration**: This package is designed to work seamlessly with `MeSHDbi`. For advanced enrichment analysis, consider using this package in conjunction with `meshr`.
- **Entrez IDs**: Ensure your input gene list uses Entrez Gene IDs when using `keytype="GENEID"`.

## Reference documentation
- [MeSH.Pfa.3D7.eg.db Reference Manual](./references/reference_manual.md)