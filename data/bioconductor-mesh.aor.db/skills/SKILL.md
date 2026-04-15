---
name: bioconductor-mesh.aor.db
description: This package provides mappings between Medical Subject Headings (MeSH) identifiers and Entrez Gene IDs using the AnnotationDbi framework. Use when user asks to map MeSH IDs to gene identifiers, retrieve MeSH hierarchies, or query gene-MeSH associations for functional enrichment analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MeSH.AOR.db.html
---

# bioconductor-mesh.aor.db

name: bioconductor-mesh.aor.db
description: Access and query the MeSH.AOR.db annotation package for mapping between Medical Subject Headings (MeSH) IDs and Entrez Gene IDs. Use this skill when you need to perform identifier conversions, retrieve MeSH hierarchies, or explore gene-MeSH associations within the Bioconductor ecosystem.

# bioconductor-mesh.aor.db

## Overview
`MeSH.AOR.db` is a Bioconductor annotation package that provides a standardized interface for mapping between MeSH (Medical Subject Headings) identifiers and Entrez Gene IDs. It utilizes the `AnnotationDbi` framework, allowing users to query biological metadata using a consistent set of accessor methods. This package is essential for researchers performing functional enrichment analysis or literature-based gene characterization.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MeSH.AOR.db")
library(MeSH.AOR.db)
```

## Core Workflow
The package follows the standard `AnnotationDbi` interface. Use the following four methods to interact with the database:

### 1. Discovering Available Data
Check which types of identifiers (keys) and information (columns) are available:

```r
# List available columns to retrieve
columns(MeSH.AOR.db)

# List available keytypes to search by
keytypes(MeSH.AOR.db)
```

### 2. Retrieving Keys
Extract specific identifiers to use for filtering or lookups:

```r
# Get the first 6 keys of a specific keytype
kts <- keytypes(MeSH.AOR.db)
ks <- head(keys(MeSH.AOR.db, keytype = kts[1]))
```

### 3. Querying the Database
Use the `select` function to map keys to desired columns:

```r
# Example: Map specific keys to all available columns
res <- select(MeSH.AOR.db, 
              keys = ks, 
              columns = columns(MeSH.AOR.db), 
              keytype = kts[1])
head(res)
```

## Database Metadata
To inspect the underlying SQLite database structure and metadata:

```r
# Get database connection information
dbconn(MeSH.AOR.db)

# Get the file path of the SQLite database
dbfile(MeSH.AOR.db)

# View the database schema
dbschema(MeSH.AOR.db)

# Get general information about the database version and source
dbInfo(MeSH.AOR.db)
```

## Usage Tips
- **MeSHDbi Requirement**: While `MeSH.AOR.db` contains the data, it relies on the `MeSHDbi` package for the underlying logic. Ensure `MeSHDbi` is installed if you encounter method dispatch errors.
- **Keytype Selection**: Always verify the `keytype` argument in `select()` matches the format of your input `keys` to avoid empty results.
- **Large Queries**: If querying thousands of genes, consider retrieving only the specific `columns` needed to improve performance.

## Reference documentation
- [MeSH.AOR.db Reference Manual](./references/reference_manual.md)