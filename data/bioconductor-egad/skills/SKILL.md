---
name: bioconductor-egad
description: Bioconductor-egad evaluates gene networks and predicts gene function using guilt-by-association methods while controlling for multifunctionality bias. Use when user asks to evaluate network performance, predict gene functions, calculate multifunctionality scores, or analyze gene network topology.
homepage: https://bioconductor.org/packages/release/bioc/html/EGAD.html
---

# bioconductor-egad

name: bioconductor-egad
description: Tools for calculating functional properties of networks using guilt by association (GBA). Use when analyzing gene networks, predicting gene function, evaluating network topology, or assessing multifunctionality bias in biological datasets.

# bioconductor-egad

## Overview

EGAD (Extending Guilt by Association by Degree) provides highly efficient tools for evaluating gene networks. It uses "Guilt by Association" (GBA) to predict gene function and assess network quality. A core feature is its ability to control for "multifunctionality," a bias where high-degree nodes (hubs) appear to be associated with many functions simply due to their connectivity rather than specific biological signals.

## Core Workflows

### 1. Network Construction

Build networks from various data sources. Networks should generally be symmetric gene-by-gene matrices.

```R
# Build a co-expression network from an expression matrix
# exprs: genes in rows, samples in columns
net <- build_coexp_network(exprs, gene.list)

# Build a binary network from interaction pairs
# data: 2-column matrix of interacting pairs
net_binary <- build_binary_network(data, gene.list)

# Build a weighted network from triplets (geneA, geneB, weight)
net_weighted <- build_weighted_network(data_with_weights, gene.list)
```

### 2. Annotation Preparation

EGAD requires a binary annotation matrix where rows are genes and columns are functional groups (e.g., GO terms).

```R
# Create an annotation matrix from a mapping file
# data: 2-column matrix (gene, term)
annotations <- make_annotations(data, gene.list, term.list)

# Filter annotations to keep groups within a specific size range
annotations_filtered <- filter_network_cols(annotations, min = 20, max = 1000)
```

### 3. Neighbor Voting (GBA)

The primary method for evaluating network performance. It uses cross-validation to see how well a gene's neighbors predict its known labels.

```R
# Run neighbor voting with 3-fold cross-validation
# Returns AUROC/AUPRC for each functional group
gba_results <- neighbor_voting(annotations, net, nFold = 3, output = "AUROC")

# Access results
# auc: performance of the network
# avg_node_degree: mean degree of genes in that group
# degree_null_auc: performance based on node degree alone (multifunctionality)
print(gba_results)

# Quick wrapper for the full pipeline
gba_full <- run_GBA(net, annotations, min = 10, max = 500)
```

### 4. Multifunctionality Analysis

Assess if your network's performance is driven by node degree (bias) rather than specific connectivity.

```R
# Calculate multifunctionality scores for genes
gene_mf <- calculate_multifunc(annotations)

# Calculate AUC for functional groups based on multifunctionality
# optimallist: ranked list from calculate_multifunc
mf_auc <- auc_multifunc(annotations, gene_mf[,4])
```

### 5. Network Topology

Analyze the structural properties of the network.

```R
# Calculate node degrees
degrees <- node_degree(net)

# Calculate network assortativity (preference for similar nodes to connect)
assort <- assortativity(net)

# Extend a binary network using inverse path lengths
ext_net <- extend_network(net_binary, max = 6)
```

## Visualization

EGAD includes functions to visualize performance metrics and network structures.

```R
# Plot ROC or PRC for a specific group
plot_roc(scores, labels)
plot_prc(scores, labels)

# Overlay multiple ROC curves
plot_roc_overlay(scores_matrix, labels_matrix)

# Visualize network as a heatmap
plot_network_heatmap(net, colrs = colorRampPalette(c("white", "red"))(100))

# Compare AUROC distributions
plot_density_compare(auroc_net_A, auroc_net_B)
```

## Tips for Success

- **Symmetry:** Ensure your network matrices are symmetric. Most functions expect `net[i,j] == net[j,i]`.
- **Gene IDs:** Ensure the row/column names of your network match the row names of your annotation matrix exactly.
- **Ranking:** For co-expression networks, using ranked correlations (`flag = "rank"` in `build_coexp_network`) often provides more robust results than raw correlation values.
- **Memory:** For very large networks, EGAD is optimized for speed, but ensure you have sufficient RAM as it typically works with dense matrices.

## Reference documentation

- [EGAD Reference Manual](./references/reference_manual.md)