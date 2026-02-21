---
name: r-aptreeshape
description: R package aptreeshape (documentation from project home).
homepage: https://cran.r-project.org/web/packages/aptreeshape/index.html
---

# r-aptreeshape

name: r-aptreeshape
description: Analysis of phylogenetic tree shape using the apTreeshape R package. Use this skill when you need to simulate, visualize, or test the topological balance of phylogenetic trees using statistical indices (Colless, Sackin) or likelihood-based models (Yule, PDA).

## Overview

The `apTreeshape` package provides tools for analyzing the "shape" or topology of phylogenetic trees. It focuses on tree imbalance and provides statistical tests to compare observed trees against null models of speciation. It is particularly useful for macroevolutionary studies to determine if diversification has been symmetric or biased.

## Installation

Since the package was archived on CRAN, it should be installed from the CRAN archive or via a GitHub mirror:

```R
# Install from CRAN archive
install.packages("https://cran.r-project.org/src/contrib/Archive/apTreeshape/apTreeshape_1.4.5.tar.gz", repos = NULL, type = "source")

# Alternatively, using remotes
# remotes::install_github("cran/apTreeshape")
```

## Core Workflows

### 1. Creating and Converting Trees
The package uses a specific `treeshape` class. You can convert `phylo` objects (from the `ape` package) easily.

```R
library(apTreeshape)
library(ape)

# Convert from ape's phylo object
data(bird.families)
shape_tree <- as.treeshape(bird.families)

# Summary provides basic stats (nodes, tips, imbalance)
summary(shape_tree)
plot(shape_tree)
```

### 2. Measuring Tree Imbalance
Calculate standard indices to quantify how "balanced" a tree is.

```R
# Colless Index (standardized or not)
colless(shape_tree, norm = "yule")

# Sackin's Index
sackin(shape_tree, norm = "pda")

# Total Cophenetic Index
tci(shape_tree)
```

### 3. Statistical Testing
Test if a tree fits a specific null model (Yule/Equal Rates Markov or PDA/Proportional to Distinguishable Arrangements).

```R
# Test using the Colless index against the Yule model
# 'alternative' can be "less" (more balanced) or "greater" (more imbalanced)
colless.test(shape_tree, model = "yule", alternative = "greater")

# Test using the Sackin index
sackin.test(shape_tree, model = "pda")
```

### 4. Simulating Trees
Generate trees under specific models to compare with empirical data.

```R
# Simulate a Yule tree with 50 tips
yule_tree <- rtreeshape(n = 1, tip.number = 50, model = "yule")

# Simulate a PDA tree
pda_tree <- rtreeshape(n = 1, tip.number = 50, model = "pda")

# Biased speciation model (Aldous' branching)
biased_tree <- rtreeshape(n = 1, tip.number = 50, model = "aldous", p = 0.1)
```

### 5. Likelihood and Optimization
Estimate the parameter of the Beta-splitting model, which generalizes many speciation models.

```R
# Maximum likelihood estimation of the beta parameter
# beta = 0 corresponds to Yule; beta = -1.5 corresponds to PDA
max_lik <- maxlik.betasplit(shape_tree)
print(max_lik$beta_hat)
```

## Tips
- **Data Cleaning**: Ensure trees are bifurcating. `apTreeshape` is designed for rooted, binary trees. Use `ape::multi2di` if your tree has polytomies.
- **Normalization**: Always specify the `norm` argument in index functions if you intend to compare trees of different sizes.
- **Large Trees**: For very large trees, likelihood calculations for the beta-splitting model can be computationally intensive.

## Reference documentation
- [apTreeshape Home Page](./references/home_page.md)