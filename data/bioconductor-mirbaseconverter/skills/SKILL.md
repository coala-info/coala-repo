---
name: bioconductor-mirbaseconverter
description: This tool converts and retrieves miRNA information, including names, accessions, sequences, and families, across different miRBase versions. Use when user asks to identify miRBase versions, convert between miRNA names and accessions, translate names between database versions, map precursor to mature miRNAs, or retrieve miRNA sequences and family classifications.
homepage: https://bioconductor.org/packages/release/bioc/html/miRBaseConverter.html
---

# bioconductor-mirbaseconverter

name: bioconductor-mirbaseconverter
description: A specialized tool for converting and retrieving miRNA information (Names, Accessions, Sequences, Families) across different miRBase versions (v6 to v22). Use this skill when you need to: (1) Identify the most likely miRBase version for a list of miRNA names, (2) Convert between miRNA Names and miRBase Accessions, (3) Translate miRNA names between different miRBase versions, (4) Convert between Precursor and Mature miRNAs, or (5) Retrieve miRNA sequences, family classifications, and historical name changes.

## Overview
The `miRBaseConverter` package is a comprehensive R/Bioconductor tool designed to resolve inconsistencies in miRNA nomenclature caused by frequent updates to the miRBase database. It provides a built-in database for high-efficiency retrieval of miRNA metadata without requiring constant internet access for every query.

## Core Workflows

### 1. Version Identification
If you have a list of miRNA names but don't know which miRBase version they belong to, use `checkMiRNAVersion()`. This is a critical first step for accurate downstream conversion.

```r
library(miRBaseConverter)
data(miRNATest)
miRNANames <- miRNATest$miRNA_Name
# Returns a table of match proportions and identifies the "BEST Matched" version
version_info <- checkMiRNAVersion(miRNANames, verbose = TRUE)
```

### 2. ID Conversion (Accession <-> Name)
Accessions (e.g., MIMAT0000062) are stable identifiers, while Names (e.g., hsa-let-7a-5p) change across versions.

```r
# Accession to Name (specify target version)
names_v22 <- miRNA_AccessionToName(Accessions, targetVersion = "v22")

# Name to Accession (specify the version the names currently belong to)
accessions <- miRNA_NameToAccession(miRNANames, version = "v18")
```

### 3. Cross-Version Name Conversion
There are two primary strategies for updating miRNA names from an old version to a newer one:

**Strategy A: Three-Step Exact Match (Recommended)**
This uses the Accession as a bridge to ensure the most accurate mapping.
1. `version <- checkMiRNAVersion(miRNANames)`
2. `accs <- miRNA_NameToAccession(miRNANames, version = version)`
3. `new_names <- miRNA_AccessionToName(accs$Accession, targetVersion = "v22")`

**Strategy B: Global Search**
Use `miRNAVersionConvert()` for a quick search across all historical records.
```r
result <- miRNAVersionConvert(miRNANames, targetVersion = "v22", exact = TRUE)
```

### 4. Precursor and Mature miRNA Mapping
```r
# Mature to Precursor
precursors <- miRNA_MatureToPrecursor(miRNANames)

# Precursor to Mature (often returns two mature miRNAs: 5p and 3p)
matures <- miRNA_PrecursorToMature(precursorNames)
```

### 5. Information Retrieval (Sequences and Families)
```r
# Get Sequences
seqs <- getMiRNASequence(Accessions, targetVersion = "v22")

# Get Family Information
families <- checkMiRNAFamily(Accessions)

# Get Full History of a single miRNA
history <- getMiRNAHistory("MIMAT0000765")
```

## Metadata and Species Queries
*   `getAllVersionInfo()`: Lists all miRBase versions, release dates, and counts.
*   `getAllSpecies()`: Lists all species abbreviations (e.g., "hsa", "mmu") and full names.
*   `getMiRNATable(version="v22", species="hsa")`: Returns the complete data table for a specific species and version.

## Tips for Success
*   **Version Prefix**: When specifying versions in function arguments, use the "v" prefix (e.g., `"v22"`, not `22`).
*   **Input Types**: Most functions accept either a single string or a character vector for batch processing.
*   **NA Handling**: If a miRNA does not exist in a target version, the functions typically return `<NA>`. Always check for these when processing large datasets.
*   **Online Redirection**: Use `goTo_miRBase(Accessions)` to automatically open the official miRBase web entry for specific miRNAs in your browser.

## Reference documentation
- [miRBaseConverter: A comprehensive and high-efficiency tool for converting and retrieving the information of miRNAs in different miRBase versions](./references/miRBaseConverter-vignette.md)