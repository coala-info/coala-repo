---
name: bioconductor-biodbchebi
description: The biodbChebi package provides a programmatic interface to the ChEBI database for retrieving chemical metadata and performing compound searches. Use when user asks to retrieve chemical entries by accession number, search for compounds by name or mass, or convert CAS and InChI identifiers to ChEBI IDs.
homepage: https://bioconductor.org/packages/release/bioc/html/biodbChebi.html
---

# bioconductor-biodbchebi

## Overview

The `biodbChebi` package is an extension of the `biodb` framework, providing a connector to the ChEBI database. It allows users to programmatically retrieve detailed chemical information, perform compound searches, and handle identifier conversions. It is particularly useful in metabolomics and chemical biology workflows for annotating chemical entities.

## Core Workflow

### 1. Initialization and Connection
All operations require a `biodb` instance and a connector to the ChEBI database.

```r
library(biodbChebi)

# Initialize the biodb instance
mybiodb <- biodb::newInst()

# Create the ChEBI connector
chebi <- mybiodb$getFactory()$createConn('chebi')
```

### 2. Retrieving Entries
Retrieve specific entries using ChEBI accession numbers.

```r
# Request entries by ID
entries <- chebi$getEntry(c('2528', '17053'))

# Access specific fields (e.g., SMILES)
smiles_val <- entries[[1]]$getFieldValue('smiles')

# Convert entries to a data frame for easier analysis
df <- mybiodb$entriesToDataframe(entries, fields=c('accession', 'formula', 'molecular.mass', 'inchikey'))
```

### 3. Searching for Compounds
Search the database using names or mass values. Note that `searchCompound()` is deprecated in favor of `searchForEntries()`.

```r
# Search by name
ids_name <- chebi$searchForEntries(name='aspartic', max.results=5)

# Search by mass with tolerance
ids_mass <- chebi$searchForEntries(mass=133, mass.field='molecular.mass', mass.tol=0.3)

# Combined search
ids_both <- chebi$searchForEntries(name='aspartic', mass=133, mass.field='molecular.mass', mass.tol=0.1)
```

### 4. Identifier Conversion
Convert common chemical identifiers to ChEBI IDs.

```r
# Convert CAS IDs
chebi_ids <- chebi$convCasToChebi(c('87605-72-9', '51-41-2'))

# Convert InChI or InChIKey
chebi_id_inchi <- chebi$convInchiToChebi('InChI=1S/C8H11NO3/c9-4-8(12)5-1-2-6(10)7(11)3-5/h1-3,8,10-12H,4,9H2/t8-/m0/s1')
chebi_id_key <- chebi$convInchiToChebi('MBDOYVRWFFCFHM-SNAWJCMRSA-N')
```

### 5. Cleanup
Always terminate the `biodb` instance to free resources and manage the cache.

```r
mybiodb$terminate()
```

## Tips and Best Practices
- **Field Names**: Common fields include `smiles`, `inchi`, `inchikey`, `formula`, `molecular.mass`, and `kegg.compound.id`.
- **Data Frames**: Use `mybiodb$entriesToDataframe()` when dealing with multiple entries to quickly generate a tabular summary of chemical properties.
- **Simplification**: In conversion functions like `convCasToChebi()`, if a CAS ID maps to multiple ChEBI IDs, the function returns a list. Set `simplify=FALSE` to ensure consistent list output if processing batches.
- **Local vs Remote**: While `biodbChebi` typically connects to the ChEBI web services, the `biodb` framework handles caching automatically to improve performance on repeated queries.

## Reference documentation
- [An introduction to biodbChebi](./references/biodbChebi.md)
- [An introduction to biodbChebi (Rmd)](./references/biodbChebi.Rmd)