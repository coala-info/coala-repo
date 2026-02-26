---
name: r-vegan
description: This tool provides expert guidance for community ecology analysis and multivariate statistics using the R package vegan. Use when user asks to calculate diversity indices, perform rarefaction, compute ecological dissimilarities, conduct ordination such as NMDS, RDA, or CCA, and run statistical tests like PERMANOVA.
homepage: https://cloud.r-project.org/web/packages/vegan/index.html
---


# r-vegan

name: r-vegan
description: Expert guidance for community ecology analysis using the R package 'vegan'. Use this skill when performing multivariate analysis of ecological communities, including ordination (PCA, RDA, CCA, NMDS), diversity analysis (Shannon, Simpson, rarefaction), and dissimilarity-based methods (adonis2, anosim, mantel).

# r-vegan

## Overview
The `vegan` package is the standard R toolkit for community ecologists. It provides tools for descriptive community ecology, including diversity indices, species abundance models, and a wide array of ordination methods to analyze species-environment relationships.

## Installation
To install the stable version from CRAN:
```R
install.packages("vegan")
```

## Core Workflows

### 1. Diversity Analysis
Calculate alpha diversity and perform rarefaction to account for sampling effort.
```R
library(vegan)
data(dune)

# Diversity indices
H <- diversity(dune) # Shannon by default
S <- specnumber(dune) # Species richness
J <- H/log(S) # Pielou's evenness

# Rarefaction
raremax <- min(rowSums(dune))
Srare <- rarefy(dune, raremax)
rarecurve(dune, step = 20, sample = raremax, col = "blue", cex = 0.6)
```

### 2. Dissimilarity and Distance
`vegdist` is preferred over `dist` for ecological data as it defaults to Bray-Curtis.
```R
# Quantitative Bray-Curtis
d_bray <- vegdist(dune, method = "bray")

# Binary (Presence/Absence) Jaccard
d_jaccard <- vegdist(dune, method = "jaccard", binary = TRUE)
```

### 3. Non-metric Multidimensional Scaling (NMDS)
Use `metaMDS` for robust NMDS. It automatically handles transformations (like Wisconsin) and finds a stable solution via multiple restarts.
```R
set.seed(123)
nm <- metaMDS(dune, k = 2, trymax = 100)
plot(nm, type = "t")

# Check fit
stressplot(nm)
```

### 4. Constrained Ordination (RDA/CCA)
Use `rda` for linear constraints (Principal Components) or `cca` for unimodal constraints (Correspondence Analysis).
```R
data(dune.env)

# Constrained Correspondence Analysis
m_cca <- cca(dune ~ Management + A1, data = dune.env)
plot(m_cca)

# Significance testing (Permutation test)
anova(m_cca, by = "term")
```

### 5. Statistical Testing (PERMANOVA)
Use `adonis2` to test for differences in community composition between groups.
```R
# Test if Management affects community composition
adonis2(dune ~ Management, data = dune.env, permutations = 999)
```

## Tips and Troubleshooting
- **Data Types**: Ensure community data is numeric. If using `tibbles`, ensure row names are handled correctly or converted to a matrix, as `vegan` expects numeric matrices/data frames for species data.
- **Zero Stress**: If `metaMDS` reports zero stress, you likely have too few sites for the number of dimensions. Ensure $n > 2k + 1$.
- **Environmental Fitting**: Use `envfit(ord, env)` to project environmental vectors or factors onto any ordination result (including NMDS).
- **Decluttering Plots**: For crowded plots, use `orditorp(ord, display = "species")` to only label species that don't overlap, or use `identify.ordiplot` for interactive labeling.
- **Passive Points**: To add new sites/species to an existing eigenvector ordination without re-running the model, use `predict(model, newdata = ...)`.

## Reference documentation
- [vegan FAQ](./references/FAQ-vegan.Rmd)