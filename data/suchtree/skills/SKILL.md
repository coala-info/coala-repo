---
name: suchtree
description: SuchTree is a Python library for performing fast, memory-efficient computations and distance calculations on large phylogenetic trees. Use when user asks to calculate distances between taxa, analyze co-evolutionary interactions between linked trees, or process massive phylogenies that require thread-safe performance.
homepage: https://github.com/ryneches/SuchTree/
metadata:
  docker_image: "quay.io/biocontainers/suchtree:1.3--py39hbcbf7aa_0"
---

# suchtree

## Overview
SuchTree is a specialized Python library designed for fast, thread-safe computations on phylogenetic trees. While standard tools like DendroPy or ETE3 offer high flexibility for tree manipulation, they often struggle with performance and memory overhead when handling trees with tens of thousands or millions of taxa. SuchTree solves this by using a compact, memory-efficient representation that fits within CPU caches and utilizes optimized code paths for data access. Use this skill to perform rapid distance calculations and analyze complex interactions between multiple evolutionary trees.

## Installation and Setup
SuchTree is available via PyPI and Bioconda. It requires `scipy`, `numpy`, `dendropy`, `cython`, and `pandas`.

```bash
# Installation via Conda (recommended for bioinformatics)
conda install -c bioconda -c conda-forge suchtree

# Installation via pip
pip install SuchTree
```

## Core Usage Patterns

### Initializing Trees
SuchTree can load trees from local files, URLs, or raw Newick strings.

```python
from SuchTree import SuchTree

# From a local Newick file
T = SuchTree('path/to/tree.nwk')

# From a URL
T = SuchTree('https://example.com/phylogeny.tree')

# From a Newick string
T = SuchTree('(A:0.1,B:0.2,(C:0.3,D:0.4):0.5);')
```

### Distance Calculations
The primary utility of SuchTree is the rapid retrieval of distances between taxa.

```python
# Get the distance between two specific taxa
dist = T.distance('Taxon_A', 'Taxon_B')

# Bulk distance calculations (highly optimized)
# distances_bulk accepts ArrayLike objects for high-throughput sampling
distances = T.distances_bulk(pairs_list)
```

### Working with Linked Trees
For studying co-evolution or interacting groups (e.g., hosts and parasites), use `SuchLinkedTrees`.

```python
from SuchTree import SuchTree, SuchLinkedTrees

# Initialize two trees and their links
tree_a = SuchTree('host.tree')
tree_b = SuchTree('parasite.tree')
links = {'host_1': ['parasite_1', 'parasite_2'], 'host_2': ['parasite_3']}

SLT = SuchLinkedTrees(tree_a, tree_b, links)

# Generate a weighted adjacency matrix for the graph
adj_matrix = SLT.adjacency_matrix()

# Export to other network analysis libraries
graph_igraph = SLT.to_igraph()
graph_nx = SLT.to_networkx()
```

## Expert Tips and Best Practices
- **Memory Management**: For trees exceeding 100,000 taxa, avoid converting the entire tree to a standard distance matrix, as this scales quadratically ($N^2$) and will likely exceed available RAM. Use SuchTree's native sampling methods instead.
- **Visualization**: SuchTree is optimized for computation, not plotting. For publication-quality figures, use `toytree` in conjunction with SuchTree.
- **Thread Safety**: SuchTree is designed to be thread-safe. You can safely perform tree traversals and distance calculations across multiple threads using Python's `threading` or `concurrent.futures` modules.
- **Subsetting**: When working with `SuchLinkedTrees`, use the built-in subsetting functions to isolate specific phylogenetic or ecological properties before generating Laplacian matrices for spectral decomposition.

## Reference documentation
- [SuchTree GitHub Repository](./references/github_com_ryneches_SuchTree.md)
- [Bioconda SuchTree Overview](./references/anaconda_org_channels_bioconda_packages_suchtree_overview.md)