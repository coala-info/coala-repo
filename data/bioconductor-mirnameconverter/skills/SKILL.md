---
name: bioconductor-mirnameconverter
description: This tool translates mature miRNA names between different miRBase versions and manages nomenclature changes. Use when user asks to translate miRNA names to specific miRBase versions, identify the likely miRBase version of a dataset, validate miRNA names, or retrieve miRNA sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/miRNAmeConverter.html
---


# bioconductor-mirnameconverter

name: bioconductor-mirnameconverter
description: Comprehensive miRNA name translation and miRBase version management. Use when Claude needs to: (1) Convert mature miRNA names between different miRBase release versions, (2) Identify the most likely miRBase version for a set of miRNA names, (3) Validate miRNA names against the miRBase database, (4) Retrieve miRNA sequences, or (5) Check for miRNAs that swap MIMAT IDs across versions.

# bioconductor-mirnameconverter

## Overview
The `miRNAmeConverter` package provides tools for handling the evolution of miRNA nomenclature across different miRBase release versions. It allows users to translate mature miRNA names to specific versions, retrieve sequences, and identify which miRBase version a set of names likely originated from. It relies on the `miRBaseVersions.db` annotation package for historical mapping.

## Core Workflow

### 1. Initialization
All operations require an instance of the `MiRNANameConverter` class.
```r
library(miRNAmeConverter)
nc <- MiRNANameConverter()
```

### 2. Translating miRNA Names
Translate names from an unknown or mixed version to one or more target versions.
```r
miRNAs <- c("hsa-miR-140", "hsa-miR-125a")
# Translate to versions 15, 16, 20, and 21
res <- translateMiRNAName(nc, miRNAs = miRNAs, versions = c(15, 16, 20, 21))

# View the main translation table
print(res)

# Access additional information stored in attributes
description <- attr(res, "description")
sequences <- attr(res, "sequence")
```

### 3. Assessing miRBase Version
If the source version of a miRNA list is unknown, use `assessVersion` to find the most likely match based on name frequency in the database.
```r
version_info <- assessVersion(nc, miRNAs = miRNAs)
# Returns a data frame with 'version' and 'frequency'
```

### 4. Validating Names
Check if names exist in any version of miRBase.
```r
valid_names <- checkMiRNAName(nc, miRNAs = c("hsa-miR-29a", "not-a-mirna"))
# Returns only the valid names: "hsa-miR-29a"
```

## Advanced Features

### Sequence Retrieval
The `translateMiRNAName` function can return sequence information via the `sequenceFormat` argument.
- `sequenceFormat = 1`: Only sequences.
- `sequenceFormat = 2`: miRNA name and sequence.
```r
res <- translateMiRNAName(nc, miRNAs = miRNAs, versions = 21, sequenceFormat = 2)
seqs <- attr(res, "sequence")
```

### Handling MIMAT Swapping
Some miRNA names have been assigned to different MIMAT accessions across versions. Use `assessMiRNASwappingMIMAT` to identify these ambiguous cases.
```r
swapped <- assessMiRNASwappingMIMAT(nc, miRNAs = miRNAs)
```

### Saving Results
The package provides a dedicated function to save translation results while preserving the metadata attributes.
```r
saveResults(nc, res, outputFilename = "miRNA_translation.txt", outputPath = ".")
```

## Package Metadata and Stats
- **Current Version Support**: Use `currentVersion(nc)` to see the highest supported miRBase version.
- **Organism Support**: Use `validOrganisms(nc)` to list supported species prefixes (e.g., "hsa", "mmu").
- **Database Stats**: `nTotalEntries(nc)` provides the total number of miRNA entries across all versions.

## Reference documentation
- [miRNAmeConverter Reference Manual](./references/reference_manual.md)