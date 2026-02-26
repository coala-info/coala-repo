---
name: bioconductor-jaspar2014
description: This package provides the 2014 release of the JASPAR database containing transcription factor binding profiles and site sequences for use in R. Use when user asks to access JASPAR 2014 motifs, retrieve position frequency matrices, or fetch transcription factor binding site sequences.
homepage: https://bioconductor.org/packages/release/data/experiment/html/JASPAR2014.html
---


# bioconductor-jaspar2014

name: bioconductor-jaspar2014
description: Data package for the JASPAR 2014 database of transcription factor binding profiles. Use this skill when you need to access the 2014 version of JASPAR motifs, position frequency matrices (PFMs), or binding site sequences within R, typically in conjunction with the TFBSTools package for motif searching and analysis.

# bioconductor-jaspar2014

## Overview
JASPAR2014 is a Bioconductor data package containing the 2014 release of the JASPAR database. It provides a SQLite database of transcription factor binding profiles and a collection of binding site sequences. This package is primarily used as a data source for the `TFBSTools` package, which provides the functional interface for searching and manipulating these motifs.

## Core Usage

### Loading the Package
```r
library(JASPAR2014)
```

### Accessing the Database Path
The package defines a `JASPAR2014` object which stores the path to the SQLite database.
```r
# View the database object
JASPAR2014
# The 'db' slot contains the character string of the path
# slot(JASPAR2014, "db")
```

### Accessing Site Sequences
The package includes `JASPAR2014SitesSeqs`, a `DNAStringSetList` containing transcription factor binding site sequences.
```r
data(JASPAR2014SitesSeqs)
# Access sequences by JASPAR ID
JASPAR2014SitesSeqs
```

## Integration with TFBSTools
Because JASPAR2014 is a data-only package, you must use `TFBSTools` to perform queries.

### Fetching Matrices (PFMs)
To retrieve motifs from the database, use the `getMatrixSet` function from `TFBSTools`.
```r
library(TFBSTools)
library(JASPAR2014)

# Connect to the 2014 database
db <- slot(JASPAR2014, "db")

# Fetch all vertebrate motifs
opts <- list(species = "Homo sapiens", 
             collection = "CORE")
pfm_list <- getMatrixSet(db, opts)
```

### Common Query Options
When using `getMatrixSet`, you can filter by:
- `ID`: JASPAR stable ID (e.g., "MA0001.1")
- `name`: Transcription factor name (e.g., "Evi1")
- `collection`: "CORE", "CNE", "PHYLOFACTS", "POLII", "PBM", "PBM_HOMEO", "PBM_HLH"
- `all_versions`: Boolean to return all versions of a matrix
- `species`: NCBI Taxon ID or species name

## Workflow: Motif to PWM
A typical workflow involves loading the data from JASPAR2014 and converting it to a Position Weight Matrix (PWM) for scanning sequences.
```r
# 1. Get PFM from JASPAR2014 via TFBSTools
pfm <- getMatrixByID(db, "MA0004.1")

# 2. Convert PFM to PWM
pwm <- toPWM(pfm)

# 3. Use PWM for downstream analysis (e.g., searchSeq)
```

## Reference documentation
- [JASPAR2014 Reference Manual](./references/reference_manual.md)