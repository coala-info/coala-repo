---
name: r-geiger
description: The geiger package provides tools for macroevolutionary analysis by fitting models of trait evolution and diversification to phylogenetic trees. Use when user asks to fit continuous or discrete trait models, synchronize tree and trait data, identify diversification rate shifts, or rescale phylogenetic branch lengths.
homepage: https://cloud.r-project.org/web/packages/geiger/index.html
---

# r-geiger

## Overview
The `geiger` package is a comprehensive suite for macroevolutionary analysis. It allows researchers to fit various models of trait evolution to phylogenetic trees, detect shifts in the tempo of evolution, and integrate fossil data with extant phylogenies. It is a core tool in the R phylogenetics ecosystem, often used alongside `ape` and `phytools`.

## Installation
To install the stable version from CRAN:
```R
install.packages("geiger")
```

## Core Workflows

### 1. Data Preparation
Ensure your tree (class `phylo`) and trait data (vector or matrix) match. The `treedata()` function is the standard way to synchronize them.
```R
library(geiger)
# Synchronize tree and data (removes mismatches)
combined <- treedata(tree, data)
phy <- combined$phy
dat <- combined$data
```

### 2. Fitting Continuous Trait Models
Use `fitContinuous()` to compare models of evolution for quantitative traits.
```R
# Fit Brownian Motion (BM)
fitBM <- fitContinuous(phy, dat, model = "BM")

# Fit Ornstein-Uhlenbeck (OU)
fitOU <- fitContinuous(phy, dat, model = "OU")

# Fit Early Burst (EB)
fitEB <- fitContinuous(phy, dat, model = "EB")

# Compare models using AICc
print(fitBM$opt$aicc)
print(fitOU$opt$aicc)
```

### 3. Fitting Discrete Trait Models
Use `fitDiscrete()` for categorical data (e.g., binary or multistate characters).
```R
# Fit Equal Rates (ER) model
fitER <- fitDiscrete(phy, dat, model = "ER")

# Fit All Rates Different (ARD) model
fitARD <- fitDiscrete(phy, dat, model = "ARD")
```

### 4. Diversification Analysis
Identify shifts in diversification rates or fit models to lineage-through-time data.
```R
# Medusa: Identify shifts in diversification rates
# Requires a tree and optionally richness data for unresolved clades
res <- medusa(phy)
plot(res)
```

### 5. Time-Scaling and Congruification
`congruify.phylo()` allows you to map dates from a large, dated "master" tree onto a smaller target tree based on shared taxonomy.
```R
# Scale target tree to match reference tree nodes
scaled_tree <- congruify.phylo(reference_tree, target_tree, taxonomy = NULL)
```

## Key Functions Reference
- `fitContinuous()`: Fits models like BM, OU, EB, white, kappa, delta, and lambda.
- `fitDiscrete()`: Fits Mk models (ER, SYM, ARD).
- `treedata()`: Cleans and matches phylogenetic trees with trait datasets.
- `medusa()`: Stepwise AIC approach to find diversification rate shifts.
- `disparity()`: Calculates morphological disparity within groups.
- `rescale()`: Transforms the branch lengths of a tree according to various evolutionary models.

## Tips
- **Model Selection**: Always use AICc (provided in the output list under `$opt$aicc`) to compare models, especially with small sample sizes.
- **Data Format**: `treedata()` expects the row names of the data matrix to match the tip labels of the tree.
- **Unresolved Clades**: If your tree has tips representing multiple species, use the `n.taxa` argument in diversification functions to account for hidden diversity.

## Reference documentation
- [Geiger README](./references/README.html.md)
- [Geiger Home Page](./references/home_page.md)