---
name: r-adephylo
description: This tool provides multivariate methods for exploratory analysis and quantification of phylogenetic signals in biological trait data. Use when user asks to quantify phylogenetic signal, perform phylogenetic decomposition of trait variation, model signal using Moran's eigenvectors, or visualize comparative data on trees.
homepage: https://cloud.r-project.org/web/packages/adephylo/index.html
---


# r-adephylo

name: r-adephylo
description: Multivariate tools for exploratory analyses of phylogenetic comparative data. Use this skill when you need to analyze biological traits in a phylogenetic context, including quantifying phylogenetic signal (Moran's I, Abouheif's test), performing phylogenetic decomposition of trait variation (orthogram), modeling signal using orthonormal bases (Moran's eigenvectors), or visualizing comparative data on trees.

# r-adephylo

## Overview
The `adephylo` package provides exploratory methods for the Phylogenetic Comparative Method (PCM). It extends the `ade4` package and works seamlessly with `ape` and `phylobase`. It is designed to visualize, test, and investigate phylogenetic signals in comparative data using multivariate techniques.

## Installation
```R
install.packages("adephylo")
# Dependencies often required:
install.packages(c("ape", "phylobase", "ade4"))
```

## Core Workflows

### 1. Data Representation
`adephylo` uses `phylo` (from `ape`) and `phylo4d` (from `phylobase`) objects.
```R
library(adephylo)
library(ape)
library(phylobase)

# Create a phylo4d object (tree + data)
my_tree <- read.tree(text="((A,B),C);")
my_data <- data.frame(trait1 = c(1, 2, 10), row.names = c("A", "B", "C"))
obj <- phylo4d(my_tree, my_data)

# Visualize data on the tree
table.phylo4d(obj)
```

### 2. Testing Phylogenetic Signal
Quantify whether closely related taxa have more similar trait values than expected by chance.

*   **Moran's I**: Requires a proximity matrix.
```R
# Compute proximity matrix
W <- proxTips(my_tree, method = "Abouheif")
# Compute Moran's I for a specific trait
moran.idx(tdata(obj)$trait1, W)
```

*   **Abouheif's Test**: A permutation test for phylogenetic signal.
```R
# Test all traits in a phylo4d object
res <- abouheif.moran(obj)
plot(res)
```

### 3. Phylogenetic Decomposition (Orthogram)
Decompose trait variation into different phylogenetic levels using an orthonormal basis.
```R
# Perform orthogram analysis
res_ortho <- orthogram(tdata(obj)$trait1, my_tree)
```

### 4. Modeling Phylogenetic Signal
Use Moran's Eigenvectors (ME) to account for phylogenetic structure in linear models.
```R
# Generate Moran's eigenvectors
me_basis <- me.phylo(my_tree, method = "Abouheif")

# Use ME as a covariate to remove phylogenetic autocorrelation from residuals
lm_model <- lm(trait1 ~ me_basis[,1] + other_variable, data = tdata(obj))
```

### 5. Proximity and Distance Functions
*   `distRoot`: Compute phylogenetic distance from tips to the root.
*   `distTips`: Compute pairwise distances between tips.
*   `proxTips`: Compute phylogenetic proximities (methods: "patristic", "nNodes", "Abouheif", "sumDD").

## Tips for Success
*   **Missing Data**: `adephylo` functions generally do not handle `NA` values. Impute or remove missing data before analysis (e.g., using mean imputation for PCA).
*   **Branch Lengths**: Some proximity methods (like "patristic") require branch lengths. If your tree lacks them, use `ape::compute.brlen()`.
*   **Interoperability**: Always ensure tip labels in your data frame match the tip labels in your tree object exactly.

## Reference documentation
- [adephylo: exploratory analyses for the phylogenetic comparative method](./references/adephylo.md)