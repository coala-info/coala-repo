---
name: bioconductor-netresponse
description: The netresponse package identifies functional subnetworks and characterizes their activation patterns across different conditions using nonparametric probabilistic mixture modeling. Use when user asks to detect network responses, identify functional subnetworks, fit Variational Dirichlet Process mixture models, or visualize subnetwork activation states.
homepage: https://bioconductor.org/packages/release/bioc/html/netresponse.html
---

# bioconductor-netresponse

## Overview
The `netresponse` package provides tools for the data-driven identification of functional subnetworks that respond differently across various conditions. It uses nonparametric probabilistic modeling (Variational Dirichlet Process Gaussian Mixture Models) to characterize subnetwork activation patterns without requiring prior knowledge of the number of states.

## Core Workflow

### 1. Data Preparation
The package requires a functional dataset (e.g., gene expression matrix) and a network representation (e.g., an adjacency matrix or a `graph` object).

```r
library(netresponse)

# D: matrix with samples in rows, features (genes) in columns
# network: adjacency matrix, igraph, or graphNEL object
```

### 2. Detecting Network Responses
The primary function is `detect.responses`, which identifies subnetworks and fits mixture models to their activity patterns.

```r
# mixture.method = "vdp" is the default for nonparametric discovery
res <- detect.responses(D, network, mixture.method = "vdp", pca.basis = TRUE)

# Retrieve identified subnetworks
subnets <- get.subnets(res)
subnet.id <- names(subnets)[[1]]
```

### 3. Analyzing Clusters and Parameters
Once responses are detected, you can extract sample assignments and model parameters for specific subnetworks.

```r
# Soft assignments (probabilities)
probs <- sample2response(res, subnet.id)

# Hard assignments (cluster membership)
clusters <- response2sample(res, subnet.id)

# Model parameters (means, sds, weights)
params <- get.model.parameters(res, subnet.id)
```

### 4. Visualization
The package provides a unified plotting function `plot_responses` with multiple modes.

```r
# PCA plot of subnetwork states
vis_pca <- plot_responses(res, subnet.id, plot_mode = "pca")

# Network topology with response coloring
vis_net <- plot_responses(res, subnet.id, plot_mode = "network")

# Heatmap of feature activity across samples
vis_hm <- plot_responses(res, subnet.id, plot_mode = "heatmap")

# Boxplots of data distribution per response
vis_box <- plot_responses(res, subnet.id, plot_mode = "boxplot_data")
```

## Nonparametric Mixture Modeling (VDP)
You can use the underlying Variational Dirichlet Process (VDP) mixture model independently of the network analysis for general clustering tasks.

```r
# Fit infinite Gaussian mixture model
mixt <- vdp.mixt(D)

# Extract centroids
centroids <- mixt$posterior$centroids

# Get cluster assignments
assignments <- apply(mixt$posterior$qOFz, 1, which.max)
```

## Tips and Best Practices
- **Speedup**: For large datasets, use the `speedup = TRUE` argument in `detect.responses` to utilize faster approximations.
- **Network Formats**: The package is flexible; if you don't have a specific network, a fully connected matrix can be used to find global clusters, though this bypasses the subnetwork discovery logic.
- **PCA Basis**: Setting `pca.basis = TRUE` in `detect.responses` is recommended for high-dimensional subnetworks to improve the stability of the mixture model fitting.

## Reference documentation
- [Introduction to the netresponse R package](./references/NetResponse.md)
- [Introduction to the netresponse R package (Source)](./references/NetResponse.Rmd)