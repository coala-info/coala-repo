---
name: bioconductor-mesh.eco.k12.mg1655.eg.db
description: This tool provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Escherichia coli K12 MG1655. Use when user asks to perform functional annotation, enrichment analysis, or map gene identifiers to MeSH terms for E. coli K12 MG1655.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Eco.K12.MG1655.eg.db.html
---

# bioconductor-mesh.eco.k12.mg1655.eg.db

name: bioconductor-mesh.eco.k12.mg1655.eg.db
description: Provides mapping between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs for Escherichia coli K12 MG1655. Use this skill when performing functional annotation, enrichment analysis, or gene-to-MeSH term lookups for E. coli K12 MG1655 using Bioconductor's AnnotationDbi interface.

# bioconductor-mesh.eco.k12.mg1655.eg.db

## Overview

The MeSH.Eco.K12.MG1655.eg.db package is a specialized annotation database for Escherichia coli K12 MG1655. It facilitates the correspondence between Entrez Gene IDs and MeSH (Medical Subject Headings) terms. The package implements the standard AnnotationDbi interface, making it compatible with common Bioconductor workflows for genomic data annotation.

## Basic Usage

To use this package, load the library and interact with the central object named after the package.

library(MeSH.Eco.K12.MG1655.eg.db)

### Exploring the Database

Use the standard four accessor methods to understand the structure and available data:

- columns(MeSH.Eco.K12.MG1655.eg.db): Returns the types of data that can be retrieved.
- keytypes(MeSH.Eco.K12.MG1655.eg.db): Returns the types of identifiers that can be used as query keys (e.g., MESHID, GENEID).
- keys(MeSH.Eco.K12.MG1655.eg.db, keytype="..."): Returns all valid keys for a specific keytype.
- select(MeSH.Eco.K12.MG1655.eg.db, keys, columns, keytype): Retrieves the mapping between the provided keys and requested columns.

### Example Workflow

Retrieve MeSH IDs for a set of Entrez Gene IDs:

# 1. Define your Entrez Gene IDs
my_genes <- c("944742", "944747")

# 2. Check available columns
cols <- columns(MeSH.Eco.K12.MG1655.eg.db)

# 3. Perform the mapping
results <- select(MeSH.Eco.K12.MG1655.eg.db, 
                  keys = my_genes, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")

## Metadata and Database Information

You can extract administrative and versioning information using these helper functions:

- species(MeSH.Eco.K12.MG1655.eg.db): Confirms the target organism (Escherichia coli K12 MG1655).
- dbInfo(MeSH.Eco.K12.MG1655.eg.db): Provides source and version information for the underlying data.
- dbschema(MeSH.Eco.K12.MG1655.eg.db): Shows the SQLite database schema.
- dbfile(MeSH.Eco.K12.MG1655.eg.db): Returns the path to the SQLite database file.

## Tips for Success

- Ensure your input keys match the expected keytype (e.g., Entrez Gene IDs should be characters, not integers).
- Use the MeSHDbi package in conjunction with this database for more advanced MeSH-based enrichment analyses.
- If you are looking for GO terms or other annotations, use the organism-level package (org.EcK12.eg.db) instead, as this package is strictly for MeSH mappings.

## Reference documentation

- [MeSH.Eco.K12.MG1655.eg.db Reference Manual](./references/reference_manual.md)