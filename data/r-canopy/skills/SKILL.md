---
name: r-canopy
description: R package canopy (documentation from project home).
homepage: https://cran.r-project.org/web/packages/canopy/index.html
---

# r-canopy

name: r-canopy
description: Statistical framework for inferring tumor phylogeny and intra-tumor heterogeneity using NGS data. Use when needing to identify sub-populations (clones), determine mutation profiles, and reconstruct evolutionary history from somatic SNAs (VAFs) and CNAs (allele-specific coverage ratios).

# r-canopy

## Overview
Canopy is an R package designed to access intra-tumor heterogeneity and track longitudinal and spatial clonal evolutionary history. It uses a Bayesian framework to pool data across multiple samples from the same patient to infer the phylogenetic tree, the mutation profiles of the clones, and the clonal proportions in each sample. It specifically handles the temporal ordering of SNAs that fall within CNA regions and resolves their phase.

## Installation
To install the stable version from CRAN:
```R
install.packages("Canopy")
```

To install the development version (recommended) with dependencies:
```R
install.packages(c("ape", "fields", "pheatmap", "scatterplot3d", "devtools"))
devtools::install_github("yuchaojiang/Canopy/package")
```

## Core Workflow

### 1. Data Preparation
Canopy requires two primary inputs:
- **SNA Data**: Matrices of mutant allele counts (`R`) and total depth (`D`) for somatic SNAs.
- **CNA Data**: Allele-specific coverage ratios (tumor vs. normal) for somatic CNAs.

### 2. MCMC Sampling
The main function `canopy.sample` performs MCMC sampling to explore the space of phylogenetic trees and clonal compositions.

```R
# Example sampling call
sampchain <- canopy.sample(R = R, D = D, WM = WM, Wm = Wm, 
                           cell.no = 3:6, num_chain = 4, 
                           iter = 10000, burnin = 1000, thin = 10)
```
- `cell.no`: Range of number of clones to test.
- `num_chain`: Number of parallel MCMC chains.

### 3. Model Selection and Post-processing
After sampling, use BIC to determine the optimal number of clones and summarize the posterior distribution.

```R
# BIC for model selection
bic <- canopy.BIC(sampchain)
k <- which.max(bic) # Optimal number of clones

# Posterior summary
config.post <- canopy.post(sampchain, K = k)
```

### 4. Visualization
Canopy provides functions to visualize the inferred trees and clonal proportions.

```R
# Plot the tree with the highest posterior probability
canopy.plottree(config.post)

# Plot clonal proportions across samples
canopy.plotclones(config.post)
```

## Key Tips
- **SNA Clustering**: For high-dimensional data, it is highly recommended to cluster SNAs first and use cluster medoids as input to reduce the parameter space.
- **CNA Matrix C**: Matrix C defines the relationship between SNAs and CNAs. If an SNA falls within a CNA region, Canopy can infer if the SNA occurred before or after the CNA.
- **Sampling Mode**: If only SNA data is available, Canopy can run in an SNA-only mode by adjusting the input parameters.
- **Overlapping CNAs**: Special care must be taken when defining the CNA input if genomic regions have overlapping or nested copy number events.

## Reference documentation
- [How to get CCFs for SNAs](./references/CCF.md)
- [General Package Overview](./references/README.md)
- [Choosing CNAs and SNAs](./references/SNA_CNA_choice.md)
- [Generating SNA and CNA Input](./references/SNA_CNA_input.md)
- [Troubleshooting config.summary Errors](./references/config_summary_error.md)
- [Dealing with Overlapping CNAs](./references/overlapping_CNA.md)
- [Running with SNA-only Input](./references/sampling_mode.md)