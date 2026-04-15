---
name: bioconductor-lrbasedbi
description: LRBaseDbi provides a generic interface and database class for managing and querying ligand-receptor interaction data within the Bioconductor ecosystem. Use when user asks to construct LRBaseDb objects from AnnotationHub, query ligand-receptor pairs for specific species, or retrieve interaction metadata for cell-cell communication analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/LRBaseDbi.html
---

# bioconductor-lrbasedbi

## Overview

LRBaseDbi is a Bioconductor package that provides a generic interface for Ligand-Receptor (L-R) interaction databases. It defines the `LRBaseDb` class and provides methods to construct these objects using data from `AnnotationHub`. This package is essential for researchers performing cell-cell communication analysis (such as with the `scTensor` package) who need to map ligands to their corresponding receptors for specific species.

## Core Workflow

### 1. Database Construction
To use LRBaseDbi, you must first retrieve the appropriate database file for your species of interest using `AnnotationHub`.

```r
library(LRBaseDbi)
library(AnnotationHub)

# Initialize AnnotationHub
ah <- AnnotationHub()

# Query for a specific species (e.g., Sus scrofa / Pig)
db_metadata <- query(ah, c("LRBaseDb", "Sus scrofa"))
dbfile <- db_metadata[[1]]

# Construct the LRBaseDb object
LRBase.Ssc.eg.db <- LRBaseDb(dbfile)
```

### 2. Querying the Database
LRBaseDb objects follow the standard Bioconductor AnnotationDbi interface.

*   **columns(db)**: List the types of data available (e.g., GENEID_L, GENEID_R).
*   **keytypes(db)**: List the types of keys that can be used for filtering.
*   **keys(db, keytype)**: Retrieve all keys of a specific type.
*   **select(db, keys, columns, keytype)**: Perform the actual data retrieval.

```r
# Check available columns
cols <- columns(LRBase.Ssc.eg.db)

# Get specific L-R pairs for a set of receptors
ks <- keys(LRBase.Ssc.eg.db, keytype='GENEID_R')
results <- select(LRBase.Ssc.eg.db, 
                  keys = ks[1:5], 
                  columns = c('GENEID_L', 'GENEID_R'), 
                  keytype = 'GENEID_R')
```

### 3. Metadata and Utility Functions
Use these functions to inspect the database provenance and versioning:

*   **species(db)**: Returns the common name of the species.
*   **lrNomenclature(db)**: Returns the scientific name.
*   **lrListDatabases(db)**: Returns the source databases used to compile the L-R pairs.
*   **lrVersion(db)**: Returns the version of the LRBase data.
*   **dbInfo(db)**: Provides general information about the database object.

## Integration with scTensor
LRBaseDbi serves as the data provider for the `scTensor` package. If you are performing tensor decomposition for cell-cell communication, you will typically pass the `LRBaseDb` object into `scTensor` workflows to define the underlying L-R network.

## Tips
*   **Caching**: `AnnotationHub` downloads are cached locally. If you encounter issues, check your `AnnotationHub` cache directory.
*   **Gene IDs**: Most LRBaseDb objects use Entrez Gene IDs (represented as GENEID_L for Ligand and GENEID_R for Receptor). Ensure your input data matches this nomenclature or use an OrgDb package to convert symbols to Entrez IDs first.

## Reference documentation
- [Introduction to LRBaseDbi](./references/LRBaseDbi.md)