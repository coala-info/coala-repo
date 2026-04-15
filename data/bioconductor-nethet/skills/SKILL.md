---
name: bioconductor-nethet
description: This tool analyzes biological network heterogeneity from high-dimensional data using Gaussian Graphical Models. Use when user asks to perform network-based clustering, test for differential networks between groups, conduct gene-set analysis, or perform differential regression.
homepage: https://bioconductor.org/packages/release/bioc/html/nethet.html
---

# bioconductor-nethet

name: bioconductor-nethet
description: Analysis of network heterogeneity from high-dimensional data using Gaussian Graphical Models (GGMs). Use this skill to perform network-based clustering (mixglasso), high-dimensional two-sample testing for differential networks (diffnet), gene-set analysis (GGM-GSA), and differential regression.

## Overview

The `nethet` package is designed for investigating biological network heterogeneity. It moves beyond the assumption of a single underlying network by providing tools to identify sub-populations with distinct network topologies and to statistically compare networks between known groups. It primarily uses the Graphical Lasso (glasso) for sparse inverse covariance estimation.

## Core Workflows

### 1. Data Simulation
Generate synthetic data from Gaussian mixture models to test workflows.

```r
library(nethet)

# Simulate mixture of networks
# n: samples, p: variables, n.comp: groups, s: sparsity (0-1)
sim_res <- sim_mix_networks(n=100, p=25, n.comp=3, s=0.9)

# Generate two networks with specific overlap for differential testing
gen_nets <- generate_2networks(p=20, graph='random', n.nz=rep(20,2), n.nz.common=15)
```

### 2. Network Estimation (Known Groups)
When group labels are known, use `het_cv_glasso` to estimate group-specific networks with cross-validated penalty parameters.

```r
# data: matrix, grouping: vector of labels
networks <- het_cv_glasso(data = my_data, grouping = my_labels)

# Access results
# networks$Sig: list of estimated covariance matrices
# networks$Omega: list of estimated concentration matrices (networks)
```

### 3. Network-Based Clustering (Unknown Groups)
Use `mixglasso` to simultaneously cluster samples and learn group-specific networks.

```r
# Run with a fixed number of components
mix_res <- mixglasso(my_data, n.comp=3)

# Run over a range to find optimal n.comp via BIC
mix_search <- mixglasso(my_data, n.comp=1:5)
best_model <- mix_search$models[[mix_search$bic.opt]]

# Check clustering accuracy if ground truth exists
library(mclust)
adj_rand <- adjustedRandIndex(mix_res$comp, true_labels)
```

### 4. Differential Network Testing
Test the null hypothesis that two groups share the same underlying network structure.

```r
# Uses multi-split approach for stable p-values
# x1, x2: data matrices for the two groups
dn_test <- diffnet_multisplit(x1, x2, b.splits=50)

# Extract aggregated p-value
print(dn_test$medagg.pval)
plot(dn_test) # Visualize p-value distribution
```

### 5. GGM-GSA (Gene-Set Analysis)
Perform differential network analysis across multiple predefined gene sets.

```r
# gsets: list of character vectors (gene names)
# gene.names: vector matching columns in x1/x2
gsa_res <- ggmgsa_multisplit(x1, x2, gsets=my_gsets, gene.names=colnames(x1), b.splits=25)
summary(gsa_res)
```

### 6. Differential Regression
Test if two high-dimensional regression models (Y ~ X) are significantly different.

```r
# y1, y2: response vectors; x1, x2: predictor matrices
dr_test <- diffregr_multisplit(y1, y2, x1, x2, b.splits=10)
print(dr_test$medagg.pval)
```

## Visualization and Export

### Plotting Networks
`nethet` provides specialized plotting for its clustering objects.

```r
# Dot plot of partial correlations across groups
dot_plot(best_model, p.corrs.thresh=0.5)

# Scatter plots for specific node pairs across groups
node_pairs <- rbind(c(1,2), c(3,4))
scatter_plot(best_model, data=my_data, node.pairs=node_pairs)
```

### Exporting
Export inferred networks to CSV for use in external tools like Cytoscape.

```r
# Set quote=FALSE for easier Cytoscape import
export_network(best_model, file='my_network.csv', p.corrs.thresh=0.25, quote=FALSE)
```

## Tips and Best Practices
- **Data Scaling**: Ensure data is centered and scaled before running `mixglasso` or `diffnet` if variables are on different scales.
- **Stability**: Always use a sufficient number of splits (`b.splits >= 50`) for `diffnet` and `diffregr` to avoid the "p-value lottery" of a single random split.
- **Parallelization**: On Unix systems, set `mc.flag=TRUE` in multisplit functions to use the `parallel` library for faster computation.
- **BIC Selection**: When using `mixglasso` to find the number of components, the default adaptive penalization is generally recommended over setting `lambda=0`.

## Reference documentation
- [nethet](./references/nethet.md)