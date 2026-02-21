---
name: r-phylosignal
description: A collection of tools to explore the phylogenetic signal in univariate and multivariate data. The package provides functions to plot traits data against a phylogenetic tree, different measures and tests for the phylogenetic signal, methods to describe where the signal is located and a phylogenetic clustering method.</p>
homepage: https://cran.r-project.org/web/packages/phylosignal/index.html
---

# r-phylosignal

## Overview
The `phylosignal` package provides a suite of tools for quantifying and localizing phylogenetic signals in univariate and multivariate continuous data. It builds upon the `phylobase` framework, using `phylo4d` objects to integrate phylogenetic trees with trait data.

## Installation
```R
install.packages("phylosignal")
# Required dependencies for data handling
install.packages(c("ape", "phylobase", "adephylo"))
```

## Core Workflow

### 1. Data Preparation
Convert your tree (class `phylo`) and data frame into a `phylo4d` object.
```R
library(phylosignal)
library(phylobase)

# Create phylo4d object
p4d <- phylo4d(tree, trait_data)
```

### 2. Visualizing Traits on Trees
Use specialized plotting functions to visualize trait distribution across the phylogeny.
```R
# Standard barplot
barplot(p4d)

# Dotplot or Gridplot (heatmap style)
dotplot(p4d, tree.type = "cladogram")
gridplot(p4d, tree.type = "fan")

# Customizing colors based on values
mat.col <- ifelse(tdata(p4d, "tip") < 0, "red", "grey35")
barplot(p4d, bar.col = mat.col)
```

### 3. Measuring Phylogenetic Signal
Calculate multiple signal statistics (Cmean, I, K, K*, Lambda) simultaneously.
```R
# Test all traits in the object
signal_results <- phyloSignal(p4d, method = "all")
```

### 4. Locating Signal (LIPA)
Identify specific nodes or tips where the phylogenetic signal is concentrated using Local Indicators of Phylogenetic Association.
```R
# Local Moran's I
res_lipa <- lipaMoran(p4d)

# Visualize LIPA on the tree (highlighting significant tips)
barplot.phylo4d(p4d, bar.col = (res_lipa$p.value < 0.05) + 1)
```

### 5. Phylogenetic Correlograms
Assess how signal changes with phylogenetic distance.
```R
crlg <- phyloCorrelogram(p4d, trait = "trait_name")
plot(crlg)
```

## Advanced Plotting Tips
The package allows "focusing" on specific plot regions to add standard R graphical elements.
- `focusTree()`: Add scale bars or annotations to the tree region.
- `focusTraits(i)`: Add lines or points to the i-th trait panel.
- `focusTips()`: Annotate tip labels or highlight clades.
- `focusStop()`: Release the focus to return to standard plotting.

```R
barplot(p4d)
focusTree()
add.scale.bar()
focusStop()
```

## Reference documentation
- [Package overview](./references/Basics.Rmd)
- [Plotting functions](./references/Demo_plots.Rmd)