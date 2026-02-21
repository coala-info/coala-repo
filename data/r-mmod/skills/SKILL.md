---
name: r-mmod
description: "Provides functions for measuring     population divergence from genotypic data.</p>"
homepage: https://cloud.r-project.org/web/packages/mmod/index.html
---

# r-mmod

name: r-mmod
description: Expert assistance for the R package 'mmod' (Modern Measures of Population Differentiation). Use this skill when analyzing population genetic structure using genind objects to calculate modern differentiation statistics like Hedrick's G''ST, Jost's Dest, and Phi'st. Ideal for workflows involving population divergence estimation, bootstrapping for confidence intervals, and Mantel tests for isolation by distance.

# r-mmod

## Overview
The `mmod` package provides modern alternatives to traditional population differentiation measures (like Nei's $G_{ST}$). It addresses the dependency of $G_{ST}$ on the number of alleles and populations, offering corrected statistics that are comparable across studies. It integrates seamlessly with the `adegenet` package and its `genind` data class.

## Installation
To install the package from CRAN:
```R
install.packages("mmod")
```

## Core Workflow

### 1. Data Preparation
`mmod` functions require a `genind` object. You can create one using `adegenet` or load example data:
```R
library(mmod)
library(adegenet)
data(nancycats) # Example genind object
```

### 2. Calculating Differentiation Statistics
Use `diff_stats()` to calculate $H_s$, $H_t$, $G_{ST}$, Hedrick's $G''_{ST}$, and Jost's $D$ simultaneously.

```R
# Calculate basic stats (per locus and global)
stats <- diff_stats(nancycats)

# Include Phi'st (AMOVA-based, takes longer to calculate)
stats_full <- diff_stats(nancycats, phi_st = TRUE)

# Access results
stats$per.locus  # Locus-specific estimates
stats$global     # Global estimates (mean/harmonic mean)
```

### 3. Bootstrapping for Confidence Intervals
To assess the robustness of differentiation estimates, use the Chao bootstrap method.

```R
# 1. Generate bootstrap samples (e.g., 1000 reps)
bs_samples <- chao_bootstrap(nancycats, nreps = 1000)

# 2. Summarize for a specific statistic (e.g., Jost's D)
# Options: D_Jost, Gst_Hedrick, Gprime_st, Phi_st
bs_summary <- summarise_bootstrap(bs_samples, D_Jost)

# View Mean and 95% CI
print(bs_summary)
```

### 4. Pairwise Differentiation and Isolation by Distance
For population-level comparisons and Mantel tests:

```R
# Calculate pairwise Jost's D
# Use linearized=TRUE for Mantel tests (x / (1-x))
pw_d <- pairwise_D(nancycats, linearized = TRUE)

# Calculate geographic distances (if coordinates exist in @other$xy)
geo_dist <- dist(nancycats@other$xy)

# Perform Mantel test (requires ade4)
library(ade4)
mantel.rtest(pw_d, geo_dist, nrepet = 999)
```

## Key Functions Reference
- `diff_stats(x, phi_st)`: Comprehensive summary of differentiation.
- `Gst_Hedrick(x)`: Calculates Hedrick's $G'_{ST}$.
- `Gprime_st(x)`: Calculates Hedrick's $G''_{ST}$ (directly related to migration rate).
- `D_Jost(x)`: Calculates Jost's $Dest$ (diversity partitioning).
- `Phi_st(x)`: Calculates $\phi'_{ST}$ based on AMOVA.
- `pairwise_D(x)` / `pairwise_Gst_Hedrick(x)`: Pairwise population matrices.
- `chao_bootstrap(x, nreps)`: Creates bootstrap replicates of a genind object.

## Tips
- **Negative Values**: Because estimators are used, you may see small negative values for $D$ or $G_{ST}$. These should generally be interpreted as zero (no differentiation).
- **Interpretation**: $D$ is often preferred for its ease of interpretation ($0$ = no differentiation, $1$ = complete differentiation).
- **Data Loading**: If your data is in FSTAT or GENEPOP format, use `adegenet::read.fstat()` or `adegenet::read.genpop()` before using `mmod`.

## Reference documentation
- [mmod: Modern Measures of Population Differentiation](./references/mmod-demo.md)