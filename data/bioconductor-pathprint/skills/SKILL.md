---
name: bioconductor-pathprint
description: The bioconductor-pathprint package converts gene expression data into ternary fingerprints to enable global functional comparisons across different platforms and species. Use when user asks to convert expression matrices to pathway fingerprints, calculate consensus fingerprints for sample groups, or compare expression profiles against the GEO database using functional distance.
homepage: https://bioconductor.org/packages/3.6/bioc/html/pathprint.html
---


# bioconductor-pathprint

## Overview

The `pathprint` package provides a robust framework for global comparison of gene expression data by integrating pathway curation with a probability of expression (POE) distribution derived from the Gene Expression Omnibus (GEO). It converts complex expression matrices into "fingerprints"—ternary vectors where:
*   **+1**: Significantly high expression (overexpressed).
*   **0**: Expression similar to the majority of arrays on that platform.
*   **-1**: Significantly low expression (underexpressed).

## Typical Workflow

### 1. Data Preparation
The package requires a gene expression matrix (probe/feature IDs as rows, sample IDs as columns), the GEO platform ID (e.g., "GPL6244"), and the species name.

```r
library(pathprint)
library(SummarizedExperiment)
library(pathprintGEOData)

# Example using GEOquery to get data
# exprs_matrix <- exprs(gse_object[[1]])
# platform <- annotation(gse_object[[1]])
# species <- "human"
```

### 2. Generating Fingerprints
Use `exprs2fingerprint` to process new expression data. This requires loading several data objects from the `pathprint` and `pathprintGEOData` packages.

```r
# Load required reference data
data(compressed_result)
ds <- c("chipframe", "genesets", "pathprint.Hs.gs", "platform.thresholds", "pluripotents.frame")
data(list = ds)

# Generate the fingerprint
my_fingerprint <- exprs2fingerprint(
    exprs = exprs_matrix,
    platform = platform,
    species = species,
    progressBar = FALSE
)
```

### 3. Comparative Analysis
You can compare your results against the pre-calculated GEO fingerprint matrix (contained in `compressed_result`).

```r
# Extract GEO reference data
GEO.fingerprint.matrix <- assays(result)$fingerprint
GEO.metadata.matrix <- colData(result)

# Calculate consensus fingerprint for a group of samples
consensus <- consensusFingerprint(my_fingerprint, threshold = 0.9)

# Calculate functional distance between a consensus and other samples
distances <- consensusDistance(consensus, GEO.fingerprint.matrix)
```

### 4. Visualization
Fingerprints are best visualized using heatmaps to show functional changes across samples.

```r
# Heatmap of pathways with variation (sd > 0)
heatmap(my_fingerprint[apply(my_fingerprint, 1, sd) > 0, ],
        col = c("blue", "white", "red"),
        mar = c(10, 10),
        main = "Pathway Fingerprint Heatmap")
```

## Key Functions

*   `exprs2fingerprint()`: The primary function to convert expression data to ternary scores.
*   `consensusFingerprint()`: Creates a single representative fingerprint from a group of samples based on a threshold of consistency.
*   `consensusDistance()`: Calculates the Manhattan distance between a consensus fingerprint and a matrix of fingerprints, scaled by the number of pathways.
*   `pathprintGEOData`: A companion data package containing the pre-computed GEO fingerprint database.

## Tips for Success

*   **Platform Support**: Ensure the platform ID matches the GEO "GPL" format. The package uses `chipframe` to map probes to genes.
*   **Species**: Supports 'human' (Homo sapiens), 'mouse' (Mus musculus), and 'rat' (Rattus norvegicus).
*   **Memory**: The `GEO.fingerprint.matrix` is large. Use the `pathprintGEOData` objects carefully if working in memory-constrained environments.
*   **Interpretation**: A score of 0 is the "background" state for that specific platform in GEO; it does not necessarily mean the pathway is "off," but rather that its expression is at the median level for that technology.

## Reference documentation

- [Pathway Fingerprinting: a working example](./references/exampleFingerprint.md)