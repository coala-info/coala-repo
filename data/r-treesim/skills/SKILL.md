---
name: r-treesim
description: The TreeSim package simulates phylogenetic trees under various birth-death models, including constant-rate, density-dependent, and rate-shifting processes. Use when user asks to simulate trees with a fixed number of taxa or age, model mass extinction events, or generate serially sampled heterochronous trees.
homepage: https://cran.r-project.org/web/packages/treesim/index.html
---


# r-treesim

## Overview
The `TreeSim` package is a standard R tool for simulating phylogenetic trees. It supports constant-rate birth-death processes, density-dependent speciation, and complex scenarios involving rate shifts and mass extinction events. It is particularly useful for generating null distributions of tree topologies and branch lengths for phylogenetic analysis.

## Installation
```R
install.packages("TreeSim")
library(TreeSim)
```

## Core Workflows

### 1. Simulating Trees with Fixed Taxa (Isochronous)
Use `sim.bd.taxa` to simulate trees where all tips are sampled at the present.
```R
# Simulate 5 trees with 10 tips each
# lambda (speciation) = 2.0, mu (extinction) = 1.0, frac (sampling fraction) = 1.0
trees <- sim.bd.taxa(n=10, numbsim=5, lambda=2.0, mu=1.0, frac=1.0, complete=TRUE)
```

### 2. Simulating Trees with Fixed Age
Use `sim.bd.age` to simulate trees that have evolved for a specific duration.
```R
# Simulate trees with age 2.0
trees_age <- sim.bd.age(age=2.0, numbsim=5, lambda=2.0, mu=1.0, frac=1.0, mrca=TRUE)
```

### 3. Rate Shifts and Mass Extinctions
Use `sim.rateshift.taxa` to define time intervals with different birth/death rates.
```R
# Define rates and times (times are time before present)
lambdas <- c(2, 1)
mus <- c(0, 0.5)
times <- c(0, 0.5) # Shift occurs at 0.5 time units ago
trees_shift <- sim.rateshift.taxa(n=10, numbsim=5, lambdas, mus, frac=c(1,1), times)
```

### 4. Serially Sampled Trees (Heterochronous)
For trees where tips are sampled at different time points (e.g., viral sequences or fossils), use the `sim.bdsky.stt` or `sim.bdtypes.stt.taxa` functions.
```R
# Simulate serially sampled trees
# n: number of tips, lambda: speciation, mu: extinction, psi: sampling rate
trees_serial <- sim.bdsky.stt(n=10, lambdas=2, mus=0.5, psis=0.5)
```

### 5. Visualizing Results
`TreeSim` provides Lineage-Through-Time (LTT) plotting functions.
```R
# Plot LTT for a list of trees
LTT.plot(trees)
```

## Tips and Best Practices
- **Complete vs. Extant Trees**: The `complete` parameter determines if extinct lineages are kept. Set `complete=FALSE` to get trees containing only lineages that survived to the sampling point.
- **Conditioning**: Be mindful of whether you are conditioning on the MRCA (Most Recent Common Ancestor) or the root (origin).
- **Object Types**: Functions typically return a list of objects of class `phylo` (from the `ape` package). Use `trees[[1]]` to access the first tree.
- **GSA**: For more complex models where standard birth-death assumptions don't fit, use `sim.gsa.taxa` (General Sampling Algorithm).

## Reference documentation
- [TreeSim Home Page](./references/home_page.md)