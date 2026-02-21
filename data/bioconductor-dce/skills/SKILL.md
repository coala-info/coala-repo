---
name: bioconductor-dce
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.13/bioc/html/dce.html
---

# bioconductor-dce

name: bioconductor-dce
description: Analyze Differential Causal Effects (DCE) in biological pathways using gene expression data. Use this skill to estimate how gene interactions change between conditions (e.g., healthy vs. tumor) by combining observational data with prior pathway knowledge from databases like KEGG or BioCarta.

## Overview

The `dce` package allows researchers to quantify changes in causal relationships between genes across different biological states. Unlike standard differential expression analysis which looks at individual gene levels, `dce` focuses on the *interaction* (edge weights) within a pathway. It uses Directed Acyclic Graphs (DAGs) to represent pathways and computes the difference in total causal effects between a wild-type (WT) and a mutant/diseased (MT) condition.

## Core Workflow

### 1. Prepare Pathway and Expression Data
You need a network topology (as a `graph` object or adjacency matrix) and two expression matrices (rows = samples, columns = genes).

```r
library(dce)
library(graph)

# Option A: Create a random DAG for simulation
graph_wt <- create_random_DAG(nodes = 20, prob = 0.3)

# Option B: Retrieve a real pathway (e.g., KEGG Breast Cancer)
pathways <- get_pathways(pathway_list = list(kegg = c("Breast cancer")))
brca_pathway <- pathways[[1]]$graph
```

### 2. Simulate or Load Expression Data
Expression data should be provided for both conditions.

```r
# Simulate data based on a graph
X_wt <- simulate_data(graph_wt, n = 100)
X_mt <- simulate_data(graph_mt, n = 100)

# For real data, ensure column names match graph nodes
# shared_genes <- intersect(nodes(brca_pathway), colnames(X_wt))
```

### 3. Compute Differential Causal Effects
The `dce` function is the primary interface. It estimates the causal effect for every edge in both conditions and calculates the difference.

```r
# Basic execution
res <- dce(graph_wt, X_wt, X_mt)

# Using a specific solver (e.g., linear model)
res <- dce(graph_wt, X_wt, X_mt, solver = "lm")

# Adjusting for latent confounding (e.g., batch effects)
res_deconf <- dce(graph_wt, X_wt, X_mt, deconfounding = TRUE)
```

### 4. Analyze and Visualize Results
The output is a `dce` object that can be converted to a data frame or plotted.

```r
# View top dysregulated edges
res_df <- as.data.frame(res)
print(head(res_df[order(res_df$dce_pvalue), ]))

# Plot the network with DCE values as edge weights
plot(res, nodesize = 20, labelsize = 1, use_symlog = TRUE)
```

## Key Functions

- `get_pathways`: Retrieves pathway topologies from databases (KEGG, BioCarta, NCI, Panther, PharmGKB).
- `dce`: Main function to estimate differential causal effects.
- `simulate_data`: Generates synthetic expression data from a DAG.
- `plot_network`: Visualizes a graph with specific edge weights or attributes.
- `df_pathway_statistics`: A built-in dataset providing an overview of available pathways and their sizes.

## Tips for Success

- **Gene Matching**: Ensure that the column names of your expression matrices exactly match the node names in your pathway graph. Use `intersect` to find common genes.
- **Adjustment Sets**: `dce` automatically handles adjustment sets to ignore spurious correlations, assuming the input network accurately models causal relationships.
- **Total vs. Direct Effects**: Note that `dce` computes *total* causal effects. A change in one edge weight can propagate and show "differential effects" on downstream edges even if those specific downstream interactions haven't changed.
- **Deconfounding**: If your data has known or suspected batch effects, set `deconfounding = TRUE` (or provide a latent variable count) to improve the accuracy of the DCE estimates.

## Reference documentation

- [Get started](./references/dce.md)
- [Overview of pathway network databases](./references/pathway_databases.md)