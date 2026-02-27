---
name: bioconductor-pathprintgeodata
description: This package provides a repository of pathway fingerprints derived from the Gene Expression Omnibus for cross-platform and cross-species functional analysis. Use when user asks to load pre-calculated pathway expression matrices, compare biological states across GEO samples, or identify similar phenotypes using consensus fingerprints.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/pathprintGEOData.html
---


# bioconductor-pathprintgeodata

## Overview

The `pathprintGEOData` package is a data-only experiment package that supports the `pathprint` functional analysis framework. It provides a massive repository of "pathway fingerprints"—ternary representations of pathway expression (high, low, or insignificant) derived from the Gene Expression Omnibus (GEO). This allows for rapid cross-platform and cross-species comparison of biological states without the need for raw data reprocessing.

## Core Data Structures

The package primarily provides data via the `data()` function. The most critical object is a `SummarizedExperiment` containing the global fingerprint matrix.

- **geo_sum_data**: A `SummarizedExperiment` object containing:
    - `assays(geo_sum_data)$fingerprint`: The ternary matrix (-1, 0, 1).
    - `colData(geo_sum_data)`: Metadata for the GEO samples (GSM, GPL, GSE, Species).
- **chipframe**: A list of supported platforms (e.g., GPL570, GPL1261).
- **genesets**: The pathway definitions used to generate the fingerprints.
- **pluripotents.frame**: A reference set of GSM IDs for pluripotent stem cells used in validation and examples.

## Typical Workflow

### 1. Loading Data
To use this data, you must load both the data package and the `pathprint` engine, along with `SummarizedExperiment` for data extraction.

```r
library(pathprint)
library(pathprintGEOData)
library(SummarizedExperiment)

# Load the primary SummarizedExperiment object
data(SummarizedExperimentGEO)

# Load auxiliary metadata and reference frames
data(chipframe)
data(pluripotents.frame)
```

### 2. Extracting Matrices
The fingerprints and metadata are stored within the `geo_sum_data` object.

```r
# Extract the fingerprint matrix (Rows = Pathways, Cols = GSM IDs)
GEO.fingerprint.matrix <- assays(geo_sum_data)$fingerprint

# Extract metadata
GEO.metadata.matrix <- colData(geo_sum_data)
```

### 3. Comparative Analysis
A common use case is comparing a specific set of samples (e.g., pluripotency) against the entire GEO background.

```r
# 1. Create a consensus fingerprint for a specific phenotype
pluripotent.consensus <- consensusFingerprint(
    GEO.fingerprint.matrix[, pluripotents.frame$GSM],
    threshold = 0.9
)

# 2. Calculate distance between the consensus and all GEO samples
geo.distances <- consensusDistance(pluripotent.consensus, GEO.fingerprint.matrix)

# 3. Identify top matches in GEO (lowest distance)
top_matches <- head(sort(geo.distances[, "distance"]), 100)
```

### 4. Filtering by Platform or Species
Use the metadata matrix to subset the global fingerprint matrix for specific analyses.

```r
# Find all Human samples on the GPL570 platform
human_gpl570_ids <- rownames(GEO.metadata.matrix[
    GEO.metadata.matrix$Species == "Homo sapiens" & 
    GEO.metadata.matrix$GPL == "GPL570", 
])

# Subset the fingerprint matrix
human_matrix <- GEO.fingerprint.matrix[, human_gpl570_ids]
```

## Tips for Success

- **Memory Management**: The `GEO.fingerprint.matrix` is very large. Ensure the R environment has sufficient RAM or subset the `SummarizedExperiment` before extracting the full matrix if only specific platforms are needed.
- **Ternary Logic**: Remember that values are -1 (under-expressed), 0 (baseline), and 1 (over-expressed). Distances are calculated based on the Manhattan distance between these vectors.
- **Species Mapping**: While pathways are compiled from Human sources (Reactome, KEGG, WikiPathways), other species (M. musculus, R. norvegicus, D. rerio, D. melanogaster, C. elegans) are included via orthology mapping.

## Reference documentation

- [Using pathprintGEOData with pathprint package](./references/usingPathprintGEOData.md)