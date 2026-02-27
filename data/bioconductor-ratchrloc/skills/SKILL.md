---
name: bioconductor-ratchrloc
description: The ratCHRLOC package provides genomic location mappings and chromosome assignments for Rattus norvegicus Entrez Gene identifiers. Use when user asks to map rat genes to chromosomes, find transcription start or end positions, or retrieve cytoband coordinates.
homepage: https://bioconductor.org/packages/release/data/annotation/html/ratCHRLOC.html
---


# bioconductor-ratchrloc

## Overview

The `ratCHRLOC` package is a Bioconductor annotation data package for *Rattus norvegicus*. It provides mappings between Entrez Gene identifiers and their genomic locations, including chromosome assignments, transcription start/end positions, and cytoband coordinates.

The package uses environment objects to store these mappings. Data is primarily derived from the UCSC Golden Path database.

## Installation and Loading

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ratCHRLOC")
library(ratCHRLOC)
```

## Core Workflows

### Mapping Genes to Chromosomes
To find which chromosome a specific Entrez Gene ID resides on, use `ratCHRLOCENTREZID2CHR`.

```R
# Convert to list for easier inspection
chr_map <- as.list(ratCHRLOCENTREZID2CHR)

# Get chromosome for a specific Entrez ID
chr_map[["12345"]] 
```

### Finding Transcription Start and End Positions
Coordinates are organized by chromosome (1-20 and X) and by start/end points. 

**Naming Convention:** `ratCHRLOC[Chromosome][START|END]`
Examples: `ratCHRLOC1START`, `ratCHRLOC10END`, `ratCHRLOCXSTART`.

```R
# Get start positions for genes on Chromosome 10
start_pos <- as.list(ratCHRLOC10START)

# Get end positions for genes on Chromosome 10
end_pos <- as.list(ratCHRLOC10END)

# Access a specific gene's start position
# Returns a named vector (e.g., "Confident" or "Unconfident")
start_pos[["24144"]]
```

### Interpreting Coordinate Values
*   **Positive Values:** Gene is on the sense strand. Measured in base pairs from the p-arm (5' end) to the q-arm (3' end).
*   **Negative Values:** Gene is on the antisense strand. Indicated by a leading "-" sign (e.g., -1234567).
*   **Names:** Values are named "Confident" if the gene is confidently placed, or "Unconfident" if it is placed on a "random" UCSC sub-structure.

### Cytoband Locations
To map chromosome numbers to cytoband identifiers and their base pair ranges:

```R
bands <- as.list(ratCHRLOCCYTOLOC)

# Get all cytobands on Chromosome 1
names(bands[["1"]])

# Get start/end base pairs for the first band on Chromosome 1
bands[["1"]][[1]]
```

## Package Metadata and QC
You can view build dates and probe mapping statistics using the quality control object.

```R
# Display QC information
ratCHRLOC()

# Access specific QC counts
as.list(ratCHRLOCQC)
```

## Tips
*   **Package Dependencies:** Many examples require the `annotate` package to be loaded.
*   **Memory Efficiency:** If you only need a few IDs, use `get("ID", ratCHRLOC1START)` instead of converting the entire environment to a list with `as.list()`.
*   **Data Source:** These mappings are based on older UCSC builds (e.g., hg16 equivalent for rat). Always verify the "Date built" using `ratCHRLOC()` if working with the latest genome assemblies.

## Reference documentation

- [ratCHRLOC Reference Manual](./references/reference_manual.md)