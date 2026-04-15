---
name: bioconductor-assessorfdata
description: This package provides mapping and results objects for the AssessORF package, including genome sequences and gene prediction data for 20 bacterial strains. Use when user asks to retrieve proteomics and conservation mappings, access gene prediction results from sources like Prodigal or GenBank, or export strain genomes in FASTA format.
homepage: https://bioconductor.org/packages/release/data/experiment/html/AssessORFData.html
---

# bioconductor-assessorfdata

name: bioconductor-assessorfdata
description: Access mapping and results objects for the AssessORF package, including genome sequences for 20 bacterial strains. Use this skill to retrieve pre-computed proteomics and evolutionary conservation mappings, gene prediction results from various sources (Prodigal, GeneMarkS2, GenBank, Glimmer), and to export strain genomes in FASTA format for further analysis.

## Overview
AssessORFData is a data experiment package that supports the AssessORF package. It provides standardized datasets for 20 specific bacterial strains. Each strain includes a "mapping object" (proteomics and conservation evidence mapped to the genome) and four "results objects" (evidence scores for gene sets predicted by different algorithms).

## Core Functions

### Identifying Available Data
Use these functions to see which strains and gene prediction sources are available in the package.
```r
library(AssessORFData)

# List all 20 available strain IDs
strains <- GetStrainIDs()

# List the 4 available gene prediction sources
sources <- GetGeneSources()
# Returns: "Prodigal", "GeneMarkS2", "GenBank", "Glimmer"
```

### Retrieving Mapping and Results Objects
While `data()` can be used, the package provides helper functions to easily assign objects to specific variables.

```r
# Get the mapping object for a specific strain
# Mapping objects contain proteomics and conservation evidence
mapObj <- GetDataMapObj("MGAS5005")

# Get a results object for a specific strain and gene source
# Results objects contain evidence scores for predicted genes
resObj <- GetResultsObj("MGAS5005", "Prodigal")
```

### Exporting Genome Sequences
To run external tools or custom analyses on the underlying genomic data, export the strain's genome to a FASTA file.

```r
# Save a strain's genome to a local FASTA file
SaveGenomeToPath("MGAS5005", "path/to/output.fasta")
```

## Typical Workflow
1. **Identify Strain**: Choose a strain ID from `GetStrainIDs()`.
2. **Load Evidence**: Retrieve the mapping object using `GetDataMapObj()`.
3. **Load Predictions**: Retrieve results objects for one or more sources (e.g., "GenBank" vs "Prodigal") using `GetResultsObj()`.
4. **Analyze**: Use the retrieved objects as input for `AssessORF` package functions to evaluate the quality of gene predictions.

## Data Structure Notes
- **Mapping Object**: Stores the raw mapping of evidence (proteomics/conservation) to the genome coordinates.
- **Results Object**: Stores the calculated support/conflict levels for each gene in a specific predicted gene set.
- **Strain IDs**: Common IDs include "H37Rv", "PAO1", "K_12_MG1655", and "MGAS5005".

## Reference documentation
- [Quick Guide to AssessORFData](./references/AssessORFDataGuide.md)