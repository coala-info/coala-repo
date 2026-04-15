---
name: r-biodb
description: r-biodb is an R package framework for accessing and querying biological and chemical databases through a unified interface. Use when user asks to retrieve database entries by accession number, search for compounds by name or mass, perform mass spectrometry searches, or develop new database connectors in R.
homepage: https://cran.r-project.org/web/packages/biodb/index.html
---

# r-biodb

name: r-biodb
description: Specialized R package framework for accessing biological and chemical databases (ChEBI, HMDB, KEGG, UniProt). Use when you need to retrieve database entries by accession number, search for compounds by name or mass, search mass spectrometry (MS) spectra, or develop new database connectors in R.

## Overview
biodb is a framework for developing and using database connectors in R. It provides a unified interface to access various remote and local databases, featuring a built-in caching system, request scheduling to respect access policies, and standardized field mapping across different data sources.

## Installation
Install the stable version from Bioconductor:
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install('biodb')
```
To use specific databases, you may need extension packages:
```R
devtools::install_github('pkrog/biodbChebi')
devtools::install_github('pkrog/biodbKegg')
```

## Core Workflow
The standard workflow involves initializing the biodb instance, creating a connector via the factory, and then performing queries.

### 1. Initialization and Connection
```R
# Create a new biodb instance
bdb <- biodb::newInst()

# Create a connector (e.g., for ChEBI)
chebi <- bdb$getFactory()$createConn('chebi')
```

### 2. Retrieving Entries
Retrieve entries by accession numbers and convert them to a data frame:
```R
ids <- c('2528', '7799')
entries <- chebi$getEntry(ids)
df <- bdb$entriesToDataframe(entries)
```

### 3. Searching Compounds
Search by name or mass across compound databases:
```R
# Search by name
chebi$searchCompound(name='phosphate')

# Search by mass with tolerance
chebi$searchCompound(mass=230.02, mass.field='monoisotopic.mass', mass.tol=0.01)
```

### 4. Mass Spectrometry (MS) Operations
Search MS databases or annotate M/Z values:
```R
# Search MS entries by M/Z range
ms_conn$searchMsEntries(mz.min=40, mz.max=41)

# Annotate a data frame of M/Z values using a compound database
annotated_df <- compound_conn$annotateMzValues(myInputDataFrame, mz.tol=0.1, ms.mode='neg')
```

## Developing New Connectors
biodb provides a generator to create the skeleton for new extension packages:
```R
biodb::genNewExtPkg(
  path = 'path/to/biodbFoo',
  dbName = 'foo.db',
  dbTitle = 'Foo Database',
  connType = 'compound', # or 'mass'
  remote = TRUE
)
```

## Tips
- **Caching**: biodb automatically caches requests. You can manage the cache via `bdb$getCache()`.
- **Field Definitions**: Standardized fields (e.g., `inchi`, `smiles`, `monoisotopic.mass`) allow switching between databases without changing downstream code.
- **Definitions**: Custom fields can be loaded via YAML files using `bdb$loadDefinitions('my_fields.yml')`.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)