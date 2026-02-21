---
name: bioconductor-imman
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/IMMAN.html
---

# bioconductor-imman

## Overview

The `IMMAN` package (Interolog Protein Network Mapping and Analysis) is designed to reconstruct a consensus protein interaction network shared across different species. It uses a sequence-based orthology detection method (all-versus-all pairwise alignment) combined with interaction data from the STRING database. The resulting Interolog Protein Network (IPN) consists of nodes representing Orthologous Protein Sets (OPSs) and edges representing conserved interactions.

## Core Workflow

### 1. Data Preparation
Prepare protein lists (character vectors of identifiers) for each species and identify their corresponding NCBI Taxonomy IDs.

```r
library(IMMAN)

# Example using built-in datasets
data(FruitFly)
data(Celegance)

# Create a list of protein vectors
ProteinLists <- list(as.character(FruitFly$V1)[1:10], 
                     as.character(Celegance$V1)[1:10])

# Define Taxonomy IDs (e.g., 7227 for Drosophila, 6239 for C. elegans)
Species_IDs <- c(7227, 6239)
```

### 2. Running the IPN Reconstruction
The main function `IMMAN()` performs sequence downloading, alignment, STRING database querying, and network assembly.

```r
output <- IMMAN(
  ProteinLists = ProteinLists,
  Species_IDs = Species_IDs,
  identityU = 30,              # Alignment identity threshold (0-100)
  substitutionMatrix = "BLOSUM62",
  gapOpening = -8,
  gapExtension = -8,
  BestHit = TRUE,              # Use best reciprocal hit strategy
  coverage = 1,                # Min species sharing the interaction (1 to N)
  NetworkShrinkage = FALSE,    # Merge similar OPSs if TRUE
  score_threshold = 400,       # STRING interaction confidence score
  STRINGversion = "11",        # STRING database version
  InputDirectory = getwd()
)
```

### 3. Interpreting Results
The output is a list containing the reconstructed network and mapping details:

*   `output$IPNEdges`: The edges of the final Interolog Protein Network (OPS to OPS).
*   `output$IPNNodes`: Mapping of specific protein IDs from each species to their assigned OPS label.
*   `output$Networks`: A list of species-specific networks retrieved from STRING.
*   `output$maps`: Mapping between UniProt Accessions and STRING identifiers.

## Key Parameters and Tips

*   **identityU**: Increasing this value (e.g., to 40 or 50) results in stricter orthology assignments and a smaller, more conserved network.
*   **coverage**: This is the most critical parameter for robustness. Setting `coverage` to the total number of species ensures that only interactions present in *every* input species are included in the final IPN.
*   **score_threshold**: Refers to the STRING combined score. 400 is medium confidence; 700+ is high confidence.
*   **NetworkShrinkage**: Set to `TRUE` if you want to collapse the network by merging OPSs that share common proteins, which simplifies the topology.

## Reference documentation

- [IMMAN](./references/IMMAN.md)