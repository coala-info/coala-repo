---
name: bioconductor-powertcr
description: This tool analyzes T cell receptor repertoires by modeling clone size distributions and performing comparative statistical analyses. Use when user asks to fit discrete gamma-GPD or Pareto models to clone counts, cluster repertoires using Jensen-Shannon distance, or estimate diversity metrics like Shannon entropy and clonality.
homepage: https://bioconductor.org/packages/release/bioc/html/powerTCR.html
---


# bioconductor-powertcr

name: bioconductor-powertcr
description: Analysis of T cell receptor (TCR) repertoires using model-based comparative approaches. Use this skill to fit clone size distributions (discrete gamma-GPD spliced threshold or Type-I Pareto models), perform hierarchical clustering based on Jensen-Shannon distance, and calculate diversity estimators (richness, Shannon entropy, clonality).

# bioconductor-powertcr

## Overview

The `powerTCR` package provides tools for the comparative analysis of T cell receptor (TCR) repertoires by modeling their clone size distributions. It specifically addresses the imperfect power-law behavior of TCR data using a discrete gamma-GPD (Generalized Pareto Distribution) spliced threshold model. The package allows for parsing common TCR sequencing formats, fitting statistical models to clone counts, and clustering samples based on the similarity of their fitted distributions.

## Typical Workflow

### 1. Data Loading and Parsing
The package can parse various formats (MiTCR, MiGEC, VDJtools, ImmunoSEQ, MiXCR, IMSEQ). If data is already in R, it simply requires a vector of clone sizes (counts).

```r
library(powerTCR)

# Parse a single file
# sample_counts <- parseFile("path/to/file.txt", format = "mixcr")

# Using the built-in toy dataset
data(repertoires)
# repertoires is a list of numeric vectors (clone sizes)
```

### 2. Fitting the Spliced Threshold Model
The core model fits a Gamma distribution to the "bulk" (small clones) and a GPD to the "tail" (large clones).

```r
# Define a grid of potential thresholds (u)
# Usually quantiles of the data (e.g., 75th to 90th)
thresholds <- unique(round(quantile(repertoires[[1]], c(.75, .8, .85, .9))))

# Fit the model
fit <- fdiscgammagpd(repertoires[[1]], useq = thresholds, shift = min(repertoires[[1]]))

# Access results
mle_params <- get_mle(fit) # phi, shape, rate, threshold, sigma, xi
nllh_val <- get_nllh(fit)
```

### 3. Fitting the Type-I Pareto Model
An alternative power-law model (Desponds et al.) that minimizes the KS-statistic.

```r
pareto_fit <- fdesponds(repertoires[[1]])
# Returns min.KS, Cmin (threshold), and pareto.alpha
```

### 4. Comparative Analysis (Clustering)
Compare samples using Jensen-Shannon (JS) distance between their fitted distributions.

```r
# 1. Fit models for all samples in a list
fits_list <- lapply(repertoires, function(x) {
  fdiscgammagpd(x, useq = unique(round(quantile(x, c(.8, .9)))), shift = min(x))
})

# 2. Define a grid for evaluation (from min clone size to a large upper bound)
eval_grid <- min(unlist(repertoires)):100000

# 3. Compute distance matrix
dist_matrix <- get_distances(fits_list, grid = eval_grid, modelType = "Spliced")

# 4. Cluster and plot
clusterPlot(dist_matrix, method = "ward.D")
```

### 5. Diversity Estimation
Extract model-based diversity metrics.

```r
div_metrics <- get_diversity(fits_list)
# Returns richness, shannon, clonality, and prop_stim (proportion of highly stimulated clones)
```

## Distribution Functions and Simulation
The package provides standard R-style functions for the discrete gamma-GPD model:
- `ddiscgammagpd(x, ...)`: Density
- `pdiscgammagpd(q, ...)`: Distribution
- `qdiscgammagpd(p, ...)`: Quantile
- `rdiscgammagpd(n, ...)`: Random generation (simulation)

## Tips
- **Threshold Selection**: The `useq` parameter in `fdiscgammagpd` is critical. If the model fails to converge, try a different or denser grid of quantiles.
- **Grid for JS Distance**: When using `get_distances`, ensure the `grid` extends far enough into the tail (e.g., 100,000+) to capture the differences in large clones, as this is where the models often diverge most.
- **Bootstrapping**: Use `get_bootstraps(fits, resamples = 1000)` to generate confidence intervals for model parameters like $\xi$ (the shape parameter of the GPD tail).

## Reference documentation
- [powerTCR](./references/powerTCR.md)