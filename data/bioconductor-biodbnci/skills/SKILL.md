---
name: bioconductor-biodbnci
description: This tool provides an interface to the National Cancer Institute databases to retrieve chemical identifiers, molecular structures, and NCI-60 cytotoxic activity data. Use when user asks to query the CACTUS Chemical Identifier Resolver, convert chemical formats like SMILES or SDF, or access growth inhibition data from the NCI-60 cancer cell line panel.
homepage: https://bioconductor.org/packages/release/bioc/html/biodbNci.html
---

# bioconductor-biodbnci

name: bioconductor-biodbnci
description: Access and retrieve data from the National Cancer Institute (NCI) databases, specifically the NCI-60 GI50 dataset and the CACTUS Chemical Identifier Resolver. Use this skill when a user needs to query NCI chemical identifiers, retrieve molecular structures (SDF/SMILES), or access NCI-60 cytotoxic activity data within an R session using the biodb framework.

# bioconductor-biodbnci

## Overview
The `biodbNci` package is an extension of the `biodb` framework, providing an interface to the National Cancer Institute (NCI) resources. It primarily facilitates two workflows: interacting with the CACTUS Chemical Identifier Resolver (to convert names, SMILES, or CAS numbers into other formats) and accessing the NCI-60 dataset, which contains growth inhibition (GI50) data for various compounds across 60 human cancer cell lines.

## Installation and Setup
To use this skill, the `biodb` and `biodbNci` packages must be installed.
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("biodbNci")

library(biodb)
library(biodbNci)
```

## Core Workflows

### 1. Initializing the biodb Instance
All operations start by creating a `biodb` instance and then connecting to the NCI connectors.
```r
# Create biodb instance
mybiodb <- biodb::newInst()

# Create a connector for CACTUS (Chemical Identifier Resolver)
cactus <- mybiodb$getFactory()$createConn('nci.cactus')

# Create a connector for NCI-60 dataset
nci60 <- mybiodb$getFactory()$createConn('nci60')
```

### 2. Using CACTUS for Chemical Conversion
The CACTUS connector allows for searching and retrieving chemical metadata.
```r
# Search for a compound by name to get NCI IDs
ids <- cactus$searchCompound(name='aspirin')

# Retrieve specific formats (e.g., SMILES, SDF, InChI)
smiles <- cactus$getEntry('50-78-2', fields='smiles')
sdf_content <- cactus$getEntry('50-78-2', retmode='sdf')
```

### 3. Accessing NCI-60 Data
The NCI-60 connector provides access to the developmental therapeutics program data.
```r
# Get entry for a specific NSC number (NCI identifier)
entry <- nci60$getEntry('123127')

# Convert entry to a data frame or list to see GI50 values
df <- entry$as.df()
```

## Tips and Best Practices
- **Caching**: `biodb` uses a local cache. If you perform many queries, ensure your cache directory is properly configured to avoid redundant network calls.
- **NSC Numbers**: When working with NCI-60, identifiers are typically "NSC" numbers. Ensure these are passed as strings to the `getEntry` methods.
- **Field Selection**: Use `cactus$getSearchableFields()` and `cactus$getOutputFields()` to discover what metadata can be queried or retrieved.
- **Cleanup**: Always terminate the biodb instance at the end of a script to free resources: `mybiodb$terminate()`.

## Reference documentation
- [biodbNci Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/biodbNci.html)