---
name: bioconductor-clstutils
description: This tool performs taxonomic classification and reference set creation using phylogenetic placements. Use when user asks to perform taxonomic classification of sequences placed on a tree, identify taxonomic outliers, or select diverse sequence subsets for reference packages.
homepage: https://bioconductor.org/packages/release/bioc/html/clstutils.html
---


# bioconductor-clstutils

name: bioconductor-clstutils
description: Taxonomic classification and reference set creation using phylogenetic placements. Use this skill when performing taxonomic assignment of sequences placed on a tree (via pplacer), identifying outlier sequences in taxonomic groups, or selecting diverse subsets of sequences for reference packages.

# bioconductor-clstutils

## Overview

The `clstutils` package provides tools for processing phylogenetic placements (specifically from `pplacer`) to perform taxonomic classification. It also includes utilities for "cleaning" reference datasets by identifying outliers (potentially mislabeled sequences) and selecting a representative, diverse subset of sequences to build efficient reference packages.

## Core Workflows

### 1. Taxonomic Classification of Placements

This workflow assigns a taxonomic identity to a query sequence that has been placed onto a reference tree using `pplacer`.

```r
library(clstutils)

# 1. Prepare distance matrices from pplacer output
# Requires a .json (placefile) and a .distmat (distfile) from placeutil
treedists <- treeDists(distfile="merged.distmat.bz2", placefile="merged.json")

# 2. Load taxonomy from a reference package (.refpkg)
# lowest_rank defines the specificity of the classification
taxdata <- taxonomyFromRefpkg("my_sequences.refpkg", 
                             seqnames=rownames(treedists$dmat), 
                             lowest_rank='species')

# 3. Define the placement of the query sequence
# 'at' is the edge index, 'edge' and 'branch' are distances
placetab <- data.frame(at=49, edge=5.149e-07, branch=5.149e-07)

# 4. Perform classification
classification <- classifyPlacements(taxdata, treedists, placetab)
```

### 2. Identifying Taxonomic Outliers

Use this to find sequences that are likely mislabeled or poor quality within a specific taxon.

```r
# Calculate a distance matrix (e.g., using ape)
library(ape)
dmat <- dist.dna(my_dna_bin, model='raw', as.matrix=TRUE)

# Find outliers based on a distance cutoff (e.g., 1.5% difference)
# or a quantile of all pairwise distances
outliers <- findOutliers(dmat, cutoff=0.015)

# Visualize outliers on a tree
prettyTree(nj(dmat), groups=ifelse(outliers, 'outlier', 'non-outlier'))
```

### 3. Selecting a Diverse Reference Subset

When building a reference package, you often need a representative subset of sequences rather than every available sequence.

```r
# Select N diverse sequences
# idx: indices of sequences that MUST be included (e.g., type strains)
# exclude: logical vector of outliers to ignore
selected_indices <- maxDists(dmat, 
                             idx=which(seqdat$isType), 
                             N=10, 
                             exclude=outliers, 
                             include.center=TRUE)

# The result is a vector of indices for the selected sequences
diverse_set <- my_dna_bin[selected_indices, ]
```

## Key Functions

- `treeDists()`: Converts phylogenetic tree distances into matrix representations for classification.
- `taxonomyFromRefpkg()`: Extracts and formats taxonomic metadata from a BiOpal/pplacer reference package.
- `classifyPlacements()`: The primary wrapper for assigning taxonomy to new placements.
- `findOutliers()`: Identifies sequences that are significantly distant from the "central" sequence of a group.
- `maxDists()`: Implements a greedy algorithm to select a subset of sequences that maximizes phylogenetic diversity.
- `prettyTree()`: An extension of `ape::plot.phylo` for easier annotation of outliers and selected subsets.

## Reference documentation

- [Taxonomic classification using pplacer, clst, and clstutils](./references/pplacerDemo.md)
- [Reference set creation using clstutils](./references/refSet.md)