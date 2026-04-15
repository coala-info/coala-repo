---
name: bioconductor-interactionset
description: The bioconductor-interactionset package provides a framework for representing and manipulating genomic interaction data like Hi-C and ChIA-PET within the Bioconductor ecosystem. Use when user asks to create GInteractions or InteractionSet objects, perform 2D overlaps, calculate genomic distances between anchors, link promoters to enhancers, or convert between interaction formats.
homepage: https://bioconductor.org/packages/release/bioc/html/InteractionSet.html
---

# bioconductor-interactionset

name: bioconductor-interactionset
description: Specialized knowledge for the InteractionSet R package to represent and manipulate genomic interaction data (Hi-C, ChIA-PET). Use when the user needs to create GInteractions, InteractionSet, or ContactMatrix objects, perform 2D overlaps, calculate genomic distances between anchors, or convert between interaction formats.

# bioconductor-interactionset

## Overview
The `InteractionSet` package provides a robust framework for handling pairwise genomic interactions. It extends the Bioconductor `SummarizedExperiment` paradigm to 2D space, allowing users to store experimental data (like contact counts) alongside the genomic coordinates of the interacting partners (anchors).

## Core Classes
- **GInteractions**: Represents pairwise interactions between genomic regions. It uses a centralized `GRanges` object (`regions`) and integer indices to save memory.
- **InteractionSet**: An extension of `SummarizedExperiment` where each row is a `GInteractions` entry and each column is a sample.
- **ContactMatrix**: Represents interaction data in a matrix format where rows and columns correspond to genomic regions.
- **StrictGInteractions**: A subclass of `GInteractions` that automatically enforces anchor ordering (anchor1 >= anchor2) to simplify comparisons.

## Key Workflows

### 1. Creating GInteractions
```r
library(InteractionSet)
# Define all possible regions
all.regions <- GRanges("chr1", IRanges(seq(1, 100, 10), width=10))

# Create interactions using indices of all.regions
gi <- GInteractions(c(1, 2), c(3, 4), all.regions)

# Access anchors
anchors(gi, type="first")
anchors(gi, id=TRUE) # Returns indices
```

### 2. Working with InteractionSet
```r
# counts is a matrix where rows = length(gi)
iset <- InteractionSet(list(counts=counts), gi)

# Access underlying interactions
interactions(iset)

# Access data
assay(iset, "counts")
```

### 3. Genomic Distances and Properties
- `pairdist(gi)`: Calculates linear distance between anchor midpoints. Returns `NA` for inter-chromosomal interactions.
- `intrachr(gi)`: Returns a logical vector indicating if interactions are on the same chromosome.
- `swapAnchors(gi)`: Standardizes interactions so the first anchor index is always less than or equal to the second.

### 4. Overlaps and Linking
- **1D Overlap**: `findOverlaps(gi, granges_obj)` finds interactions where at least one anchor overlaps the subject.
- **2D Overlap**: `findOverlaps(gi, gi_subject)` finds interactions where both anchors overlap the corresponding anchors of the subject.
- **Linking**: `linkOverlaps(gi, regions1, regions2)` identifies interactions that connect a region in `regions1` (e.g., promoters) to a region in `regions2` (e.g., enhancers).

### 5. Conversions
- **Inflate**: `inflate(gi, rows, cols, fill=value)` converts a `GInteractions` object into a `ContactMatrix`.
- **Deflate**: `deflate(cm)` converts a `ContactMatrix` back into an `InteractionSet`.
- **Linearize**: `linearize(iset, region)` converts 2D interaction data into a 1D `RangedSummarizedExperiment` relative to a specific "bait" region (pseudo-4C).

## Tips
- **Memory Efficiency**: Always prefer using the `regions` and indices approach in `GInteractions` constructors when dealing with large Hi-C datasets.
- **Standardization**: Use `StrictGInteractions` or call `swapAnchors()` before performing `unique()`, `sort()`, or `match()` to ensure permutations of the same interaction are treated as identical.
- **Subsetting**: Subsetting an `InteractionSet` by row preserves the `regions` set but filters the interactions; subsetting by column filters the samples.

## Reference documentation
- [Classes for genomic interaction data](./references/interactions.md)