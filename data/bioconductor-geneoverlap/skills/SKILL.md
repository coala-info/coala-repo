---
name: bioconductor-geneoverlap
description: The GeneOverlap package tests the statistical significance of the overlap between gene lists using Fisher's exact test. Use when user asks to test for gene set enrichment, calculate the significance of shared genes between two lists, or generate a heatmap of overlaps between multiple gene sets.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneOverlap.html
---

# bioconductor-geneoverlap

## Overview
The `GeneOverlap` package provides a framework for testing the statistical significance of the overlap between gene lists. It uses Fisher's exact test (based on a hypergeometric distribution) to determine if the number of shared genes is greater than what would be expected by chance, given a specific genomic background (genome size). It supports both individual pair comparisons and matrix-based comparisons for multiple gene sets.

## Core Workflow

### 1. Data Preparation
Input data should be character vectors of gene symbols or IDs.
```R
library(GeneOverlap)
# Example vectors
listA <- c("GENE1", "GENE2", "GENE3")
listB <- c("GENE2", "GENE3", "GENE4")
# Genome size is the total number of genes in the background (e.g., 20000)
gs <- 20000
```

### 2. Testing a Single Pair
Use the `GeneOverlap` class for comparing two specific lists.
```R
# Create object
go.obj <- newGeneOverlap(listA, listB, genome.size=gs)

# Run Fisher's exact test
go.obj <- testGeneOverlap(go.obj)

# View results
print(go.obj)
getPval(go.obj)
getOddsRatio(go.obj)
getJaccard(go.obj)
getIntersection(go.obj)
```

### 3. Testing Multiple Lists (Matrix)
Use the `GeneOverlapMatrix` (GOM) class to compare two collections of gene lists (named lists of vectors).
```R
# Create GOM object
# set1 and set2 are named lists of character vectors
gom.obj <- newGOM(set1, set2, genome.size=gs)

# Self-comparison (within one set)
gom.self <- newGOM(set1, genome.size=gs)

# Visualize
drawHeatmap(gom.obj)
```

## Key Functions and Accessors

### Object Creation
- `newGeneOverlap(listA, listB, genome.size)`: Constructor for single pair comparison.
- `newGOM(gset1, gset2, genome.size)`: Constructor for matrix comparison. If `gset2` is omitted, it performs a self-comparison of `gset1`.

### Statistical Testing
- `testGeneOverlap(obj)`: Performs the actual Fisher's exact test. Required before results can be extracted.

### Data Extraction
- `getMatrix(gom.obj, name)`: Extracts a matrix of values from a GOM object. `name` can be "pval", "odds.ratio", "jaccard", or "intersection".
- `getNestedList(gom.obj, name)`: Extracts results as a nested list structure.
- `gom.obj[i, j]`: Accesses the individual `GeneOverlap` object at a specific matrix position.

### Visualization
- `drawHeatmap(gom.obj, what=c("odds.ratio", "Jaccard"), ...)`: Generates a heatmap. 
    - `what`: Determines the color scale (default is odds ratio).
    - `ncolused`: Number of colors in the scale.
    - `grid.col`: Color palette (e.g., "Blues", "Reds").
    - `note.col`: Color of the text labels in the heatmap.

## Tips and Best Practices
- **Genome Size**: The choice of `genome.size` significantly impacts the p-value. It should represent the "universe" of genes that could have potentially appeared in your lists (e.g., all protein-coding genes or all genes expressed in the tissue).
- **Odds Ratio**: An odds ratio > 1 indicates a positive association (enrichment), while < 1 indicates a negative association (depletion).
- **Jaccard Index**: Useful for measuring similarity independent of the genome size, ranging from 0 (no overlap) to 1 (identical lists).
- **Named Lists**: When using `newGOM`, ensure your input lists are named, as these names are used for heatmap labeling.

## Reference documentation
- [GeneOverlap](./references/GeneOverlap.md)