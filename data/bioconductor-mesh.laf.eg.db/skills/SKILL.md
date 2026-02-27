---
name: bioconductor-mesh.laf.eg.db
description: This package provides mapping between MeSH identifiers and Entrez Gene IDs for the African elephant. Use when user asks to map MeSH terms to elephant genes, perform gene set enrichment analysis, or query biological themes for Loxodonta africana.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.Laf.eg.db.html
---


# bioconductor-mesh.laf.eg.db

name: bioconductor-mesh.laf.eg.db
description: Provides mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs for Loxodonta africana (African elephant). Use this skill when performing functional annotation, gene set enrichment analysis, or cross-referencing biological literature with genomic data for the African elephant using Bioconductor.

# bioconductor-mesh.laf.eg.db

## Overview

The `MeSH.Laf.eg.db` package is a specialized Bioconductor annotation data package. It serves as a bridge between the Medical Subject Headings (MeSH) controlled vocabulary and Entrez Gene identifiers specifically for *Loxodonta africana*. It is built upon the `MeSHDbi` framework, allowing users to query biological themes associated with elephant genes using standard Bioconductor SQL-based interface methods.

## Core Workflows

### Loading and Inspection
To begin using the mapping data, load the library and inspect the available fields.

```r
library(MeSH.Laf.eg.db)

# View basic metadata (species, database schema, etc.)
MeSH.Laf.eg.db
species(MeSH.Laf.eg.db)
dbInfo(MeSH.Laf.eg.db)
```

### Querying the Database
The package uses the standard `AnnotationDbi` interface: `columns`, `keytypes`, `keys`, and `select`.

1.  **Identify available fields:**
    ```r
    # List available columns to retrieve
    columns(MeSH.Laf.eg.db)

    # List types of keys that can be used for filtering
    keytypes(MeSH.Laf.eg.db)
    ```

2.  **Retrieve specific mappings:**
    Use the `select` function to map between MeSH IDs and Entrez Gene IDs.

    ```r
    # Example: Get the first 6 keys for a specific keytype (e.g., MESHID)
    my_keys <- head(keys(MeSH.Laf.eg.db, keytype="MESHID"))

    # Perform the join/lookup
    results <- select(MeSH.Laf.eg.db, 
                      keys = my_keys, 
                      columns = c("GENEID", "MESHCATEGORY"), 
                      keytype = "MESHID")
    head(results)
    ```

### Database Connection Details
For advanced users needing direct SQL access or file paths:
```r
dbconn(MeSH.Laf.eg.db)  # Returns the DBI connection object
dbfile(MeSH.Laf.eg.db)  # Returns the path to the SQLite file
```

## Usage Tips
- **Keytypes:** Common keytypes include `GENEID` (Entrez Gene ID) and `MESHID`.
- **MeSH Categories:** Use the `MESHCATEGORY` column to filter results by specific MeSH branches (e.g., Diseases, Chemicals and Drugs).
- **Integration:** This package is typically used in conjunction with `MeSHSim` for semantic similarity or `meshr` for enrichment analysis.

## Reference documentation
- [MeSH.Laf.eg.db Reference Manual](./references/reference_manual.md)