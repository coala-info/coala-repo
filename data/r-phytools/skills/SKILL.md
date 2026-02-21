---
name: r-phytools
description: A wide range of methods for phylogenetic analysis - concentrated in phylogenetic comparative biology, but also including numerous techniques for visualizing, analyzing, manipulating, reading or writing, and even inferring phylogenetic trees. Included among the functions in phylogenetic comparative biology are various for ancestral state reconstruction, model-fitting, and simulation of phylogenies and trait data. A broad range of plotting methods for phylogenies and comparative data include (but are not restricted to) methods for mapping trait evolution on trees, for projecting trees into phenotype space or a onto a geographic map, and for visualizing correlated speciation between trees. Lastly, numerous functions are designed for reading, writing, analyzing, inferring, simulating, and manipulating phylogenetic trees and comparative data. For instance, there are functions for computing consensus phylogenies from a set, for simulating phylogenetic trees and data under a range of models, for randomly or non-randomly attaching species or clades to a tree, as well as for a wide range of other manipulations and analyses that phylogenetic biologists might find useful in their research.</p>
homepage: https://cloud.r-project.org/web/packages/phytools/index.html
---

# r-phytools

name: r-phytools
description: Specialized phylogenetic analysis using the phytools R package. Use this skill when performing comparative biology tasks, including ancestral state reconstruction, mapping trait evolution, fitting models of character evolution, simulating trees and data, and creating complex phylogenetic visualizations (e.g., cophylo plots, phenograms, or trees on maps).

# r-phytools

## Overview
The `phytools` package is a comprehensive ecosystem for phylogenetic comparative biology. It provides tools for manipulating phylogenetic trees, fitting models of continuous and discrete trait evolution, reconstructing ancestral states, and generating sophisticated visualizations of comparative data.

## Installation
To install the stable version from CRAN:
```r
install.packages("phytools")
```
To install the development version from GitHub:
```r
remotes::install_github("liamrevell/phytools")
```

## Core Workflows

### 1. Tree Manipulation and Input/Output
- **Read/Write**: Use `read.newick` or `read.nexus`. For trees with mapped states (SIMMAP), use `read.simmap`.
- **Binding/Dropping**: `bind.tip` to add species and `drop.tip` to remove them.
- **Stochastic Mapping**: `make.simmap` for mapping discrete character evolution using stochastic character mapping.

### 2. Ancestral State Reconstruction
- **Continuous Traits**: `fastAnc` for maximum likelihood estimation (faster than `ace` in ape) or `anc.ML`.
- **Discrete Traits**: `make.simmap` (Bayesian/Stochastic) or `rerootingMethod` (marginal ancestral states).
- **Visualization**: `plotAncStates` or `contMap` (for continuous traits) and `densityMap` (for stochastic mapping results).

### 3. Comparative Methods & Model Fitting
- **Brownian Motion**: `brownie.lite` for testing multiple rates of BM evolution on a tree.
- **Ornstein-Uhlenbeck**: `fitAnc` or integration with `geiger` patterns.
- **Phylogenetic Regression**: `phylosig` to calculate phylogenetic signal (Lambda or K).
- **Correlation**: `phyl.pca` for phylogenetic PCA and `phyl.resid` for phylogenetic size correction.

### 4. Advanced Visualization
- **Cophylo**: `cophylo` and `plot.cophylo` for visualizing two linked trees (e.g., parasite-host).
- **Phenogram**: `phenogram` to project a phylogeny into phenotype space (trait vs. time).
- **Phylo-Map**: `phylo.to.map` to project a tree onto a geographic map.
- **Trait Mapping**: `contMap` and `densityMap` for color-coded edges based on trait values.

## Tips and Best Practices
- **Object Classes**: Most functions expect objects of class `"phylo"` or `"simmap"`. Use `as.phylo` to convert if necessary.
- **Node Numbering**: Be aware that `phytools` often uses internal node numbering consistent with the `ape` package (nodes `N+1` to `N+M`).
- **Data Matching**: Ensure that the row names of your trait data matrix exactly match the `tree$tip.label`. Use `geiger::name.check` if available to verify.
- **Speed**: For very large trees, prefer `fastAnc` over standard `ace` for ancestral state reconstruction.

## Reference documentation
- [README](./references/README.md)