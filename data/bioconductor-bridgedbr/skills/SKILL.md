---
name: bioconductor-bridgedbr
description: BridgeDbR provides an R interface to the BridgeDb framework for mapping biological identifiers across various databases. Use when user asks to map gene, protein, or metabolite identifiers between different data sources, download mapping databases, or resolve secondary identifiers.
homepage: https://bioconductor.org/packages/release/bioc/html/BridgeDbR.html
---

# bioconductor-bridgedbr

## Overview
BridgeDbR provides an R interface to the BridgeDb framework, allowing for standardized mapping between various biological database identifiers. It supports genes, proteins, metabolites, and metabolic interactions. The package relies on `.bridge` mapping files which can be downloaded for specific organisms or data types.

## Core Concepts
- **Organisms**: Identified by Latin names (e.g., "Homo sapiens") and two-character codes (e.g., "Hs").
- **Data Sources**: Databases like Ensembl or ChEBI, identified by full names and short system codes (e.g., "En" for Ensembl, "Ce" for ChEBI).
- **System Codes**: Essential for mapping functions (e.g., "L" for Entrez Gene, "X" for Affymetrix).

## Typical Workflow

### 1. Setup and Data Source Identification
```r
library(BridgeDbR)

# Convert between names and codes
code <- getOrganismCode("Rattus norvegicus") # "Rn"
fullName <- getFullName("Ce")                # "ChEBI"
sysCode <- getSystemCode("ChEBI")            # "Ce"

# Identify potential sources for an ID
getMatchingSources("HMDB00555")
```

### 2. Obtaining Mapping Databases
Mapping requires a `.bridge` file.
```r
# List available gene databases
getBridgeNames()

# Download a database for a specific organism
dbLocation <- getDatabase("Homo sapiens", location = getwd())

# Load the database into a mapper object
mapper <- loadDatabase(dbLocation)
```

### 3. Mapping Identifiers
Use `map()` for single identifiers or `maps()` for batch processing.
```r
# Map Entrez Gene (L) to Affy (X)
map(mapper, source="L", identifier="196410", target="X")

# Using CURIEs (Compact Identifiers)
map(mapper, compactIdentifier="ncbigene:196410", target="X")

# Batch mapping from a data frame
input_df <- data.frame(
    source = rep("Ch", length(ids)),
    identifier = ids
)
results <- maps(mapper, input_df, target="Wd") # Wd = Wikidata
```

### 4. Handling Secondary Identifiers
Some databases (like ChEBI) use `sec2pri` mapping files to resolve outdated identifiers.
```r
# Load a sec2pri bridge file
sec2pri <- loadDatabase("ChEBI_secID2priID.bridge")

# Check if an ID is primary or secondary
res <- map(sec2pri, source="Ce", identifier="CHEBI:1234")
# The 'isPrimary' column in the result indicates status (T/F)
```

## Tips
- **rJava**: BridgeDbR requires `rJava`. Ensure your Java environment is correctly configured if loading fails.
- **Absolute Paths**: Always use absolute paths with `loadDatabase()` to avoid file-not-found errors.
- **Metabolites**: Metabolite mapping files are often hosted on Figshare rather than the standard PathVisio download servers; these must be downloaded manually or via `download.file()`.

## Reference documentation
- [Secondary identifiers](./references/secondary.md)
- [BridgeDbR Tutorial (Rmd)](./references/tutorial.Rmd)
- [BridgeDbR Tutorial (md)](./references/tutorial.md)