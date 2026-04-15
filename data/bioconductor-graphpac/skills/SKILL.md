---
name: bioconductor-graphpac
description: This tool identifies clusters of mutated amino acids in protein tertiary structures by reordering 3D coordinates into a 1D space using graph theory and the Traveling Salesman Problem. Use when user asks to find non-random mutational clusters in 3D protein structures, map protein coordinates to a 1D sequence using graph-based reordering, or identify statistically significant mutation clusters in multi-domain proteins.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GraphPAC.html
---

# bioconductor-graphpac

name: bioconductor-graphpac
description: Identify clusters of mutated amino acids in protein tertiary structures using graph theory and the Traveling Salesman Problem (TSP). Use this skill when analyzing somatic mutation data to find non-random clusters that are close in 3D space but may be distant in 1D sequence.

# bioconductor-graphpac

## Overview

GraphPAC (Graph Theoretical Identification of Mutated Amino Acid Clusters in Proteins) is an R package designed to identify mutational clusters by mapping a protein's 3D structure onto a 1D space. It achieves this by solving the Traveling Salesman Problem (TSP) to find the shortest path between amino acids in 3D space. Once reordered, the Nonrandom Mutation Clustering (NMC) algorithm is applied to identify statistically significant clusters.

This package is a companion to `iPAC` but uses graph theory instead of MultiDimensional Scaling (MDS), making it particularly effective for proteins with multiple domains connected by flexible linkers.

## Core Workflow

### 1. Data Preparation
To use GraphPAC, you require three components:
- **Positional Data**: 3D coordinates (X, Y, Z) for each amino acid (usually from PDB/CIF files).
- **Mutational Data**: A matrix where rows are samples and columns are amino acid positions (1 if mutated, 0 otherwise).
- **Canonical Sequence**: The protein sequence (usually from UniProt/Fasta).

```R
library(GraphPAC)

# 1. Get Positions (using iPAC helper functions)
# CIF <- "path/to/file.cif"
# Fasta <- "path/to/fasta.fasta"
# KRAS.Positions <- get.Positions(CIF, Fasta, "A")

# 2. Load Mutation Data
data(KRAS.Mutations) 
# Ensure column names are V1, V2, ..., Vm
```

### 2. Identifying Clusters
The primary function is `GraphClust`. It reorders the protein and identifies clusters in one step.

```R
# Run clustering using a TSP insertion method
# Options: "nearest_insertion", "farthest_insertion", "cheapest_insertion", "arbitrary_insertion"
my.clusters <- GraphClust(
  mutations = KRAS.Mutations,
  position.matrix = KRAS.Positions$Positions,
  insertion.type = "cheapest_insertion",
  alpha = 0.05,
  MultComp = "Bonferroni"
)
```

### 3. Interpreting Results
The output object contains several key elements:
- `Remapped`: Clusters found after graph-based reordering.
- `OriginalCulled`: Clusters found linearly, excluding amino acids missing 3D data.
- `Original`: Clusters found by the original NMC algorithm (sequence only).
- `candidate.path`: The specific order of amino acids determined by the TSP solver.
- `path.distance`: Total distance (Angstroms) of the reordered path.

## Visualization

### Jump Plots (Linear)
Visualizes the reordering of the protein. Colors represent the position in the remapped sequence.
```R
Plot.Protein.Linear(
  my.clusters$candidate.path, 
  v.per.row = 25, 
  color.palette = "heat", 
  title = "Protein Reordering"
)
```

### Interactive Circle Plots
Uses `igraph` and `tkplot` to show how the TSP path connects amino acids in a circular layout.
```R
Plot.Protein(
  my.clusters$protein.graph, 
  my.clusters$candidate.path, 
  vertex.size = 5, 
  color.palette = "heat"
)
```

## Comparison with iPAC
To compare the reordering efficiency between GraphPAC (TSP) and iPAC (MDS), use Kendall's Tau via the `RMallow` package:
```R
library(RMallow)
graph.path <- my.clusters$candidate.path
mds.path <- get.Remapped.Order(KRAS.Mutations, KRAS.Positions$Positions)
path.matrix <- rbind(original = sort(graph.path), graph = graph.path, mds = mds.path)
AllSeqDists(path.matrix)
```

## Tips
- **Missing Data**: Amino acids without 3D coordinates are automatically removed from the `Remapped` and `OriginalCulled` analyses. Check `my.clusters$missing.positions` to see which were excluded.
- **Insertion Methods**: "cheapest_insertion" is often a good balance between speed and path quality, but results may vary depending on protein complexity.
- **Column Naming**: Ensure your mutation matrix columns follow the `V1, V2...Vm` convention required by the underlying NMC algorithm.

## Reference documentation
- [GraphPAC: Graph Theoretical Identification of Mutated Amino Acid Clusters in Proteins](./references/GraphPAC.md)