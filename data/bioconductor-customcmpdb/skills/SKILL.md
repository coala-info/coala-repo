---
name: bioconductor-customcmpdb
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/customCMPdb.html
---

# bioconductor-customcmpdb

## Overview
The `customCMPdb` package provides a unified interface to access and query several major small molecule databases. It integrates annotation data (stored in SQLite) with structural data (stored as SDF files). A key feature is the ability for users to "side-load" their own custom compound collections into the local database, allowing them to be queried alongside community standards like DrugBank and LINCS.

## Installation and Setup
To use this package, ensure `customCMPdb` and `ChemmineR` (for structure handling) are loaded:

```r
library(customCMPdb)
library(ChemmineR)
library(RSQLite)
```

## Working with Annotations
Annotations are managed via an SQLite database.

### Loading and Listing Annotations
*   `loadAnnot()`: Returns a connection to the SQLite database.
*   `listAnnot()`: Lists all available annotation tables (e.g., "drugAgeAnnot", "lincsAnnot", "DrugBankAnnot").

```r
conn <- loadAnnot()
dbListTables(conn)
# Read a specific table
drugAgeData <- dbReadTable(conn, "drugAgeAnnot")
dbDisconnect(conn)
```

### Querying the Database
Use `queryAnnotDB` to retrieve specific compound information across multiple sources using identifiers (typically ChEMBL IDs).

```r
query_ids <- c("CHEMBL10", "CHEMBL113")
results <- queryAnnotDB(query_ids, annot = c("drugAgeAnnot", "lincsAnnot"))
```

## Working with Structures (SDF)
Structural data is retrieved as `SDFset` objects, which are compatible with the `ChemmineR` ecosystem.

```r
# Load structures for a specific source
da_sdf <- loadSDFwithName(source = "DrugAge")
db_sdf <- loadSDFwithName(source = "DrugBank")
cmap_sdf <- loadSDFwithName(source = "CMAP2")
lincs_sdf <- loadSDFwithName(source = "LINCS")

# Visualize a structure
plot(da_sdf[1])
```

## Custom Compound Integration
You can add your own data frames to the local database. Custom tables should ideally include a `chembl_id` column for cross-referencing.

### Adding and Deleting Custom Data
```r
# Create a data frame with annotations
my_data <- data.frame(
  cmp_name = c("CompoundA", "CompoundB"),
  chembl_id = c("CHEMBL123", "CHEMBL456"),
  my_metric = c(0.5, 0.8)
)

# Add to database
addCustomAnnot(my_data, annot_name = "myProject")

# Query custom data alongside community data
res <- queryAnnotDB("CHEMBL123", annot = c("lincsAnnot", "myProject"))

# Remove custom table
deleteAnnot("myProject")
```

### Resetting the Database
If the local database becomes corrupted or you wish to remove all custom additions, use:
```r
defaultAnnot()
```

## Workflow Tips
1.  **Identifier Mapping**: The package uses a mapping table to connect entries across databases. If a ChEMBL ID is missing, you can often query using source-specific IDs (like LINCS IDs) if they are present in the annotation table.
2.  **AnnotationHub**: The underlying data is hosted on Bioconductor's `AnnotationHub`. If you need the raw file path to the SQLite database:
    ```r
    library(AnnotationHub)
    ah <- AnnotationHub()
    path <- ah[["AH79563"]]
    ```
3.  **ChemmineR Integration**: Since structures are returned as `SDFset` objects, you can perform chemical similarity searches, descriptor calculations, and clustering using standard `ChemmineR` functions.

## Reference documentation
- [_customCMPdb_: Integrating Community and Custom Compound Collections](./references/customCMPdb.md)
- [customCMPdb Vignette Source](./references/customCMPdb.Rmd)