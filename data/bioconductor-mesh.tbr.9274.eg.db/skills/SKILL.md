---
name: bioconductor-mesh.tbr.9274.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Trypanosoma brucei strain 9274. Use when user asks to map gene identifiers to medical subject headings, perform functional annotation, or conduct gene enrichment analysis for this specific organism.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Tbr.9274.eg.db.html
---

# bioconductor-mesh.tbr.9274.eg.db

name: bioconductor-mesh.tbr.9274.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Trypanosoma brucei strain 9274. Use this skill when performing functional annotation, gene enrichment analysis, or cross-referencing biological literature with genomic data for this specific organism using Bioconductor.

# bioconductor-mesh.tbr.9274.eg.db

## Overview
The `MeSH.Tbr.9274.eg.db` package is a specialized annotation database for *Trypanosoma brucei* (strain 9274). It facilitates the translation between Entrez Gene identifiers and MeSH terms, allowing researchers to link genetic data with standardized medical and biological terminology. This package is built upon the `AnnotationDbi` and `MeSHDbi` frameworks, providing a consistent interface for data retrieval.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("MeSH.Tbr.9274.eg.db")

library(MeSH.Tbr.9274.eg.db)
```

## Core Workflows

### Exploring the Database
Use the standard AnnotationDbi methods to understand the available data types:

```r
# View available columns (data types) to retrieve
columns(MeSH.Tbr.9274.eg.db)

# View available keytypes (fields you can search by)
keytypes(MeSH.Tbr.9274.eg.db)

# Get a sample of keys (e.g., Entrez Gene IDs)
head(keys(MeSH.Tbr.9274.eg.db, keytype="GENEID"))
```

### Mapping Identifiers
The `select` function is the primary tool for mapping between Entrez Gene IDs and MeSH IDs:

```r
# Example: Mapping specific Gene IDs to MeSH terms
my_genes <- head(keys(MeSH.Tbr.9274.eg.db, keytype="GENEID"))
res <- select(MeSH.Tbr.9274.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
print(res)
```

### Database Metadata
To inspect the underlying database structure or species information:

```r
species(MeSH.Tbr.9274.eg.db)
dbInfo(MeSH.Tbr.9274.eg.db)
dbschema(MeSH.Tbr.9274.eg.db)
```

## Usage Tips
- **Keytypes**: Common keytypes include `GENEID` (Entrez) and `MESHID`.
- **MeSHDbi Dependency**: For more advanced manipulation of MeSH data, ensure the `MeSHDbi` package is also installed.
- **Strain Specificity**: This package is specific to *Trypanosoma brucei* strain 9274. Ensure your gene identifiers correspond to this specific strain to avoid mapping errors.

## Reference documentation
- [MeSH.Tbr.9274.eg.db Reference Manual](./references/reference_manual.md)