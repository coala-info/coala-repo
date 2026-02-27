---
name: bioconductor-mesh.eca.eg.db
description: This package provides mappings between MeSH identifiers and Entrez Gene IDs for *Equus caballus*. Use when user asks to perform functional annotation, conduct gene set enrichment analysis, or map horse genes to medical subject headings.
homepage: https://bioconductor.org/packages/3.13/data/annotation/html/MeSH.Eca.eg.db.html
---


# bioconductor-mesh.eca.eg.db

name: bioconductor-mesh.eca.eg.db
description: Mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Equus caballus (Horse). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for horses using Bioconductor.

## Overview

The `MeSH.Eca.eg.db` package is a specialized annotation database for *Equus caballus* (Horse). It provides a bridge between the MeSH hierarchical vocabulary (used for indexing biological and medical literature) and NCBI Entrez Gene identifiers. This allows researchers to associate horse genes with specific medical subjects, diseases, or biological concepts.

## Core Workflows

### Loading the Database
To begin, load the library. The database object is named the same as the package.

```r
library(MeSH.Eca.eg.db)
# View object summary
MeSH.Eca.eg.db
```

### Exploring Metadata
Use standard AnnotationDbi methods to inspect the database structure:

```r
# Check the species
species(MeSH.Eca.eg.db)

# Get database metadata
dbInfo(MeSH.Eca.eg.db)

# List available columns (data types)
columns(MeSH.Eca.eg.db)

# List available keytypes (searchable fields)
keytypes(MeSH.Eca.eg.db)
```

### Querying Data
The `select` function is the primary method for retrieving mappings.

```r
# 1. Define keys (e.g., Entrez Gene IDs)
my_genes <- c("100033834", "100033835")

# 2. Retrieve MeSH IDs associated with these genes
res <- select(MeSH.Eca.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")

# View results
head(res)
```

### Reverse Lookup
You can also find genes associated with specific MeSH terms:

```r
# Get all genes associated with a specific MeSH ID
mesh_keys <- c("D000001")
gene_mappings <- select(MeSH.Eca.eg.db, 
                        keys = mesh_keys, 
                        columns = "GENEID", 
                        keytype = "MESHID")
```

## Usage Tips
- **Keytypes**: Common keytypes include `GENEID` (Entrez) and `MESHID`.
- **MeSH Categories**: Use the `MESHCATEGORY` column to filter results by specific MeSH branches (e.g., Diseases, Chemicals and Drugs).
- **Integration**: This package is often used in conjunction with `MeSHDbi` and enrichment analysis tools like `meshr`.

## Reference documentation
- [MeSH.Eca.eg.db Reference Manual](./references/reference_manual.md)