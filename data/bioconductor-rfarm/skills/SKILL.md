---
name: bioconductor-rfarm
description: The bioconductor-rfarm tool provides an R interface to query the Rfam database for non-coding RNA family data and metadata. Use when user asks to search for RNA families by keyword or sequence, retrieve consensus secondary structures, download covariance models, or access phylogenetic trees and PDB mappings.
homepage: https://bioconductor.org/packages/release/bioc/html/rfaRm.html
---

# bioconductor-rfarm

name: bioconductor-rfarm
description: Access and query the Rfam database for non-coding RNA (ncRNA) families. Use this skill to search for RNA families by keyword or sequence, retrieve consensus secondary structures, seed alignments, covariance models, phylogenetic trees, and PDB structural mappings.

# bioconductor-rfarm

## Overview

The `rfaRm` package provides an R client-side interface to the Rfam database, a collection of non-coding RNA families defined by multiple sequence alignments, consensus secondary structures, and covariance models. This skill enables workflows for identifying RNA elements (like riboswitches or cis-regulatory elements) and retrieving their associated bioinformatic data for downstream analysis.

## Identification and Search

### Keyword Search
Find Rfam accessions (format `RFXXXXX`) using keywords.
```r
library(rfaRm)
accessions <- rfamTextSearchFamilyAccession("riboswitch")
```

### Sequence Search
Search a query RNA sequence against Rfam covariance models. Note: This can be slow for long sequences.
```r
# Sequence must contain A, U, G, C
hits <- rfamSequenceSearch("GGAUCUUCGGGGCAGGGUGAAAUUCCCGACCGGUGGUAUAGUCCACGAAAGUAUUUGCUUUGAUUUGGUGAAAUUCCAAAACCGACAGUAGAGUCUGGAUGAGAGAAGAUUC")
# Access specific hit data
hits$FMN$alignmentSecondaryStructure
```

### Identifier Conversion
Convert between Rfam Accessions (RFXXXXX) and IDs (e.g., "Cobalamin").
```r
id <- rfamFamilyAccessionToID("RF00174")
acc <- rfamFamilyIDToAccession("FMN")
```

## Data Retrieval

### Family Summary
Get functional descriptions and metadata.
```r
summary <- rfamFamilySummary("RF00174")
summary$description
summary$comment
```

### Secondary Structure
Retrieve consensus sequences and structures in WUSS or Dot-Bracket (DB) format.
```r
# Returns a character vector: [1] sequence, [2] structure
ss <- rfamConsensusSecondaryStructure("RF00174", format = "DB")

# Save to file for use with R4RNA or other tools
rfamConsensusSecondaryStructure("RF00174", filename = "structure.txt", format = "DB")
```

### Alignments and Models
Retrieve the curated seed alignment or the Infernal covariance model.
```r
# Returns a Biostrings MultipleAlignment object
seed <- rfamSeedAlignment("RF00174", format = "stockholm")

# Save covariance model to file
rfamCovarianceModel("RF00050", filename = "model.cm")
```

### Sequence Regions and PDB Mappings
List all genomic regions belonging to a family or associated 3D structures.
```r
# Get genomic coordinates
regions <- rfamSequenceRegions("RF00050")

# Get PDB entries
pdb_map <- rfamPDBMapping("RF00050")
```

## Visualization

### Secondary Structure Plots
Generate plots directly in R or save as SVG/PNG.
```r
# Plot to graphics device
rfamSecondaryStructurePlot("RF00174", plotType = "norm")

# Save SVG with sequence conservation
rfamSecondaryStructureXMLSVG("RF00174", filename = "cons.svg", plotType = "cons")
```

### Phylogenetic Trees
Retrieve or plot the tree associated with the seed alignment.
```r
# Get NHX format string
tree_str <- rfamSeedTree("RF00050")

# Save tree image
rfamSeedTreeImage("RF00164", filename = "tree.png", label = "species")
```

## Workflow Tips
- **Interoperability**: Use `rfamSeedAlignment` results with the `Biostrings` package and `rfamSeedTree` results with `treeio`.
- **File Formats**: Many functions support a `filename` argument to export data directly to standard formats (Stockholm, FASTA, NHX, CM).
- **Large Families**: `rfamSequenceRegions` may fail for families with an extremely high number of members due to server-side limits.

## Reference documentation
- [rfaRm](./references/rfaRm.md)