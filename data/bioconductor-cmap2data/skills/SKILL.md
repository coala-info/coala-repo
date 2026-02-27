---
name: bioconductor-cmap2data
description: This package provides a curated reference set of 1309 drug gene expression profiles from the Connectivity Map v2.0 for drug repurposing and network analysis. Use when user asks to load drug cluster assignments, access ranked expression profiles for DrugVsDisease analysis, or generate network data for Cytoscape visualization.
homepage: https://bioconductor.org/packages/release/data/experiment/html/cMap2data.html
---


# bioconductor-cmap2data

## Overview

The `cMap2data` package is a Bioconductor experiment data package providing a curated reference set of drug gene expression profiles derived from the Connectivity Map (CMap) v2.0. It contains 1309 ranked expression profiles based on the HGU-133A platform, converted to gene symbols. This data is primarily used as a reference set for the `DrugVsDisease` (DvD) package to identify negatively correlated (repurposing candidates) or positively correlated (potential side effects) profiles.

## Data Objects and Usage

The package contains no R code/functions; it consists entirely of data objects that are accessed using the `data()` command.

### Loading the Data

To use the reference sets, load the package and call the specific data objects:

```r
library(cMap2data)

# Load drug cluster assignments
data(drugClusters, package="cMap2data")

# Load Cytoscape network information (edges, distance, RPS)
data(cytodrug, package="cMap2data")

# Load compound names and search terms for external databases
data(druglabels, package="cMap2data")
```

### Key Data Structures

1.  **drugClusters**: Contains the assignments of the 1309 compounds into 103 clusters based on affinity propagation clustering. This is useful for identifying groups of drugs with similar transcriptional signatures.
2.  **cytodrug**: A data object containing network edges, distances, and the Running sum Peak Statistic (RPS).
    *   **RPS = 1**: Indicates a positive correlation (similar effect).
    *   **RPS = -1**: Indicates a negative correlation (opposite effect/potential repurposing).
    *   **Distance**: Measures the strength of the correlation.
3.  **druglabels**: Provides mapping between the internal nodes used in the reference set and search-compatible terms for external resources like DrugBank.

## Typical Workflow

1.  **Integration with DrugVsDisease**: Use these data objects as the `refList` or reference mapping when running `DrugVsDisease` pipelines.
2.  **Network Visualization**: Use `cytodrug` and `druglabels` to generate `.sif` and edge attribute files for Cytoscape to visualize drug-drug or drug-disease connections.
3.  **Drug Repurposing**: Compare a disease signature against the 1309 ranked profiles in this package to find drugs that "reverse" the disease expression pattern (high negative correlation).

## Reference documentation

- [Connectivity Map 2 data package](./references/cMap2data.md)