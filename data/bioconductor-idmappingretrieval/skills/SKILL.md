---
name: bioconductor-idmappingretrieval
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/IdMappingRetrieval.html
---

# bioconductor-idmappingretrieval

name: bioconductor-idmappingretrieval
description: Facilitates biological identifier mapping and annotation retrieval from online services (NetAffx, Ensembl, EnVision) using the IdMappingRetrieval R package. Use this skill when you need to create, cache, and manage one-to-many ID maps (e.g., Uniprot to Affymetrix Probeset IDs) or retrieve complete annotation data frames for specific microarray platforms.

# bioconductor-idmappingretrieval

## Overview

The `IdMappingRetrieval` package provides a unified interface for retrieving biological identifier mappings from online bioinformatics services. It features a robust two-tier caching system that stores raw data frames and processed ID maps locally, significantly speeding up subsequent retrieval. The package supports both query-based services (automated via APIs like biomaRt or ENVISIONQuery) and file-based services (processing manual downloads from NetAffx or Ensembl).

## Session Initialization

Every session must begin by defining a caching directory. This directory stores `.RData` files organized by service and array type.

```R
library(IdMappingRetrieval)

# 1. Initialize the caching system
Annotation$init(directory="./annotationData", verbose=TRUE)

# 2. Set credentials (required for Affymetrix/NetAffx services)
AnnotationAffx$setCredentials(user="your_email@example.com", password="your_password")
```

## Service Object Configuration

Service objects are created based on the data source. Common parameters include `cacheFolderName`, `primaryColumn`, `secondaryColumn`, and `species`.

### Query-Based Services (Automated)
*   **AnnotationEnsembl**: Uses `biomaRt` to query Ensembl.
*   **AnnotationEnvision**: Uses `ENVISIONQuery` for EnVision Web Services.
*   **AnnotationAffx**: Uses `AffyCompatible` for Affymetrix repositories.

```R
# Example: Ensembl Query Service
annEnsembl <- AnnotationEnsembl(
  cacheFolderName="Ensembl",
  primaryColumn="uniprot_swissprot_accession",
  secondaryColumn="affy_hg_u133_plus_2",
  species="hsapiens"
)
```

### File-Based Services (Manual)
*   **AnnotationEnsemblCsv**: Processes CSV exports from Ensembl BioMart.
*   **AnnotationNetAffx**: Processes batch query results from Affymetrix.

```R
# Example: Ensembl CSV Service
annEnsemblCsv <- AnnotationEnsemblCsv(
  cacheFolderName="EnsemblCsv",
  df_filename="path/to/biomart_export.txt",
  primaryColumn=c("UniProt.SwissProt.Accession", "UniProt.TrEMBL.Accession"),
  full.merge=TRUE
)
```

## Data Retrieval Workflows

### Retrieving ID Maps
An ID map is a two-column data frame where the secondary column contains comma-separated strings for one-to-many mappings.

```R
arrayType <- "HG-U133_Plus_2"

# Retrieve from a single service
idMap <- getIdMap(annEnsembl, 
                  arrayType=arrayType, 
                  primaryKey="Uniprot", 
                  secondaryKey="Affy")

# Retrieve from multiple services using a list
services <- list(Ensembl=annEnsembl, Affy=annAffx_Q)
idMapList <- lapply(services, getIdMap, 
                    arrayType=arrayType, 
                    primaryKey="Uniprot", 
                    secondaryKey="Affy")
```

### Using the ServiceManager
The `ServiceManager` acts as a container to manage multiple services simultaneously and provides interactive selection menus.

```R
# Create manager with default services
svm <- ServiceManager(ServiceManager$getDefaultServices())

# Retrieve ID maps for specific services
idMapList <- getIdMapList(svm, 
                          arrayType=arrayType, 
                          selection=c("Ensembl", "NetAffx_Q"),
                          primaryKey="Uniprot", 
                          secondaryKey="Affy")

# Interactive mode (opens menus for array and service selection)
idMapList <- ServiceManager$getIdMapList(arrayType="menu", selection="menu")
```

### Retrieving Raw Annotation Data
To get the full annotation table rather than just the mapping pair:

```R
rawDF <- getDataFrame(annEnsembl, arrayType=arrayType)
```

## Tips for Success
*   **Column Merging**: If `primaryColumn` or `secondaryColumn` contains multiple names, the service object automatically merges those columns.
*   **Swapping**: Use `swap=TRUE` in the constructor to reverse the mapping direction (e.g., changing a Uniprot->Affy map to Affy->Uniprot).
*   **Force Update**: If online data has changed, set `force=TRUE` in `getIdMap` or `getDataFrame` to bypass the cache and re-download.
*   **Species**: Ensure the `species` parameter matches the naming convention of the underlying service (e.g., "Homo sapiens" for Envision vs "hsapiens" for Ensembl).

## Reference documentation
- [IdMappingRetrieval](./references/IdMappingRetrieval.md)