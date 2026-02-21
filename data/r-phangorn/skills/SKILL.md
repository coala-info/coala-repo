---
name: r-phangorn
description: "Allows for estimation of phylogenetic trees and networks     using Maximum Likelihood, Maximum Parsimony, distance methods and     Hadamard conjugation (Schliep 2011). Offers methods for tree comparison,      model selection and visualization of phylogenetic networks as described in     Schliep et al. (2017).</p>"
homepage: https://cloud.r-project.org/web/packages/phangorn/index.html
---

# r-phangorn

name: r-phangorn
description: Expert guidance for phylogenetic reconstruction and analysis using the phangorn R package. Use this skill when performing Maximum Likelihood (ML), Maximum Parsimony (MP), distance-based tree estimation, ancestral sequence reconstruction, or phylogenetic network analysis (Neighbor-Net, ConsensusNet).

## Overview
The `phangorn` package is a comprehensive R library for phylogenetic analysis. It extends the `ape` package to provide advanced estimation methods including the parsimony ratchet, ML model selection, and specialized tools for morphological and codon data.

## Installation
```R
install.packages("phangorn")
library(phangorn)
```

## Core Workflows

### 1. Data Preparation
`phangorn` uses the `phyDat` class. Convert matrices or read files directly:
```R
# Read DNA, AA, or Morphological data
data <- read.phyDat("alignment.fasta", format = "fasta", type = "DNA")

# Custom data types (e.g., 5-state DNA with gaps)
data_5state <- phyDat(matrix_data, type = "USER", levels = c("a","c","g","t","-"))
```

### 2. Distance-Based Methods
Fast initial tree estimation using UPGMA or Neighbor-Joining (NJ):
```R
dm <- dist.ml(data, model = "JC69") # ML distances
treeNJ <- NJ(dm)
treeUPGMA <- upgma(dm)
```

### 3. Maximum Parsimony (MP)
Use the Parsimony Ratchet for robust topology search:
```R
# Find most parsimonious tree
treePars <- pratchet(data, trace = 0)
# Assign edge lengths using ACCTRAN
treePars <- acctran(treePars, data)
```

### 4. Maximum Likelihood (ML)
The recommended workflow uses `pml_bb` for automated model selection and tree inference:
```R
# Automated model selection and tree search
mt <- modelTest(data)
fit <- pml_bb(mt, control = pml.control(trace = 0))

# Manual ML optimization
fit <- pml(treeNJ, data)
fit_opt <- optim.pml(fit, model="GTR", optGamma=TRUE, optInv=TRUE, rearrangement="stochastic")
```

### 5. Ancestral State Reconstruction
```R
# Parsimony reconstruction
anc_p <- anc_pars(tree, data)

# Likelihood reconstruction
fit <- pml(tree, data)
anc_ml <- anc_pml(fit)
plotAnc(anc_ml, site = 1)
```

### 6. Phylogenetic Networks
Visualize conflicting signals or reticulate evolution:
```R
# Neighbor-Net
dm <- dist.hamming(data)
nnet <- neighborNet(dm)
plot(nnet, "2D")

# Consensus Network from bootstrap trees
bs_trees <- bootstrap.phyDat(data, FUN = function(x) nj(dist.hamming(x)))
cnet <- consensusNet(bs_trees, prob = 0.2)
plot(cnet)
```

## Key Functions Reference
- `phyDat()`: Create phylogenetic data objects.
- `modelTest()`: Compare nucleotide or amino acid substitution models.
- `pml_bb()`: Integrated ML tree estimation (replaces complex `pml` + `optim.pml` pipelines).
- `bootstrap.pml()`: Perform standard non-parametric bootstrapping.
- `plotBS()`: Plot trees with bootstrap support (supports standard, ultrafast, and transfer bootstrap).
- `codonTest()`: Estimate dN/dS ratios and test for positive selection.

## Tips for Success
- **Starting Trees**: Always use a NJ or UPGMA tree as a starting point for ML to reduce computation time.
- **Parallelization**: Use `multicore = TRUE` in `modelTest` or `bootstrap.pml` on Linux/macOS to speed up analysis.
- **Morphological Data**: Use `type = "STANDARD"` or `type = "USER"` in `read.phyDat` for discrete character matrices.
- **Rooting**: Use `midpoint(tree)` or `ape::root(tree, outgroup)` for visualization, as many `phangorn` methods return unrooted trees.

## Reference documentation
- [Markov models and transition rate matrices](./references/AdvancedFeatures.Rmd)
- [Ancestral Sequence Reconstruction](./references/Ancestral.Rmd)
- [Intertwining phylogenetic trees and networks](./references/IntertwiningTreesAndNetworks.Rmd)
- [Maximum likelihood by hand](./references/MLbyHand.Rmd)
- [Phylogenetic trees from morphological data](./references/Morphological.Rmd)
- [Splits and Networx](./references/Networx.Rmd)
- [Estimating phylogenetic trees with phangorn](./references/Trees.Rmd)