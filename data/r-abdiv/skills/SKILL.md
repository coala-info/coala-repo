---
name: r-abdiv
description: This tool provides functions to calculate alpha, beta, and phylogenetic ecological diversity measures using the R package abdiv. Use when user asks to calculate richness, Shannon index, or Simpson index, compute Bray-Curtis or Jaccard dissimilarities, and perform phylogenetic diversity analysis like Faith's PD or UniFrac.
homepage: https://cran.r-project.org/web/packages/abdiv/index.html
---

# r-abdiv

name: r-abdiv
description: Expert guidance for using the 'abdiv' R package to calculate alpha and beta diversity measures. Use this skill when performing ecological diversity analysis, including richness, Shannon index, Bray-Curtis dissimilarity, Jaccard distance, and phylogenetic diversity measures like Faith's PD and UniFrac.

## Overview

The `abdiv` package provides a comprehensive collection of ecological diversity measures. It is designed to be clear and consistent, re-implementing measures found in `vegan`, `scikit-bio`, `Mothur`, and `GUniFrac`.

- **Alpha Diversity**: Measures diversity within a single site/sample (e.g., richness, shannon, simpson).
- **Beta Diversity**: Measures dissimilarity between two sites/samples (e.g., bray_curtis, jaccard, canberra).
- **Phylogenetic Diversity**: Incorporates evolutionary relationships using phylogenetic trees (e.g., faith_pd, unweighted_unifrac).

## Installation

Install the package from CRAN:

```r
install.packages("abdiv")
```

## Alpha Diversity Workflow

Alpha diversity functions take a numeric vector of species counts.

```r
library(abdiv)

site1 <- c(2, 5, 16, 0, 1)

# Basic measures
richness(site1)
shannon(site1)
invsimpson(site1)

# Get a list of all available alpha diversity functions
alpha_diversities
```

### Tidyverse Integration
For long-format data frames, use `group_by()` and `summarize()`:

```r
library(dplyr)

# Single measure
plants %>%
  group_by(Site) %>%
  summarize(div = shannon(Counts))

# Multiple measures
plants %>%
  group_by(Site) %>%
  summarize(across(Counts, list(shannon = shannon, richness = richness)))
```

## Beta Diversity Workflow

Beta diversity functions take two numeric vectors and return a single dissimilarity value.

```r
site1 <- c(2, 5, 16, 0, 1)
site2 <- c(0, 0, 8, 8, 8)

bray_curtis(site1, site2)
jaccard(site1, site2)

# Get a list of all available beta diversity functions
beta_diversities
```

### Creating Distance Matrices
To compute distances across multiple sites, use a site-by-species matrix and the `usedist` package:

```r
# plants_matrix: rows = sites, cols = species
dist_matrix <- usedist::dist_make(plants_matrix, bray_curtis)
```

## Phylogenetic Diversity

Phylogenetic functions require a phylogenetic tree (usually an `ape` phylo object).

### Faith's Phylogenetic Diversity (Alpha)
```r
# Using a count vector and a tree
faith_pd(counts, tree)

# If vector is named, names are matched to tree tips
faith_pd(c(sp1=10, sp2=5), tree)

# If using long-format data
plants %>%
  group_by(Site) %>%
  summarize(pd = faith_pd(Counts, tree, Species))
```

### UniFrac (Beta)
```r
# Unweighted UniFrac
unweighted_unifrac(site1, site2, tree)

# Weighted UniFrac
weighted_unifrac(site1, site2, tree)

# Distance matrix with UniFrac
usedist::dist_make(plants_matrix, unweighted_unifrac, tree)
```

## Tips and Best Practices

1.  **Data Format**: Use long format (data frames) for alpha diversity and matrix format for beta diversity distance matrices.
2.  **Species Matching**: When using phylogenetic measures, ensure species names in your data match the tip labels in the tree. `abdiv` functions handle matching automatically if names are provided.
3.  **Zero Handling**: Beta diversity measures in `abdiv` are designed to handle zero counts correctly, but ensure your matrix includes all species present across all samples (fill missing species with 0).
4.  **Comparison**: Use the `alpha_diversities` and `beta_diversities` character vectors to programmatically apply multiple measures to your data for sensitivity analysis.

## Reference documentation

- [abdiv: Alpha and Beta Diversity Measures](./references/README.md)