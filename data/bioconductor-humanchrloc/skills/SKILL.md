---
name: bioconductor-humanchrloc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/humanCHRLOC.html
---

# bioconductor-humanchrloc

name: bioconductor-humanchrloc
description: Access human chromosomal location annotation data from Bioconductor. Use this skill to map Entrez Gene identifiers to transcription start and end positions across all human chromosomes (1-22, X, Y), and to retrieve cytoband location data.

# bioconductor-humanchrloc

## Overview

The `humanCHRLOC` package is a Bioconductor annotation data package providing transcription start and end locations for human genes. It maps Entrez Gene identifiers to specific base pair positions on the human genome (based on the Golden Path/UCSC hg16 assembly). Positions are measured from the p-arm (5' end of the sense strand) to the q-arm (3' end). Antisense strand locations are indicated by a negative sign.

## Core Workflows

### Loading the Package
```r
if (!require("humanCHRLOC")) {
    BiocManager::install("humanCHRLOC")
    library(humanCHRLOC)
}
library(annotate) # Required for many annotation environment operations
```

### Mapping Genes to Chromosomal Locations
The package provides environment objects for each chromosome, split by START and END positions.

**Pattern:** `humanCHRLOC[CHR][START|END]`
- `CHR`: 1-22, X, or Y.
- `START`: Transcription starting location.
- `END`: Transcription ending location.

```r
# Example: Get transcription start locations for genes on Chromosome 10
start_locs <- as.list(humanCHRLOC10START)

# Access specific Entrez Gene ID
gene_id <- "10" # Example Entrez ID
start_locs[[gene_id]]
```

### Interpreting Values
- **Positive values:** Gene is on the sense strand.
- **Negative values:** Gene is on the antisense strand (e.g., -1234567).
- **Names:** Values are named "Confident" (placed reliably) or "Unconfident" (random/unplaced in UCSC data).

### Cytoband and Chromosome Mapping
The package includes global mapping tools for human genes:

1.  **Cytoband Locations:** `humanCHRLOCCYTOLOC` maps chromosome numbers to cytoband identifiers and their start/end base pair ranges.
2.  **Gene to Chromosome:** `humanCHRLOCENTREZID2CHR` maps Entrez Gene IDs to their resident chromosome number.

```r
# Get cytobands for Chromosome 1
bands <- as.list(humanCHRLOCCYTOLOC)
chr1_bands <- bands[["1"]]
# View start/end for the first band
chr1_bands[[1]]

# Find which chromosome a gene belongs to
gene_to_chr <- as.list(humanCHRLOCENTREZID2CHR)
gene_to_chr["10"]
```

### Quality Control
To view package metadata and build information:
```r
humanCHRLOC() # Displays QC information
```

## Reference documentation

- [humanCHRLOC](./references/reference_manual.md)