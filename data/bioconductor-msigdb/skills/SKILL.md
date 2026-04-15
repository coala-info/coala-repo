---
name: bioconductor-msigdb
description: This package provides a structured interface to access and manage the Molecular Signatures Database (MSigDB) within R using GSEABase objects. Use when user asks to download gene sets for human or mouse, subset specific collections like Hallmarks or Gene Ontology, and prepare gene sets for enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/msigdb.html
---

# bioconductor-msigdb

name: bioconductor-msigdb
description: Access and manage the Molecular Signatures Database (MSigDB) in R. Use this skill to download gene sets for human and mouse, subset specific collections (e.g., Hallmarks, Gene Ontology), and prepare gene sets for enrichment analysis tools like limma, GSEA, or GSVA.

# bioconductor-msigdb

## Overview
The `msigdb` package provides a structured interface to the Molecular Signatures Database (MSigDB) within R. Unlike other packages that return simple lists or tibbles, `msigdb` uses `GeneSet` and `GeneSetCollection` objects from the `GSEABase` package. This preserves essential metadata, such as gene set descriptions, versions, and organism information, ensuring data integrity and easier downstream analysis.

## Installation
Install the package using BiocManager:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("msigdb")
```

## Loading and Accessing Data
Data is hosted on ExperimentHub. You can access it via the `ExperimentHub` interface or the package's custom accessor.

### Using getMsigdb
The `getMsigdb()` function is the most direct way to retrieve specific versions and species.

```r
library(msigdb)

# Load Human (hs) Gene Symbols (SYM) version 7.4
msigdb.hs = getMsigdb(org = 'hs', id = 'SYM', version = '7.4')

# Load Mouse (mm) Gene Symbols
msigdb.mm = getMsigdb(org = 'mm', id = 'SYM', version = '7.4')
```

### Using ExperimentHub
Use this method to browse all available versions and records.

```r
library(ExperimentHub)
eh = ExperimentHub()
query(eh, 'msigdb')

# Download a specific record by ID
msigdb_v72 = eh[['EH5421']]
```

### Integrating KEGG
Due to licensing, KEGG gene sets are not bundled by default but can be appended dynamically:

```r
msigdb.hs = appendKEGG(msigdb.hs)
```

## Managing Collections
MSigDB is organized into categories (e.g., H, C1-C8). Use these functions to explore and filter the database.

### Listing and Subsetting
```r
# List available categories (e.g., "h", "c2", "c5")
listCollections(msigdb.hs)

# List sub-collections (e.g., "GO:BP", "CP:REACTOME")
listSubCollections(msigdb.hs)

# Retrieve only Hallmark gene sets
hallmarks = subsetCollection(msigdb.hs, 'h')

# Retrieve Gene Ontology Biological Process (GO:BP)
go_bp = subsetCollection(msigdb.hs, 'c5', 'GO:BP')
```

## Inspecting Gene Sets
Since the data uses `GSEABase` structures, use standard accessors to extract information.

```r
library(GSEABase)

# Get a specific gene set from the collection
gs = msigdb.hs[[1]]

# Extract gene symbols/IDs
geneIds(gs)

# Get metadata
description(gs)
details(gs)

# Summarize categories in a collection
table(sapply(lapply(msigdb.hs, collectionType), bcCategory))
```

## Workflow: Preparing for Enrichment Analysis
To use these gene sets with tools like `limma::fry` or `camera`, convert the `GeneSetCollection` into a list of indices mapped to your expression matrix.

```r
library(limma)

# 1. Subset the desired collection
hallmarks = subsetCollection(msigdb.hs, 'h')

# 2. Extract gene IDs as a list
msigdb_ids = geneIds(hallmarks)

# 3. Map IDs to the row names of your expression matrix (emat)
fry_indices = ids2indices(msigdb_ids, rownames(emat))

# 4. Run enrichment
# res = fry(emat, index = fry_indices, design = design)
```

## Reference documentation
- [msigdb: The molecular signatures database (MSigDB) in R](./references/msigdb.Rmd)
- [msigdb: The molecular signatures database (MSigDB) in R](./references/msigdb.md)