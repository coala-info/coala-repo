---
name: bioconductor-mesh.mdo.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for Mus musculus. Use when user asks to map mouse Entrez Gene IDs to Medical Subject Headings, perform functional annotation, or query medical concepts associated with specific mouse genes.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Mdo.eg.db.html
---

# bioconductor-mesh.mdo.eg.db

name: bioconductor-mesh.mdo.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Mus musculus (House mouse). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data using the MeSH.Mdo.eg.db Bioconductor package.

# bioconductor-mesh.mdo.eg.db

## Overview

The `MeSH.Mdo.eg.db` package is an annotation database that facilitates the correspondence between MeSH terms and Entrez Gene IDs for *Mus musculus*. It is built upon the `MeSHDbi` framework, allowing users to query medical subject headings associated with specific genes or vice versa. This is particularly useful for researchers looking to link experimental results to standardized medical and biological concepts.

## Core Workflows

### Loading the Database
To begin using the annotation data, load the library in R:

```r
library(MeSH.Mdo.eg.db)
# Display basic information about the database
MeSH.Mdo.eg.db
```

### Exploring the Database Structure
Use the standard `AnnotationDbi` methods to understand what data is available:

```r
# List available columns (data types)
columns(MeSH.Mdo.eg.db)

# List available keytypes (fields that can be used as query keys)
keytypes(MeSH.Mdo.eg.db)

# Retrieve a sample of keys for a specific keytype
head(keys(MeSH.Mdo.eg.db, keytype="MESHID"))
```

### Querying Data
The `select` function is the primary tool for retrieving mappings. It requires the keys you are searching for, the columns you want to retrieve, and the keytype of your input.

```r
# Example: Mapping Entrez Gene IDs to MeSH IDs
my_genes <- c("11430", "11431") # Example Entrez IDs
res <- select(MeSH.Mdo.eg.db, 
              keys = my_genes, 
              columns = c("MESHID", "MESHCATEGORY"), 
              keytype = "GENEID")
head(res)
```

### Database Metadata
You can extract administrative and versioning information using the following utility functions:

```r
species(MeSH.Mdo.eg.db)   # Confirm species (Mus musculus)
dbInfo(MeSH.Mdo.eg.db)    # Database metadata and source dates
dbfile(MeSH.Mdo.eg.db)    # Path to the SQLite database file
dbschema(MeSH.Mdo.eg.db)  # Internal database schema
```

## Usage Tips
- **Keytype Consistency**: Always ensure the `keytype` argument in `select()` matches the format of your `keys` vector (e.g., use "GENEID" for Entrez IDs).
- **MeSH Categories**: MeSH IDs are often categorized (e.g., Anatomy [A], Diseases [C]). Use the `MESHCATEGORY` column to filter results if you are only interested in specific types of annotations like "Diseases".
- **Integration**: This package is designed to work seamlessly with other MeSH-related Bioconductor packages like `MeSHDbi` and `meshr` for enrichment analysis.

## Reference documentation
- [MeSH.Mdo.eg.db Reference Manual](./references/reference_manual.md)