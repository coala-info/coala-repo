---
name: bioconductor-mesh.bsu.168.eg.db
description: This package provides mapping between Entrez Gene identifiers and Medical Subject Headings (MeSH) for *Bacillus subtilis* subsp. subtilis str. 168. Use when user asks to map gene IDs to MeSH terms, retrieve biological categories for genes, or annotate genetic data with hierarchical controlled vocabulary.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Bsu.168.eg.db.html
---

# bioconductor-mesh.bsu.168.eg.db

## Overview

The `MeSH.Bsu.168.eg.db` package is a specialized Bioconductor annotation database for *Bacillus subtilis* subsp. subtilis str. 168. It facilitates the translation between Entrez Gene identifiers and MeSH (Medical Subject Headings) terms. This mapping is essential for researchers looking to link genetic data with the hierarchical controlled vocabulary used by PubMed and other NLM databases for indexing biological concepts and diseases.

## Usage Guidance

The package follows the standard `AnnotationDbi` interface. To use it, you must load the library and use the four core accessor methods: `columns()`, `keytypes()`, `keys()`, and `select()`.

### Basic Workflow

1.  **Load the package:**
    ```r
    library(MeSH.Bsu.168.eg.db)
    ```

2.  **Explore available data types:**
    Use `columns()` to see what data can be retrieved and `keytypes()` to see what identifiers can be used as queries.
    ```r
    columns(MeSH.Bsu.168.eg.db)
    keytypes(MeSH.Bsu.168.eg.db)
    ```

3.  **Retrieve identifiers:**
    Use `keys()` to list available identifiers of a specific type.
    ```r
    # Get the first 6 Entrez Gene IDs
    eg_keys <- head(keys(MeSH.Bsu.168.eg.db, keytype="GENEID"))
    ```

4.  **Perform a lookup:**
    Use `select()` to map between identifiers.
    ```r
    # Map Entrez IDs to MeSH IDs and Categories
    res <- select(MeSH.Bsu.168.eg.db, 
                  keys = eg_keys, 
                  columns = c("MESHID", "MESHCATEGORY"), 
                  keytype = "GENEID")
    print(res)
    ```

### Database Metadata

To inspect the underlying database structure or species information:
*   `species(MeSH.Bsu.168.eg.db)`: Confirms the target organism (Bacillus subtilis 168).
*   `dbInfo(MeSH.Bsu.168.eg.db)`: Displays metadata about the database version and source.
*   `dbconn(MeSH.Bsu.168.eg.db)`: Returns the connection object to the underlying SQLite database.

## Tips for Success

*   **MeSH Categories:** MeSH terms are organized into categories (e.g., D for Drugs and Chemicals, G for Phenomena and Processes). Use the `MESHCATEGORY` column to filter results to specific areas of interest.
*   **Entrez IDs:** Ensure your input gene list uses Entrez Gene IDs (numeric strings) rather than gene symbols or locus tags, as `GENEID` is the primary key for genomic mapping in this package.
*   **MeSHDbi:** For more complex queries or to understand the MeSH hierarchy better, refer to the `MeSHDbi` package which provides the underlying infrastructure for this annotation object.

## Reference documentation

- [MeSH.Bsu.168.eg.db](./references/reference_manual.md)