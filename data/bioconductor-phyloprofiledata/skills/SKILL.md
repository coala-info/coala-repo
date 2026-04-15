---
name: bioconductor-phyloprofiledata
description: This package provides curated phylogenetic profiling datasets including orthology information, protein sequences, and functional domain architectures via ExperimentHub. Use when user asks to retrieve example data for phylogenetic profiling, access AMPK-TOR or BUSCO Arthropoda datasets, or test workflows for the PhyloProfile R package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/PhyloProfileData.html
---

# bioconductor-phyloprofiledata

## Overview

The `PhyloProfileData` package is an ExperimentHub-based data package providing curated datasets for illustrating and testing phylogenetic profiling workflows. It specifically supports the `PhyloProfile` R package by providing multi-layered data including orthology information, protein sequences, and functional domain architectures.

The package contains two primary datasets:
1.  **AMPK-TOR Pathway**: 147 human proteins across 83 species.
2.  **BUSCO Arthropoda**: 1011 ortholog groups across 88 species.

## Data Retrieval Workflow

All data is hosted on `ExperimentHub`. To use these datasets, you must first initialize an ExperimentHub object and query for the package records.

```r
library(ExperimentHub)
library(PhyloProfileData)

# Initialize Hub and query records
eh <- ExperimentHub()
myData <- query(eh, "PhyloProfileData")

# View available records
myData
```

### Dataset Record IDs

| Dataset Component | AMPK-TOR ID | BUSCO Arthropoda ID |
|-------------------|-------------|---------------------|
| Phylogenetic Profile | EH2544 | EH2547 |
| FASTA Sequences | EH2545 | EH2548 |
| Domain Annotations | EH2546 | EH2549 |

## Working with Phylogenetic Profiles

The profile data frames contain orthology relationships and Feature Architecture Similarity (FAS) scores.

```r
# Load AMPK-TOR profile
ampkTorPhyloProfile <- myData[["EH2544"]]

# Structure:
# geneID: Query protein ID
# ncbiID: Taxonomy ID of the search species
# orthoID: Orthologous protein ID in the target species
# FAS_F / FAS_B: Forward and Backward FAS scores (0 to 1)
head(ampkTorPhyloProfile)
```

## Working with Sequences and Domains

Sequences are provided as `AAStringSet` objects, and domains are provided as data frames compatible with `PhyloProfile` visualization.

```r
# Load Sequences (AAStringSet)
ampkTorFasta <- myData[["EH2545"]]

# Load Domain Annotations
# Contains: feature name, start/end positions, and database source (PFAM, SMART, etc.)
ampkTorDomain <- myData[["EH2546"]]
```

## Usage Tips

- **FAS Scores**: A score of 1 indicates identical domain architectures between the query and the ortholog; 0 indicates completely different architectures.
- **Integration**: These datasets are designed to be passed directly into `PhyloProfile` functions for visualization and evolutionary analysis.
- **Taxonomy**: The `ncbiID` column uses the "ncbi" prefix (e.g., `ncbi284812`). Ensure your taxonomy processing logic accounts for this prefix if merging with other NCBI-based datasets.

## Reference documentation

- [Overview of PhyloProfileData](./references/PhyloProfileData.md)
- [PhyloProfileData Vignette Source](./references/PhyloProfileData.Rmd)